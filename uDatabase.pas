unit uDatabase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDConnection: TFDConnection;
    FDQTravelsSections: TFDQuery;
    FDQTemp: TFDQuery;
    FDQDocuments: TFDQuery;
    FDQSections: TFDQuery;
    FDQImportExport: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function QCreateDatabase(): Boolean;  // Priklopi se na podatkovno bazo, če ne obstaja, jo ustvari. Vrne True, če je priklop uspel

    function QGetTravelsSections(): Integer;  // Iz tabel Travel in Section, zberi vse poti združene (Left join) z odseki. Vrni št. zadetkov (-1=izbor ni uspel)

    function QAddSection(id_travel: Integer; transport_type: Integer; title: String; date: TDate; time: TTime; note: String; duration: Integer = 0; latitude: Float32 = 0.0; longitude: Float32 = 0.0): Integer; // Shrani odsek poti in vrne zadnji dodan id_sekcije, če je zapis uspel, drugače vrne -1
    function QUpdateSection(id_section: Integer; id_travel: Integer; transport_type: Integer; title: String; date: TDate; time: TTime; note: String; duration: Integer; latitude: Float32; longitude: Float32): Boolean; // Posodobi odsek poti za podan id_section in vrne True, če je zapis uspel, drugače vrne False
    function QDeleteSection(id_section: Integer): Boolean;   // izbriši sekcijo za podani id_section
    function QDeleteAllSectionsFromTravel(id_travel: Integer): Boolean;   // Izbriši vse delepoti za podan id_travel
    function QGetSection(id_section: Integer): Integer;  // izberi zapise iz tabele Section, za podani id_section, vrne št. izbranih zapisov,-1 če je napaka
    function QGetAllSectionFromTravel(id_travel: Integer): Integer; // izberi vse zapise iz tabele Sections, za pripadajoči id_travel, vrne število zadetkov

    function QAddTravel(title: String; note: String; color: Int64 = $FFE0E0E0): Integer;  // Shrani podatke v tabelo Travels in vren zadnji dodani id_travel, če je zapis uspel,drugače vrne -1
    function QUpdateTravel(id_travel: Integer; title: String; note: String; color: Int64 = $FFE0E0E0): Boolean;  // Posodobi zapis v bazi Travels, s podanim id_travel
    function QGetTravel(id_travel: Integer): Boolean;  // vrne zapis iz tabele Travel, za podani id_travel
    function QDeleteTravel(id_travel: Integer): Boolean;  // izbriši pot za podan id_travel

    function QGetAllDocumentsFromSection(id_section: Integer): Integer;  // Iz tabele Documents izberi vse ustrezne dokumente, glede na id_sekcije
    function QGetDocument(id_document: Integer): Boolean;  // vrni izbran dokument
    function QDeleteDocument(id_document: Integer): Boolean; // izbriše dokument iz batze za podan id_document
    function QDeleteAllDocumentsFromSection(id_section: Integer): Boolean; // izbriši vse dokumente v podani sekciji
    function QAddDocument(title: String; path: String; id_section: Integer): Integer;  // Shrani dokument v bazo Documents in vrne id_document
    function QUpdateDocument(id_document: Integer; title: String; path: String; id_section: Integer): Boolean; //Posodobi zapis v bazi Documents, s podanim id_document, če je zapis uspel vrne True, drugače vrne False

    function QGetLastInsertedID(tablename: String): Integer; // vrne zadnji dodani ID v izbrani tabeli
    function IsDateTimeBetween(datetime: String; id_section: Integer): Integer;
    function GetSectionClosestNow(): Integer;   // Iz tabele Sections izberi sekcijo, ki ima datum in uro najbljižje trenutnemu datumu in uri
    //NE UPORABLJAM
    function QExportData(FDQuery: TFDQuery; table_name: String; id_name: String; id_value: Integer): Integer;
    function QImportData(table_name: String; sql: String): Integer;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}
uses uShared, IOUtils;

{ TDataModule1 }


function TDataModule1.QCreateDatabase(): Boolean;
var
  Path: String;
  DBName: String;
