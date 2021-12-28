unit uShared;

interface
uses SysUtils, System.IOUtils, System.UITypes, FMX.Maps,
{$IFDEF Android}
Androidapi.Helpers,
ANdroidapi.JNI.JavaTypes,
Androidapi.JNI.GraphicsContentViewText,
Androidapi.JNI.App,
{$ENDIF}
{$IFDEF MSWINDOWS}
System.Types, Winapi.Windows,
{$ENDIF}
System.RegularExpressions;


const
  select_header_text_color = TAlphaColors.Red;       // privzeta barva označenega besedila glave in noge
  select_item_background_color = TAlphaColors.Lightblue;  // privzeta barva označenega predmeta (Item)

function GetMarcoPoloPath(): String;
function ParseDateFromSQLite(const DateStr: String): TDateTime;   // Pretvori SQLite Data (yyyy-mm-dd) format v TDateTime
function ParseTimeFromSQLite(const TimeStr: String): TTime;   // Pretvori SQLite Time (hh:mm:ss) Format v TTime
function TrimAll(text: String): String; // Iz stringa pobriše VSE presledke
function ExtractGPS(text: String): TMapCoordinate; // Iz stringa izloči GPS koordinate, če obstjajo
function GetVersionInfo(): String;

implementation

function GetVersionInfo(): String;
var
{$IFDEF Android}
  PkgInfo: JPackageInfo;
{$ENDIF}
{$IFDEF MSWINDOWS}
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
{$ENDIF}
begin
  // vrne različico aplikacije
{$IFDEF Android}
	//PkgInfo := SharedActivity.getPackageManager.getPackageInfo(SharedActivity.getPackagename, 0);
  PkgInfo := TAndroidHelper.Activity.getPackageManager.getPackageInfo(TAndroidHelper.Activity.getPackageName, 0);
	result := JStringToString(pkgInfo.VersionName);
	//result := JStringToString(pkgInfo.packageName);
	//result := JStringToString(pkgInfo.versionCode);
{$ENDIF}
{$IFDEF MSWINDOWS}
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d.%d.%d',
    [LongRec(FixedPtr.dwFileVersionMS).Hi,  //major
     LongRec(FixedPtr.dwFileVersionMS).Lo,  //minor
     LongRec(FixedPtr.dwFileVersionLS).Hi,  //release
     LongRec(FixedPtr.dwFileVersionLS).Lo]) //build
{$ENDIF}
end;

function TrimAll(text: String): String;
begin
	// Izloči vse presledke v besedilu
	result := text.Replace(' ', '');
end;

function ExtractGPS(text: String): TMapCoordinate;
var
	matches: TMatchCollection;
	gps, latitude, longitude: String;
	map_coord: TMapCoordinate;
  //FormatSettings: TFormatSettings;
begin
	// Iz stringa izloči GPS koordinate, če obstjajo
  // čejih obstaja več, izloči samo prve
	matches := TRegEx.Matches(text, '(?:((?:[-+]?\d{1,2}[.]\d+),\s*(?:[-+]?\d{1,3}[.]\d+))|(\d{2,3}°\d{2}"\d{2,3}' +
                            '\.\d\"[N|S]\s\d{2,3}°\d{2}"\d{2,3}\.\d\"[E|W]))');
	if matches.Count > 0 then
	begin
		gps := TrimAll(matches.Item[0].Value);
		latitude := gps.SubString(0, Pos(',', gps) - 1);
		longitude := gps.Substring(Pos(',', gps), gps.Length);
    latitude := latitude.Replace('.', FormatSettings.DecimalSeparator);
    longitude := longitude.Replace('.', FormatSettings.DecimalSeparator);
		map_coord.Latitude := StrToFloat(latitude);
		map_coord.Longitude := StrToFloat(longitude);
	end else
	begin
		map_coord.Latitude := -1;
		map_coord.Longitude := -1;
	end;
	result := map_coord;
end;


function GetMarcoPoloPath(): String;
begin
  Result := TPath.Combine(TPath.GetDocumentsPath, 'MarcoPolo');
end;



function ParseDateFromSQLite(const DateStr: String): TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  // Pretvori SQLite Data (yyyy-mm-dd) format v TDateTime
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'YYYY-MM-DD';
  Result := StrToDate(DateStr, FormatSettings);
end;

function ParseTimeFromSQLite(const TimeStr: String): TTime;
var
  FormatSettings: TFormatSettings;
begin
  // Pretvori SQLite Time (hh:mm:ss) Format v TTime
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortTimeFormat := 'hh:mm:ss';
  Result := StrToTime(TimeStr, FormatSettings);
end;

end.
