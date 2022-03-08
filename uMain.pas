unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Ani, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView,
  FMX.Layouts, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Platform, FMX.ListBox, FMX.Colors, FMX.Edit, System.ImageList,
  FMX.ImgList, FMX.ExtCtrls, FMX.DateTimeCtrls, FMX.EditBox,
  {$IFDEF Android}
  DW.android.Helpers, DW.FilesSelector, FMX.VirtualKeyboard, Posix.Unistd, Androidapi.JNI.Support, Androidapi.JNI.App,
  {$ENDIF}
  FMX.NumberBox, FMX.Media, System.Permissions, FMX.DialogService, System.Messaging,
  FMX.Gestures, FMX.Effects, uDatabase, FireDAC.Stan.StorageJSON,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.MultiView,
  uItemHeaderColor,
  DW.VKVertScrollbox, FMX.Maps, FMX.WebBrowser, HtmlLabel; // scrollable form KASTRI


type
  TfrmMain = class(TForm)
    layMenuAdd: TLayout;
    rctMenuAdd: TRectangle;
    AnimationMenu: TFloatAnimation;
    layBottomMenu: TLayout;
    tacMain: TTabControl;
    taiTravelsSections: TTabItem;
    livTravelsSections: TListView;
    recTravel: TRectangle;
    layTravelTopMenu: TLayout;
    Label5: TLabel;
    taiAddTravel: TTabItem;
    layAddTravelTopMenu: TLayout;
    labAddEditTravel: TLabel;
    taiAddSection: TTabItem;
    layAddSectionTopMenu: TLayout;
    labAddEditSection: TLabel;
    taiDocuments: TTabItem;
    layDocumentsTopMenu: TLayout;
    Label2: TLabel;
    taiAddDocument: TTabItem;
    layAddDocumentTopMenu: TLayout;
    labAddEditDocument: TLabel;
    taiDebug: TTabItem;
    layDebug: TLayout;
    labDebug: TLabel;
    rectDebugg: TRectangle;
    rectAddTravel: TRectangle;
    rectAddSection: TRectangle;
    rectDocuments: TRectangle;
    rectAddDocuments: TRectangle;
    ActionListTabs: TActionList;
    ChangeTabActionAddTravel: TChangeTabAction;
    ChangeTabActionAddSection: TChangeTabAction;
    ChangeTabActionAddDocument: TChangeTabAction;
    ChangeTabActionDocuments: TChangeTabAction;
    ChangeTabActionTravel: TChangeTabAction;
    Label7: TLabel;
    edtTravelTitle: TEdit;
    gplTravelColor: TGridPanelLayout;
    recTravelColor: TRectangle;
    Label8: TLabel;
    Label9: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    cobTransportType: TComboBox;
    Label10: TLabel;
    edtSectionTitle: TEdit;
    Label11: TLabel;
    dteSectionStartDate: TDateEdit;
    Label12: TLabel;
    tieSectionStartTime: TTimeEdit;
    Label13: TLabel;
    GridPanelLayout2: TGridPanelLayout;
    GridPanelLayout3: TGridPanelLayout;
    Label14: TLabel;
    Label15: TLabel;
    imgTransportType: TImage;
    lbiBus: TListBoxItem;
    lbiTrain: TListBoxItem;
    lbiTram: TListBoxItem;
    lbiTrolleybus: TListBoxItem;
    lbiAriplain: TListBoxItem;
    lbiTaxi: TListBoxItem;
    lbiCar: TListBoxItem;
    lbiFerry: TListBoxItem;
    lbiShip: TListBoxItem;
    lbiWalk: TListBoxItem;
    lbiMotorcycle: TListBoxItem;
    lbiBicycle: TListBoxItem;
    lbiBorder: TListBoxItem;
    lbiBalloon: TListBoxItem;
    lbiCableCar: TListBoxItem;
    lbiHelicopter: TListBoxItem;
    ClearEditButton1: TClearEditButton;
    edtLongitude: TNumberBox;
    edtEstimatedTravelTime: TNumberBox;
    edtLatitude: TNumberBox;
    ClearEditButton2: TClearEditButton;
    GridPanelLayout4: TGridPanelLayout;
    Label16: TLabel;
    Label17: TLabel;
    edtDocumentTitle: TEdit;
    ClearEditButton3: TClearEditButton;
    OpenDialog: TOpenDialog;
    labDocumentPath: TLabel;
    layAddSection: TLayout;
    taiCamera: TTabItem;
    imgCameraView: TImage;
    layCameraTopMenu: TLayout;
    layCameraBottomMenu: TLayout;
    CameraComponent: TCameraComponent;
    Rectangle1: TRectangle;
    ChangeTabActionCamera: TChangeTabAction;
    livDocuments: TListView;
    PreviousTabAction: TPreviousTabAction;
    NextTabAction: TNextTabAction;
    libNon: TListBoxItem;
    layBTNAddTravel: TLayout;
    layBTNAddSection: TLayout;
    SaveDialog: TSaveDialog;
    muvMainMenu: TMultiView;
    layBTNExit: TLayout;
    layBTNExportData: TLayout;
    layBTNImportData: TLayout;
    laySeperatorSolid: TLayout;
    linSeperatorSolid: TLine;
    layBTNInfo: TLayout;
    taiInfo: TTabItem;
    recInfo: TRectangle;
    labInfo: TLabel;
    ChangeTabActionInfo: TChangeTabAction;
    layBTNDebug: TLayout;
    ChangeTabActionDebug: TChangeTabAction;
    laySeperatorDot: TLayout;
    linSeperatorDot: TLine;
    ChangeTabActionSettings: TChangeTabAction;
    layAboutLogo: TLayout;
    imgAboutLogoEarth: TImage;
    labMarcoPolo: TLabel;
    labVersionInfo: TLabel;
    labVerion: TLabel;
    gplInfoIcons: TGridPanelLayout;
    imgAboutLogoPlain: TImage;
    timAboutAnimation: TTimer;
    labAboutHelp: TLabel;
    shaLNKAboutHelp: TShadowEffect;
    btnCopyDB2Android: TButton;
    cbStyled: TCheckBox;
    ccbTravelColor: TColorListBox;
    vsbAddTravelKeyboard: TVertScrollBox;
    memAddSectionNote: TMemo;
    layAddSectionNote: TLayout;
    Label6: TLabel;
    layAddTravel: TLayout;
    layAddTravelNote: TLayout;
    Label4: TLabel;
    vsbAddSectionKeyboard: TVertScrollBox;
    memTravelNote: TMemo;
    vsbInfo: TVertScrollBox;
    StyleBook1: TStyleBook;
    Label18: TLabel;
    btnCopyDBFROMAndroid: TButton;
    imgBTNDebugBack: TSpeedButton;
    imgBTNInfoBack: TSpeedButton;
    imgAboutWWW: TSpeedButton;
    imgAboutMail: TSpeedButton;
    imgAboutFB: TSpeedButton;
    imgAboutYoutube: TSpeedButton;
    imgBTNHome: TSpeedButton;
    imgBTNMeinMenu: TSpeedButton;
    imgBTNCamerePicCancle: TSpeedButton;
    imgBTNSavePicture: TSpeedButton;
    imgBTNCameraBack: TSpeedButton;
    imgBTNRotateCamera: TSpeedButton;
    imgBTNTorch: TSpeedButton;
    imgBTNCaptureImage: TSpeedButton;
    imgBTNSaveDocument: TSpeedButton;
    imgBTNAddDocumentBack: TSpeedButton;
    imgBTNSelectDocument: TSpeedButton;
    imgBTNPhotoCamera: TSpeedButton;
    imgBTNDocumentsBack: TSpeedButton;
    imgBTNDeleteDocument: TSpeedButton;
    imgBTNEditDocument: TSpeedButton;
    imgBTNSaveSection: TSpeedButton;
    imgBTNAddSectionBack: TSpeedButton;
    imgBTNPasteGPS: TSpeedButton;
    imgBTNSaveTravel: TSpeedButton;
    imgBTNTravelBack: TSpeedButton;
    imgBTNNavigation: TSpeedButton;
    imgBTNDeleteTravelsSection: TSpeedButton;
    imgBTNEditTravelsSections: TSpeedButton;
    imgBTNHomeMeinMenu: TSpeedButton;
    imgBTNImportData: TSpeedButton;
    imgBTNInfo: TSpeedButton;
    imgBTNDebug: TSpeedButton;
    imgBTNExit: TSpeedButton;
    imgBTNAddTravel: TSpeedButton;
    imgBTNAddSection: TSpeedButton;
    cirButtonMeni: TSpeedButton;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    HtmlCopyright1: THtmlLabel;
    HtmlCopyright2: THtmlLabel;
    HtmlCopyright3: THtmlLabel;
    HtmlCopyright4: THtmlLabel;
    HtmlCopyright5: THtmlLabel;
    HtmlCopyright6: THtmlLabel;
    HtmlCopyright7: THtmlLabel;
    HtmlCopyright8: THtmlLabel;
    HtmlCopyright9: THtmlLabel;
    HtmlCopyright10: THtmlLabel;
    HtmlCopyright11: THtmlLabel;
    HtmlCopyright12: THtmlLabel;
    clrEstimatedTravelTime: TClearEditButton;
    clrLatitude: TClearEditButton;
    clrLongitude: TClearEditButton;
    imgButton: TImageList;
    imlTransportType: TImageList;
    imlFileExtension: TImageList;
    procedure rctMenuAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tacMainChange(Sender: TObject);
    procedure btnCopyDB2AndroidClick(Sender: TObject);
    procedure cobTransportTypeChange(Sender: TObject);
    procedure livTravelsSectionsItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure livTravelsSectionsItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure imgBTNSelectDocumentClick(Sender: TObject);
    procedure imgBTNCameraBackClick(Sender: TObject);
    procedure CameraComponentSampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure edtDocumentTitleChange(Sender: TObject);
    procedure imgBTNCaptureImageClick(Sender: TObject);
    procedure livDocumentsItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgBTNSaveSectionClick(Sender: TObject);
    procedure imgBTNEditTravelsSectionsClick(Sender: TObject);
    procedure imgBTNMouseEnter(Sender: TObject);
    procedure imgBTNMouseLeave(Sender: TObject);
    procedure imgBTNDeleteDocumentClick(Sender: TObject);
    procedure livTravelsSectionsUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure imgBTNRotateCameraClick(Sender: TObject);
    procedure imgBTNSettingsBackClick(Sender: TObject);
    procedure cbStyledChange(Sender: TObject);
    procedure timAboutAnimationTimer(Sender: TObject);
    procedure imgAboutYoutubeClick(Sender: TObject);
    procedure labAboutHelpClick(Sender: TObject);
    procedure imgAboutLogoPlainDblClick(Sender: TObject);
    procedure imgAboutLogoPlainTap(Sender: TObject; const Point: TPointF);
    procedure ccbTravelColorChange(Sender: TObject);
    procedure muvMainMenuStartHiding(Sender: TObject);
    procedure muvMainMenuStartShowing(Sender: TObject);
    procedure imgBTNHomeClick(Sender: TObject);
    procedure imgBTNTorchClick(Sender: TObject);
    procedure btnCopyDBFROMAndroidClick(Sender: TObject);
    procedure imgBTNDebugBackClick(Sender: TObject);
    procedure imgBTNInfoBackClick(Sender: TObject);
    procedure imgAboutWWWClick(Sender: TObject);
    procedure imgAboutMailClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure imgBTNCamerePicCancleClick(Sender: TObject);
    procedure imgBTNSavePictureClick(Sender: TObject);
    procedure imgBTNSaveDocumentClick(Sender: TObject);
    procedure imgBTNAddDocumentBackClick(Sender: TObject);
    procedure imgBTNPhotoCameraClick(Sender: TObject);
    procedure imgBTNDocumentsBackClick(Sender: TObject);
    procedure imgBTNEditDocumentClick(Sender: TObject);
    procedure imgBTNPasteGPSClick(Sender: TObject);
    procedure imgBTNSaveTravelClick(Sender: TObject);
    procedure imgBTNNavigationClick(Sender: TObject);
    procedure imgBTNDeleteTravelsSectionClick(Sender: TObject);
    procedure btnBack2TravelClick(Sender: TObject);
    procedure imgBTNHomeMeinMenuClick(Sender: TObject);
    procedure imgBTNImportDataClick(Sender: TObject);
    procedure imgBTNInfoClick(Sender: TObject);
    procedure imgBTNDebugClick(Sender: TObject);
    procedure imgBTNExitClick(Sender: TObject);
    procedure imgBTNAddSectionClick(Sender: TObject);
    procedure imgBTNAddTravelClick(Sender: TObject);
    procedure cirButtonMeniClick(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
    procedure HtmlCopyright1LinkClick(const ASender: TObject;
      const AHRef: string);
    procedure clrLongitudeClick(Sender: TObject);
    procedure clrLatitudeClick(Sender: TObject);
    procedure clrEstimatedTravelTimeClick(Sender: TObject);
    procedure edtLongitudeKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtLatitudeKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
    easter_egg_direction: Integer;       // EasterEgg, ob dvokliku na logo, se smer potovanja letala obrne
    edit_mode: Boolean;    // označuje ali zapis dodajamo ali urejamo
    old_file: String; // ime in pot do datoteke, ki jo bomo izbrisali
  {$IFDEF Android}
    FSelector: TFilesSelector;  // KASTRI, FileSelector
    importing_db: Boolean;
  {$ENDIF}
    FSavedCameraActive: Boolean;  // kamera
    // Kamera
    procedure DisplayCameraPreviewFrame();
    procedure SetTorchOn(on_off: Boolean);
    // Ostalo
    procedure SetBTNEffect(Sender: TObject; enabled: Boolean);
    procedure SetEditDeleteButton();  // Nastavi gumbe za popravljanje in brisanje zapisov
    procedure EnableNavigationButton(); // omogoči/onemogoči gumb za navigacijo (glede na to ali so vpisane koordinate)
    procedure ApplicationEventChangedHandler(const Sender: TObject; const AMessage: TMessage);
    procedure HideMenuAdd();  // Skrij meni za dodajanje poti in odseka poti(Obrni animacijo)
    procedure FillTravelsSections(); // Napolni ListView Potovanja in Sekcij
    procedure ClearFormAddTravel();    // Počisti formo za dodajanje Potovanja
    procedure FillFormAddTravel(id_travel: Integer);  // Napolni formo AddTravel s podatki, glede na podan id_travel
    procedure ClearFormAddDocument();   // Počisti formo za dodajanje dokumenta
    procedure FillFormAddDocument(id_document: Integer);  // Napolni formo AddDocument s podatki, glede na id_document
    procedure ClearFormAddSection(); // Počisto formo za dodajanje sekcije poti
    procedure FillFormAddSection(id_section: Integer); // Napolni formo AddSection s podatki, glede na podan id_section
    function CheckSectionDateTime(date: TDate; time: TTime; duration: Integer; id_section: Integer): Boolean; // Preveri ali se datum in čas, ter predviden čas potovanja prekriva z že obstoječim (izloči zapis, ki ga urejamo id_section)
    procedure SelectAllItemsBetweanHeader(start_header: Integer);    // Izberi vse sekcije med izbranim potovanjem, klik na Header
    procedure SelectAllItemsBetweanFooter(start_footer: Integer);    // Izberi vse sekcije med izbranim potovanjem, klik na Footer
    procedure FillDocuments(id_section: Integer);
    procedure ShowDocuments(file_path:String);
    function CopyDocument(): String;  // kopiraj dokument v Documents lokalno mapo
    function DeleteDocument(id_document: Integer): Boolean; // Izbriši dokument iz mape Documents in iz podatkovne baze
    function DeleteDocumentsInSection(id_section: Integer): Boolean; // izbriši vse dokumente sekcije iz mape Documents in iz podatkovne baze
    function DeleteSectionsInTravel(id_travel: Integer): Boolean; // izbriši vse osdeke poti in njihove dokumente

    procedure ResetListViewColor(listview: TListView);
    function SelectListViewItem(list_view: TListView; id_item: Integer): Boolean;
    function SelectItemByID(list_view: TListView; id_name: String; id_value: Integer): Integer;
    procedure ImportDataFromFile(id_travel: Integer; zip_file: String);

  {$IFDEF Android}
    procedure SelectorCompleteHandler(Sender: TObject; const AOK: Boolean);  // KASTRI, FileSelector
    procedure DisplayRationale(Sender: TObject; const APermissions: TArray<string>; const APostRationaleProc: TProc);
    procedure ActivateCameraPermissionRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
    procedure ExternalStorageRequestResult(Sender: TObject; const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>);
  {$ENDIF}
    procedure ShowMessageDlgOK(text: String); // Prikaži dialog z obvestilom in gumbom ok
    procedure ShowHTMLCopyright();
    procedure SaveFormState();
    procedure LoadFormState();
   // SE NE UPORABLJA ALI JE V DEBUG ZAČASNO
   //procedure ShowASyncMessage(text: String);  // Prikaži asinhrono obvestilo na zaslonu
  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;

implementation

uses
  System.IOUtils, uShared, System.DateUtils,
{$IFDEF Android}
  Androidapi.Helpers,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net,
  Androidapi.JNI.Webkit,
{$ENDIF}
{$IFDEF MSWINDOWS}
 ShellApi, Winapi.Windows,
{$ENDIF}
  System.Math, StrUtils,
  uImportExport,
  FMX.Surfaces, System.Rtti,
  OpenViewUrl, System.Sensors, FireDAC.Stan.Intf, FMX.MultiResBitmap;   // DEBUG System.IOUtils

{$R *.fmx}
procedure TfrmMain.btnBack2TravelClick(Sender: TObject);
begin
  // Prikaži formo (zavihek) Potovanja  (Gumb Home)
  edit_mode := False;
  muvMainMenu.HideMaster;
  labAddEditTravel.Text := 'Dodaj Potovanje';
  labAddEditSection.Text := 'Dodaj Odsek';
  ExecuteAction(ChangeTabActionTravel);
end;

procedure TfrmMain.cirButtonMeniClick(Sender: TObject);
begin
  // če je forma (zavihek) Dokument
  if (tacMain.ActiveTab = taiDocuments) then
  begin
    // Počisti formo za dodajanje dokument
    ClearFormAddDocument();
    labAddEditDocument.Text := 'Dodaj Dokument';
    // Prikaži formo (zavihek) za dodajanje dokumentov
    ExecuteAction(ChangeTabActionAddDocument);
  end else
  begin
    // Če ni izbran noben predmet (Item),potem ne prikaži menija za dodajanje odseka
    if livTravelsSections.Selected = nil then
      layBTNAddSection.Enabled := False
    else
      layBTNAddSection.Enabled := True;

    ClearFormAddSection();
    // Prikaži / Skrij meni za dodajanje poti in odseka poti (animiran)
    if AnimationMenu.Inverse = True then
    begin
      // Prikaži meni
      layMenuAdd.Position.Y :=  Self.Height + 20;
      layMenuAdd.Visible :=  true;
      AnimationMenu.Inverse :=  False;
      AnimationMenu.StartValue :=  Self.Height + 20;
      AnimationMenu.StopValue :=  0;
      AnimationMenu.Start;
    end else
    begin
      // Skrij meni za dodajanje potovanja ali odseka poti
      HideMenuAdd();
    end;
  end;
end;

procedure TfrmMain.rctMenuAddClick(Sender: TObject);
begin
  // klik na polje mimo gumbov skrije meni za dodajanje potovanja/ odseka poti
  HideMenuAdd();
end;

procedure TfrmMain.tacMainChange(Sender: TObject);
begin
  // Ob menjavi zavihka, skrij gumb Dodaj, če so zavihki za dodajanje potovanja, odseka ali dokumenta
  if (tacMain.ActiveTab = taiTravelsSections) OR  (tacMain.ActiveTab = taiDocuments) then
    cirButtonMeni.Visible :=  True
  else
    cirButtonMeni.Visible :=  False;

  // Če je prikazan zavihek Kamera, jo akrtiviraj, drugače jo deaktiviraj
  if (tacMain.ActiveTab = taiCamera) then
  begin
    CameraComponent.Active :=  True;
    imgBTNRotateCamera.Enabled := True;  // omogoči gumb za menjavo kamere, sprenja / zadnja
    imgBTNCaptureImage.Enabled := True;  // omogoči gumb za zajem slike
    SetTorchOn(False);
  end;

  // Če je prikazan zavihek Info, jo akrtiviraj animacijo avijona
  if (tacMain.ActiveTab = taiInfo) then
    timAboutAnimation.Enabled := True
  else
    timAboutAnimation.Enabled := False;

  if (tacMain.ActiveTab = taiAddSection) then
    vsbAddSectionKeyboard.ViewportPosition := PointF(vsbAddSectionKeyboard.ViewportPosition.X, 0);  // postavimo se na vrh forme
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ASyncService : IFMXDialogServiceASync;
{$IFDEF Android}
  FPermissionCamera: string;  //kamera
  FPremissionExternaStorage: String; // WRITE_EXTERNAL_STORAGE
{$ENDIF}
begin
    inherited;
  // Ob ustvarjanju forme
  easter_egg_direction := -1;  // estr eg, ob dvokliku na logo (Info), se smer potovanja letala obrne
  // priklopi se na podatkovno bazo (če ne obstaja jo ustvari)
  if NOT(DataModule1.QCreateDatabase()) then
  begin
    // priklop na bazo ni uspel, izpiši napako in zapri aplikacijo
    if TPlatformServices.Current.SupportsPlatformService (IFMXDialogServiceAsync, IInterface(ASyncService)) then
    begin
      ASyncService.MessageDialogAsync( 'Napaka pri ustvarjanje ali povezovanju na podatkovno bazo!',
                                      TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
                                       procedure(const AResult: TModalResult)
                                       begin
                                         case AResult of
                                           mrOK: Application.Terminate();
                                         end;
                                       end);
    end;
  end;
  // Edit Mode nastavi na False
  edit_mode := False;
  // Napolni Potovanja in sekcije
  FillTravelsSections();
  // Nastavi privzeto vrednost animacije menija za dodajanje poti in odseka poti
  AnimationMenu.Inverse :=  True;

  // SCROLLABLE FORM KASTRI
  vsbAddSectionKeyboard.ControlsLayout := layAddSection;
  vsbAddTravelKeyboard.ControlsLayout := layAddTravel;

{$IFDEF Android}
  // KASTRI, FileSelector, , Ustvari TFileSelector za izbiro datotek Android in iOS
  FSelector :=  TFilesSelector.Create;
  FSelector.Title :=  'Izberi datoteko';
  FSelector.OnComplete :=  SelectorCompleteHandler;   // Nastavi proceduro za odziv po izbranem dokumentu
  importing_db := False;
{$ENDIF}
  // Kamera
  imgBTNCamerePicCancle.Visible := False;   // Skrij gumb za razveljavitev slikanja
  imgBTNSavePicture.Visible := False;       // Skrij gumb za shranjevanje slike
  TMessageManager.DefaultManager.SubscribeToMessage(TApplicationEventMessage, ApplicationEventChangedHandler);
{$IFDEF Android}
  // Kamera
  FPermissionCamera :=  JStringToString(TJManifest_permission.JavaClass.CAMERA);
  // Preveri ali ima aplikacija dostop do kamere in če ne jo zahtevaj
  if (NOT PermissionsService.IsPermissionGranted(FPermissionCamera)) then
    PermissionsService.RequestPermissions([FPermissionCamera], ActivateCameraPermissionRequestResult, DisplayRationale);
  // Write WRITE_EXTERNAL_STORAGE
  FPremissionExternaStorage :=  JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  // Preveri ali ima aplikacija dostop do Externa_storage in če ne jo zahtevaj
  if (NOT PermissionsService.IsPermissionGranted(FPremissionExternaStorage)) then
      PermissionsService.RequestPermissions([FPremissionExternaStorage], ExternalStorageRequestResult, DisplayRationale);
{$ENDIF}
  // Nastavi privzeti zavihek (Potovanja)
  SetEditDeleteButton();
  tacMain.ActiveTab :=  taiTravelsSections;
  // nastavi Copyright besedilo v info zavihku
  ShowHTMLCopyright();

{$IFDEF DEBUG}
  taiDebug.Visible := True;
  layBTNDebug.Visible := True;
{$ELSE}
  taiDebug.Visible := False;
  layBTNDebug.Visible := False;
{$ENDIF}
  SelectItemByID(livTravelsSections, 'id_section', DataModule1.GetSectionClosestNow());
  SaveState.StoragePath := TPath.GetHomePath;
  LoadFormState(); // load last form state
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
{$IFDEF Android}
  FSelector.Free;
{$ENDIF}
  inherited;
end;

procedure TfrmMain.imgBTNMouseEnter(Sender: TObject);
begin
  // Ob miškinem kazalcu nad gumbom, vključi efekt sence
  // Za vse TImage gumbe
  SetBTNEffect(Sender, True);
end;

procedure TfrmMain.imgBTNMouseLeave(Sender: TObject);
begin
  // Ob miškinem kazalcu nad gumbom, izključi efekt sence;
  // Za vse TImage gumbe
  SetBTNEffect(Sender, False);
end;


procedure TfrmMain.imgBTNNavigationClick(Sender: TObject);
var
  latitude, longitude: String;
begin
  // Odpri program z navigacijo (google maps) in mu podaj koordinate
  if (DataModule1.QGetSection(livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger) > 0) then
  begin
    // Zamenjaj ,z . pri koordinatah
    latitude := ReplaceStr(DataModule1.FDQTemp.FieldByName('latitude').AsString,',', '.');
    longitude := ReplaceStr(DataModule1.FDQTemp.FieldByName('longitude').AsString,',', '.');
    OpenNavigation(latitude + ', ' + longitude);
  end;
end;

procedure TfrmMain.HideMenuAdd();
begin
  // Skrij meni za dodajanje poti in odseka poti(Obrni animacijo)
  AnimationMenu.Inverse :=  True;
  AnimationMenu.Start;
  layMenuAdd.Visible :=  False;
end;

procedure TfrmMain.HtmlCopyright1LinkClick(const ASender: TObject;
  const AHRef: string);
begin
  // klik na HTMLLabel link
  OpenURL(AHRef);
end;


procedure TfrmMain.FillTravelsSections();
var
  hTitle: String;
  ItemAdd: TListViewItem;
  date: String;
  fdate: TFormatSettings;
  imgSize: TSizeF;
  header_id_travel: Integer;  // id_travel, ki smo ga zapisali v Header, ga moramo zapisati tudi v Footer
  color: Int64;
begin
  // Napolni ListView Potovanja in Sekcije
  livTravelsSections.Items.Clear;
  livTravelsSections.BeginUpdate;
  // nastavi fromat datuma sqlite
  fdate.DateSeparator :=  '-';
  fdate.ShortDateFormat :=  'yyyy-mm-dd';
  date :=  '';
  header_id_travel := -1;
  color := $FF000000;  // black
  // prikaži sliko izbrane vrste prevoznega sredstva
  imgSize.Create(40, 40); // Velikost slike tipa transporta
  if (DataModule1.QGetTravelsSections() > 0) then
  begin
      DataModule1.FDQTravelsSections.First;
      while (not DataModule1.FDQTravelsSections.Eof) do
      begin
        if DataModule1.FDQTravelsSections.FieldByName('date').AsString <> '' then    // če datum sekcije ni prazen, pretvori datum iz formata sqlite v dd.mm.yyyy
          date :=  FormatDateTime('dd.mm.yyyy',StrToDate(DataModule1.FDQTravelsSections.FieldByName('date').AsString, fdate));
        if hTitle<>DataModule1.FDQTravelsSections.FieldByName('title').AsString then   // Če se spremeni naziv Potovanja
        begin
          if (hTitle <> '') then        // Dodaj Footer
          begin
            ItemAdd :=   livTravelsSections.Items.Add;
            ItemAdd.Text :=  'END ' + hTitle;
            ItemAdd.Data['id_travel'] := header_id_travel;
            ItemAdd.Data['color'] := color;
            ItemAdd.Purpose :=  TListItemPurpose.Footer;
          end;
          // Dodaj Header
          ItemAdd :=   livTravelsSections.Items.Add;
          ItemAdd.Text :=  'START ' + DataModule1.FDQTravelsSections.FieldByName('title').AsString;
          header_id_travel := DataModule1.FDQTravelsSections.FieldByName('id_travel').AsInteger;
          ItemAdd.Data['id_travel'] := header_id_travel;
          color := DataModule1.FDQTravelsSections.FieldByName('color').AsInteger;
          ItemAdd.Data['color'] := color;
          ItemAdd.Purpose :=  TListItemPurpose.Header;
          // če ima to potovanje vsaj en odsek, ga dodaj v ListView
          if (DataModule1.FDQTravelsSections.FieldByName('id_section').AsInteger>0) then
          begin
            ItemAdd :=   livTravelsSections.Items.Add;
            ItemAdd.Data['SectionDate'] :=  date;
            ItemAdd.Data['SectionTime'] :=   DataModule1.FDQTravelsSections.FieldByName('time').AsString;
            ItemAdd.Data['SectionTitle'] :=   DataModule1.FDQTravelsSections.FieldByName('title_1').AsString;
            ItemAdd.Data['imgSection'] := imlTransportType.Bitmap(imgSize, DataModule1.FDQTravelsSections.FieldByName('transport_type').AsInteger);  // prikaži sliko tipa transporta
            ItemAdd.Data['id_section'] :=  DataModule1.FDQTravelsSections.FieldByName('id_section').AsInteger;    // v tag zapišemo id_section, če NI to Header ali Footer
            ItemAdd.Data['id_travel'] := DataModule1.FDQTravelsSections.FieldByName('id_travel').AsInteger;
          end;
        end else  // Če se potovanje ni spremenilo
        begin
          ItemAdd :=   livTravelsSections.Items.Add;
          ItemAdd.Data['SectionDate'] :=  date;
          ItemAdd.Data['SectionTime'] :=   DataModule1.FDQTravelsSections.FieldByName('time').AsString;
          ItemAdd.Data['SectionTitle'] :=   DataModule1.FDQTravelsSections.FieldByName('title_1').AsString;
          ItemAdd.Data['id_section'] :=  DataModule1.FDQTravelsSections.FieldByName('id_section').AsInteger;   // v tag zapišemo id_section, če NI to Header ali Footer
          ItemAdd.Data['id_travel']:=DataModule1.FDQTravelsSections.FieldByName('id_travel').AsInteger;
          ItemAdd.Data['imgSection'] := imlTransportType.Bitmap(imgSize, DataModule1.FDQTravelsSections.FieldByName('transport_type').AsInteger);  // prikaži sliko tipa transporta
        end;
        hTitle :=  DataModule1.FDQTravelsSections.FieldByName('title').AsString;
        DataModule1.FDQTravelsSections.Next;
      end;
      ItemAdd := livTravelsSections.Items.Add;
      ItemAdd.Text :=  'END ' + hTitle;
      ItemAdd.Data['id_travel'] := header_id_travel;
      ItemAdd.Data['color'] := color;
      ItemAdd.Purpose :=  TListItemPurpose.Footer;
      livTravelsSections.EndUpdate;
  end;
end;

procedure TfrmMain.ShowMessageDlgOK(text: String);
begin
  // Prikaži okno s sporočilo im gumbom OK
  TDialogService.MessageDialog((text), system.UITypes.TMsgDlgType.mtConfirmation,
  [system.UITypes.TMsgDlgBtn.mbOK], system.UITypes.TMsgDlgBtn.mbOK,0,nil);
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  OpenURL('https://www.facebook.com/Aspira-zavod-za-razvoj-posameznika-in-dru%C5%BEbe-104246438239931');
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
{$IFDEF Android}
var
  FService : IFMXVirtualKeyboardService;
{$ENDIF}
begin
{$IFDEF Android}
  // Upravljaj gumb Back, vrni se za en zavihek nazaj /izpusti zavihka za vnos poti in oddsekapoti)

  if (Key = vkHardwareBack) OR (Key = vkHome) then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then   // če je vidna virtualna tipkovnica, potem ne naredi nič
    begin
      // Back button pressed, keyboard visible, so do nothing...
    end else
    begin
      muvMainMenu.HideMaster;
      if (tacMain.ActiveTab <> taiTravelsSections) then
      begin
        if (tacMain.ActiveTab = taiDocuments) OR (tacMain.ActiveTab = taiAddSection)     // Če smo na zavihku Dokuments, potem pojdi na Travels / Sections zavihek
            OR (tacMain.ActiveTab = taiInfo) then
          ExecuteAction(ChangeTabActionTravel)
        else
          ExecuteAction(PreviousTabAction);   //drugače se vrni za en zavihek nazaj
      end;
        Key := 0; // Nastavi Key = 0 da preprečimo privzeto akcijo
    end;
  end;
{$ENDIF}
end;


procedure TfrmMain.FormSaveState(Sender: TObject);
begin
  SaveFormState();
end;

procedure TfrmMain.ResetListViewColor(listview: TListView);
var
  i: Integer;
begin
  // ponastavi barvo in barvo pisave vseh predmetov v podanem ListView
  listview.BeginUpdate;
  for i := 0 to listview.ItemCount -1 do
  begin
    listview.SetDefaultColorForItem(i);
  end;
  listview.EndUpdate;
end;

procedure TfrmMain.EnableNavigationButton();
var
  longitude, latitude: Float32;
begin
  // omogoči/onemogoči gumb za navigacijo (glede na to ali so vpisane koordinate)
  if (livTravelsSections.ItemIndex > 0) then  // če je predmet (Item) označen
  begin
    if (DataModule1.QGetSection(livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger) > 0) then   // Dobi podatke za označen predmet (Item)
    begin
      longitude := DataModule1.FDQTemp.FieldByName('longitude').AsFloat;
      latitude := DataModule1.FDQTemp.FieldByName('latitude').AsFloat;
      imgBTNNavigation.Enabled := ((longitude>0) AND (latitude>0));   // če so vpisane koordinate, omogoči gumb za navigacijo
    end;
  end else
    imgBTNNavigation.Enabled := False;
end;


procedure TfrmMain.ClearFormAddTravel();
begin
  // Forma Potovanje. Počisti formo.
  edtTravelTitle.Text :=  '';
  ccbTravelColor.Color :=  TAlphaColorRec.Black;
  recTravelColor.Fill.Color :=  ccbTravelColor.Color;
  memTravelNote.Lines.Clear;
  edtTravelTitle.SetFocus;
  vsbAddTravelKeyboard.ViewportPosition := PointF(vsbAddTravelKeyboard.ViewportPosition.X, 0);  // postavimo se na vrh forme
  recTravelColor.Repaint;
end;

procedure TfrmMain.imgBTNEditDocumentClick(Sender: TObject);
begin
  edit_mode := True;  // Urejamo zapis
  labAddEditDocument.Text := 'Uredi Dokument';
  if livDocuments.ItemIndex>-1 then       // Če je kak dokument označenm
  begin
    old_file := livDocuments.Items[livDocuments.ItemIndex].Data['path'].AsString; // shranio staro pot do dokumenta, ki ga boš pri shranejvanju zbiral in shranil novega (če se spremeni)
    FillFormAddDocument(livDocuments.Items[livDocuments.ItemIndex].Data['id_document'].AsInteger);  // Napolni Formo AddDocument
    ExecuteAction(ChangeTabActionAddDocument);  // odpri formo za dodajanje / spreminjanje dokuemnta
  end;
end;

procedure TfrmMain.imgBTNEditTravelsSectionsClick(Sender: TObject);
var
  id_travel: Integer;
  header_footer_selected: Boolean;
begin
  // Uredi Potovanje / Odsek Potovanja
  if livTravelsSections.ItemIndex > -1 then  // če je izbrano potovanje ali odsek poti
  begin
    edit_mode := True; // Urejamo zapis
    header_footer_selected := (livTravelsSections.Items[livTravelsSections.ItemIndex].Purpose = TListItemPurpose.Header) OR
        (livTravelsSections.Items[livTravelsSections.ItemIndex].Purpose = TListItemPurpose.Footer);
    id_travel := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_travel'].AsInteger;
      // če je izbran je Header ali Footer potem uredi potovanje
    if (header_footer_selected = True) then     // uredi potovanje
    begin
      labAddEditTravel.Text := 'Uredi Potovanje';
      if (id_travel > 0) then // če je id_travel > 0 potem lahko urejamo Potovanje
      begin
        vsbAddTravelKeyboard.ViewportPosition := PointF(vsbAddTravelKeyboard.ViewportPosition.X, 0);  // postavimo se na vrh forme
        FillFormAddTravel(id_travel);
        ExecuteAction(ChangeTabActionAddTravel);    // Pokaži zavihek AddTrave
      end;
    end else    // drugače uredi odsek poti
    begin
      labAddEditSection.Text := 'Uredi Odsek';
      FillFormAddSection(livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger);
      ExecuteAction(ChangeTabActionAddSection);    // Pokaži zavihek AddSection
    end;
  end;
end;

procedure TfrmMain.imgBTNExitClick(Sender: TObject);
begin
  // Izhod iz aplikacije
  Application.Terminate;
end;

procedure TfrmMain.imgBTNHomeMeinMenuClick(Sender: TObject);
var
  id_travel, id_section: Integer;
  item_purpose: TListItemPurpose;
  zip_path, msg: String;
begin
  muvMainMenu.HideMaster;
  // Izvoz podatkov
  id_travel := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_travel'].AsInteger;
  id_section := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger;
  item_purpose := livTravelsSections.Items[livTravelsSections.ItemIndex].Purpose;
  // Za android naj bo zip_path = Downloads, za Windows pa ponudi možnost izbire mape kam naj se shrani
{$IFDEF Android}
  zip_path := TPath.Combine(TPath.GetSharedDownloadsPath, 'MarcoPolo_' + FormatDateTime('dd_mm_yyyy_hh_mm_ss', Now) + '.zip'); // nastavi ime in pot do zip dtoteke, ki se bo ustvarila;
  msg := 'Izvoz podatkov je uspel! Datoteka se nahaja v mapi Download.';
{$ENDIF}
{$IFDEF MSWINDOWS}
  SaveDialog.FileName := 'MarcoPolo_' + FormatDateTime('dd_mm_yyyy_hh_mm_ss', Now) + '.zip';
  if SaveDialog.Execute then
  begin
    zip_path := SaveDialog.FileName;
    msg := 'Izvoz podatkov je uspel! Datoteka se nahaja v mapi ' + ExtractFileDir(SaveDialog.FileName) + '.';
  end else
    exit;
{$ENDIF}
  if ExportData(id_travel, id_section, item_purpose, zip_path) then
    ShowMessageDlgOK(msg)
  else
    ShowMessageDlgOK('Napaka pri izvozu podatkov');
end;

procedure TfrmMain.FillFormAddTravel(id_travel: Integer);
begin
  // Napolni formo AddTravel
  if id_travel > 0 then
  begin
    if (DataModule1.QGetTravel(id_travel)) then    // Dobi podatke iz tabele Travels, za podan id_travel
    begin
      edtTravelTitle.Text := DataModule1.FDQTemp.FieldByName('title').AsString;
      memTravelNote.Text := DataModule1.FDQTemp.FieldByName('note').AsString;
      ccbTravelColor.Color := DataModule1.FDQTemp.FieldByName('color').AsInteger;
    end;
    edtTravelTitle.SetFocus;
  end;
end;

procedure TfrmMain.SelectAllItemsBetweanHeader(start_header: Integer);
var
  i: Integer;
begin
  // Označi vse odseke poti na izbranem potovanju, ob kliku na Header
  livTravelsSections.BeginUpdate;
  i :=  start_header + 1;
  repeat
    livTravelsSections.SetCustomColorForItem(i,select_item_background_color);
    inc(i);
  until (i >= livTravelsSections.Items.Count) OR
      (livTravelsSections.Items[i].Purpose = TListItemPurpose.Header) OR
      (livTravelsSections.Items[i].Purpose = TListItemPurpose.Footer);
  livTravelsSections.EndUpdate;
end;


procedure TfrmMain.SelectAllItemsBetweanFooter(start_footer: Integer);
var
  i: Integer;
begin
  // Označi vse odseke poti na izbranem potovanju, ob kliku na Footer
  livTravelsSections.BeginUpdate;
  i :=  start_footer - 1;
  repeat
    livTravelsSections.SetCustomColorForItem(i, uShared.select_item_background_color);
    Dec(i);
  until (i <= 0) OR
      (livTravelsSections.Items[i].Purpose = TListItemPurpose.Header) OR
      (livTravelsSections.Items[i].Purpose = TListItemPurpose.Footer);
  livTravelsSections.EndUpdate;
end;

procedure TfrmMain.imgBTNHomeClick(Sender: TObject);
begin
// Prikaži formo (zavihek) Potovanja  (Gumb Home)
  edit_mode := False;
  muvMainMenu.HideMaster;
  labAddEditTravel.Text := 'Dodaj Potovanje';
  labAddEditSection.Text := 'Dodaj Odsek';
  ResetListViewColor(livTravelsSections);
  SelectItemByID(livTravelsSections, 'id_section', DataModule1.GetSectionClosestNow());
  ExecuteAction(ChangeTabActionTravel);
end;


procedure TfrmMain.livTravelsSectionsItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  EnableNavigationButton(); // omogoči/onemogoči gumb za navigacijo(glede na toče sovpisane koordinate)
  // ob kliku na predmet (item) ponastavi barvo vseh (če je bilo prej več označenih)
  ResetListViewColor(livTravelsSections);
  if (AItem.Purpose = TListItemPurpose.Header) then // če smo izbrali Header ali Footer
  begin
    SelectAllItemsBetweanHeader(AItem.Index);
  end;
  if (AItem.Purpose = TListItemPurpose.Footer)  then
  begin
    SelectAllItemsBetweanFooter(AItem.Index);
  end;
end;

procedure TfrmMain.imgBTNDocumentsBackClick(Sender: TObject);
begin
  // Prikaži formo (zavihek) Potovanja  (Gumb Home)
  edit_mode := False;
  muvMainMenu.HideMaster;
  labAddEditTravel.Text := 'Dodaj Potovanje';
  labAddEditSection.Text := 'Dodaj Odsek';
  ExecuteAction(ChangeTabActionTravel);
end;

procedure TfrmMain.livTravelsSectionsUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  item_header: TListItemHeaderColor;
begin
  // Obarvaj glavo potovanja
  if AItem.Purpose in [TListItemPurpose.Header, TListItemPurpose.Footer] then
  begin
    item_header:= AItem.Objects.FindDrawable('Text') as TListItemHeaderColor;
    if item_header = nil then
    begin
      item_header:= TListItemHeaderColor.Create(AItem);
      item_header.Color:=AItem.Data['color'].AsInteger;
    end;
  end;
end;

procedure TfrmMain.ccbTravelColorChange(Sender: TObject);
begin
  // Forma Potovanje. Spremeni barvo kvadrata, na barvo, ki je bila izbrana iz comboboxa
  recTravelColor.Fill.Color :=  ccbTravelColor.Color;
  recTravelColor.Repaint;
end;


procedure TfrmMain.ClearFormAddSection();
var
  s: TSizeF;
begin
  // prikaži sliko izbrane vrste prevoznega sredstva
  s.Create(44, 44); // Velikost slike
  imgTransportType.Bitmap :=  imlTransportType.Bitmap(s, 0);  // prikaži sliko X
  cobTransportType.ItemIndex := 0;
  edtSectionTitle.Text := '';
  dteSectionStartDate.Date := Now();
  tieSectionStartTime.Time := Now();
  edtEstimatedTravelTime.Value := 0;
  edtLongitude.Value := 0;
  edtLatitude.Value := 0;
  memAddSectionNote.Lines.Clear;
  cobTransportType.SetFocus;
end;

procedure TfrmMain.FillFormAddSection(id_section: Integer);
begin
  // Napolni Formo AddSection, glede na podan id_section
  if id_section>0 then
  begin
    if (DataModule1.QGetSection(id_section) > 0) then // Dobi podatke iz tabele Sections, za podan id_section
    begin
      cobTransportType.ItemIndex := DataModule1.FDQTemp.FieldByName('transport_type').AsInteger;
      edtSectionTitle.Text := DataModule1.FDQTemp.FieldByName('title').AsString;
      dteSectionStartDate.Date := ParseDateFromSQLite(DataModule1.FDQTemp.FieldByName('date').AsString);
      tieSectionStartTime.Time := ParseTimeFromSQLite(DataModule1.FDQTemp.FieldByName('time').AsString);
      memAddSectionNote.Text := DataModule1.FDQTemp.FieldByName('note').AsString;
      edtEstimatedTravelTime.Value := DataModule1.FDQTemp.FieldByName('duration').AsInteger;
      edtLatitude.Value := DataModule1.FDQTemp.FieldByName('latitude').AsFloat;
      edtLongitude.Value:= DataModule1.FDQTemp.FieldByName('longitude').AsFloat;
    end;
    cobTransportType.SetFocus;
  end;
end;


procedure TfrmMain.livTravelsSectionsItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  if ItemObject is TListItemAccessory then   // če smo izbrali puščico
   begin
    if livTravelsSections.Items[ItemIndex].Data['id_section'].AsInteger <> 0 then     // Če že imamo vnešen in izbran odsek poti
    begin
      FillDocuments(livTravelsSections.Items[ItemIndex].Data['id_section'].AsInteger); // napolni zavihek Documents z ustreznimi dokumenti
      ExecuteAction(ChangeTabActionDocuments);   // prikaži zavihek Dokumenti
    end else

      ExecuteAction(ChangeTabActionAddSection);  // prikaži dodajanje odseka
   end;
   SetEditDeleteButton(); // nastavi gumbe za brisanje in urejanje
end;


procedure TfrmMain.clrEstimatedTravelTimeClick(Sender: TObject);
begin
  edtEstimatedTravelTime.Value := 0;
end;

procedure TfrmMain.clrLatitudeClick(Sender: TObject);
begin
  edtLatitude.Value := 0.0;
end;

procedure TfrmMain.clrLongitudeClick(Sender: TObject);
begin
  edtLongitude.Value := 0.0;
end;

procedure TfrmMain.cobTransportTypeChange(Sender: TObject);
var
  s: TSizeF;
begin
  // prikaži sliko izbrane vrste prevoznega sredstva
  s.Create(44, 44); // Velikost slike
  imgTransportType.Bitmap :=  imlTransportType.Bitmap(s, cobTransportType.ItemIndex);  // prikaži sliko iz dropdow menija
  edtSectionTitle.SetFocus;
end;

procedure TfrmMain.edtDocumentTitleChange(Sender: TObject);
begin
  imgBTNSaveDocument.Enabled :=  True;
end;

procedure TfrmMain.edtLatitudeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (KeyChar = '.') OR (KeyChar = ',') then
    KeyChar := FormatSettings.DecimalSeparator;
end;

procedure TfrmMain.edtLongitudeKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (KeyChar = '.') OR (KeyChar = ',') then
    KeyChar := FormatSettings.DecimalSeparator
end;

procedure TfrmMain.imgBTNSaveSectionClick(Sender: TObject);
var
  id_section, id_travel, transport_type, duration: Integer;
  title: String;
  date: TDate;
  time: TTime;
  latitude, longitude: Real;
  last_id_section: Integer;
  note: String;
begin
  if (edit_mode = True) then     // Če urejemo zapis v bazi, nastavi id_section
    id_section := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger
  else    // drugače ga nastavi na -1
    id_section := -1;
  // preveri ali so vnešeni vsi potrebni podatki in ali so pravilni (datum, ura, predviden čas potovanja)
  if (edtSectionTitle.Text <> '')then
  begin
    if (CheckSectionDateTime(dteSectionStartDate.Date, tieSectionStartTime.Time, Trunc(edtEstimatedTravelTime.Value), id_section)) then
    begin
      // Pripravi podatke
      edtSectionTitle.SetFocus;          //(če v NumberBoxu ne potrdimo vnosa z Enter ali z prestavitvijo fokusa, se vrednost ne shrani)
      id_travel := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_travel'].AsInteger;
      transport_type := cobTransportType.ItemIndex;
      title := edtSectionTitle.Text;
      date := dteSectionStartDate.Date;
      time := tieSectionStartTime.Time;
      note := memAddSectionNote.Text;
      duration := Trunc(edtEstimatedTravelTime.Value);
      latitude := edtLatitude.Value;
      longitude := edtLongitude.Value;
      if (edit_mode = True) then     // Urejemo zapis v bazi
      begin
        // dobi id_section, ki ga popravljamo
        id_section := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger;
        DataModule1.QUpdateSection(id_section, id_travel, transport_type, title, date, time, note, duration, latitude, longitude);   // Posodobi zapis za izbran id_section
        FillTravelsSections();     // ponovno napolni podatke v ListVie TravelsSections
        SelectListViewItem(livTravelsSections, id_section);  // Izberi item, ki smo ga popravljali
        ExecuteAction(ChangeTabActionTravel);  // postavi se na zavihet TravelsSections
        labAddEditSection.Text := 'Dodaj Odsek';
        edit_mode := False;
      end else  // Če ni edit_mode = True, potem dodajamo nov zapis v bazo
      begin
        // dobi id_travel
        // preden zapiše vrednosti mora fokus postaviti na nekodrugo polje
        last_id_section := DataModule1.QAddSection(id_travel, transport_type, title, date, time, note, duration, latitude, longitude);
        FillTravelsSections();
        SelectListViewItem(livTravelsSections, last_id_section);  // Izberi item, ki smo dodali
        ClearFormAddDocument();
        ExecuteAction(ChangeTabActionAddDocument);
      end;
    end else
    ShowMessageDlgOK('Datum in ura sta kažeta v preteklost ali pa se prekrivata z drugim datumom in časom potovanja!');
  end else
  ShowMessageDlgOK('Vpišite vse obvezne podatke!');
end;

procedure TfrmMain.imgBTNSaveTravelClick(Sender: TObject);
var
  color: Integer;
  id_travel: Integer;
begin
  // Forma Potovanje. Preveri ali zapis ustreza in dodaj podatke v bazo
  if (edtTravelTitle.Text <> '') then
  begin
    color := ccbTravelColor.Color;
    if (edit_mode = True) then   // če imamo imamo edit_mode nastavljen na True, potem posodabljamo bazo
    begin
      id_travel := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_travel'].AsInteger;
      DataModule1.QUpdateTravel(id_travel, edtTravelTitle.Text, memTravelNote.Text, color);  // Posodobi v bazo
      FillTravelsSections();   // ponovno napolni ListView TravlesSections
      edit_mode := False; // Resetiraj edit_mode,nastavi na False
      labAddEditTravel.Text := 'Dodaj Potovanje';
      SelectAllItemsBetweanHeader(SelectItemByID(livTravelsSections, 'id_travel', id_travel));
      ExecuteAction(ChangeTabActionTravel);    // Pokaži zavihek Travles&Sections
    end else   // drugače v bazo dodajamo nov zapis
    begin
      id_travel := DataModule1.QAddTravel(edtTravelTitle.Text, memTravelNote.Text, color);  // Shrani v bazo
      ClearFormAddTravel();
      FillTravelsSections();   // ponovno napolni ListView TravlesSections
      SelectAllItemsBetweanHeader(SelectItemByID(livTravelsSections, 'id_travel', id_travel));
      ExecuteAction(ChangeTabActionAddSection);    // Pokaži zavihek AddSections
    end;
  end else
    ShowMessageDlgOK('Vpišite vse obvezne podatke!');
end;

function TfrmMain.DeleteSectionsInTravel(id_travel: Integer): Boolean;
var
  id_section: Integer;
begin
  // izbriši vse osdeke poti in njihove dokumente
  try
    DataModule1.QGetAllSectionFromTravel(id_travel);  // izberi vse sekcije iz potovanja
    DataModule1.FDQSections.First;
    while (not DataModule1.FDQSections.Eof) do     // za vsako sekcijo
    begin
      id_section := DataModule1.FDQSections.FieldByName('id_section').AsInteger;  // dobi id_sekcije
      DeleteDocumentsInSection(id_section);   // izbriši vse dokumente
      DataModule1.FDQSections.Next;
      DataModule1.QDeleteSection(id_section);   // na koncu izbriši se sekcijo
    end;
    result := True;
  except on E: Exception do
    result := False;
  end;;
end;

function TfrmMain.CheckSectionDateTime(date: TDate; time: TTime;
                                      duration: Integer;
                                      id_section: Integer): Boolean;
var
  datetime: TDateTime;
  start_datetime, end_datetim: String;
begin
  // Preveri ali se datum in čas,
  // ter predviden čas potovanja prekriva z že obstoječim
  cobTransportType.SetFocus;
  datetime := date + time;
  start_datetime := FormatDateTime('yyyy-mm-dd hh:mm:ss', datetime);
  // Preveri ali je datum in čas začetka poti večji od trenutnega datuma in ure
  if (CompareDateTime(datetime, Now) >= 0) then
  begin
    // Preveri ali začetni in končni datum in čas potovanja
    // sovpada še s katerim od datumov
    end_datetim := FormatDateTime('yyyy-mm-dd hh:mm:ss',IncMinute(datetime,
                                  Trunc(edtEstimatedTravelTime.Value)));
    if ((DataModule1.IsDateTimeBetween(start_datetime, id_section)=0) AND
        (DataModule1.IsDateTimeBetween(end_datetim, id_section)=0))  then
      result := True
    else
      result := False;
  end else
    result := False;
end;

procedure TfrmMain.imgBTNPasteGPSClick(Sender: TObject);
var
  Svc: IFMXClipboardService;
  Value: TValue;
  map_coord: TMapCoordinate;
begin
  // prilepi GPS koordinate iz odložišča
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
  begin
    Value := Svc.GetClipboard;
    if not Value.IsEmpty then    // če odložišče ni prazno
    begin
      if Value.IsType<string> then   // in če je v odložišču besedilo
      begin
        map_coord := ExtractGPS(Value.ToString);
        edtLatitude.Value := map_coord.Latitude;
        edtLongitude.Value := map_coord.Longitude;
      end;
    end;
  end;
end;

procedure TfrmMain.imgBTNPhotoCameraClick(Sender: TObject);
begin
  ExecuteAction(ChangeTabActionCamera);
end;


procedure TfrmMain.ClearFormAddDocument();
begin
  // počisti formo za dodajanje dokumenta
  labDocumentPath.Text := '';
  edtDocumentTitle.Text := '';
end;

procedure TfrmMain.FillDocuments(id_section: Integer);
var
  ItemAdd: TListViewItem;
  imgSize: TSize;
  extension: String;
  Item: TCustomBitmapItem;
begin
  // Napolni ListView Dokumenti
  livDocuments.Items.Clear;
  livDocuments.BeginUpdate;
  if (DataModule1.QGetAllDocumentsFromSection(id_section) > 0) then
  begin
    DataModule1.FDQDocuments.First;
    While (not DataModule1.FDQDocuments.Eof) do
    begin
      ItemAdd :=   livDocuments.Items.Add;
      ItemAdd.Data['title'] := DataModule1.FDQDocuments.FieldByName('title').AsString;
      ItemAdd.Data['path'] := DataModule1.FDQDocuments.FieldByName('path').AsString;
      ItemAdd.Data['id_document'] := DataModule1.FDQDocuments.FieldByName('id_document').AsInteger;
      extension := TPath.GetExtension(DataModule1.FDQDocuments.FieldByName('path').AsString);
      extension := extension.Substring(1,3);
      imgSize.Create(40, 40); // Velikost slike tipa transporta
      if (imlFileExtension.BitmapItemByName(extension, Item, imgSize)) then
        ItemAdd.Data['file_image'] := Item.Bitmap  // prikaži ikono tipa dokumenta
      else
        ItemAdd.Data['file_image'] := imlFileExtension.Bitmap(imgSize, 0);  // prikaži ikono dokumenta neznanega tipa datoteke
      DataModule1.FDQDocuments.Next;
    end;
  end;
  livDocuments.EndUpdate;
end;


procedure TfrmMain.FillFormAddDocument(id_document: Integer);
begin
  if id_document > 0 then
  begin
    if (DataModule1.QGetDocument(id_document)) then
    begin
      labDocumentPath.Text := DataModule1.FDQTemp.FieldByName('path').AsString;
      edtDocumentTitle.Text := DataModule1.FDQTemp.FieldByName('title').AsString;
    end;
  end;
end;

procedure TfrmMain.livDocumentsItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  if ItemObject is TListItemAccessory then   // če smo na dokumentu izbrali puščico
    // prikaži dokument
    ShowDocuments(livDocuments.Items[ItemIndex].Data['path'].AsString);
  SetEditDeleteButton();
end;

procedure TfrmMain.ShowDocuments(file_path: String);
{$IFDEF Android}
var
  LIntent: JIntent;
  LUri: Jnet_Uri;
  mime: JMimeTypeMap;
  ExtToMime: JString;
  file_name: String;
 {$ENDIF}
begin
  // prikaži dokument v zunanjem pregledovalniku
  if file_path<>'' then      // če pot do datotek obstaja, odpri datoteko
  begin
  {$IFDEF Android}
    // ob kliku na dokument v ListView ga prikaži
    // open external viewer
    file_name := TPath.GetFileName(file_path);
    LUri := TAndroidHelper.JFileToJURI(TJFile.JavaClass.init(StringToJString(file_path)));
    LIntent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
    mime := TJMimeTypeMap.JavaClass.getSingleton();
    ExtToMime := mime.getMimeTypeFromExtension(StringToJString(StringReplace(TPath.GetExtension(file_name), '.', '', [])));
    LIntent.setDataAndType(LUri,  ExtToMime);
    LIntent.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);
    TAndroidHelper.Activity.startActivity(LIntent);
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    ShellExecute(GetDesktopWindow, 'open', PChar(file_path), '', '', SW_SHOWNORMAL);
  {$ENDIF}
  end;