begin
  // Priklopi se na podatkovno bazo, če ne obstaja, jo ustvari. Vrne True, če je priklop uspel
  // Nastavi pot do podatkovne baze (Windows: %UserProfile%\Documents, Android: ?, iOS: ?)
  Path := GetMarcoPoloPath();
  // Če mapa MarcoPolo NE obstaja jo ustvari
  if NOT TDirectory.Exists(Path) then
    TDirectory.CreateDirectory(Path);
  // nastavi pot do podatkovne baze
  DBName := TPath.Combine(Path, 'marco_polo.sqlite');
  // če podatkovna baza ne obstaja jo kreiraj, ustvari tabele in polja ter se priklopi nanjo
  try
    // ustvari podatkovno bazo
    FDConnection.Params.Clear;
    FDConnection.DriverName := 'SQLITE';
    FDConnection.Params.Values['database'] := DBName;
    FDConnection.Connected := True;

    // ustvari tabelo potovanja
    FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS Travels ( ' +
                        ' id_travel INTEGER NOT NULL ' +
                        ' CONSTRAINT PK_Travels PRIMARY KEY AUTOINCREMENT, ' +
                        ' color INTEGER, ' +
                        ' title TEXT, ' +
                        ' note TEXT)');
    // ustvari tabelo Sekcije (deli poti)
    FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS "Sections" ("id_section"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                        '	"transport_type"	INTEGER, ' +
                        '	"title"	TEXT, ' +
                        '	"date"	TEXT, ' +
                        '	"time"	TEXT, ' +
                        '	"duration"	INTEGER, ' +
                        '	"latitude"	REAL, ' +
                        '	"longitude"	REAL, ' +
                        '	"note"	TEXT, ' +
                        '	"id_travel"	INTEGER, ' +
                        '	CONSTRAINT "Relationship1" FOREIGN KEY("id_travel") REFERENCES "Travels"("id_travel"))');
    // Ustvari tabelo dokumenti
    FDConnection.ExecSQL('CREATE TABLE IF NOT EXISTS "Documents" ( ' +
                        '"id_document"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                        '"title"	TEXT, ' +
                        '"path"	TEXT, ' +
                        '"id_section"	INTEGER, ' +
                        'CONSTRAINT "Relationship2" FOREIGN KEY("id_section") REFERENCES "Sections"("id_section"))');

    result := FDConnection.Connected;  // priklop na bazo je uspel(baza je bila ustvarjena ali pa je že obstajala)
  except on E: Exception do
    result := False;  // Napaka pri ustvarjanju podatkovne baze
  end;
end;

function TDataModule1.QGetLastInsertedID(tablename: String): Integer;
begin
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('SELECT seq from sqlite_sequence WHERE name=:name');
    FDQTemp.ParamByName('name').AsString := tablename;
    FDQTemp.Open();
    result := FDQTemp.FieldByName('seq').AsInteger;    // Vrne zadnji ID v izbrani tabeli
  except on E: Exception do
    result := -1;  // Napaka pri izbiri dokumentov, vrne -1
  end;
end;


///////////////////TRAVELS / SECTIONS///////////

function TDataModule1.QGetTravelsSections(): Integer;
begin
// Iz tabel Travel in Section, zberi vse poti združene (Left join) z odseki. Vrni št. zadetkov (-1=izbor ni uspel)
  try
    FDQTravelsSections.SQL.Clear;
    FDQTravelsSections.SQL.Add('SELECT * FROM Travels AS T LEFT JOIN Sections As S ON S.id_travel=T.id_travel ' +
                                'ORDER BY T.id_travel, S.date, S.time');
    FDQTravelsSections.Open();
    result := FDQTravelsSections.RecordCount;  // Vrne število zadetkov
  except on E: Exception do
    result := -1;  // Napaka pri izbiri poti/odseka poti, vrne -1
  end;
end;

///////////////////TRAVEL / SECTION///////////

///////////////////DOCUMENT/////////////////////
function TDataModule1.QDeleteAllDocumentsFromSection(id_section: Integer): Boolean;
begin
  // izbriši vse dokumente v podani sekciji
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('DELETE FROM Documents WHERE id_section=:id_section');
    FDQTemp.ParamByName('id_section').AsInteger := id_section;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end;
end;


function TDataModule1.QDeleteDocument(id_document: Integer): Boolean;
begin
  // izbriše dokument iz batze za podan id_document
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('DELETE FROM Documents WHERE id_document=:id_document');
    FDQTemp.ParamByName('id_document').AsInteger := id_document;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end;
