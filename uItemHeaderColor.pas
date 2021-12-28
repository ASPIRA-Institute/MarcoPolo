unit uItemHeaderColor;

interface

uses System.UITypes, FMX.ListView.Types, FMX.Graphics, System.Types, FMX.Types;

type
  TListItemHeaderColor = class(TListItemSimpleControl)
  private
    FColor: TAlphaColor;
    procedure SetColor(const AValue: TAlphaColor);
  public
    constructor Create(const AOwner: TListItem); override;
    destructor Destroy; override;
    procedure Render(const Canvas: TCanvas; const DrawItemIndex: Integer; const DrawStates: TListItemDrawStates;
      const Resources: TListItemStyleResources; const Params: TListItemDrawable.TParams;
      const SubPassNo: Integer = 0); override;
  public
    property Color: TAlphaColor read FColor write SetColor;
  end;


implementation

constructor TListItemHeaderColor.Create(const AOwner: TListItem);
begin
  inherited;
end;

destructor TListItemHeaderColor.Destroy;
begin
  inherited;
end;

procedure TListItemHeaderColor.SetColor(const AValue: TAlphaColor);
begin
  // Nastavi barvo Item
  FColor:= AValue;
end;

procedure TListItemHeaderColor.Render(const Canvas: TCanvas; const DrawItemIndex: Integer; const DrawStates: TListItemDrawStates;
      const Resources: TListItemStyleResources; const Params: TListItemDrawable.TParams;
      const SubPassNo: Integer = 0);
var
  R: TRectF;
begin
  // nariši pravokotnik preko Item in ga obarvaj
  inherited;
  R:= Self.LocalRect;
  Canvas.BeginScene;
  try
    Canvas.Stroke.Kind:= TBrushKind.None;
    Canvas.Fill.Kind:= TBrushKind.Solid;
    Canvas.Fill.Color:= FColor;
    Canvas.FillRect(R, 0, 0, [TCorner.TopLeft, TCorner.TopRight, TCorner.BottomLeft, TCorner.BottomRight], 0.5, TCornerType.Bevel);
  finally
    Canvas.EndScene;
  end;

end;


end.
