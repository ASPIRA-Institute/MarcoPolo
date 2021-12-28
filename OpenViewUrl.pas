unit OpenViewUrl;

interface

uses System.Sensors;

// URLEncode is performed on the URL
// so you need to format it   protocol://path
function OpenURL(const URL: string; const DisplayError: Boolean = False): Boolean;
function OpenNavigation(const Q: string): Boolean; overload;
function OpenNavigation(const Q: string; const Coord: TLocationCoord2D): Boolean; overload;

implementation

uses
  IdURI, SysUtils, Classes, FMX.Dialogs
{$IFDEF ANDROID}
  , FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.JavaTypes, Androidapi.Helpers,
  Androidapi.JNI.App;
{$ELSE}
{$IFDEF MSWINDOWS}
  , Winapi.ShellAPI, Winapi.Windows;
{$ELSE}
{$IFDEF IOS}
  , iOSapi.Foundation, FMX.Helpers.iOS, Macapi.Helpers;
{$ELSE};
{$ENDIF IOS}
{$ENDIF ANDROID}
{$ENDIF MSWINDOWS}


function OpenURL(const URL: string; const DisplayError: Boolean = False): Boolean;
{$IFDEF ANDROID}
var
  Intent: JIntent;
{$ENDIF ANDROID}
{$IFDEF IOS}
var
  NSU: NSUrl;
{$ENDIF IOS}
begin
  try
    {$IFDEF MSWINDOWS}
      ShellExecute(0, 'OPEN', PChar(URL), '', '', SW_SHOWNORMAL);
    {$ENDIF MSWINDOWS}

    {$IFDEF IOS}
      NSU   := StrToNSUrl(TIdURI.URLEncode(URL));
      if SharedApplication.canOpenURL(NSU) then
      begin
        SharedApplication.openUrl(NSU);
      end;
    {$ENDIF IOS}

     {$IFDEF ANDROID}
      Intent := TJIntent.Create;
      Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
      Intent.setData(StrToJURI(URL));
      TAndroidHelper.Activity.startActivity(Intent);
    {$ENDIF ANDROID}
      result := True;
    except on E: Exception do    // ob napaki vrni prazno pot do dokumenta
      result := False;
    end;
end;




function OpenNavigation(const Q: string): Boolean;
var Coord: TLocationCoord2D;
begin
  Coord.Latitude := 0.0;
  Coord.Longitude := 0.0;
  OpenNavigation(Q, Coord);
  result := True;
end;


function OpenNavigation(const Q: string; const Coord: TLocationCoord2D): Boolean;
begin
  //Open in Google Maps
  {$IFDEF ANDROID}
  exit(OpenURL('http://maps.google.com/?q=' + Q));
  {$ELSE}
  {$IFDEF MSWINDOWS}
  exit(OpenURL('http://maps.google.com/?q=' + Q));
  //ShellExecute(0, 'OPEN', PChar(URL), '', '', SW_SHOWNORMAL);
  {$ELSE}
  //In iOS, if Google Maps is installed, use it, otherwise, use Apple Maps
  //If we have coordinates, use them as the start address
  {$IFDEF IOS}
  //Get a string of the longitute and latitute seperated by a comma if set
  if (Coord.Latitude <> 0.0) or (Coord.Longitude <> 0.0) then
  begin
    CoordString := Coord.Latitude.ToString + ',' + Coord.Longitude.ToString;
  end
  else begin
    CoordString := '';
  end;
  if not OpenURL('comgooglemaps://?daddr=' + Q) then
  begin
    if (0.0 < CoordString.Length) then
    begin
      exit(OpenURL('http://maps.apple.com/?daddr=' + Q + '&saddr=loc:' + CoordString));
    end
    else begin
      exit(OpenURL('http://maps.apple.com/?daddr=' + Q));
    end;
  end
  else begin
    exit(true);
  end;
  {$ELSE}
  //Unsupported platform
  exit(false);
  {$ENDIF IOS}
  {$ENDIF ANDROID}
  {$ENDIF MSWINDOWS}
end;


end.