end;


function TDataModule1.QGetDocument(id_document: Integer): Boolean;
begin
  // Izberi dokument glede na podan id_document
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('SELECT * FROM Documents WHERE id_document=:id_document');
    FDQTemp.ParamByName('id_document').AsInteger := id_document;
    FDQTemp.Open();
    result := True;
  except on E: Exception do
    result := False;
  end;
end;

function TDataModule1.QGetAllDocumentsFromSection(id_section: Integer): Integer;
begin
  // Iz tabele Documents izberi vse ustrezne dokumente, glede na id_sekcije in vrne št. zadetkov
  try
    FDQDocuments.SQL.Clear;
    FDQDocuments.SQL.Add('SELECT * FROM Documents WHERE id_section=:id_section');
    FDQDocuments.ParamByName('id_section').AsInteger := id_section;
    FDQDocuments.Open();
    result := FDQDocuments.RecordCount;  // Vrne število zadetkov
  except on E: Exception do
    result := -1;  // Napaka pri izbiri dokumentov, vrne -1
  end;
end;

function TDataModule1.QAddDocument(title: String; path: String; id_section: Integer): Integer;
begin
  // Dodaj dokument v bazo Documentm, vrne id_documet
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('INSERT INTO Documents (title, path, id_section) VALUES(:title, :path, :id_section)');
    FDQTemp.Params.ParamByName('title').AsWideString := title;
    FDQTemp.Params.ParamByName('path').AsWideString := path;
    FDQTemp.Params.ParamByName('id_section').AsInteger := id_section;
    FDQTemp.ExecSQL();
    result := FDConnection.GetLastAutoGenValue('Documents');  // vrne id_document, ki smo ga shranili
  except on E: Exception do
    result := -1;  // ob neuspehu vrne -1
  end;
end;

function TDataModule1.QUpdateDocument(id_document: Integer; title, path: String;
  id_section: Integer): Boolean;
begin
  //Posodobi zapis v bazi Documents, s podanim id_document, če je zapis uspel vrne True, drugače vrne False
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('UPDATE Documents SET id_section=:id_section, title=:title, path=:path WHERE id_document=:id_document');
    FDQTemp.Params.ParamByName('id_section').AsInteger := id_section;
    FDQTemp.Params.ParamByName('id_document').AsInteger := id_document;
    FDQTemp.Params.ParamByName('title').AsWideString := title;
    FDQTemp.Params.ParamByName('path').AsWideString := path;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end;
end;
///////////////////DOCUMENT/////////////////////

//////////////////////TRAVEL/////////////////////
function TDataModule1.QAddTravel(title: String; note: String; color: Int64 = $FFE0E0E0): Integer;
begin
  // Shrani podatke v tabelo Travels
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('INSERT INTO Travels (title, color, note) VALUES(:title, :color, :note)');
    FDQTemp.Params.ParamByName('title').AsWideString := title;
    FDQTemp.Params.ParamByName('note').AsWideString := note;
    FDQTemp.Params.ParamByName('color').AsInteger := color;
    FDQTemp.ExecSQL();
    result := FDConnection.GetLastAutoGenValue('Travels');
  except on E: Exception do
    result := -1;
  end;
end;


function TDataModule1.QUpdateTravel(id_travel: Integer; title: String; note: String;
 color: Int64): Boolean;
begin
  // Posodobi podatke v tabelo Travels, za podan id_travel
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('UPDATE Travels SET title=:title, note=:note,color=:color WHERE id_travel=:id_travel');
    FDQTemp.Params.ParamByName('id_travel').AsInteger := id_travel;
    FDQTemp.Params.ParamByName('title').AsWideString := title;
    FDQTemp.Params.ParamByName('note').AsWideString := note;
    FDQTemp.Params.ParamByName('color').AsInteger := color;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end;
end;

function TDataModule1.QGetTravel(id_travel: Integer): Boolean;
begin
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('SELECT * from Travels WHERE id_travel=:id_travel');
    FDQTemp.ParamByName('id_travel').AsInteger := id_travel;
    FDQTemp.Open();
    result := True;    // Vrne True,če je povpraševanje uspešno
  except on E: Exception do
    result := False;  // Če ni uspešno, vrne False
  end;
end;

