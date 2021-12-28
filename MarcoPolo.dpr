program MarcoPolo;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {frmMain},
  uSplash in 'uSplash.pas' {frmSplash},
  uShared in 'uShared.pas',
  uDatabase in 'uDatabase.pas' {DataModule1: TDataModule},
  FMX.ListView in 'FMX.ListView.pas',
  FMX.ListView.Types in 'FMX.ListView.Types.pas',
  OpenViewUrl in 'OpenViewUrl.pas',
  uImportExport in 'uImportExport.pas',
  uItemHeaderColor in 'uItemHeaderColor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

