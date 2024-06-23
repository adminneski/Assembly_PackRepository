{*******************************************************}
{                                                       }
{                       EhLib 11.0                      }
{                      LaControlsEh                     }
{                                                       }
{    Copyright (c) 2022-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit LaControlsEh;

interface

{$SCOPEDENUMS ON}

uses
  Types, Classes, Messages, SysUtils, Variants,
  {$IFDEF FPC}
  EhLibLCL,
  {$ELSE}
  EhLibVCL,
  {$ENDIF}
  {$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  Generics.Collections, DB,
  //RenderEngineEh,
  LaObjectsEh,
  ToolCtrlsEh,
  ImgList, StdCtrls,
  Graphics, Controls, Forms, Dialogs;

type
  TLaPadding = class;
  TLaThickness = class;
  TLaControlEh = class;
  TLaTextBlockEh = class;
  TLaImageEh = class;

{ TLaPadding }

  TLaPadding = class(TLaMargins)
//  protected
//    class procedure InitDefaults(Margins: TMargins); override;
  protected
    procedure Change; override;

  public
    constructor Create(ALaObject: TLaObjectEh); override;

  published
    property Left default 0;
    property Top default 0;
    property Right default 0;
    property Bottom default 0;
  end;

{ TLaThickness }

  TLaThickness = class(TLaMargins)
//  protected
//    class procedure InitDefaults(Margins: TMargins); override;
  protected
    procedure Change; override;

  public
    constructor Create(ALaObject: TLaObjectEh); override;

  published
    property Left default 0;
    property Top default 0;
    property Right default 0;
    property Bottom default 0;
  end;

{ TLaControlEh }

  TLaControlEh = class(TLaObjectEh)
  private
    FPadding: TLaPadding;
    FBorderColor: TColor;
    FBorderThickness: TLaThickness;
    FFont: TFont;
    FParentFont: Boolean;
    FColor: TColor;

    procedure SetPadding(const Value: TLaPadding);
    procedure SetBorderThickness(const Value: TLaThickness);
    function IsFontStored: Boolean;
    procedure SetFont(const Value: TFont);
    procedure SetParentFont(const Value: Boolean);
    procedure FontChanged(Sender: TObject);

    procedure SetColor(Value: TColor);
  protected
    //procedure InternalRender(RenderContext: TRenderContextEh);
    procedure ParentChanged; override;

    procedure PaddingChanged;
    procedure BorderThicknessChanged;
    procedure UpdateFont;
    procedure ParentDependenciesChanged; override;
  public
    //procedure Render(RenderContext: TRenderContextEh); virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure Draw(ARect: TRect; ACanvas: TCanvas); override;
    //procedure DrawClient(AClientRect: TRect; ACanvas: TCanvas); virtual;
    procedure DrawClientBackgound(AClientRect: TRect; ACanvas: TCanvas); virtual;
    procedure DrawClientForeground(AClientRect: TRect; ACanvas: TCanvas); virtual;
    procedure DrawBorder(ABorderRect: TRect; ACanvas: TCanvas); virtual;

  //Size MeasureOverride(Size availableSize)
  //Size ArrangeOverride(Size finalSize)
    function DoQueryLayout(QuerySize: TSize; ACanvas: TCanvas): TSize; override;
    function DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize; virtual;

    function DoPerformLayout(PerfSize: TSize; ACanvas: TCanvas): TSize; override;
    function DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize; virtual;

    property Padding: TLaPadding read FPadding write SetPadding;

    property BorderThickness: TLaThickness read FBorderThickness write SetBorderThickness;
    //property BorderWidth: Integer read FBorderWidth write FBorderWidth;
    property BorderColor: TColor read FBorderColor write FBorderColor;

    property Font: TFont read FFont write SetFont stored IsFontStored;
    property ParentFont: Boolean read FParentFont write SetParentFont default True;

    property Color: TColor read FColor write SetColor default clNone;
  end;

{ TLaTextBlockEh }

  TLaTextBlockEh = class(TLaControlEh)
  private
    FWordWrap: Boolean;
    FText: String;
    FFieldName: String;
    FIsRefLink: Boolean;
    FLinkIsActive: Boolean;
    FOnHyperLinkClick: TNotifyEvent;
    procedure SetText(const Value: String);
    procedure SetFieldName(const Value: String);
    procedure SetLinkIsActive(const Value: Boolean);
    function CalcTextSize(AreaWidth: Integer; ACanvas: TCanvas): TSize;

  protected
    procedure UpdateText; virtual;

    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    procedure Assign(Source: TPersistent); override;
    procedure DrawClientForeground(AClientRect: TRect; ACanvas: TCanvas); override;

    function DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize; override;
    function DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize; override;

    property LinkIsActive: Boolean read FLinkIsActive write SetLinkIsActive;

  published
    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property Text: String read FText write SetText; //reintroduce; //override; //overload; //
    property FieldName: String read FFieldName write SetFieldName;
    property IsRefLink: Boolean read FIsRefLink write FIsRefLink;

    property OnHyperLinkClick: TNotifyEvent read FOnHyperLinkClick write FOnHyperLinkClick;
  end;

  { TLaImageEh }

  TLaImageEh = class(TLaControlEh)
  private
    FImageList: TCustomImageList;
    FImageIndex: Integer;
    FFieldName: String;
    FPicture: TPicture;

    procedure SetImageList(const Value: TCustomImageList);
    procedure SetImageIndex(const Value: Integer);
    procedure SetFieldName(const Value: String);
    procedure PaintTo(Graphic: TGraphic; ACanvas: TCanvas; const DestRect: TRect; Placement: TImagePlacementEh; const ShiftPoint: TPoint; const ClipRect: TRect);
    function GetDestRect(SrcSize: TSize; const SrcRect: TRect; Placement: TImagePlacementEh): TRect;
    procedure SetPicture(const Value: TPicture);
    function GetPictureActualSize: TSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure DrawClientForeground(AClientRect: TRect; ACanvas: TCanvas); override;

    function DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize; override;
    function DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize; override;

    function GetPictureForField(AFieldName: String): TPicture;

  published
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property FieldName: String read FFieldName write SetFieldName;
    property Picture: TPicture read FPicture write SetPicture;
  end;

implementation

uses Math;

{ TLaControl }

//procedure TLaControl.Render(RenderContext: TRenderContextEh);
//begin
//
//end;

//procedure TLaControl.InternalRender(RenderContext: TRenderContextEh);
//var
//  RenderGroup: TRenderGroup;
//begin
//  RenderGroup := TRenderGroup.Create;
//  RenderContext.SetParentRenderGroup(RenderGroup);
//  Render(RenderContext);
//end;

constructor TLaControlEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPadding  := TLaPadding.Create(Self);
  FBorderThickness := TLaThickness.Create(Self);
  //FMargins.OnChange := DoMarginChange;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FParentFont := True;

  FColor := clNone;
  FBorderColor := clDefault;
end;

destructor TLaControlEh.Destroy;
begin
  FreeAndNil(FPadding);
  FreeAndNil(FBorderThickness);
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TLaControlEh.Draw(ARect: TRect; ACanvas: TCanvas);
var
  ABorderRect: TRect;
  AClientRect: TRect;
begin
  ABorderRect := ARect;
//  ABorderRect := Rect(ARect.Left + Margins.Left,
//                      ARect.Top + Margins.Top,
//                      ARect.Right - Margins.Right,
//                      ARect.Bottom - Margins.Bottom);
  DrawBorder(ABorderRect, ACanvas);

  AClientRect := CreateRect(ABorderRect.Left + BorderThickness.Left,
                      ABorderRect.Top + BorderThickness.Top,
                      ABorderRect.Right - BorderThickness.Right,
                      ABorderRect.Bottom - BorderThickness.Bottom);
  DrawClientBackgound(AClientRect, ACanvas);

  AClientRect := CreateRect(ABorderRect.Left + Padding.Left,
                      ABorderRect.Top + Padding.Top,
                      ABorderRect.Right - Padding.Right,
                      ABorderRect.Bottom - Padding.Bottom);
  DrawClientForeground(AClientRect, ACanvas);

//  DrawClient(AClientRect, ACanvas);
end;

procedure TLaControlEh.DrawBorder(ABorderRect: TRect; ACanvas: TCanvas);
begin
  if BorderThickness.Top > 0 then
  begin
    ACanvas.Pen.Color := BorderColor;
    ACanvas.Polyline([Classes.Point(ABorderRect.Left, ABorderRect.Top),
                      Classes.Point(ABorderRect.Right, ABorderRect.Top)]);
  end;

  if BorderThickness.Right > 0 then
  begin
    ACanvas.Pen.Color := BorderColor;
    ACanvas.Polyline([Classes.Point(ABorderRect.Right-1, ABorderRect.Top),
                      Classes.Point(ABorderRect.Right-1, ABorderRect.Bottom)]);
  end;

  if BorderThickness.Bottom > 0 then
  begin
    ACanvas.Pen.Color := BorderColor;
    ACanvas.Polyline([Classes.Point(ABorderRect.Left, ABorderRect.Bottom-1),
                      Classes.Point(ABorderRect.Right, ABorderRect.Bottom-1)]);
  end;

  if BorderThickness.Left > 0 then
  begin
    ACanvas.Pen.Color := BorderColor;
    ACanvas.Polyline([Classes.Point(ABorderRect.Left, ABorderRect.Top),
                      Classes.Point(ABorderRect.Left, ABorderRect.Bottom)]);
  end;
end;

//procedure TLaControl.DrawClient(AClientRect: TRect; ACanvas: TCanvas);
//begin
//end;

procedure TLaControlEh.DrawClientBackgound(AClientRect: TRect; ACanvas: TCanvas);
begin
  if (FColor <> clNone) then
  begin
    ACanvas.Brush.Color := Color;
    ACanvas.FillRect(AClientRect);
  end;
end;

procedure TLaControlEh.DrawClientForeground(AClientRect: TRect; ACanvas: TCanvas);
begin

end;

procedure TLaControlEh.SetBorderThickness(const Value: TLaThickness);
begin
  FBorderThickness.Assign(Value);
end;

procedure TLaControlEh.SetColor(Value: TColor);
begin
  FColor := Value;
end;

procedure TLaControlEh.SetPadding(const Value: TLaPadding);
begin
  FPadding.Assign(Value);
end;

procedure TLaControlEh.PaddingChanged;
begin
end;

procedure TLaControlEh.ParentChanged;
begin
  inherited ParentChanged;
  UpdateFont;
end;

procedure TLaControlEh.ParentDependenciesChanged;
begin
  UpdateFont;
end;

procedure TLaControlEh.BorderThicknessChanged;
begin
end;

function TLaControlEh.DoQueryLayout(QuerySize: TSize; ACanvas: TCanvas): TSize;
begin
  QuerySize.cx := QuerySize.cx - Padding.Left - Padding.Right - BorderThickness.Left - BorderThickness.Right;
  QuerySize.cy := QuerySize.cy - Margins.Top - Margins.Bottom - BorderThickness.Top - BorderThickness.Bottom;

  Result := DoQueryLayoutClientArea(QuerySize, ACanvas);
  if (Result.cx > 1048576) or (Result.cy > 1048576) then
    raise Exception.Create('DoQueryLayout.' + ClassName + ' : cx' + IntToStr(Result.cx) + ' cy: ' + IntToStr(Result.cy));

  Result.cx := Result.cx + Padding.Left + Padding.Right + BorderThickness.Left + BorderThickness.Right;
  Result.cy := Result.cy + Padding.Top + Padding.Bottom + BorderThickness.Top + BorderThickness.Bottom;
end;

function TLaControlEh.DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize;
begin
  Result := QuerySize;
//  Result.cx := Result.cx - Padding.Left - Padding.Right - BorderThickness.Left - BorderThickness.Right;
//  Result.cy := Result.cy - Padding.Top - Padding.Bottom - BorderThickness.Top - BorderThickness.Bottom;
end;

function TLaControlEh.DoPerformLayout(PerfSize: TSize; ACanvas: TCanvas): TSize;
var
  ClientRect: TRect;
begin
  ClientRect := CreateRect(0, 0, PerfSize.cx, PerfSize.cy);
  ClientRect.Left := ClientRect.Left + Padding.Left + BorderThickness.Left;
  ClientRect.Right := ClientRect.Right - Padding.Right - BorderThickness.Right;
  ClientRect.Top := ClientRect.Top + Padding.Top + BorderThickness.Top;
  ClientRect.Bottom := ClientRect.Bottom - Padding.Bottom - BorderThickness.Bottom;

  Result := DoPerformLayoutClientArea(ClientRect, ACanvas);

  Result.cx := Result.cx + Padding.Left + Padding.Right + BorderThickness.Left + BorderThickness.Right;
  Result.cy := Result.cy + Padding.Top + Padding.Bottom + BorderThickness.Top + BorderThickness.Bottom;
end;

function TLaControlEh.DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize;
begin
  Result := RectSize(ClientRect);
end;

function TLaControlEh.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TLaControlEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TLaControlEh.SetParentFont(const Value: Boolean);
begin
  if FParentFont <> Value then
  begin
    FParentFont := Value;
//    if (FParent <> nil) and not (csReading in ComponentState) then
//      Perform(CM_PARENTFONTCHANGED, 0, 0);
  end;
end;

procedure TLaControlEh.FontChanged(Sender: TObject);
begin
  FParentFont := False;
  UpdateChildDependencies;
end;

procedure TLaControlEh.UpdateFont;
begin
  if ParentFont and
    (Parent <> nil) and
    (Parent is TLaControlEh)  then
  begin
    FFont.OnChange := nil;
    FFont.Assign(TLaControlEh(Parent).Font);
    FFont.OnChange := FontChanged;
  end;
end;

procedure TLaControlEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);

  if (Source is TLaControlEh) then
  begin
    Padding := TLaControlEh(Source).Padding;
    BorderThickness := TLaControlEh(Source).BorderThickness;
    BorderColor := TLaControlEh(Source).BorderColor;
    Color := TLaControlEh(Source).Color;

    if (TLaControlEh(Source).ParentFont = False) then
    begin
      Font := TLaControlEh(Source).Font;
      //ParentFont := False;
    end;
  end;
end;

{ TLaPadding }

constructor TLaPadding.Create(ALaObject: TLaObjectEh);
begin
  inherited Create(ALaObject);
end;

procedure TLaPadding.Change;
begin
  if (LaObject <> nil) then
    TLaControlEh(LaObject).PaddingChanged;
end;

{ TLaThickness }

constructor TLaThickness.Create(ALaObject: TLaObjectEh);
begin
  inherited Create(ALaObject);
end;

procedure TLaThickness.Change;
begin
  if (LaObject <> nil) then
    TLaControlEh(LaObject).BorderThicknessChanged;
end;

{ TLaFlowTextBlock }

function TLaTextBlockEh.CalcTextSize(AreaWidth: Integer; ACanvas: TCanvas): TSize;
begin
  UpdateText;
  ACanvas.Font := Font;
  //Text
  if (Text = '') then
  begin
    Result.cx := 0;
    Result.cy := GetFontTextHeight(ACanvas, ACanvas.Font);
  end
  else if WordWrap then
  begin
    MeasureTextEh(ACanvas, AreaWidth, Text, True, Result);
  end
  else
  begin
    Result := ACanvas.TextExtent(Text);
  end;
end;

function TLaTextBlockEh.DoQueryLayoutClientArea(QuerySize: TSize;
  ACanvas: TCanvas): TSize;
begin
  Result := CalcTextSize(QuerySize.cx, ACanvas);
end;

function TLaTextBlockEh.DoPerformLayoutClientArea(ClientRect: TRect;
  ACanvas: TCanvas): TSize;
begin
  Result := CalcTextSize(RectSize(ClientRect).cx, ACanvas);
end;

procedure TLaTextBlockEh.DrawClientForeground(AClientRect: TRect; ACanvas: TCanvas);
var
  AText: String;
begin
  UpdateText;
  AText := Text;
  ACanvas.Font := Font;
  if (LinkIsActive) then
  begin
    ACanvas.Font.Style := ACanvas.Font.Style + [TFontStyle.fsUnderline];
  end;
  if WordWrap then
    WriteTextEh(ACanvas, AClientRect, False, 0, 0, AText,
      TAlignment.taLeftJustify, TTextLayout.tlTop,
      True, False, 0, 0, False, False)
  else
  begin
    ACanvas.Brush.Style := TBrushStyle.bsClear;
    //ACanvas.TextRect(AClientRect, AClientRect.Left, AClientRect.Top, AText, []);
    DrawTextEh(ACanvas, AText, AClientRect, False);
  end;
end;

procedure TLaTextBlockEh.MouseEnter;
begin
  inherited MouseEnter;
  if (IsRefLink) then
  begin
    LinkIsActive := True;
    Screen.Cursor := crHandPoint;
  end;
end;

procedure TLaTextBlockEh.MouseLeave;
begin
  inherited MouseLeave;
  if (IsRefLink) then
  begin
    LinkIsActive := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TLaTextBlockEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
//var
//  BlockItem: TFlRichBlockItemEh;
//  TextBlockItem: TFlBreakableTextEh;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (IsRefLink = True) and
     Assigned(OnHyperLinkClick)
  then
    OnHyperLinkClick(Self);

//  BlockItem := GetBlockItemAtPos(Point(X, Y));
//  if (BlockItem <> nil) then
//  begin
//    if (BlockItem is TFlBreakableTextEh) then
//    begin
//      TextBlockItem := TFlBreakableTextEh(BlockItem);
//      if (TextBlockItem.IsHyperLink = True) and
//         Assigned(OnHyperLinkClick)
//      then
//        OnHyperLinkClick(TextBlockItem);
//    end;
//  end;
end;

procedure TLaTextBlockEh.SetText(const Value: String);
begin
  if (FText <> Value) then
  begin
    if FieldName <> '' then
       raise EInvalidOperation.Create('TLaFlowTextBlock can''t SetText when FieldName is not Empty.');
    FText := Value;
  end;
end;

procedure TLaTextBlockEh.SetFieldName(const Value: String);
begin
  if (FFieldName <> Value) then
  begin
//    if FText <> '' then
//       raise EInvalidOperation.Create('TLaFlowTextBlock can''t SetFieldName when Text is not Empty.');
    FFieldName := Value;
    FText := '';
  end;
end;

procedure TLaTextBlockEh.SetLinkIsActive(const Value: Boolean);
begin
  if (FLinkIsActive <> Value) then
  begin
    FLinkIsActive := Value;
    Invalidate;
  end;
end;

procedure TLaTextBlockEh.UpdateText;
var
  DataSet: TDataSet;
  Field: TField;
begin
  if (FieldName <> '') then
  begin
    DataSet := GetDataSet;
    if (DataSet = nil) then Exit;

    Field := DataSet.FieldByName(FieldName);
    FText := Field.AsString;
  end;
end;

procedure TLaTextBlockEh.Assign(Source: TPersistent);
var
  SrcTextBlock: TLaTextBlockEh;
begin
  inherited Assign(Source);

  if (Source is TLaTextBlockEh) then
  begin
    SrcTextBlock := TLaTextBlockEh(Source);
    WordWrap := SrcTextBlock.WordWrap;
    Text := SrcTextBlock.Text;
    FieldName := SrcTextBlock.FieldName;
    IsRefLink := SrcTextBlock.IsRefLink;

    OnHyperLinkClick := SrcTextBlock.OnHyperLinkClick;
  end;
end;

{ TLaImageEh }

constructor TLaImageEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPicture := TPicture.Create;
end;

destructor TLaImageEh.Destroy;
begin
  FreeAndNil(FPicture);
  inherited Destroy;
end;

function TLaImageEh.GetPictureActualSize: TSize;
var
  APic: TPicture;
begin
  if (Picture <> nil) and (Picture.Graphic <> nil) then
  begin
    Result := CreateSize(Picture.Width, Picture.Height);
  end
  else if (ImageList <> nil) then
  begin
    Result := CreateSize(ImageList.Width, ImageList.Height);
  end
  else if (FieldName <> '') then
  begin
    APic := GetPictureForField(FieldName);
    Result := CreateSize(APic.Width, APic.Height);
    APic.Free;
  end
  else
  begin
    Result := CreateSize(0, 0);
  end;
end;

function TLaImageEh.DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize;
var
//  APic: TPicture;
  APicSize: TSize;
begin
  APicSize := GetPictureActualSize();

  if (APicSize.cx >= 0) or (APicSize.cy >= 0) then
    Result := RectSize(GetDestRect(APicSize, CreateRect(0, 0, QuerySize.cx, QuerySize.cy), ipReduceFitEh))
  else
    Result := CreateSize(0, 0);
end;

function TLaImageEh.DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize;
var
//  APic: TPicture;
  APicSize: TSize;
  AClientSize: TSize;
begin
  APicSize := GetPictureActualSize();
  AClientSize := RectSize(ClientRect);

  if (APicSize.cx >= 0) or (APicSize.cy >= 0) then
    Result := RectSize(GetDestRect(APicSize, CreateRect(0, 0, AClientSize.cx, AClientSize.cy), ipReduceFitEh))
  else
    Result := CreateSize(0, 0);
end;

function TLaImageEh.GetDestRect(SrcSize: TSize; const SrcRect: TRect; Placement: TImagePlacementEh): TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
  ActualPlacement: TImagePlacementEh;
begin
  w := SrcSize.cx;
  h := SrcSize.cy;
  Result := SrcRect;
  cw := Result.Right - Result.Left;
  ch := Result.Bottom - Result.Top;
  if Placement = ipReduceFitEh then
    if (cw >= w) and (ch >= h)
      then ActualPlacement := ipCenterCenterEh
      else ActualPlacement := ipFitEh
    else
      ActualPlacement := Placement;

  case ActualPlacement of
    ipStretchEh :
      begin
        w := cw;
        h := ch;
      end;

    ipFillEh :
      begin
        if (w > 0) and (h > 0) then
        begin
          xyaspect := h / w;
          h := ch;
          w := Trunc(ch / xyaspect);
          if w < cw then
          begin
            w := cw;
            h := Trunc(cw * xyaspect);
          end;
        end
        else
        begin
          w := cw;
          h := ch;
        end;
      end;

    ipFitEh :
      begin
        if (w > 0) and (h > 0) then
        begin
          xyaspect := w / h;
          w := cw;
          h := Trunc(cw / xyaspect);
          if h > ch then
          begin
            h := ch;
            w := Trunc(ch * xyaspect);
          end;
        end
        else
        begin
          w := cw;
          h := ch;
        end;
      end;
  end;

  Result.Right := Result.Left + w;
  Result.Bottom := Result.Top + h;

  case ActualPlacement of
    ipTopLeftEh :
      OffsetRect(Result, 0, 0);
    ipTopCenterEh :
      OffsetRect(Result, (cw - w) div 2, 0);
    ipTopRightEh :
      OffsetRect(Result, (cw - w), 0);

    ipCenterLeftEh :
      OffsetRect(Result, 0, (ch - h) div 2);
    ipCenterCenterEh :
      OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
    ipCenterRightEh :
      OffsetRect(Result, (cw - w), (ch - h) div 2);

    ipBottomLeftEh :
      OffsetRect(Result, 0, (ch - h));
    ipBottomCenterEh :
      OffsetRect(Result, (cw - w) div 2, (ch - h));
    ipBottomRightEh :
      OffsetRect(Result, (cw - w), (ch - h));

    ipFillEh :
      begin
        if h = ch then
        begin
          Inc(Result.Left, (cw - w) div 2);
          Inc(Result.Right, (cw - w) div 2);
        end else
        begin
          Inc(Result.Top, (ch - h) div 2);
          Inc(Result.Bottom, (ch - h) div 2);
        end;
      end;

    ipFitEh :
      begin
        if w = cw then
        begin
          Inc(Result.Top, (ch - h) div 2);
          Inc(Result.Bottom, (ch - h) div 2);
        end else
        begin
          Inc(Result.Left, (cw - w) div 2);
          Inc(Result.Right, (cw - w) div 2);
        end;
      end;
  end;
end;

procedure TLaImageEh.PaintTo(Graphic: TGraphic; ACanvas: TCanvas; const DestRect: TRect;
  Placement: TImagePlacementEh; const ShiftPoint: TPoint;
  const ClipRect: TRect);
var
  Rect: TRect;
  MLeft : Integer;
begin
  Rect := GetDestRect(CreateSize(Graphic.Width, Graphic.Height), DestRect, Placement);

  if (Placement = ipTileEh) and (Graphic.Width > 0) and (Graphic.Height > 0) then
  begin
    MLeft := Rect.Left;
    while Rect.Top < DestRect.Bottom do
    begin
      while Rect.Left < DestRect.Right do
      begin
        ACanvas.StretchDraw(Rect, Graphic);
        OffsetRect(Rect, Graphic.Width, 0);
      end;
      Rect.Left := MLeft;
      Rect.Right := Rect.Left + Graphic.Width;
      OffsetRect(Rect, 0, Graphic.Height);
    end;
  end
  else
  begin
    ACanvas.StretchDraw(Rect, Graphic);
  end;
end;

//procedure SetCanvasZoomAndRotation(ACanvas:TCanvas; Zoom:Double;
//  Angle:Double; CenterpointX, CenterpointY: Double);
//var
//  form : tagXFORM;
//  Winkel:Double;
//
//begin
//  Winkel := DegToRad(Angle);
//  SetGraphicsMode(ACanvas.Handle, GM_ADVANCED);
//  SetMapMode(ACanvas.Handle,MM_ANISOTROPIC);
//  form.eM11 := Zoom * cos( Winkel);
//  form.eM12 := Zoom *Sin( Winkel)  ;
//  form.eM21 := Zoom * (-sin( Winkel));
//  form.eM22 := Zoom * cos( Winkel) ;
//  form.eDx := CenterpointX;
//  form.eDy := CenterpointY;
//  SetWorldTransform(ACanvas.Handle,form);
//end;

procedure TLaImageEh.DrawClientForeground(AClientRect: TRect; ACanvas: TCanvas);
var
  APicture: TPicture;
begin
  if (RectWidth(AClientRect) <= 0) or (RectHeight(AClientRect) <= 0) then Exit;

  if (Picture <> nil) and (Picture.Graphic <> nil) then
  begin
    PaintTo(Picture.Graphic, ACanvas, AClientRect, ipFitEh, Classes.Point(0, 0), EmptyRect);
  end
  else if (ImageList <> nil) and
     (ImageIndex >= 0) and
     (ImageIndex <= ImageList.Count) then
  begin
    //if (ImageList.Width > RectWidth(AClientRect)) then

    ImageList.Draw(ACanvas, AClientRect.Left, AClientRect.Top, ImageIndex);
  end
  else if (FieldName <> '') then
  begin
    APicture := GetPictureForField(FieldName);
    //Picture.PaintTo(ACanvas, ARect, ipTopLeftEh, Point(0, 0), EmptyRect);
    //ACanvas.Draw(ARect.Left, ARect.Top, Picture.Graphic);
    PaintTo(APicture.Graphic, ACanvas, AClientRect, ipFitEh, Classes.Point(0, 0), EmptyRect);
    APicture.Free;
  end;
end;

procedure TLaImageEh.SetFieldName(const Value: String);
begin
  if (FFieldName <> Value) then
  begin
//    if FText <> '' then
//       raise EInvalidOperation.Create('TLaFlowTextBlock can''t SetFieldName when Text is not Empty.');
    FFieldName := Value;
    //FText := '';
  end;
end;

procedure TLaImageEh.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
end;

procedure TLaImageEh.SetImageList(const Value: TCustomImageList);
begin
  FImageList := Value;
end;

procedure TLaImageEh.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
//  FPicture := Value;
end;

function TLaImageEh.GetPictureForField(AFieldName: String): TPicture;
var
  DataSet: TDataSet;
  Field: TField;
begin
  DataSet := GetDataSet;
  if (DataSet = nil) then Exit(nil);

  Field := DataSet.FieldByName(FieldName);
  Result := ToolCtrlsEh.GetPictureForField(Field);
end;

procedure TLaImageEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);

  if (Source is TLaImageEh) then
  begin
    ImageList := TLaImageEh(Source).ImageList;
    ImageIndex := TLaImageEh(Source).ImageIndex;
    FieldName := TLaImageEh(Source).FieldName;
    Picture := TLaImageEh(Source).Picture;
  end;
end;

end.