function TDataModule1.QDeleteTravel(id_travel: Integer): Boolean;
begin
  // izbriši pot za podan id_travel
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('DELETE FROM Travels WHERE id_travel=:id_travel');
    FDQTemp.ParamByName('id_travel').AsInteger := id_travel;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end
end;

//////////////////////TRAVEL/////////////////////



//////////////////////SECTION/////////////////////
function TDataModule1.QAddSection(id_travel, transport_type: Integer;
  title: String; date: TDate; time: TTime; note: String; duration: Integer; latitude,
  longitude: Float32): Integer;
var
  fdate_time: TFormatSettings;
begin
  // Doda zapis v tabelo Sections in vrne zadnji dodan id_section, če zapis ni uspel, vrne -1
  // nastavi fromat datuma sqlite
  fdate_time.DateSeparator :=  '-';
  fdate_time.ShortDateFormat :=  'yyyy-mm-dd';
  fdate_time.TimeSeparator := ':';
  fdate_time.ShortTimeFormat := 'hh:mm:ss';
  // Shrani podatke v tabelo Sections
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('INSERT INTO Sections (id_travel, transport_type, title, date, time, note, duration, latitude, longitude) ' +
                    'VALUES(:id_travel, :transport_type, :title, :date, :time, :note, :duration, :latitude, :longitude)');
    FDQTemp.Params.ParamByName('id_travel').AsInteger := id_travel;
    FDQTemp.Params.ParamByName('transport_type').AsInteger := transport_type;
    FDQTemp.Params.ParamByName('title').AsWideString := title;
    FDQTemp.Params.ParamByName('date').AsString := FormatDateTime('yyyy-mm-dd', date, fdate_time);
    FDQTemp.Params.ParamByName('time').AsString := FormatDateTime('hh:mm:ss', time, fdate_time);
    FDQTemp.Params.ParamByName('note').AsWideString := note;
    FDQTemp.Params.ParamByName('duration').AsInteger := duration;
    FDQTemp.Params.ParamByName('latitude').AsFloat := latitude;
    FDQTemp.Params.ParamByName('longitude').AsFloat := longitude;
    FDQTemp.ExecSQL();
    result := FDConnection.GetLastAutoGenValue('Sections');
  except on E: Exception do
    result := -1;
  end;
end;

function TDataModule1.QUpdateSection(id_section, id_travel,
  transport_type: Integer; title: String; date: TDate; time: TTime; note: String;
  duration: Integer; latitude, longitude: Float32): Boolean;
var
  fdate_time: TFormatSettings;
begin
  // Posodobi podatke v tabelo Sections, za podan id_section
  // nastavi fromat datuma sqlite
  fdate_time.DateSeparator :=  '-';
  fdate_time.ShortDateFormat :=  'yyyy-mm-dd';
  fdate_time.TimeSeparator := ':';
  fdate_time.ShortTimeFormat := 'hh:mm:ss';
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('UPDATE Sections SET id_travel=:id_travel, transport_type=:transport_type, title=:title, date=:date, ' +
                    'time=:time, note=:note, duration=:duration, latitude=:latitude, longitude=:longitude WHERE id_section=:id_section');
    FDQTemp.Params.ParamByName('id_section').AsInteger := id_section;
    FDQTemp.Params.ParamByName('id_travel').AsInteger := id_travel;
    FDQTemp.Params.ParamByName('transport_type').AsInteger := transport_type;
    FDQTemp.Params.ParamByName('title').AsWideString := title;
    FDQTemp.Params.ParamByName('date').AsString := FormatDateTime('yyyy-mm-dd', date, fdate_time);
    FDQTemp.Params.ParamByName('time').AsString := FormatDateTime('hh:mm:ss', time, fdate_time);
    FDQTemp.Params.ParamByName('note').AsWideString := note;
    FDQTemp.Params.ParamByName('duration').AsInteger := duration;
    FDQTemp.Params.ParamByName('latitude').AsFloat := latitude;
    FDQTemp.Params.ParamByName('longitude').AsFloat := longitude;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end;
end;

function TDataModule1.QGetSection(id_section: Integer): Integer;
begin
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('SELECT * from Sections WHERE id_section=:id_section');
    FDQTemp.ParamByName('id_section').AsInteger := id_section;
    FDQTemp.Open();
    result := FDQTemp.RecordCount;  // Vrne število zadetkov
  except on E: Exception do
    result := -1;  // Če ni uspešno, vren -1
  end;
