unit uImportExport;

interface

uses uDatabase, System.Zip, FMX.Objects, FMX.Memo, System.IOUtils, System.SysUtils,
  FMX.ListView.Types, uShared, System.StrUtils;

function ExportData(id_travel: Integer; id_section: Integer; item_purpose: TListItemPurpose; zip_path: String):Boolean;
function ImportData(id_travel: Integer; zip_path: String):Boolean;
function AddDocumentsToDB(id_section, section_num: Integer; tmp_path: String): Boolean;
function ExportDocuments(id_section: Integer; section_num: Integer; tmp_path: String): Boolean;
function CopyAllDocumentsToFolder(tmp_path: String): Boolean;

implementation

uses
  System.Classes;

////////////////IMPORT/////////////////////
function ImportData(id_travel: Integer; zip_path: String):Boolean;
var
  ZipFile: TZipFile;
  strTmp: TStringList;
  tmp_path: String;
  id_section: Integer;
  sql, line: String;
  section_num: Integer;
  document_added: Boolean;
begin
  // Import data
  try
    ZipFile := TZipFile.Create;
    strTmp := TStringList.Create();
    try
      id_section := 0;
      document_added := False;
      // Odzipaj v začasno mapo
      tmp_path := TPath.Combine(TPath.GetTempPath(), 'MarcoPolo');   // Nastavi začano pot za zbiranje datotek (tmp  mapa)
      if DirectoryExists(tmp_path) then   // pobriši začasno mapo če že obstaja (če se ni prejšničkrat pobrisala)
        TDirectory.Delete(tmp_path, True);

      ForceDirectories(tmp_path);

      if FileExists(zip_path) then    // če zip datoteka obstaja, jo odpri za pisanje in branje
      begin
        ZipFile.ExtractZipFile(zip_path, tmp_path);

        if FileExists(TPath.Combine(tmp_path, 'Travels.db')) then
        begin
          // ustvari novo potovanje
          strTmp.LoadFromFile(TPath.Combine(tmp_path, 'Travels.db'));
          sql := Trim(strTmp.Text);
          sql := ReplaceStr(sql, '\n', sLineBreak);   // zamenjaj vse \n s prelomom vrstice
          id_travel := DataModule1.QImportData('Travels', sql);
        end;
        if id_travel > 0 then
        begin
          // ustvari nove sekcije poti
          strTmp.LoadFromFile(TPath.Combine(tmp_path, 'Sections.db'));
          // za vsako sekcijo
          section_num := 0;
          for line in strTmp do
          begin
            sql := line;
            sql := ReplaceStr(sql, '\n', sLineBreak);   // zamenjaj vse \n s prelomom vrstice
            sql := ReplaceStr(sql, '$id_travel$', IntToStr(id_travel));    // napolni še pravilni id_travel
            sql := ReplaceStr(sql, '$ds$', '.');   // zamenjaj $ds$ z .
            id_section := DataModule1.QImportData('Sections', sql);
            Inc(section_num);
            document_added := AddDocumentsToDB(id_section, section_num, tmp_path);   // za vsako sekcijo dodaj pripadajoče dokuemnte v DB
          end;
          if document_added then   // če so v bazo dodani vsi dokumenti
            // Kopiraj vse datoteke razen *.db
            CopyAllDocumentsToFolder(tmp_path);
        end;
      end;
      // pobriši začasno mapo
      if (id_travel > 0) AND (id_section > 0) AND document_added then
      begin
        if DirectoryExists(tmp_path) then   // pobriši začasno mapo če že obstaja (če se ni prejšničkrat pobrisala)
          TDirectory.Delete(tmp_path, True);
        result := True
      end else
        result := False;
    finally
      ZipFile.Free;
      strTmp.Free;
    end;
  except
    result := False;
  end;
end;

function AddDocumentsToDB(id_section, section_num: Integer; tmp_path: String): Boolean;
var
  strTmp: TStringList;
  sql, line: String;
  num: Integer;
  file_path: String;
begin
  // ustvari nove dokumente v DB
  try
    strTmp := TStringList.Create();
    file_path := TPath.Combine(GetMarcoPoloPath(), 'Documents');
    try
      if section_num > 0 then
      begin
        strTmp.LoadFromFile(TPath.Combine(tmp_path, 'Documents.db'));
        for line in strTmp do    //
        begin
          num := StrToInt(line.Substring(0, Pos(':', line)-1));
          if section_num = num then     // če dokument pripada tej sekciji
          begin
            sql := Trim(line.Substring(Pos(':', line), line.Length));
            sql := ReplaceStr(sql, '$id_section$', IntToStr(id_section));    // napolni še pravilni id_section
            sql := ReplaceStr(sql, '$path$', file_path + PathDelim);    // napolni še pravilni pot do dokumenta
            DataModule1.QImportData('Documents', sql);   // Dodaj dokument v DB
          end;
        end;
        result := True;
      end else
        result := False;
    finally
      strTmp.Free;
    end;
  except
    result := False;
  end;