end;


procedure TfrmMain.imgBTNSelectDocumentClick(Sender: TObject);
begin
{$IFDEF Android}
  // KASTI, Fileselector, odpri dialog za izbiro datoteke
  FSelector.FileKinds :=  [TFileKind.Image, TFileKind.Audio, TFileKind.Movie, TFileKind.Text, TFileKind.Item, TFileKind.Content, TFileKind.SourceCode];
  FSelector.Select(TSelectionMode.Content);
{$ENDIF}
{$IFDEF MSWINDOWS}
  // Windows odpri dialog za izbiro datoteke
  if OpenDialog.Execute then
  begin
    labDocumentPath.Text :=  OpenDialog.FileName;
    edtDocumentTitle.Text := TPath.GetFileNameWithoutExtension(OpenDialog.FileName);
  end;
{$ENDIF}
  // Nastavi fokus na vnos naziva dokumenta
  edtDocumentTitle.SetFocus;
end;

{$IFDEF Android}
procedure TfrmMain.SelectorCompleteHandler(Sender: TObject; const AOK: Boolean);
var
  id_travel: Integer;
  zip_file: String;
begin
  // KASTRI, FileSelector, ko je zaključena izbira datoteke, prikaži ime datoteke v editboxu naziv datoteke
  if AOK then      // čeje bil izbran kakšen dokument,nastavi pot in naziv datoteke
  begin
    if importing_db then    // če uvažamo podatke iz ZP datoteke
    begin
      if livTravelsSections.ItemIndex > -1 then    // če je izbran vsaj eden Item
      begin
        id_travel := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_travel'].AsInteger;
      end else
      begin
        id_travel := 0;
      end;
      zip_file := TPath.Combine(TPath.GetTempPath(),  FSelector.SelectedFiles[0].DisplayName);
      TAndroidHelperEx.ImportFile(FSelector.SelectedFiles[0].RawPath, zip_file);
      if (zip_file <> '') then
      begin
        ImportDataFromFile(id_travel, zip_file);
        DeleteFile(zip_file);            // pobriši začasno zip datoteko
      end;
      importing_db := False;
    end else  // Dodajanje dokumenta v Sekcijo
    begin
      labDocumentPath.Text :=  FSelector.SelectedFiles[0].RawPath;
      edtDocumentTitle.Text := TPath.GetFileNameWithoutExtension(FSelector.SelectedFiles[0].DisplayName);  // v edtDocumentTitile nastavi ime dokumenta
      // Nastavi fokus na vnos naziva dokumenta
      edtDocumentTitle.SetFocus;
    end;
  end;
