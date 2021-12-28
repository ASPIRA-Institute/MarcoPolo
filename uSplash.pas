unit uSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Effects,
  FMX.Filter.Effects, FMX.Ani;

type
  TfrmSplash = class(TForm)
    tmrSplash: TTimer;
    imgBackGround: TImage;
    imgNapisiOzadja: TImage;
    RippleTransitionEffect1: TRippleTransitionEffect;
    tmrRiipleTransition: TTimer;
    RippleTransitionEffect2: TRippleTransitionEffect;
    labAppInfo: TLabel;
    procedure tmrSplashTimer(Sender: TObject);
    procedure tmrRiipleTransitionTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    progress:Integer;
    procedure LoadMainForm();    // Naloži glavno formo
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.fmx}
uses uMain;

{ TfrmSplash }

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  //imgNapisiOzadja.Visible:=False;
  progress:=100;
  RippleTransitionEffect1.Enabled:=True;
  RippleTransitionEffect2.Enabled:=True;
  tmrRiipleTransition.Enabled:=True;

  tmrSplash.Enabled:=True;
end;

procedure TfrmSplash.LoadMainForm;
type
  TFormClass = class of TForm;
var
  form: TForm;
  formClass: TFormClass;
begin
  formClass:= nil;
  formClass:= TfrmMain;

  form:= formClass.Create(Application);
  form.Show;
  Application.MainForm:= form;
  Close;

end;

procedure TfrmSplash.tmrRiipleTransitionTimer(Sender: TObject);
begin
  // prikaži efekt Riiple
  if progress>0 then
  begin
    Dec(progress);
    RippleTransitionEffect1.Progress:=progress;
    RippleTransitionEffect2.Progress:=progress;
  end;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrRiipleTransition.Enabled:=False;
  tmrSplash.Enabled:=False;
  LoadMainForm();
end;

end.