end;

function CopyAllDocumentsToFolder(tmp_path: String): Boolean;
var
  copy_file, file_path: String;
begin
  // Kopiraj vse datoteke razen *.db iz začasne mape v Documents mapo
  try
    file_path := TPath.Combine(GetMarcoPoloPath(), 'Documents'); // nastavi pot kamor se shranjujejo dokuemnti
    ForceDirectories(file_path);  // če mapa še ne obstaja jo ustvari
    for copy_file in TDirectory.GetFiles(tmp_path)  do   // kopiraj vse datotek iz zipa v mapo Documents
    begin
      if ExtractFileExt(copy_file) <> '.db' then
      TFile.Copy(copy_file, TPath.Combine(file_path, ExtractFileName(copy_file)), True);
    end;
    result := True;
  except
    result := False;
  end;
end;
////////////////IMPORT/////////////////////

//////////////////EXPORT////////////////////////
function ExportData(id_travel: Integer; id_section: Integer; item_purpose: TListItemPurpose; zip_path: String):Boolean;
var
  strTmp: TStringList;
  tmp_path: String;
  ZipFile: TZipFile;
  title, color, note: String;
  transport_type, date, time, duration, latitude, longitude: String;
  section_num: Integer;
begin
  // izvoz Potovanja ali dela poti in vseh pripadajočih datotek
  try
    ZipFile := TZipFile.Create;
    strTmp := TStringList.Create();
    try
      tmp_path := TPath.Combine(TPath.GetTempPath(), 'MarcoPolo');   // Nastavi začano pot za zbiranje datotek (tmp  mapa)
      if DirectoryExists(tmp_path) then   // pobriši začasno mapo če že obstaja (če se ni prejšničkrat pobrisala)
        TDirectory.Delete(ExcludeTrailingPathDelimiter(tmp_path), True);
      ForceDirectories(tmp_path );  // če mapa še ne obstaja, jo ustvari
     // dobi id_section, ki je označena (če je označeno Potovanje, potem je id_section=0 in ga dobim takrat, ko arhiviram tabelo Travel)
      // če smo izbrali Header ali Footer izvozimo vse tabele: Travels, Sections, Documents
      if (item_purpose = TListItemPurpose.Header) then   // če smo označili celotni pot (arhiviraj pot, sekcije in dokumente)
      begin
        DataModule1.QExportData(DataModule1.FDQImportExport, 'Travels', 'id_travel', id_travel);  // dobi podatke za Pot
        strTmp.Clear;
        DataModule1.FDQImportExport.First;
        while (not DataModule1.FDQImportExport.Eof) do     // v trenutni različici je omogočeno označiti samo eno pot in je ta del nepotreben
        begin
          title := DataModule1.FDQImportExport.FieldByName('title').AsString;   // shrani podatke o nazivu poti
          color := DataModule1.FDQImportExport.FieldByName('color').AsString;   // shrani podatke o barvi poti
          note := DataModule1.FDQImportExport.FieldByName('note').AsString;   // shrani podatke o opombi
          note := ReplaceStr(note, sLineBreak, '\n'); // zamenjaj vse prelome vrstic z oznako \n
          strTmp.Add('INSERT INTO Travels (title, color, note) VALUES("' + title + '", "'  + color + '", "'  + note + '");');   // zapiši pot v začasni TMemo (strTmp)
          DataModule1.FDQImportExport.Next;    // nasleden zapis (trenutno je pri Poti nepotreben)
        end;
        strTmp.SaveToFile(TPath.Combine(tmp_path, 'Travels.db'), TEncoding.UTF8);  // shrani zapis iz strTmp
        DataModule1.QExportData(DataModule1.FDQImportExport, 'Sections', 'id_travel', id_travel);   // Izberi vse odseke potovanja za neko Potovanje
      end else
        DataModule1.QExportData(DataModule1.FDQImportExport, 'Sections', 'id_section', id_section);   // Izberi samo izbran odsek poti (če nismo izbrali Potovanja, temveč samo odsek poti)
      // SEKCIJE
      section_num := 0;
      strTmp.Clear;   // počisti strTmp
      DataModule1.FDQImportExport.First;   // Postavi se na prvi zapis
      while (not DataModule1.FDQImportExport.Eof) do   // čez vse zapise
      begin // Dobi ustrezne podatke
        transport_type := DataModule1.FDQImportExport.FieldByName('transport_type').AsString;
        title := DataModule1.FDQImportExport.FieldByName('title').AsString;
        date := DataModule1.FDQImportExport.FieldByName('date').AsString;
        time := DataModule1.FDQImportExport.FieldByName('time').AsString;
        note := DataModule1.FDQImportExport.FieldByName('note').AsString;
        note := ReplaceStr(note, sLineBreak, '\n'); // zamenjaj vse prelome vrstic z oznako \n
        duration := DataModule1.FDQImportExport.FieldByName('duration').AsString;
        latitude := DataModule1.FDQImportExport.FieldByName('latitude').AsString;
        latitude := ReplaceStr(latitude, FormatSettings.DecimalSeparator, '$ds$'); // zamenjaj local decimal separator z $ds$
        longitude := DataModule1.FDQImportExport.FieldByName('longitude').AsString;
        longitude := ReplaceStr(longitude, FormatSettings.DecimalSeparator, '$ds$'); // zamenjaj local decimal separator z $ds$
        id_section := DataModule1.FDQImportExport.FieldByName('id_section').AsInteger;
        strTmp.Add('INSERT INTO Sections (id_travel, transport_type, title, date, time, note, duration, latitude, longitude) '+
                   'VALUES("$id_travel$", "' + transport_type + '", "'  + title + '", "'  + date + '", "'  + time + '", "'  + note + '", "'  + duration +
                   '", "'  + latitude+ '", "'  + longitude + '");');   // zapiši jih v strTmp
        DataModule1.QGetAllDocumentsFromSection(id_section);    // dobi vse dokumente za podano sekcijo poti
        Inc(section_num);    // povečaj zaporedno št. sekcije v arhivu
        ExportDocuments(id_section, section_num, tmp_path); // zapiši vse SQL stavke za uvoz dokumentov in skopiraj datoteke
        DataModule1.FDQImportExport.Next;   //nasleden zapis
      end;
      strTmp.SaveToFile(TPath.Combine(tmp_path, 'Sections.db'), TEncoding.UTF8);   // Shrani zapisano v strTmp v datoteko Section.db
      ZipFile.ZipDirectoryContents(zip_path, ExcludeTrailingPathDelimiter(tmp_path));
      ZipFile.Close;  // Zapri zip
      // Izbriši začasno mapo in vse datoteke
      TDirectory.Delete(tmp_path, True);  // Izbriši začasno mapo
      result := True;
    finally
      ZipFile.Free;
      strTmp.Free;
    end;
  except
    result := False;
  end;