end;
{$ENDIF}


procedure TfrmMain.imgBTNSaveDocumentClick(Sender: TObject);
var
  id_section: Integer;
  file_path: String;
  id_document: Integer;
begin
  // Preveri ali so vsi obvezna polja vnešeni
  if (labDocumentPath.Text <> '') AND (edtDocumentTitle.Text <> '') then
  begin
    id_section := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger;
    if (edit_mode = True) then    // Čeje edit_mode nastavljen na True, potem urejamo zapis v bazi
    begin
      // Popravi dokument
      if old_file <> labDocumentPath.text then    // datoteka se je zamenjala
      begin
        // Izbriši staro datoteko in skopiraj novo
        if FileExists(old_file) then      // če stara datoteka še obstaja jo izbriši
          DeleteFile(PChar(old_file));
        file_path := CopyDocument();  // Kopiraj dokument in nastavi pot do dokumenta
        labDocumentPath.Text:=file_path;  // prikaži novo pot do dokumenta v labeli
      end;
      id_document := livDocuments.Items[livDocuments.ItemIndex].Data['id_document'].AsInteger;
      DataModule1.QUpdateDocument(id_document, edtDocumentTitle.Text, labDocumentPath.Text, id_section);
      labAddEditDocument.Text := 'Dodaj Dokument';
      edit_mode := False;
    end else    // drugače zapis dodajamo v bazo
    begin
      // Dodaj dokument v podatkovno bazo
      file_path := CopyDocument();
      labDocumentPath.Text:=file_path;  // prikaži novo pot do dokumenta v labeli
      id_document := DataModule1.QAddDocument(edtDocumentTitle.Text, labDocumentPath.Text, id_section);
    end;
    FillDocuments(id_section);
    // označi dodan dokument v ListView
    SelectListViewItem(livDocuments, id_document);
    SetEditDeleteButton();
    ExecuteAction(ChangeTabActionDocuments);
  end else
    ShowMessageDlgOK('Vpišite vse obvezne podatke!');
