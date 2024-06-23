{******************************************}
{                                          }
{             FastReport VCL               }
{            Composite Barcode             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeComposite;

interface

{$I frx.inc}

uses
  Classes, Types, SysUtils, Graphics, frxClass, frxBarcode, frxBarcod,
  frx2DBarcodesPresets, frxBarcodeInterface, Controls
{$IFDEF OFF2DBARS}, frxBarcode2D{$ENDIF}
;

type
  TRelativityTopPosition = (rtAllAvailable, rtTextPos, rtPrevPos);
  TRelativityBootomPosition = (rbAllAvailable, rbTextPos, rbPrevPos);
  TfrxContentType = (ctRightToLeft{$IFDEF TESTALLBARMODE}, ctTopToBottom{$ENDIF});

  IfrxBarCodeInternal = interface;
  TfrxBarCodeCompositeView = class;
  TfrxBarCodeInternalView = class;
{$IFDEF OFF2DBARS}
  TfrxBarCodeInternal2DView =class;
{$ENDIF}

  TfrxPaddings = class(TPersistent)
  private
    FLeft: Extended;
    FRight: Extended;
    FTop: Extended;
    FBottom: Extended;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property Left: Extended read FLeft write FLeft;
    property Top: Extended read FTop write FTop;
    property Right: Extended read FRight write FRight;
    property Bottom: Extended read FBottom write FBottom;
  end;

  TfrxBaseRelativityPositions = class(TPersistent)
  public
    constructor Create; virtual;
  end;

  TfrxLeftToRightRelativityPositions = class(TfrxBaseRelativityPositions)
  private
    FRelativityTopPosition: TRelativityTopPosition;
    FRelativityBootomPosition: TRelativityBootomPosition;
  public
    constructor Create; override;
    procedure Assign(Source: TPersistent); override;
  published
    property RelativityTopPosition: TRelativityTopPosition read FRelativityTopPosition write FRelativityTopPosition;
    property RelativityBootomPosition: TRelativityBootomPosition read FRelativityBootomPosition write FRelativityBootomPosition;
  end;

  TfrxTopToBottomRelativityPositions = class(TfrxBaseRelativityPositions)

  end;

  TfrxBasePosition = class(TPersistent)
  protected
    FPadding: TfrxPaddings;
    FRelativityPositions: TfrxBaseRelativityPositions;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Padding: TfrxPaddings read FPadding write FPadding;
    property RelativityPositions: TfrxBaseRelativityPositions read FRelativityPositions write FRelativityPositions;
  end;

  TfrxBasePositionClass = class of TfrxBasePosition;

  TfrxLeftToRightPosition = class(TfrxBasePosition)
  private
    function GetLeft: Extended;
    procedure SetLeft(val: Extended);
  public
    constructor Create; override;
  published
    property LeftPadding: Extended read GetLeft write SetLeft;
    property RelativityPositions;
  end;

  TfrxTopToBottomPosition = class(TfrxBasePosition)
  private
    function GetTop: Extended;
    procedure SetTop(val: Extended);
  published
    property TopPadding: Extended read GetTop write SetTop;
  end;

  IfrxBarCodeInternal = interface
  ['{1A676D61-012A-40A7-B027-D8080E1743A8}']
    procedure LockPos;
    procedure UnlockPos;
    function BarParent: TfrxBarCodeCompositeView;

    function GetPosition: TfrxBasePosition;
    procedure SetPosition(val: TfrxBasePosition);

    property Positions: TfrxBasePosition read GetPosition write SetPosition;
  end;

  TfrxGetBaseData = function (bar: IfrxBarCodeView): String of object;
  TfrxsetBaseData = procedure (bar: IfrxBarCodeView; val: String) of object;

  TfrxBarCodeCompositeView = class(TfrxView)
  private
    FShowMoveArrow: Boolean;
    FContentType: TfrxContentType;
    FCatchCycle: Boolean;
    FColor: TColor;
    FDataDelimiter: String;
    function GetPrevBar(val: TfrxReportComponent): TfrxReportComponent;
    procedure SetColor(const Value: TColor);
    function GetBarCount: Integer;
    procedure SetBarCount(val: Integer);
    procedure SetContentType(vContentType: TfrxContentType);

    function GetTextFrom(bar: IfrxBarCodeView): String;
    function GetTextSupFrom(bar: IfrxBarCodeView): String;
    function GetBaseData(AText: TfrxGetBaseData): String;
    procedure SetTextFrom(bar: IfrxBarCodeView; val: String);
    procedure SetTextSupFrom(bar: IfrxBarCodeView; val: String);
    procedure SetBaseData(AText: TfrxSetBaseData; val: String);

    function GetText: String;
    procedure SetText(val: String);
    function GetTextSup: String;
    procedure SetTextSup(val: String);
    function GetSubItem(index: Integer): TfrxReportComponent;
  protected
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
    function CheckMoveArrow(X, Y: Extended): Boolean;
    function AddInternalBarcode(ABarcodeClass: TfrxComponentClass; const ABarcodeType: Integer): TfrxView;
  public
    constructor Create(AOwner: TComponent); override;
    function IsContain(X, Y: Extended): Boolean; override;
    procedure DoMouseEnter(aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseLeave(aNextObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams); override;
    function GetRealBounds: TfrxRect; override;
    class function ContentTypeToClass(val: TfrxContentType): TfrxBasePositionClass;
    function AddLinearBarcode(ABarcodeType: TfrxBarcodeType): TfrxBarCodeInternalView; overload;
    function AddLinearBarcode(ABarcodeType: Integer): TfrxBarCodeInternalView; overload;
{$IFDEF OFF2DBARS}
    function Add2DBarcode(ABarcodeType: Integer): TfrxBarCodeInternal2DView; overload;
    function Add2DBarcode(ABarcodeType: TfrxBarcode2DType): TfrxBarCodeInternal2DView; overload;
{$ENDIF}
    function GetFirstBar: TfrxReportComponent;
    function GetLastBar: TfrxReportComponent;
    procedure UpdatePos(EventOwner: TfrxReportComponent);
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
  published
    property ContentType: TfrxContentType read FContentType write SetContentType;
    property Color: TColor read FColor write SetColor;
    property BarCount: Integer read GetBarCount write SetBarCount stored False;
    property DataDelimiter: String read FDataDelimiter write FDataDelimiter;
    property Text: String read GetText write SetText stored False;
    property SupText: String read GetTextSup write SetTextSup stored False;
  end;

  TfrxBarCodeInternalView = class(TfrxBarCodeView, IfrxBarCodeInternal)
  private
    FCatchPos: Boolean;
    FPosition: TfrxBasePosition;
    function GetPosition: TfrxBasePosition;
    procedure SetPosition(val: TfrxBasePosition);
    procedure LockPos;
    procedure UnlockPos;
    function IsLockPos: Boolean;
    function BarParent: TfrxBarCodeCompositeView;
  protected
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; override;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure SetLeft(Value: Extended); override;
    procedure SetTop(Value: Extended); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
  published
    property Position: TfrxBasePosition read GetPosition write SetPosition;
  end;

{$IFDEF OFF2DBARS}
  TfrxBarCodeInternal2DView = class(TfrxBarcode2DView, IfrxBarCodeInternal)
  private
    FCatchPos: Boolean;
    FPosition: TfrxBasePosition;
    function GetPosition: TfrxBasePosition;
    procedure SetPosition(val: TfrxBasePosition);
    procedure LockPos;
    procedure UnlockPos;
    function IsLockPos: Boolean;
    function BarParent: TfrxBarCodeCompositeView;
  protected
    procedure DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    procedure DoMouseMove(X, Y: Integer; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams); override;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams)
      : Boolean; override;
    procedure SetParent(AParent: TfrxComponent); override;
    procedure SetLeft(Value: Extended); override;
    procedure SetTop(Value: Extended); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
  published
    property Position: TfrxBasePosition read GetPosition write SetPosition;
  end;
{$ENDIF}

implementation

uses
  frxBarcodeCompositeEditor, frxRes, frxUtils, frxDsgnIntf,
  //BarPresets
  frxBarcodeBarPressetEANUPCSupp
//{$IFDEF TESTALLBARMODE}
//  frxBarcodeBarPressetMSIRedMark,
//{$ENDIF}
//  //DrawPreset
//  frxBarcodeBaseDrawPresset
//{$IFDEF TESTALLBARMODE}
//  , frxBarcodeDrawPressetMark
//{$ENDIF}
;

const
  EmptySize = 100;

{ TfrxPaddings }

constructor TfrxPaddings.Create;
begin
  FLeft := 0;
  FRight := 0;
  FTop := 0;
  FBottom := 0;
end;

procedure TfrxPaddings.Assign(Source: TPersistent);
begin
  inherited;
  if (Source is TfrxPaddings) then
  begin
    FLeft := TfrxPaddings(Source).Left;
    FRight := TfrxPaddings(Source).Right;
    FTop := TfrxPaddings(Source).Top;
    FBottom := TfrxPaddings(Source).Bottom;
  end;
end;

{ TfrxBaseRelativityPositions }

constructor TfrxBaseRelativityPositions.Create;
begin

end;

{ TfrxLeftToRightRelativityPositions }

constructor TfrxLeftToRightRelativityPositions.Create;
begin
  inherited;
  FRelativityTopPosition := rtAllAvailable;
  FRelativityBootomPosition := rbAllAvailable;
end;

procedure TfrxLeftToRightRelativityPositions.Assign(Source: TPersistent);
begin
  inherited;
  if (Source is TfrxLeftToRightRelativityPositions) then
  begin
    FRelativityTopPosition := TfrxLeftToRightRelativityPositions(Source).RelativityTopPosition;
    FRelativityBootomPosition := TfrxLeftToRightRelativityPositions(Source).RelativityBootomPosition;
  end;
end;

{ TfrxBasePosition }

constructor TfrxBasePosition.Create;
begin
  FPadding := TfrxPaddings.Create;
  FRelativityPositions := nil;
end;

destructor TfrxBasePosition.Destroy;
begin
  FreeAndNil(FPadding);
  FreeAndNil(FRelativityPositions);
end;

procedure TfrxBasePosition.Assign(Source: TPersistent);
begin
  inherited;
  if (Source is TfrxBasePosition) then
  begin
    FPadding.Assign(TfrxBasePosition(Source).Padding);
    FRelativityPositions.Assign(TfrxBasePosition(Source).RelativityPositions);
  end;
end;

{ TfrxLeftToRightContent }

constructor TfrxLeftToRightPosition.Create;
begin
  inherited;
  FRelativityPositions := TfrxLeftToRightRelativityPositions.Create;
end;

function TfrxLeftToRightPosition.GetLeft: Extended;
begin
  Result := FPadding.Left;
end;

procedure TfrxLeftToRightPosition.SetLeft(val: Extended);
begin
  FPadding.Left := val;
end;

{ TfrxTopToBottomContent }

function TfrxTopToBottomPosition.GetTop: Extended;
begin
  Result := FPadding.Top;
end;

procedure TfrxTopToBottomPosition.SetTop(val: Extended);
begin
  FPadding.Top := val;
end;

{ TfrxBarCodeСompositeView }

constructor TfrxBarCodeCompositeView.Create(AOwner: TComponent);
begin
  inherited;
  FContentType := ctRightToLeft;
  frComponentStyle := frComponentStyle + [csObjectsContainer];
  FCatchCycle := False;
  FColor := clNone;
  FDataDelimiter := ';';
  FShowMoveArrow := False;
end;

function TfrxBarCodeCompositeView.IsContain(X, Y: Extended): Boolean;
begin
  if FShowMoveArrow and CheckMoveArrow(X, Y) then
  begin
    Result := True;
    Exit;
  end;
  Result := inherited IsContain(X, Y);
end;

procedure TfrxBarCodeCompositeView.DoMouseEnter(aPreviousObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  FShowMoveArrow := True;
  EventParams.Refresh := True;
end;

procedure TfrxBarCodeCompositeView.DoMouseLeave(aNextObject: TfrxComponent; var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  if FShowMoveArrow then
    EventParams.Refresh := True;
  FShowMoveArrow := False;
end;

function TfrxBarCodeCompositeView.GetRealBounds: TfrxRect;
var
  extra1, extra2, extra: Integer;
  frxBarView: TfrxReportComponent;
  frxBarcodeView: TfrxBarCodeInternalView;
  vRect: TfrxRect;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  bmp.Canvas.Lock;
  try
    Draw(bmp.Canvas, 1, 1, 0, 0);
  finally
    bmp.Canvas.Unlock;
  end;

  Result := inherited GetRealBounds;

  if Self.ContainerObjects.Count > 0 then
  begin
    extra1 := 0;
    extra2 := 0;

    frxBarView := Self.ContainerObjects.Items[0];
    if (frxBarView is TfrxBarCodeInternalView) then
    begin
      frxBarcodeView := frxBarView as TfrxBarCodeInternalView;
      vRect := frxBarcodeView.GetRealBounds;
      extra1 := Abs(Round(vRect.Left - frxBarcodeView.AbsLeft));
    end;

    frxBarView := GetLastBar;
    if (frxBarView is TfrxBarCodeInternalView) then
    begin
      frxBarcodeView := frxBarView as TfrxBarCodeInternalView;
      vRect := frxBarcodeView.GetRealBounds;
      extra2 := Round(vRect.Right - frxBarcodeView.AbsLeft - frxBarcodeView.Width);
    end;

    if (extra1 > extra2) then
      extra := extra1
    else
      extra := extra2;

    Result.Left := Result.Left - extra;
    Result.Right := Result.Right + extra;
  end;

  bmp.Free;
end;

class function TfrxBarCodeCompositeView.ContentTypeToClass(val: TfrxContentType): TfrxBasePositionClass;
begin
  Result := TfrxLeftToRightPosition;
  case (val) of
    ctRightToLeft: Result := TfrxLeftToRightPosition;
  {$IFDEF TESTALLBARMODE}
    ctTopToBottom: Result := TfrxTopToBottomPosition;
  {$ENDIF}
  end;
end;

function TfrxBarCodeCompositeView.AddLinearBarcode(ABarcodeType: TfrxBarcodeType): TfrxBarCodeInternalView;
begin
  Result := AddInternalBarcode(TfrxBarCodeInternalView, Integer(ABarcodeType)) as TfrxBarCodeInternalView;
end;

{$IFDEF OFF2DBARS}
function TfrxBarCodeCompositeView.Add2DBarcode(ABarcodeType: Integer): TfrxBarCodeInternal2DView;
begin
  Result := AddInternalBarcode(TfrxBarCodeInternal2DView, ABarcodeType) as TfrxBarCodeInternal2DView;
end;

function TfrxBarCodeCompositeView.Add2DBarcode(ABarcodeType: TfrxBarcode2DType): TfrxBarCodeInternal2DView;
begin
  Result := AddInternalBarcode(TfrxBarCodeInternal2DView, Integer(ABarcodeType)) as TfrxBarCodeInternal2DView;
end;
{$ENDIF}

function TfrxBarCodeCompositeView.GetFirstBar: TfrxReportComponent;
begin
  Result := GetSubItem(0);
end;

function TfrxBarCodeCompositeView.GetLastBar: TfrxReportComponent;
begin
  Result := GetSubItem(Self.ContainerObjects.Count - 1);
end;

procedure TfrxBarCodeCompositeView.UpdatePos(EventOwner: TfrxReportComponent);
var
  CalcSum: Extended;
  i: Integer;
  frxBarView: TfrxView;
  frxIBarView: IfrxBarCodeInternal;
begin
  if (FCatchCycle) then
    Exit;

  if (GetLastBar = nil) then
  begin
    Self.Width := EmptySize;
    Self.Height := EmptySize;
    Exit;
  end;

  FCatchCycle := True;
  CalcSum := 0;
  case (Self.FContentType) of
    ctRightToLeft:
      begin
        for i := 0 to Self.ContainerObjects.Count - 1 do
        begin
          frxBarView := Self.ContainerObjects.Items[i];
          frxIBarView := frxBarView as IfrxBarCodeInternal;
          frxIBarView.UnlockPos;
          frxBarView.Left := CalcSum + frxIBarView.Positions.Padding.Left * fr01cm;
          frxIBarView.LockPos;
          CalcSum := frxBarView.Left + frxBarView.Width;
        end;
        FCatchCycle := False;
        Self.Width := GetLastBar.Left +  GetLastBar.Width;
      end;
  {$IFDEF TESTALLBARMODE}
    ctTopToBottom:
      begin
        for i := 0 to Self.ContainerObjects.Count - 1 do
        begin
          frxBarView := Self.ContainerObjects.Items[i];
          frxIBarView := frxBarView as IfrxBarCodeInternal;
          frxIBarView.UnlockPos;
          frxBarView.Top := CalcSum + frxIBarView.Positions.Padding.Top * fr01cm;
          frxIBarView.LockPos;
          CalcSum := frxBarView.Top + frxBarView.Height;
        end;
        FCatchCycle := False;
        Self.Height := GetLastBar.Top +  GetLastBar.Height;
        Self.Width := Self.Width;
      end;
  {$ENDIF}
  end;
end;

class function TfrxBarCodeCompositeView.GetDescription: String;
begin
  Result := frxResources.Get('obBarC');
end;

type
  TfrxHackView = class(TfrxView);

procedure TfrxBarCodeCompositeView.Draw(Canvas: TCanvas;
  ScaleX, ScaleY, OffsetX, OffsetY: Extended);
var
  i: Integer;
  frxHackView: TfrxHackView;
  frxBarView, frxPrevBarView: TfrxReportComponent;
  frxIBarViewInt, frxIPrevBarViewInt: IfrxBarCodeInternal;
  frxIBarView, frxIPrevBarView: IfrxBarCodeView;
  buf: Extended;
  LTRPosition: TfrxLeftToRightPosition;
  LTRRelativityPositions: TfrxLeftToRightRelativityPositions;

  procedure SetbAllAvailable;
  begin
    frxBarView.Height := Self.Height - frxBarView.Top;
  end;

  procedure SettAllAvailable;
  begin
    frxBarView.Top := 0;
  end;

begin
  for i := 0 to Self.ContainerObjects.Count - 1 do
  begin
    frxBarView := Self.ContainerObjects.Items[i];
    frxBarView.GetRealBounds;
    frxIBarViewInt := frxBarView as IfrxBarCodeInternal;
    frxIBarView := frxBarView as IfrxBarCodeView;

    frxPrevBarView := GetPrevBar(frxBarView);
    frxIPrevBarViewInt := frxPrevBarView as IfrxBarCodeInternal;
    frxIPrevBarView := frxIPrevBarViewInt as IfrxBarCodeView;
    case FContentType of
      ctRightToLeft:
      begin
        LTRPosition := TfrxLeftToRightPosition(frxIBarViewInt.Positions);
        LTRRelativityPositions := TfrxLeftToRightRelativityPositions(LTRPosition.RelativityPositions);
        frxIBarViewInt.UnlockPos;
        case LTRRelativityPositions.RelativityTopPosition of
          rtAllAvailable: SettAllAvailable;
          rtTextPos, rtPrevPos:
          begin
            if (frxprevBarView <> nil) then
            begin
              buf := frxprevBarView.Top;
              if (LTRRelativityPositions.RelativityTopPosition = rtTextPos) then
                buf := buf + frxIPrevBarView.GetFontHeightTop;
              frxBarView.Top := buf;
            end
            else
              SettAllAvailable;
          end;
        end;
        frxIBarViewInt.UnlockPos;
        case LTRRelativityPositions.RelativityBootomPosition of
          rbAllAvailable: SetbAllAvailable;
          rbTextPos, rbPrevPos:
          begin
            if (frxprevBarView <> nil) then
            begin
              buf := frxprevBarView.Height + frxprevBarView.Top - frxBarView.Top;
              if (LTRRelativityPositions.RelativityBootomPosition = rbTextPos) then
                buf := buf - frxIPrevBarView.GetFontHeightBottom;
              frxBarView.Height := buf;
            end
            else
              SetbAllAvailable;
          end;
        end;
        frxIBarViewInt.LockPos;
      end;
    end;
  end;
  UpdatePos(nil);
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  if (FColor <> clNone) then
  begin
    Canvas.Brush.Color := FColor;
    Canvas.FillRect(Rect(Self.FX, Self.FY, Self.FX1, Self.FY1));
  end
  else
  if (IsDesigning and (Self.ContainerObjects.Count =  0)) then
  begin
    Canvas.Brush.Color := clGray;
    TransparentFillRect(Canvas.Handle, Self.FX, Self.FY, Self.FX1, Self.FY1, clGray);
  end;

  for i := 0 to Self.ContainerObjects.Count - 1 do
  begin
    frxHackView := Self.ContainerObjects.Items[i];
    if (((vsPreview in frxHackView.Visibility) and not IsPrinting) or
      (IsPrinting and (vsPrint in frxHackView.Visibility))) then
    begin
      frxHackView.BeginDraw(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
      frxHackView.DrawBackground;
      frxHackView.DrawFrame;
      frxHackView.Draw(FCanvas, FScaleX, FScaleY, FOffsetX, FOffsetY);
    end;
  end;

  if IsDesigning then
  begin
    for i := 0 to Objects.Count - 1 do
      if TfrxComponent(Objects[i]).IsSelected then
      begin
        frxBarView := Objects.Items[i];
        TransparentFillRect(FCanvas.Handle, Round(Self.FX + (frxBarView.Left) * ScaleX) + 1,
          Round(Self.FY + (frxBarView.Top) * ScaleY) + 1,
          Round(Self.FX + (frxBarView.Left + frxBarView.Width) * ScaleX) - 1,
          Round(Self.FY + (frxBarView.Top + frxBarView.Height) * ScaleY) - 1, clSkyBlue);
       end;
  end;

  if FShowMoveArrow then
    frxImages.MainButtonImages.Draw(Canvas, FX, FY - 20, 110);

  DrawFrame;
end;

function TfrxBarCodeCompositeView.GetPrevBar(val: TfrxReportComponent): TfrxReportComponent;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Self.ContainerObjects.Count - 1 do
  begin
    if (val = Self.ContainerObjects[i]) then
    begin
      if (i > 0) then
        Result := Self.ContainerObjects[i - 1];
      break;
    end;
  end;
end;

procedure TfrxBarCodeCompositeView.SetWidth(Value: Extended);
{$IFDEF TESTALLBARMODE}
var
  i: Integer;
  MaxW: Extended;
  frxBarView: TfrxReportComponent;
  frxIBarView: IfrxBarCodeInternal;
{$ENDIF}
begin
  inherited;
  {$IFDEF TESTALLBARMODE}
  case (FContentType) of
    ctTopToBottom:
    begin
      if (not FCatchCycle) then
        if (Self.ContainerObjects.Count > 0) then
        begin
          MaxW := 0;
          for i := 0 to Self.ContainerObjects.Count - 1 do
          begin
            frxBarView := Self.ContainerObjects.Items[i];
            frxIBarView := frxBarView as IfrxBarCodeInternal;
            if (frxBarView.Width > MaxW) then
              MaxW := frxBarView.Width;
          end;
          FCatchCycle := True;
          Self.Width := MaxW;
          FCatchCycle := False;
        end;
    end;
  end;
  {$ENDIF}
end;

procedure TfrxBarCodeCompositeView.SetHeight(Value: Extended);
var
  i: Integer;
  frxBarView: TfrxReportComponent;
  frxIBarView: IfrxBarCodeInternal;
begin
  inherited;
  case (FContentType) of
    ctRightToLeft:
      for i := 0 to Self.ContainerObjects.Count - 1 do
      begin
        frxBarView := Self.ContainerObjects.Items[i];
        frxIBarView := frxBarView as IfrxBarCodeInternal;
        frxIBarView.UnlockPos;
        frxBarView.Height := Value;
        frxIBarView.LockPos;
      end;
  end;
end;

function TfrxBarCodeCompositeView.AddInternalBarcode(ABarcodeClass: TfrxComponentClass;
  const ABarcodeType: Integer): TfrxView;
var
  LView: TfrxView;
  FirstBar: Boolean;
  LBarcodeInternal: IfrxBarCodeInternal;
  LBarcodeView: IfrxBarCodeView;
begin
  Result := nil;
  if not (Supports(ABarcodeClass, IfrxBarCodeInternal) and Supports(ABarcodeClass, IfrxBarCodeView)) then Exit;
  FirstBar := GetLastBar = nil;
  LView := TfrxView(ABarcodeClass.NewInstance);
  LView.Create(Self);
  LBarcodeView := LView as IfrxBarCodeView;
  LBarcodeInternal := LView as IfrxBarCodeInternal;
  LBarcodeView.BarcodeType := ABarcodeType;
  case Self.FContentType of
    ctRightToLeft: LView.SetBounds(0, 0, Self.Width, Self.Height);
  {$IFDEF TESTALLBARMODE}
    ctTopToBottom:
      if (FirstBar) then
        LView.SetBounds(0, 0, Self.Width, Self.Height)
      else
        LView.SetBounds(0, 0, GetFirstBar.Width, GetFirstBar.Height);
  {$ENDIF}
  end;
  LView.Parent := Self;
  LView.CreateUniqueName;
  if (not FirstBar) then
    case (Self.FContentType) of
      ctRightToLeft: LBarcodeInternal.Positions.Padding.Left := 3;
    {$IFDEF TESTALLBARMODE}
      ctTopToBottom: LBarcodeInternal.Positions.Padding.Top := 3;
    {$ENDIF}
    end;
  Result := LView;
  if Assigned(Report.Designer) then
    Report.Designer.ReloadObjects(False);
end;

function TfrxBarCodeCompositeView.AddLinearBarcode(ABarcodeType: Integer): TfrxBarCodeInternalView;
begin
  Result := AddInternalBarcode(TfrxBarCodeInternalView, ABarcodeType) as TfrxBarCodeInternalView;
end;

function TfrxBarCodeCompositeView.CheckMoveArrow(X, Y: Extended): Boolean;
begin
  Result := (AbsLeft <= X) and (AbsLeft + 16 >= X) and (AbsTop - 20 <= Y) and (AbsTop + 2 >= Y);
end;

procedure TfrxBarCodeCompositeView.SetColor(const Value: TColor);
var
  i: Integer;
  frxBarView: TfrxView;
begin
  FColor := value;
  for i := 0 to Self.ContainerObjects.Count - 1 do
  begin
    frxBarView := Self.ContainerObjects.Items[i];
    frxBarView.Color := Value;
  end;
end;

function TfrxBarCodeCompositeView.GetBarCount: Integer;
begin
  Result := Self.ContainerObjects.Count;
end;

procedure TfrxBarCodeCompositeView.SetBarCount(val: Integer);
var
  i: Integer;
begin
  if (BarCount = val) then
    Exit;
  if BarCount < val then
  begin
    for i := 0 to val - BarCount - 1 do
      AddLinearBarcode(bcCodeEAN8);
  end
  else
  begin
    for i := BarCount - 1 downto val do
      TfrxView(Self.ContainerObjects[i]).Free;
  end;
  if Assigned(Report.Designer) then
    Report.Designer.ReloadObjects(False);
end;

procedure TfrxBarCodeCompositeView.SetContentType(vContentType: TfrxContentType);
var
  i: Integer;
  frxBarView: TfrxReportComponent;
  frxIBarView: IfrxBarCodeInternal;
begin
  FContentType := vContentType;
  for i := 0 to Self.ContainerObjects.Count - 1 do
  begin
    frxBarView := Self.ContainerObjects.Items[i];
    frxIBarView := frxBarView as IfrxBarCodeInternal;
    { shoud be moved to Positions setter }
    { object controls of instance which is not its responsibility }
    if (frxIBarView.Positions <> nil) then //D7 fix
      frxIBarView.Positions.Free;
    frxIBarView.Positions := ContentTypeToClass(vContentType).Create;
    frxIBarView.UnlockPos;
    frxBarView.Left := 0;
    frxIBarView.UnlockPos;
    frxBarView.Top := 0;
  end;
end;

function TfrxBarCodeCompositeView.GetTextFrom(bar: IfrxBarCodeView): String;
begin
  Result := bar.Text;
end;

function TfrxBarCodeCompositeView.GetTextSupFrom(bar: IfrxBarCodeView): String;
begin
  Result := bar.TextSup;
end;

function TfrxBarCodeCompositeView.GetBaseData(AText: TfrxGetBaseData): String;
var
  i: Integer;
  frxBarView: TfrxReportComponent;
  frxIBarView: IfrxBarCodeView;
begin
  Result := '';
  for i := 0 to Self.ContainerObjects.Count - 1 do
  begin
    frxBarView := Self.ContainerObjects.Items[i];
    frxIBarView := frxBarView as IfrxBarCodeView;
    if (i > 0) then
      Result := Result + FDataDelimiter;
    Result := Result + AText(frxIBarView);
  end;
end;

procedure TfrxBarCodeCompositeView.SetTextFrom(bar: IfrxBarCodeView; val: String);
begin
  bar.Text := val;
end;

procedure TfrxBarCodeCompositeView.SetTextSupFrom(bar: IfrxBarCodeView; val: String);
begin
  bar.TextSup := val;
end;

procedure TfrxBarCodeCompositeView.SetBaseData(AText: TfrxSetBaseData; val: String);
var
  SList: TStringList;
  i: Integer;
  frxBarView: TfrxReportComponent;
  frxIBarView: IfrxBarCodeView;

    procedure StrBreakApart(const Source, Delimeter: string; Parts: TStrings);
    var
     curPos: Integer;
     curStr: string;
    begin
     Parts.Clear;
     if Length(Source) = 0 then
       Exit;
     Parts.BeginUpdate;
     try
       CurStr:= Source;
       repeat
         CurPos:= AnsiPos(Delimeter, CurStr);
         if CurPos > 0 then begin
           Parts.Add(Copy(CurStr, 1, Pred(CurPos)));
           CurStr:= Copy(CurStr, CurPos+Length(Delimeter),
             Length(CurStr)-CurPos-Length(Delimeter)+1);
         end else
           Parts.Add(CurStr);
       until CurPos=0;
     finally
       Parts.EndUpdate;
     end;
    end;

begin
  SList := TStringList.Create;
  StrBreakApart(val, FDataDelimiter, SList);
  for i := 0 to SList.Count - 1 do
  begin
    if (i <= Self.ContainerObjects.Count - 1) then
    begin
      frxBarView := Self.ContainerObjects.Items[i];
      frxIBarView := frxBarView as IfrxBarCodeView;
      AText(frxIBarView, SList[i]);
    end
    else
     break;
  end;
  SList.Free;
end;

function TfrxBarCodeCompositeView.GetText: String;
begin
  Result := GetBaseData(GetTextFrom);
end;

procedure TfrxBarCodeCompositeView.SetText(val: String);
begin
  SetBaseData(SetTextFrom, val);
end;

function TfrxBarCodeCompositeView.GetTextSup: String;
begin
  Result := GetBaseData(GetTextSupFrom);
end;

procedure TfrxBarCodeCompositeView.SetTextSup(val: String);
begin
  SetBaseData(SetTextSupFrom, val);
end;

//procedure TfrxBarCodeCompositeView.WritePreset(Writer: TWriter);
//begin
//  frxWriteProperties(FDrawPreset, Writer, Self);
//end;
//
//procedure TfrxBarCodeCompositeView.ReadPreset(Reader: TReader);
//begin
//  frxReadProperties(FDrawPreset, Reader, Self);
//end;

function TfrxBarCodeCompositeView.GetSubItem(index: Integer): TfrxReportComponent;
begin
  if ((index < 0) or (Self.ContainerObjects.Count <= index)) then
    Result := nil
  else
    Result := Self.ContainerObjects[index];
end;

{ TfrxBarCodeInternalView }

constructor TfrxBarCodeInternalView.Create(AOwner: TComponent);
begin
  LockPos;
  FPosition := nil;
  inherited;
  FBaseName := 'BarCodeInternal';
  frComponentStyle := frComponentStyle + [csContained];
end;

destructor TfrxBarCodeInternalView.Destroy;
begin
  FreeAndNil(FPosition);
  inherited;
end;

function TfrxBarCodeInternalView.GetPosition: TfrxBasePosition;
begin
  Result := FPosition;
end;

procedure TfrxBarCodeInternalView.SetPosition(val: TfrxBasePosition);
begin
  FPosition := val;
end;

procedure TfrxBarCodeInternalView.LockPos;
begin
  FCatchPos := True;
end;

procedure TfrxBarCodeInternalView.UnlockPos;
begin
  FCatchPos := False;
end;

function TfrxBarCodeInternalView.IsLockPos: Boolean;
begin
  Result := FCatchPos;
end;

function TfrxBarCodeInternalView.BarParent: TfrxBarCodeCompositeView;
begin
  Result := TfrxBarCodeCompositeView(Self.Parent);
end;

function TfrxBarCodeInternalView.DoMouseDown(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := inherited DoMouseDown(X, Y, Button, Shift, EventParams);
  EventParams.FireParentEvent := True;
end;

procedure TfrxBarCodeInternalView.DoMouseMove(X, Y: Integer; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  EventParams.FireParentEvent := True;
end;

procedure TfrxBarCodeInternalView.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited DoMouseUp(X, Y, Button, Shift, EventParams);
  EventParams.FireParentEvent := True;
end;

procedure TfrxBarCodeInternalView.SetParent(AParent: TfrxComponent);
begin
  if not(AParent is TfrxBarCodeCompositeView) and (AParent <> nil) then Exit;
  if (AParent <> nil) and (FParent <> AParent) then
  begin
    FreeAndNil(FPosition);
    FPosition := TfrxBarCodeCompositeView(AParent).ContentTypeToClass(TfrxBarCodeCompositeView(AParent).ContentType).Create;
  end;
  inherited;
end;

procedure TfrxBarCodeInternalView.SetLeft(Value: Extended);
begin
  if (not IsLockPos) then
  begin
    inherited;
    BarParent.UpdatePos(Self);
  end;
end;

procedure TfrxBarCodeInternalView.SetTop(Value: Extended);
begin
  if (not IsLockPos) then
  begin
    inherited;
    BarParent.UpdatePos(Self);
  end;
end;

procedure TfrxBarCodeInternalView.SetWidth(Value: Extended);
begin
  if (not IsLockPos) then
  begin
    inherited;
    BarParent.UpdatePos(Self);
  end;
end;

procedure TfrxBarCodeInternalView.SetHeight(Value: Extended);
begin
  if (not IsLockPos {$IFDEF TESTALLBARMODE}or (BarParent.ContentType = ctTopToBottom){$ENDIF}) then
  begin
    if Value < 0 then
      Value := 0;
    inherited;
    BarParent.UpdatePos(Self);
  end;
end;

procedure TfrxBarCodeInternalView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  UnlockPos;
  inherited;
  LockPos;
end;

{ TfrxBarCodeInternal2DView }

{$IFDEF OFF2DBARS}
constructor TfrxBarCodeInternal2DView.Create(AOwner: TComponent);
begin
  LockPos;
  FPosition := nil;
  AutoSize := False;
  inherited;
  FBaseName := 'BarCodeInternal';
  frComponentStyle := frComponentStyle + [csContained];
end;

destructor TfrxBarCodeInternal2DView.Destroy;
begin
  FreeAndNil(FPosition);
  inherited;
end;

function TfrxBarCodeInternal2DView.GetPosition: TfrxBasePosition;
begin
  Result := FPosition;
end;

procedure TfrxBarCodeInternal2DView.SetPosition(val: TfrxBasePosition);
begin
  FPosition := val;
end;

procedure TfrxBarCodeInternal2DView.LockPos;
begin
  FCatchPos := True;
end;

procedure TfrxBarCodeInternal2DView.UnlockPos;
begin
  FCatchPos := False;
end;

function TfrxBarCodeInternal2DView.IsLockPos: Boolean;
begin
  Result := FCatchPos;
end;

function TfrxBarCodeInternal2DView.BarParent: TfrxBarCodeCompositeView;
begin
  Result := TfrxBarCodeCompositeView(Self.Parent);
end;

procedure TfrxBarCodeInternal2DView.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited DoMouseUp(X, Y, Button, Shift, EventParams);
  EventParams.FireParentEvent := True;
end;

procedure TfrxBarCodeInternal2DView.DoMouseMove(X, Y: Integer; Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited DoMouseMove(X, Y, Shift, EventParams);
  EventParams.FireParentEvent := True;
end;

function TfrxBarCodeInternal2DView.DoMouseDown(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := inherited DoMouseDown(X, Y, Button, Shift, EventParams);
  EventParams.FireParentEvent := True;
end;

procedure TfrxBarCodeInternal2DView.SetParent(AParent: TfrxComponent);
begin
  if not(AParent is TfrxBarCodeCompositeView) and (AParent <> nil) then Exit;
  if (AParent <> nil) and (FParent <> AParent) then
  begin
    FreeAndNil(FPosition);
    FPosition := TfrxBarCodeCompositeView(AParent).ContentTypeToClass(TfrxBarCodeCompositeView(AParent).ContentType).Create;
  end;
  inherited;
end;

procedure TfrxBarCodeInternal2DView.SetLeft(Value: Extended);
begin
  if (not IsLockPos) then
  begin
    inherited;
    BarParent.UpdatePos(Self);
  end;
end;

procedure TfrxBarCodeInternal2DView.SetTop(Value: Extended);
begin
  if (not IsLockPos) then
  begin
    inherited;
    BarParent.UpdatePos(Self);
  end;
end;

procedure TfrxBarCodeInternal2DView.SetWidth(Value: Extended);
begin
  if (not IsLockPos) then
  begin
    inherited;
    BarParent.UpdatePos(Self);
    UnlockPos;
  end;
end;

procedure TfrxBarCodeInternal2DView.SetHeight(Value: Extended);
begin
  if (not IsLockPos) then
  begin
    inherited;
    BarParent.UpdatePos(Self);
    UnlockPos;
  end;
end;

procedure TfrxBarCodeInternal2DView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
begin
  UnlockPos;
  inherited;
  LockPos;
end;
{$ENDIF}

end.