end;

function ExportDocuments(id_section: Integer; section_num: Integer; tmp_path: String): Boolean;
var
  strTmp: TStringList;
  title: String;
  file_name: String;
begin
  try
    strTmp := TStringList.Create();
    if FileExists(TPath.Combine(tmp_path, 'Documents.db')) then
      strTmp.LoadFromFile(TPath.Combine(tmp_path, 'Documents.db'));
    try
      DataModule1.QExportData(DataModule1.FDQTemp, 'Documents', 'id_section', id_section);  // Izberi vse dokumente za podano sekcijo
      DataModule1.FDQTemp.First;
      while (not DataModule1.FDQTemp.Eof) do  // čez vse zapise
      begin     // Dobi podatke
        title := DataModule1.FDQTemp.FieldByName('title').AsString;
        file_name := ExtractFileName(DataModule1.FDQTemp.FieldByName('path').AsString);

        strTmp.Add(IntToStr(section_num) + ':INSERT INTO Documents (id_section, title, path) VALUES("$id_section$", "' + title + '", "$path$'  + file_name + '");');  // Zapiši jih v strTmp
        TFile.Copy(DataModule1.FDQTemp.FieldByName('path').AsString, TPath.Combine(tmp_path, file_name), True);   // kopiraj tudi datoteke (jih prepiši če že obstajajo)
        DataModule1.FDQTemp.Next;    // naslednji zapis
      end;
      strTmp.SaveToFile(TPath.Combine(tmp_path,'Documents.db'), TEncoding.UTF8);  // shrani
      result := True;
    finally
      strTmp.Free;
    end;
  except
    result := False;
  end;
end;

//////////////////EXPORT////////////////////////
end.