end;

procedure TfrmMain.imgBTNSavePictureClick(Sender: TObject);
var
  uniq_filename: String;
  file_path: String;
begin
  // Shrani sliko, deaktiviraj kamero
  CameraComponent.Active := False;
  imgBTNCamerePicCancle.Visible := False;  // Skrij gumb za razveljavitev slikanja
  imgBTNSavePicture.Visible := False;      // Skrij gumb za shranjevanje slike
  imgBTNCameraBack.Visible := True;        // Prikaži gumb nazaj na zavihek AddDocument
  // shrani sliko na disk
  uniq_filename := 'IMG_' + FormatDateTime('yyymmdd_ss', Now) + '.jpg';
  file_path := TPath.Combine(TPath.GetTempPath(), uniq_filename);
  imgCameraView.Bitmap.SaveToFile(file_path);
  labDocumentPath.Text := file_path;
  edtDocumentTitle.Text := TPath.GetFileNameWithoutExtension(uniq_filename);
  // Prikaži formo (zavihek) Dokumenti
  ExecuteAction(ChangeTabActionAddDocument);
end;

function TfrmMain.CopyDocument(): String;
var
  uniq_filename: String;
  file_ext:String;
  file_path: String;
  source_file: String;
begin
  // Kopiraj izbran dokument v lokalno mapo Documents in vrni novo pot do dokumenta
  try
    uniq_filename := TPath.GetGUIDFileName(false);    // dodeli datoteki unikatno ime
    file_ext :=  ExtractFileExt(labDocumentPath.text);  // dobi končnico datotek
{$IFDEF Android}
    if file_ext = '' then    // včasih se zgodi, da je datoteka brez končnice (če npr vzamem iz downloads)
      file_ext := ExtractFileExt(FSelector.SelectedFiles[0].DisplayName);
{$ENDIF}
    // Shrani izbran dokument v mapo GetDocumentsPath() + 'MarcoPolo' + PathDelim + 'Documents'
    file_path := TPath.Combine(GetMarcoPoloPath(), TPath.Combine('Documents', uniq_filename + file_ext));
    ForceDirectories(ExtractFilePath(file_path));
    source_file := labDocumentPath.Text;
{$IFDEF Android}
    if ContainsText(source_file, 'content') then   // če je URI
      TAndroidHelperEx.ImportFile(source_file, file_path)
    else
      TFile.Copy(source_file, file_path, True);
{$ENDIF}
{$IFDEF MSWINDOWS}
    TFile.Copy(source_file, file_path, True);
{$ENDIF}
    // Izbriši vse začasne datoteke, ki so shranjene v TPath.GetTempPath (od fotografiranja)
    if ExcludeTrailingPathDelimiter(ExtractFilePath(source_file)) = ExcludeTrailingPathDelimiter(TPath.GetTempPath()) then
      DeleteFile(PChar(source_file));
    result := file_path;
  except on E: Exception do    // ob napaki vrni prazno pot do dokumenta
    result := '';
  end;