end;

function TDataModule1.QDeleteAllSectionsFromTravel(id_travel: Integer): Boolean;
begin
  // Iz tabele Sections izbriši vse sekcije za podan id_travel
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('DELETE FROM Sections WHERE id_travel=:id_travel');
    FDQTemp.ParamByName('id_travel').AsInteger := id_travel;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end;
end;

function TDataModule1.QDeleteSection(id_section: Integer): Boolean;
begin
  // Iz tabele Sections izbriši odesek za podan id_section
  try
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add('DELETE FROM Sections WHERE id_section=:id_section');
    FDQTemp.ParamByName('id_section').AsInteger := id_section;
    FDQTemp.ExecSQL();
    result := True;
  except on E: Exception do
    result := False;
  end
end;

function TDataModule1.QGetAllSectionFromTravel(id_travel: Integer): Integer;
begin
  // izberi vse zapise iz tabele Sections, za pripadajoči id_travel, vrne število zadetkov
  try
    FDQSections.SQL.Clear;
    FDQSections.SQL.Add('SELECT * FROM Sections WHERE id_travel=:id_travel');
    FDQSections.ParamByName('id_travel').AsInteger := id_travel;
    FDQSections.Open();
    result := FDQSections.RecordCount;  // Vrne število zadetkov
  except on E: Exception do
    result := -1;  // Napaka pri izbiri dokumentov, vrne -1
  end;
end;

function TDataModule1.GetSectionClosestNow: Integer;
var
  sql: String;
begin
  // Iz tabele Sections izberi sekcijo, ki ima datum in uro najbljižje trenutnemu datumu in uri
  try
    sql := 'SELECT id_section, id_travel, ' +
          '(julianday(DATE("NOW")) - julianday(date)) + (julianday(TIME("NOW")) - julianday(TIME)) as dif_date_time ' +
          'FROM Sections ORDER by ABS(dif_date_time) ASC';
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add(sql);
    FDQTemp.Open();
    if FDQTemp.RecordCount > 0 then
      result := FDQTemp.FieldByName('id_section').AsInteger  // Vrne id_section, drugače vrne -1
    else
      result := -1;
  except on E: Exception do
    result := -1;
  end
end;


//////////////////////SECTION/////////////////////

function TDataModule1.IsDateTimeBetween(datetime: String; id_section: Integer): Integer;
var
  sql: String;
begin
  // vrne št. zadetkov, če se datum in čas (duration)
  try
    sql := 'SELECT *, DATETIME(DATE(date) || " " || TIME(time)) AS startdatetime, ' +
    'DATETIME(DATE(date) || " " || TIME(DATETIME(time,  "+" || duration || " minutes"))) AS enddatetime ' +
    'FROM Sections WHERE "' + datetime + '" BETWEEN startdatetime AND enddatetime AND id_section<>' + IntToStr(id_section);
    FDQTemp.SQL.Clear;
    FDQTemp.SQL.Add(sql);
    FDQTemp.Open();
    result := FDQTemp.RecordCount;  // Vrne število zadetkov
  except on E: Exception do
    result := -1;  // Napaka pri izbiri dokumentov, vrne -1
  end;
end;

function TDataModule1.QExportData(FDQuery: TFDQuery; table_name, id_name: String; id_value: Integer): Integer;
var
  sql: String;
begin
  // Izvozi podatke
  try
    sql := 'SELECT * FROM ' + table_name + ' WHERE ' + id_name + '=' + IntToStr(id_value);
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add(sql);
    FDQuery.Open();
    result := FDQuery.FieldByName(id_name).AsInteger;    // Vrne število zadetkov
  except on E: Exception do
    result := -1;  // Napaka pri izbiri dokumentov, vrne -1
  end;

end;

function TDataModule1.QImportData(table_name, sql: String): Integer;
begin
  // Izvozi podatke
  try
    if sql <> '' then
    begin
      FDQImportExport.SQL.Clear;
      FDQImportExport.SQL.Add(sql);
      FDQImportExport.ExecSQL();
      result := FDConnection.GetLastAutoGenValue(table_name);
    end else
      result := -1;
  except on E: Exception do
    result := -1;  // Napaka pri izbiri dokumentov, vrne -1
  end;


end;

end.