end;


procedure TfrmMain.imgBTNDebugBackClick(Sender: TObject);
begin
  ExecuteAction(ChangeTabActionTravel);
end;

procedure TfrmMain.imgBTNDebugClick(Sender: TObject);
begin
  // Prikaži Debugg
  muvMainMenu.HideMaster;
  ExecuteAction(ChangeTabActionDebug);
end;

procedure TfrmMain.imgBTNDeleteDocumentClick(Sender: TObject);
begin
  // izbriši dokument iz mape in iz podatkovne baze
  TDialogService.MessageDialog(('Ali res želiš izbrisati izbrano datoteko?'), system.UITypes.TMsgDlgType.mtConfirmation,
  [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo], system.UITypes.TMsgDlgBtn.mbYes,0,
  procedure (const AResult: System.UITypes.TModalResult)
  begin
    case AResult of
      mrYES:
      begin
        // Izbriši datoteko iz mape Documents in tudi iz podatkovne baze
        DeleteDocument(livDocuments.Items[livDocuments.ItemIndex].Data['id_document'].AsInteger);
        FillDocuments(livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger); // napolni zavihek Documents z ustreznimi dokumenti
        SetEditDeleteButton();
      end;
    end;
  end);
end;

procedure TfrmMain.imgBTNDeleteTravelsSectionClick(Sender: TObject);
var
  header_footer_selected: Boolean;
  id_travel: Integer;
  id_section: Integer;
begin
  // Izbriši Potovanje / Odsek Potovanja
  if livTravelsSections.ItemIndex > -1 then  // če je izbrano potovanje ali odsek poti
  begin
    header_footer_selected := (livTravelsSections.Items[livTravelsSections.ItemIndex].Purpose = TListItemPurpose.Header) OR
        (livTravelsSections.Items[livTravelsSections.ItemIndex].Purpose = TListItemPurpose.Footer);
    id_travel := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_travel'].AsInteger;

     // če je izbran je Header ali Footer potem izbriši vse dokumente in vse odseke potovanja in tudi izbrano potovanje
    if (header_footer_selected = True) then
    begin
      // briši celotno potovanje (vse dokumente, sekcije in izbrano potovanje)
      TDialogService.MessageDialog(('Ali res želiš izbrisati izbran potovanje, vse odseke poti in vse pripadajoče dokumente?'), system.UITypes.TMsgDlgType.mtConfirmation,
      [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo], system.UITypes.TMsgDlgBtn.mbYes,0,
      procedure (const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYES:
          begin
            // Izbriši datoteko iz mape Documents in tudi iz podatkovne baze
            if DeleteSectionsInTravel(id_travel) then
              DataModule1.QDeleteTravel(id_travel); // če je uspelo brisanje sekcije, izbriši tudi pot
            FillTravelsSections();  // osveži TravelsSections
          end;
        end;
      end);
    end else    // drugače izbriši dokumente in odsek poti, ki je izbran
    begin
      TDialogService.MessageDialog(('Ali res želiš izbrisati izbran odsek poti in vse pripadajoče dokumente?'), system.UITypes.TMsgDlgType.mtConfirmation,
      [system.UITypes.TMsgDlgBtn.mbYes, system.UITypes.TMsgDlgBtn.mbNo], system.UITypes.TMsgDlgBtn.mbYes,0,
      procedure (const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYES:
          begin
            // Izbriši datoteko iz mape Documents in tudi iz podatkovne baze
            id_section := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger;
            if DeleteDocumentsInSection(id_section) then     // če je uspelo brisanje dokuemntov
              DataModule1.QDeleteSection(id_section);  // izbriši tudi sekcijo poti
            // osveži TravelsSections
            FillTravelsSections();  // osveži TravelsSections
          end;
        end;
      end);
    end;
    SetEditDeleteButton();
  end;
end;

function TfrmMain.DeleteDocument(id_document: Integer): Boolean;
var
  file_name: String;
begin
  // Izbriši datoteko iz mape Documents in podatkovne baze
  try
    DataModule1.QGetDocument(id_document);
    file_name := DataModule1.FDQTemp.FieldByName('path').AsString;
    if FileExists(file_name) then      // če obstaja datoteka v mapi Documents
      DeleteFile(PChar(file_name));    // jo izbriši
    DataModule1.QDeleteDocument(id_document);  // Izbriši še iz podatkovne baze
    result := True;
  except on E: Exception do
    result := False;
  end;
end;


function TfrmMain.DeleteDocumentsInSection(id_section: Integer): Boolean;
begin
  // izbriši vse dokumente sekcije iz mape Documents in iz podatkovne baze
  try
    DataModule1.QGetAllDocumentsFromSection(id_section);
    DataModule1.FDQDocuments.First;
    while (not DataModule1.FDQDocuments.Eof) do    // najprej izbriši vse dokumente iz mape Documents, ki pripadajo izbranemu odseku poti, potem vse odseke podane poti
    begin
      DeleteDocument(DataModule1.FDQDocuments.FieldByName('id_document').AsInteger); // izbriši posamezni dokuemnt
      DataModule1.FDQDocuments.Next;
    end;
    result := True;
  except on E: Exception do
    result := False;
  end;
end;


procedure TfrmMain.imgBTNImportDataClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  zip_file: String;
  id_travel: Integer;
{$ENDIF}
begin
  muvMainMenu.HideMaster;
  // Uvoz podatkov
{$IFDEF MSWINDOWS}
  if livTravelsSections.ItemIndex > -1 then    // če je izbran vsaj eden Item
    id_travel := livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_travel'].AsInteger
  else
    id_travel := 0;
  // Windows odpri dialog za izbiro datoteke
  if OpenDialog.Execute then
  begin
    zip_file := OpenDialog.FileName;
    ImportDataFromFile(id_travel, zip_file);
  end;
{$ENDIF}
{$IFDEF Android}
  // KASTI, Fileselector, odpri dialog za izbiro datoteke
  importing_db := True;
  FSelector.FileKinds :=  [TFileKind.Image, TFileKind.Audio, TFileKind.Movie, TFileKind.Text, TFileKind.Item, TFileKind.Content, TFileKind.SourceCode];
  FSelector.Select(TSelectionMode.Content);
{$ENDIF}
end;

procedure TfrmMain.imgBTNInfoBackClick(Sender: TObject);
begin
  // vrni se nazaj na Potovanja / Sekcije
  ExecuteAction(ChangeTabActionTravel);
end;

procedure TfrmMain.imgBTNInfoClick(Sender: TObject);
begin
  // Prikaži informacije o programu
  muvMainMenu.HideMaster;
  labVersionInfo.Text := GetVersionInfo();
  ExecuteAction(ChangeTabActionInfo);
end;

procedure TfrmMain.timAboutAnimationTimer(Sender: TObject);
begin
  // Animacija aviona
  if (imgAboutLogoPlain.RotationAngle = -360) OR (imgAboutLogoPlain.RotationAngle = 360) then
    imgAboutLogoPlain.RotationAngle := 0
  else
    imgAboutLogoPlain.RotationAngle := imgAboutLogoPlain.RotationAngle + easter_egg_direction;
end;


procedure TfrmMain.imgAboutLogoPlainDblClick(Sender: TObject);
begin
  // Windows, Easter egg, ob dvokliku logotipaobrni smer leta aviona
  easter_egg_direction :=  easter_egg_direction * (-1);
  imgAboutLogoPlain.Bitmap.FlipHorizontal;
end;

procedure TfrmMain.imgAboutLogoPlainTap(Sender: TObject; const Point: TPointF);
begin
  // Android, Easter egg, ob dvokliku logotipaobrni smer leta aviona
  easter_egg_direction :=  easter_egg_direction * (-1);
  imgAboutLogoPlain.Bitmap.FlipHorizontal;
end;

procedure TfrmMain.imgAboutMailClick(Sender: TObject);
begin
  OpenURL('mailto:info@aspira.si');
end;

procedure TfrmMain.imgAboutWWWClick(Sender: TObject);
begin
  OpenURL('https://www.aspira.si');
end;


procedure TfrmMain.imgAboutYoutubeClick(Sender: TObject);
begin
  OpenURL('https://www.youtube.com/channel/UCVtvVUUYIHN-YX2Yzu2ZXsg/videos');
end;

procedure TfrmMain.labAboutHelpClick(Sender: TObject);
var
  help_file: String;
begin;
{$IFDEF Android}
  help_file := TPath.Combine(TPath.GetDocumentsPath, 'Manual.pdf');
{$ENDIF}
{$IFDEF MSWINDOWS}
  help_file := TPath.Combine(GetMarcoPoloPath(), 'Manual.pdf');
{$ENDIF}
  ShowDocuments(help_file);
end;

procedure TfrmMain.ShowHTMLCopyright;
begin

end;


procedure TfrmMain.imgBTNSettingsBackClick(Sender: TObject);
begin
  // vrni se nazaj na Potovanja / Sekcije
  ExecuteAction(ChangeTabActionTravel);
end;


function TfrmMain.SelectListViewItem(list_view: TListView;
  id_item: Integer): Boolean;
var
  i: Integer;
begin
  // označi predmet (Item),ki ima Tag = id_section
  result := False;
  for i := 0 to list_view.Items.Count-1 do
  begin
    //if list_view.Items[i].Tag = id_item then
    if list_view.Items[i].Data['id_section'].AsInteger = id_item then
    begin
        list_view.Selected := list_view.Items[i];
        result := True;
        exit;
    end;
  end;

end;


procedure TfrmMain.SetBTNEffect(Sender: TObject; enabled: Boolean);
var
  i: Integer;
begin
  // za vsak TControl objekt, poglejali ima otroka TShadowEffect in ga vključi ali izključi
  for i := 0 to (Sender as TControl).ChildrenCount -1 do
  begin
      if (Sender as TControl).Children[i].ClassType = TShadowEffect then
      begin
        ((Sender as TControl).Children[i] as TShadowEffect).Enabled := enabled;
        exit;
      end;
  end;
end;

procedure TfrmMain.SetEditDeleteButton();
begin
  // omogoči /onemogoči gumba za popravljanje in brisanje
    if livDocuments.ItemIndex > -1 then     // na LIstView Documents
    begin
      // omogoči gumbe za urejanje in brisanje
      imgBTNEditDocument.Enabled := True;
      imgBTNDeleteDocument.Enabled := True;
    end else
    begin
      // onemogoči gumbe za urejanje in brisanje
      imgBTNEditDocument.Enabled := False;
      imgBTNDeleteDocument.Enabled := False;
    end;

    if livTravelsSections.ItemIndex > -1 then   // Na ListView TravelsSections
    begin
      // omogoči gumbe za urejanje in brisanje
      imgBTNEditTravelsSections.Enabled := True;
      imgBTNDeleteTravelsSection.Enabled := True;
      EnableNavigationButton();
    end else
    begin
      // onemogoči gumbe za urejanje in brisanje
      imgBTNEditTravelsSections.Enabled := False;
      imgBTNDeleteTravelsSection.Enabled := False;
      EnableNavigationButton();
    end;
end;


procedure TfrmMain.SetTorchOn(on_off: Boolean);
begin
  if (CameraComponent.HasTorch) AND (CameraComponent.Active) then       // če ima naprava svetilko
  begin
    imgBTNTorch.Enabled := True;
    if on_off then
    begin
      CameraComponent.TorchMode := TTorchMode.ModeOn;   // jo nastavi torch na on
      imgBTNTorch.ImageIndex := 16;    // nastavi ikono gumba na torch on
    end else
    begin
      CameraComponent.TorchMode := TTorchMode.ModeOff;   // jo nastavi torch na off
      imgBTNTorch.ImageIndex := 17;    // nastavi ikono gumba na torch off
    end;
  end else
  begin
    imgBTNTorch.ImageIndex := 17;    // nastavi ikono gumba na torch off
    imgBTNTorch.Enabled := False;                     // drugače onemogoči gumb
  end;
end;


procedure TfrmMain.imgBTNAddDocumentBackClick(Sender: TObject);
begin
  // Prikaži formo (zavihek) Dokumenti
  edit_mode := False;
  labAddEditDocument.Text := 'Dodaj Dokument';
  FillDocuments(livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger);
  SetEditDeleteButton();
  ExecuteAction(ChangeTabActionDocuments);
end;

procedure TfrmMain.imgBTNAddSectionClick(Sender: TObject);
begin
  // Prikaži formo (zavihek) za dodajanja odseka potovanja
  HideMenuAdd();
  ExecuteAction(ChangeTabActionAddSection);
end;

procedure TfrmMain.imgBTNAddTravelClick(Sender: TObject);
begin
  // Forma Potovanje. Prikaži formo za dodajanje Potovanj
  HideMenuAdd();      // skrij menu
  ClearFormAddTravel();
  vsbAddTravelKeyboard.ViewportPosition := PointF(vsbAddTravelKeyboard.ViewportPosition.X, 0);  // postavimo se na vrh forme
  ExecuteAction(ChangeTabActionAddTravel);   // prikaži zavihek dodaj Potovanje
  edtTravelTitle.SetFocus;    // nastavi fokus na prvo vnosno polje
end;

procedure TfrmMain.imgBTNCameraBackClick(Sender: TObject);
begin
  // Prikaži formo (zavihek) Dokumenti
  ExecuteAction(ChangeTabActionAddDocument);
end;

procedure TfrmMain.imgBTNCamerePicCancleClick(Sender: TObject);
begin
  // Odmrzni sliko, aktiviraj kamero
  CameraComponent.Active := True;
  imgBTNCamerePicCancle.Visible := False;  // Skrij gumb za razveljavitev slikanja
  imgBTNSavePicture.Visible := False;      // Skrij gumb za shranjevanje slike
  imgBTNCameraBack.Visible := True;        // Prikaži gumb nazaj na zavihek AddDocument
  imgBTNRotateCamera.Enabled := True;  // omogoči gumb za menjavo kamere, sprenja / zadnja
  imgBTNCaptureImage.Enabled := True;  // omogoči gumb za zajem slike
  SetTorchOn(False);  // onemogoči gumb za lučko kamere
end;

procedure TfrmMain.imgBTNCaptureImageClick(Sender: TObject);
begin
  // Slikaj, deaktiviraj kamero
  CameraComponent.Active := False;
  imgBTNCamerePicCancle.Visible := True;    // Prikaži gumb za razveljavitev slikanja
  imgBTNSavePicture.Visible := True;      // Prikaži gumb za shranjevanje slike
  imgBTNCameraBack.Visible := False;        // Skrij gumb nazaj na zavihek AddDocument
  imgBTNRotateCamera.Enabled := False;  // onemogoči gumb za menjavo kamere, sprenja / zadnja
  imgBTNCaptureImage.Enabled := False;  // onemogoči gumb za zajem slike
  SetTorchOn(False);  // onemogoči gumb za lučko kamere
end;

procedure TfrmMain.CameraComponentSampleBufferReady(Sender: TObject;
  const ATime: TMediaTime);
begin
  // Kamera OnSampleBufferReady, ko je pripravljen vzorec v medpomnilniku, sinhroniziraj sliko kamere z imgCameraView
  TThread.Synchronize(TThread.CurrentThread, DisplayCameraPreviewFrame);
end;

procedure TfrmMain.DisplayCameraPreviewFrame();
begin
  CameraComponent.SampleBufferToBitmap(imgCameraView.Bitmap, True);
end;

{$IFDEF Android}
// Optional rationale display routine to display permission requirement rationale to the user
procedure TfrmMain.DisplayRationale(Sender: TObject;
  const APermissions: TArray<string>; const APostRationaleProc: TProc);
begin
  // Show an explanation to the user *asynchronously* - don't block this thread waiting for the user's response!
  // After the user sees the explanation, invoke the post-rationale routine to request the permissions
  TDialogService.ShowMessage('The app needs to access the camera in order to work',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end);
end;

procedure TfrmMain.ActivateCameraPermissionRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 1 permission involved: CAMERA
  if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
  begin
    { Turn on the Camera }
    CameraComponent.Active :=  True;
    FSavedCameraActive :=  True;
  end
  else
    TDialogService.ShowMessage('Dostop dokamere je zavrnjen!');
end;

procedure TfrmMain.ExternalStorageRequestResult(Sender: TObject;
  const APermissions: TArray<string>;
  const AGrantResults: TArray<TPermissionStatus>);
begin
  // 1 permission involved: CAMERA
  if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
  begin
   // TDialogService.ShowMessage('Dostop je dovoljen');
  end
  else
    TDialogService.ShowMessage('Dostop do zunanjega pogona ni dovoljen!');
end;
{$ENDIF}

procedure TfrmMain.ApplicationEventChangedHandler(const Sender: TObject;
  const AMessage: TMessage);
begin
  case TApplicationEventMessage(AMessage).Value.Event of
    TApplicationEvent.WillBecomeInactive:
    begin
      FSavedCameraActive :=  CameraComponent.Active;
      CameraComponent.Active :=  False;
    end;
    TApplicationEvent.BecameActive:
      CameraComponent.Active :=  FSavedCameraActive;
  end;
end;

procedure TfrmMain.imgBTNRotateCameraClick(Sender: TObject);
begin
  // Če obstajajo dve kameri (sprednja zadnja)
  if CameraComponent.Kind = TCameraKind.FrontCamera then
    CameraComponent.Kind := TCameraKind.BackCamera
  else
    CameraComponent.Kind := TCameraKind.FrontCamera;
  SetTorchOn(False);
end;

procedure TfrmMain.imgBTNTorchClick(Sender: TObject);
begin
  if CameraComponent.TorchMode = TTorchMode.ModeOff then
    SetTorchOn(True)
  else
    SetTorchOn(False);
end;


procedure TfrmMain.muvMainMenuStartHiding(Sender: TObject);
begin
  cirButtonMeni.Enabled := True;
  tacMain.Enabled := True;
end;

procedure TfrmMain.muvMainMenuStartShowing(Sender: TObject);
begin
  cirButtonMeni.Enabled := False;
  tacMain.Enabled := False;
  if livTravelsSections.ItemIndex > -1 then
  begin
    layBTNExportData.Enabled := True
  end else
  begin
    layBTNExportData.Enabled := False;
  end;
end;

function TfrmMain.SelectItemByID(list_view: TListView; id_name: String;
  id_value: Integer): Integer;
var
  i: Integer;
begin
  // označi izbrani Item v listview, glede na podana id_name in id_value
  for i := 0 to list_view.Items.Count-1 do
  begin
    if list_view.Items[i].Data[id_name].AsInteger = id_value then
    begin
      list_view.Selected :=  list_view.Items[i];
      list_view.ShowSelection :=  True;
      result := i;
      SetEditDeleteButton();
      exit;
    end;
  end;
  result := -1;
end;

procedure TfrmMain.ImportDataFromFile(id_travel: Integer; zip_file: String);
begin
  if ImportData(id_travel, zip_file) then
  begin
    FillTravelsSections();
    ShowMessageDlgOK('Uvoz podatkov je uspešno zaključen.');
  end else
    ShowMessageDlgOK('Napaka pri uvozu podatkov.');
end;

procedure TfrmMain.SaveFormState();
var
  W: TBinaryWriter;
begin
  SaveState.Stream.Clear;
    W := TBinaryWriter.Create(SaveState.Stream);
  try
    try
      W.Write(GetVersionInfo);  // shrani informacijo o različici programa
      W.Write(tacMain.ActiveTab.Index);   // shrani informacije o aktivnem zavihku
      case tacMain.ActiveTab.Index of
        0:
        begin
          // Potovanja  (OK)
          //W.Write(livTravelsSections.ItemIndex);  // trenutno označen item
        end;
        1:
        begin
          // shrani dodaj potovanje  (OK)
          W.Write(edit_mode);
          W.Write(livTravelsSections.ItemIndex);  // trenutno označen item
          W.Write(edtTravelTitle.Text);
          W.Write(ccbTravelColor.ItemIndex);
          W.Write(recTravel.Fill.Color);
          W.Write(memTravelNote.Text);
        end;
        2:
        begin
          // shrani dodaj sekcijo  (OK)
          W.Write(edit_mode);
          W.Write(livTravelsSections.ItemIndex);  // trenutno označen item
          W.Write(cobTransportType.ItemIndex);
          W.Write(edtSectionTitle.Text);
          W.Write(dteSectionStartDate.Date);
          W.Write(tieSectionStartTime.Time);
          W.Write(edtEstimatedTravelTime.Text);
          W.Write(edtLatitude.Text);
          W.Write(edtLongitude.Text);
          W.Write(memAddSectionNote.Text);
        end;
        3:
        begin
          // shrani dokumenti zavihek (OK)
          W.Write(livTravelsSections.ItemIndex); // shrani označen odsek
          W.Write(livTravelsSections.Items[livTravelsSections.ItemIndex].Data['id_section'].AsInteger);   // shrani id odseka
          W.Write(livDocuments.ItemIndex);  // shrani označen item (dokument)
        end;
        4:
        begin
          // shrani dodaj dokument    (OK)
          W.Write(edit_mode);
          W.Write(livTravelsSections.ItemIndex);  // trenutno označen item
          W.Write(livDocuments.ItemIndex);  // shrani označen item (dokument)
          W.Write(old_file);  // shrani pot do starega dokumenta
          W.Write(labDocumentPath.Text);
          W.Write(edtDocumentTitle.Text);
        end;
        5:
        begin
          // shrani kamera zavihek  (OK)
          W.Write(edit_mode);
          W.Write(livTravelsSections.ItemIndex);  // trenutno označen item
          W.Write(livDocuments.ItemIndex);  // shrani označen item (dokument)
          W.Write(old_file);  // shrani pot do starega dokumenta
        end;
        6:
        begin
          // shrani o programu zavihek
        end;
        7:
        begin
          // shrani Debug zavihek
        end;
      end;
    except
      // napaka
      ShowMessageDlgOK('Napaka pri zapisovanju stanja forme');
    end;
  finally
    W.Free;
  end;
end;

procedure TfrmMain.LoadFormState();
var
  R: TBinaryReader;
  ver: String;
  current_tab: Integer;
  index: Integer;
begin
  if SaveState.Stream.Size > 0 then
  begin
    // obnovi formo
    R := TBinaryReader.Create(SaveState.Stream);
    try
      try
        ver := R.ReadString;
        if ver = GetVersionInfo then
        begin
          current_tab := R.ReadInteger;
          if current_tab <= tacMain.TabCount-1 then
            tacMain.TabIndex := current_tab
          else
          begin
            tacMain.TabIndex := 0;
            raise EExternalException.Create('Neveljaven zavihek');
          end;
          case current_tab of
            0:
            begin
              // zavihek Potovanja   (OK)
            {  index := R.ReadInteger;
              if livTravelsSections.Items[index].Purpose = TListItemPurpose.Header then
                SelectAllItemsBetweanHeader(index)
              else if livTravelsSections.Items[index].Purpose = TListItemPurpose.Footer then
                SelectAllItemsBetweanFooter(index)
              else
                livTravelsSections.Selected := livTravelsSections.Items[index];  // trenutno označen item
                }
            end;
            1:
            begin
              // nastavi dodaj potovanje  (OK)
              edit_mode := R.ReadBoolean;
              index := R.ReadInteger;
              if (livTravelsSections.Items.Count >= index) AND (Index > -1) then            // preveri ali ta item obstaja v listview
                livTravelsSections.Selected := livTravelsSections.Items[index];
              edtTravelTitle.Text := R.ReadString;
              ccbTravelColor.ItemIndex := R.ReadInteger;
              recTravel.Fill.Color := R.ReadCardinal;
              memTravelNote.Text := R.ReadString;
            end;
            2:
            begin
              // nastavi dodaj sekcijo  (OK)
              edit_mode := R.ReadBoolean;
              index := R.ReadInteger;
              if (livTravelsSections.Items.Count >= index) AND (Index > -1) then            // preveri ali ta item obstaja v listview
                livTravelsSections.Selected := livTravelsSections.Items[index];
              cobTransportType.ItemIndex := R.ReadInteger;
              edtSectionTitle.Text := R.ReadString;
              dteSectionStartDate.Date := R.ReadDouble;
              tieSectionStartTime.Time := R.ReadDouble;
              edtEstimatedTravelTime.Text := R.ReadString;
              edtLatitude.Text := R.ReadString;
              edtLongitude.Text := R.ReadString;
              memAddSectionNote.Text := R.ReadString;
            end;
            3:
            begin
              // nastavi dokumenti zavihek  (OK)
              index := R.ReadInteger;   // preberi označen odsek poti
              if (livTravelsSections.Items.Count >= index) AND (Index > -1) then            // preveri ali ta item obstaja v listview
                livTravelsSections.Selected := livTravelsSections.Items[index];    // označi ustrezen odsek poti
              FillDocuments(R.ReadInteger); // napolni zavihek Documents z ustreznimi dokumenti
              index := R.ReadInteger; // preberi označen dokument
              if (livDocuments.Items.Count >= index) AND (Index > -1) then
                livDocuments.Selected := livDocuments.Items[index];  // označen item (dokument)
            end;
            4:
            begin
              // nastavi dodaj dokument  (OK)
              edit_mode := R.ReadBoolean;
              index := R.ReadInteger;   // preberi označen odsek poti
              if (livTravelsSections.Items.Count >= index) AND (Index > -1) then            // preveri ali ta item obstaja v listview
                livTravelsSections.Selected := livTravelsSections.Items[index];    // označi ustrezen odsek poti
              FillDocuments(livTravelsSections.Items[index].Data['id_section'].AsInteger); // napolni zavihek Documents z ustreznimi dokumenti
              index := R.ReadInteger;   // preberi označen dokument
              if (livDocuments.Items.Count >= index) AND (Index > -1) then            // preveri ali ta item obstaja v listview
                livDocuments.Selected := livDocuments.Items[index];    // označi ustrezen odsek poti
              old_file := R.ReadString;  // shrani pot do starega dokumenta
              labDocumentPath.Text := R.ReadString;
              edtDocumentTitle.Text := R.ReadString;
            end;
            5:
            begin
              // nastavi kamera zavihek  (OK)
              edit_mode := R.ReadBoolean;
              index := R.ReadInteger;   // preberi označen odsek poti
              if (livTravelsSections.Items.Count >= index) AND (Index > -1) then            // preveri ali ta item obstaja v listview
                livTravelsSections.Selected := livTravelsSections.Items[index];    // označi ustrezen odsek poti
              FillDocuments(livTravelsSections.Items[index].Data['id_section'].AsInteger); // napolni zavihek Documents z ustreznimi dokumenti
              index := R.ReadInteger;   // preberi označen dokument
              if (livDocuments.Items.Count >= index) AND (Index > -1) then            // preveri ali ta item obstaja v listview
                livDocuments.Selected := livDocuments.Items[index];    // označi ustrezen odsek poti
              old_file := R.ReadString;  // shrani pot do starega dokumenta
            end;
            6:
            begin
              // nastavi o programu zavihek
            end;
            7:
            begin
              // nastavi Debug zavihek
            end;
          end;
        end;
      except
        // napaka pri branju nastavitev
        ShowMessageDlgOK('Napaka pri branju stanja forme');
      end;
    finally
      R.Free;
    end;
  end;
end;

/////////////////DEBUG/////////////////
procedure TfrmMain.btnCopyDB2AndroidClick(Sender: TObject);
var
  f1, f2: String;
begin
  // kopiraj DB iz  '/storage/emulated/0/Android/data/com.embarcadero.MarcoPolo/files/Pictures/marco_polo.sqlite'
  // v  '/data/user/0/com.embarcadero.MarcoPolo/files/MarcoPolo/marco_polo.sqlite'
  f1 :=  TPath.GetPicturesPath() + PathDelim + 'marco_polo.sqlite';
  f2 :=  TPath.Combine(GetMarcoPoloPath(), 'marco_polo.sqlite');
  TFile.Copy(f1, f2, True);
end;


procedure TfrmMain.btnCopyDBFROMAndroidClick(Sender: TObject);
var
  f1, f2: String;
begin
  // kopiraj DB iz  '/storage/emulated/0/Android/data/com.embarcadero.MarcoPolo/files/Pictures/marco_polo.sqlite'
  // v  '/data/user/0/com.embarcadero.MarcoPolo/files/MarcoPolo/marco_polo.sqlite'
  f1 :=  TPath.GetPicturesPath() + PathDelim + 'marco_polo.sqlite';
  f2 :=  TPath.Combine(GetMarcoPoloPath(), 'marco_polo.sqlite');
  TFile.Copy(f2, f1, True);

end;

procedure TfrmMain.cbStyledChange(Sender: TObject);
begin
  // uporablja stylebook
  if cbStyled.IsChecked then
  begin
    livTravelsSections.StyleLookup := 'listviewstyle_panel';
  end else
  begin
    livTravelsSections.StyleLookup := '';
  end;

end;

end.
