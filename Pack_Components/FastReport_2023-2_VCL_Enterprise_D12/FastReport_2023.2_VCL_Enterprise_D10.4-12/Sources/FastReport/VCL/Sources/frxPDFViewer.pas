{******************************************}
{                                          }
{             FastReport VCL               }
{             PDFView class                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPDFViewer;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
  {$IFDEF LCLGTK2}Printers, {$ENDIF}
{$ENDIF}
  Controls, Classes, Types, Graphics, SysUtils, frxClass, frxDsgnIntf, frxPDFium, frxProtocolFactory;

type
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxPDFObject = class(TComponent);  // fake component

  TDetailStretchMode = (
  pdOneToOneStrongStretch = 0,
  pdOneToOneNormalize = 1,
  pdManyToOneNormalize = 2
  //, pdManyToOneSmart //TODO
  );

  TfrxDrawOptions = class;

  TfrxPDFView = class(TfrxStretcheable, IfrxDataLinkObject)
  private
    FPDFDocument: TPdfDocument;
    FMemoryPDF, FTempStream: TMemoryStream;
    FDrawPartIndex: Integer;
    FDefHeight, FLastPadding: Extended;
    FHasNextDataPart: Boolean;

    FRotation: Integer;
    FProp: TfrxDrawOptions;
    FPassword: String;
    //FRange: String; //TODO
    FFileLink: String;
    FDetailStretchMode: TDetailStretchMode;
    FDataLink: TfrxDataLink;

    procedure PDFDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; DrawRect: TRect);
    procedure DrawError(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; DrawRect: TRect);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
    procedure Normalize(CX, CY: Integer; var DX, DY: Integer);
    procedure CheckEmpty;

    procedure SetProp(v: TfrxDrawOptions);
    procedure SetPassword(val: String);

    function LoadDataStream(Stream: TStream; const NewLink: String): Boolean;
    function GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
    function IsExpressionLink: Boolean;
    function GetDataLink: TfrxDataLink;
    procedure SetDataLink(const Value: TfrxDataLink);
    function IsDataLinkStored: Boolean;

  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    PDFDrawOptions: TPdfDrawOptions;
    constructor Create(AComponent:TComponent); override;
    destructor Destroy; override;
    function IsOneToOne: Boolean;
    class function GetDescription: String; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure BeforePrint; override;
    procedure AfterPrint; override;
    procedure LoadPDFFromStream(AStream: TStream; const APassword: String = '');
    procedure LoadFromFile(const AFileName: string);
    function CalcHeight: Extended; override;
    function DrawPart: Extended; override;
    function HasNextDataPart(aFreeSpace: Extended): Boolean; override;
    procedure GetData; override;
    function GetLastShiftAmount(aFreeSpace: Extended): Extended; override;
    procedure EditorDraw(Canvas: TCanvas; DrawRect: TRect);
    procedure ClearPDF;

    property PDFDocument: TPdfDocument read FPDFDocument;
    property MemoryPDF: TMemoryStream read FMemoryPDF;
  published
    property Rotation: Integer read FRotation write FRotation default 0;
    property FileLink: String read FFileLink write FFileLink;
    property DataLink: TfrxDataLink read GetDataLink write SetDataLink stored IsDataLinkStored;
    property DetailStretchMode: TDetailStretchMode read FDetailStretchMode write FDetailStretchMode;
    property Password: String read FPassword write SetPassword;
    property DrawOptions: TfrxDrawOptions read FProp write SetProp;
    //property Range: Integer read FRange write FRange;
    property DataField;
    property DataSet;
    property DataSetName;
    property FillType;
    property Fill;
    property Frame;
    property BrushStyle;
    property Color;
    property Cursor;
    property Style;
  end;

  TfrxDrawOptions = class(TPersistent)
  private
    FWhose: TfrxPDFView;
    function GetValue(const Index: Integer): Boolean;
    procedure SetValue(const Index: Integer; const Value: Boolean);
  public
    procedure Assign(Source: TPersistent); override;
    procedure SetWhose(w: TfrxPDFView);
  published
    property Annotations: Boolean index Integer(pdoAnnotations) read GetValue write SetValue;
    property LCDOptimized: Boolean index Integer(pdoLCDOptimized) read GetValue write SetValue;
    property NoNativeText: Boolean index Integer(pdoNoNativeText) read GetValue write SetValue;
    property GrayScale: Boolean index Integer(pdoGrayScale) read GetValue write SetValue;
    property NoCatch: Boolean index Integer(pdoNoCatch) read GetValue write SetValue;
    property LimitedImageCacheSize: Boolean index Integer(pdoLimitedImageCacheSize) read GetValue write SetValue;
    property ForceHalftone: Boolean index Integer(pdoForceHalftone) read GetValue write SetValue;
    property PrintTextWithGDI: Boolean index Integer(pdoPrintTextWithGDI) read GetValue write SetValue;
  end;

  procedure frxAssignPDF(PDFFrom, PDFTo: TfrxPDFView);
  procedure frxSetPDFiumDLLPath(Path: String);

implementation

uses frxRes,
{$IFNDEF NO_EDITORS}
  frxEditPDF,
  frxPDFViewInPlaceEditor,
{$ENDIF}
  frxPrinter, frxPDFRTTI, Variants;

type
  TfrxDrawOptionsProperty = class(TfrxClassProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
  end;

{TfrxPDFView}

procedure TfrxPDFView.PDFDraw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; DrawRect: TRect);
var
  PDFRotate: Integer;
begin
  PDFRotate := 0;
  case (Rotation) of
    90:  PDFRotate := 1;
    180: PDFRotate := 2;
    270: PDFRotate := 3;
  end;
  if Canvas is {$IFDEF LCLGTK2}TPrinterCanvas{$ELSE}TfrxPrinterCanvas{$ENDIF} then
    FPDFDocument.Paint(Canvas, DrawRect, PDFRotate, PDFDrawOptions + [pdoPrinting])
  else if FObjAsMetafile then
    FPDFDocument.Paint(Canvas, DrawRect, PDFRotate, PDFDrawOptions + [pdoUseMetafile])
  else
    FPDFDocument.Paint(Canvas, DrawRect, PDFRotate, PDFDrawOptions);
end;

procedure TfrxPDFView.DrawError(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended; DrawRect: TRect);
begin
  with Canvas do
  begin
    Font.Name := 'Arial';
    Font.Size := Round(10 * ScaleY);
    Font.Color := clRed;
    DrawRect.Left := DrawRect.Left + 2;
    DrawRect.Top := DrawRect.Top + 2;
    DrawText(Handle, PChar(FPDFDocument.ErrorText), Length(FPDFDocument.ErrorText), DrawRect,
      DT_WORDBREAK);
  end;
end;

procedure TfrxPDFView.ReadData(Stream: TStream);
begin
  Self.LoadPDFFromStream(Stream, FPassword);
end;

procedure TfrxPDFView.WriteData(Stream: TStream);
begin
  FMemoryPDF.SaveToStream(Stream);
end;

procedure TfrxPDFView.Normalize(CX, CY: Integer; var DX, DY: Integer);
var
  a1, a2, b1, b2: Integer;

  procedure Swap(var x, y: Integer);
  var
    buf: Integer;
  begin
    buf := x;
    x := y;
    y := buf;
  end;

begin
  a1 := Round(FPDFDocument.CurrentPage.Height);
  a2 := Round(FPDFDocument.CurrentPage.Width);
  if (Rotation = 90) or (Rotation = 270) then
    Swap(a1, a2);
  b1 := DY - CY;
  b2 := DX - CX;
  if a1 = 0 then a1 := 1;
  if a2 = 0 then a2 := 1;
  if b2 = 0 then b2 := 1;
  if (a1 / a2) > (b1 / b2) then
    DX := CX + Round(b1 * a2 / a1)
  else
  if (a1 / a2) < (b1 / b2) then
    DY := CY + Round(a1 * b2 / a2);
end;

procedure TfrxPDFView.CheckEmpty;
begin
  if (FPDFDocument.PageCount < 1) and (FPDFDocument.ErrorText = '') then
    FPDFDocument.ErrorText := RsPdfEmptyDocument;
end;

procedure TfrxPDFView.SetProp(v: TfrxDrawOptions);
begin
  FProp.Assign(v);
end;

procedure TfrxPDFView.SetDataLink(const Value: TfrxDataLink);
begin
  if not Assigned(FDataLink) then
    GetDataLink;
  FDataLink.Assign(Value);
end;

procedure TfrxPDFView.SetPassword(val: String);
begin
  FPassword := val;
  FMemoryPDF.Position := 0;
  FPDFDocument.LoadFromStream(FMemoryPDF, FPassword);
end;

function TfrxPDFView.IsDataLinkStored: Boolean;
begin
  Result := TfrxDataLink.IsDataLinkStored(FDataLink, frComponentState);
end;

function TfrxPDFView.IsExpressionLink: Boolean;
begin
  Result := TfrxDataLink.IsExpressionLink(FDataLink);
end;

function TfrxPDFView.isOneToOne: Boolean;
begin
  Result := (Integer(DetailStretchMode) < 2);
end;

procedure TfrxPDFView.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('PDFStream', ReadData, WriteData, True);
end;

procedure TfrxPDFView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

constructor TfrxPDFView.Create(AComponent:TComponent);
begin
  inherited Create(AComponent);
  FPDFDocument := TPdfDocument.Create;
  FMemoryPDF := TMemoryStream.Create;
  FTempStream := TMemoryStream.Create;
  FHasNextDataPart := True;
  FRotation := 0;
  FDetailStretchMode := pdOneToOneStrongStretch;
  PDFDrawOptions := [];
  FProp := TfrxDrawOptions.Create;
  FProp.SetWhose(Self);
end;

destructor TfrxPDFView.Destroy;
begin
  FPDFDocument.Free;
  FMemoryPDF.Free;
  FTempStream.Free;
  FProp.Free;
  FreeAndNil(FDataLink);
  inherited;
end;

class function TfrxPDFView.GetDescription: String;
begin
  Result := frxResources.Get('obPDF');
end;

procedure TfrxPDFView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);

  procedure DrawManyToOneNormalize();
  var
    DrawRect: TRect;
    i: Integer;
    x, y, dy: Integer;
  begin
    if (StretchMode <> smMaxHeight) then
    begin
      dy := -Round(ScaleY);
      for i := 0 to PDFDocument.PageCount - 1 do
      begin
        PDFDocument.PageIndex := i;
        x := FX1 - FX;
        y := FY1 - FY;
        Normalize(0, 0, x, y);
        DrawRect := Rect(FX, FY + dy, FX + x, FY + dy + y);
        dy := dy + y;
        if (dy > FY1 - FY) then
        begin
          dy := dy - y;
          Break;
        end;
      end;
      FY1 := FY + dy;
    end;
    DrawBackground;
    dy := -Round(ScaleY);
    for i := 0 to PDFDocument.PageCount - 1 do
    begin
      PDFDocument.PageIndex := i;
      x := FX1 - FX;
      y := FY1 - FY;
      Normalize(0, 0, x, y);
      DrawRect := Rect(FX, FY + dy, FX + x, FY + dy + y);
      dy := dy + y;
      if (dy > FY1 - FY) then
        Break;
      PDFDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY, DrawRect);
    end;
    PDFDocument.PageIndex := 0;
  end;

  procedure DrawOneToOne();
  var
    DrawRect: TRect;
  begin
    if (FDetailStretchMode = pdOneToOneNormalize) then
    begin
      if (StretchMode <> smMaxHeight) then
      begin
        Normalize(FX, FY, FX1, FY1);
        DrawRect := Rect(FX, FY, FX1, FY1);
      end
      else
      begin
        DrawRect := Rect(FX, FY, FX1, FY1);
        Normalize(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);
      end;
    end
    else
      DrawRect := Rect(FX, FY, FX1, FY1);
    DrawBackground;
    PDFDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY, DrawRect);
  end;

begin
  if Height < 0 then Height := Height * (-1);
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  CheckEmpty;
  if FPDFDocument.ErrorText <> '' then
  begin
    DrawBackground;
    DrawError(Canvas, ScaleX, ScaleY, OffsetX, OffsetY, Rect(FX, FY, FX1, FY1));
  end
  else
  begin
    if (FDetailStretchMode = pdManyToOneNormalize) then
      DrawManyToOneNormalize()
    else
      DrawOneToOne();
  end;

  if not FObjAsMetafile then
    DrawFrame;
end;

procedure TfrxPDFView.BeforePrint;
begin
  inherited;
  TfrxDataLink.SaveState(FDataLink);
  FTempStream.Clear;
  FMemoryPDF.SaveToStream(FTempStream);
  FDrawPartIndex := 1;
  FLastPadding := - 1;
end;

procedure TfrxPDFView.AfterPrint;
begin
  FDrawPartIndex := 1;
  FMemoryPDF.LoadFromStream(FTempStream);
  TfrxDataLink.RestoreState(FDataLink);
  inherited;
end;

procedure TfrxPDFView.LoadPDFFromStream(AStream: TStream; const APassword: String = '');
begin
  if (FMemoryPDF.Size > 0) then
    FMemoryPDF.Clear;
  FMemoryPDF.LoadFromStream(AStream);
  FMemoryPDF.Position := 0;
  FPDFDocument.LoadFromStream(FMemoryPDF, APassword)
end;

function TfrxPDFView.LoadDataStream(Stream: TStream;
  const NewLink: String): Boolean;
begin
  Result := True;
  try
    LoadPDFFromStream(Stream, FPassword);
  except
    Result := False;
  end;
end;

procedure TfrxPDFView.LoadFromFile(const AFileName: string);
begin
  if (FMemoryPDF.Size > 0) then
    FMemoryPDF.Clear;
  FMemoryPDF.LoadFromFile(AFileName);
  FPDFDocument.LoadFromStream(FMemoryPDF, '');
end;

function TfrxPDFView.CalcHeight: Extended;
begin
  FDefHeight := Report.Engine.PageHeight + 10;
  Result := FDefHeight;
end;

function TfrxPDFView.DrawPart: Extended;
var
  FSpDoc: TPdfDocument;
  x, y, dy: Integer;
begin
  if FPDFDocument.ErrorText <> '' then
  begin
    Result := 0;
    FHasNextDataPart := False;
    Exit;
  end;
  Result := FDefHeight;
  if (isOneToOne()) then
  begin
    FSpDoc := TPdfDocument.Create;
    FSpDoc.NewDocument;
    FSpDoc.ImportPages(FPDFDocument, IntToStr(FDrawPartIndex));
    FMemoryPDF.Clear;
    FSpDoc.SaveToStream(FMemoryPDF, dsoIncremental);
    FSpDoc.Free;
    FHasNextDataPart := FPDFDocument.PageCount > FDrawPartIndex;
    if (not FHasNextDataPart) and (FDetailStretchMode = pdOneToOneNormalize) and (StretchMode <> smMaxHeight) then
    begin
      PDFDocument.PageIndex := FPDFDocument.PageCount - 1;
      x := Round(Width);
      y := Round(Height);
      Normalize(0, 0, x, y);
      FLastPadding := - (Height - y);
    end;
    inc(FDrawPartIndex);
  end
  else
  begin
    FSpDoc := TPdfDocument.Create;
    FSpDoc.NewDocument;
    dy := 0;
    while True do
    begin
      FHasNextDataPart := FPDFDocument.PageCount >= FDrawPartIndex;
      if (not FHasNextDataPart) and (StretchMode <> smMaxHeight) then
      begin
        FLastPadding := - (Height - dy);
        break;
      end;
      PDFDocument.PageIndex := FDrawPartIndex - 1;
      x := Round(Width);
      y := Round(Height);
      Normalize(0, 0, x, y);
      dy := dy + y;
      if dy > Round(Height) then
        break;
      FSpDoc.ImportPages(FPDFDocument, IntToStr(FDrawPartIndex));
      inc(FDrawPartIndex);
    end;
    FMemoryPDF.Clear;
    FSpDoc.SaveToStream(FMemoryPDF, dsoIncremental);
    FSpDoc.Free;
  end;
end;

function TfrxPDFView.HasNextDataPart(aFreeSpace: Extended): Boolean;
begin
  Result := FHasNextDataPart and (StretchMode <> smDontStretch);
end;

procedure TfrxPDFView.GetData;
var
  s1: String;
  ss: TStringStream;
begin
  Inherited;
  if FFileLink <> '' then
  begin
    s1 := FFileLink;
    if Pos('[', s1) <> 0 then
      ExpandVariables(s1);
    if FileExists(s1) then
      LoadFromFile(s1);
  end
  else if IsDataField then
  begin
    if DataSet.IsBlobField(DataField) then
    begin
      ss := TStringStream.Create('');
      DataSet.AssignBlobTo(DataField, ss)
    end
    else
      ss := TStringStream.Create(VarToStr(DataSet.Value[DataField]));
    try
      Self.LoadPDFFromStream(ss, Password);
    finally
      ss.Free;
    end;
  end;
end;

function TfrxPDFView.GetDataLink: TfrxDataLink;
begin
  if not Assigned(FDataLink) then
    FDataLink := TfrxDataLink.Create;
  Result := FDataLink;
end;

function TfrxPDFView.GetLastShiftAmount(aFreeSpace: Extended): Extended;
begin
  Result := aFreeSpace - FSaveHeight + FLastPadding;
end;

function TfrxPDFView.GetLink(LoadMethod: TfrxDataLinkLoadMethod): String;
begin
  Result := TfrxDataLink.GetLink(FDataLink, LoadMethod);
end;

procedure TfrxPDFView.EditorDraw(Canvas: TCanvas; DrawRect: TRect);
begin
  CheckEmpty;
  if FPDFDocument.ErrorText <> '' then
    DrawError(Canvas, 1, 1, 0, 0, DrawRect)
  else
    PDFDraw(Canvas, 1, 1, 0, 0, DrawRect);
end;

procedure TfrxPDFView.ClearPDF;
begin
  FMemoryPDF.Clear;
  FPDFDocument.Clear;
  PDFDocument.ErrorText := '';
end;

{TfrxDrawOptions}

function TfrxDrawOptions.GetValue(const Index: Integer): Boolean;
begin
  Result := TPdfDrawOption(Index) in FWhose.PDFDrawOptions;
end;

procedure TfrxDrawOptions.SetValue(const Index: Integer; const Value: Boolean);
begin
  if Value then
    Include(FWhose.PDFDrawOptions, TPdfDrawOption(Index))
  else
    Exclude(FWhose.PDFDrawOptions, TPdfDrawOption(Index));
end;

procedure TfrxDrawOptions.Assign(Source: TPersistent);
var
  src: TfrxDrawOptions;
begin
  if Source is TfrxDrawOptions then
  begin
    src := TfrxDrawOptions(Source);
    Annotations := src.Annotations;
    LCDOptimized := src.LCDOptimized;
    NoNativeText := src.NoNativeText;
    GrayScale := src.GrayScale;
    NoCatch := src.NoCatch;
    LimitedImageCacheSize := src.LimitedImageCacheSize;
    ForceHalftone := src.ForceHalftone;
    SetWhose(src.FWhose);
  end
end;

procedure TfrxDrawOptions.SetWhose(w: TfrxPDFView);
begin
  FWhose := w;
end;

function TfrxDrawOptionsProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paSubProperties, paReadOnly]; // no multiselect!
end;

{Other}

procedure frxAssignPDF(PDFFrom, PDFTo: TfrxPDFView);
begin
  PDFTo.LoadPDFFromStream(PDFFrom.MemoryPDF, PDFTo.Password)
end;

procedure frxSetPDFiumDLLPath(Path: String);
begin
  PDFiumDLLPath := Path;
end;

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxPDFObject, TControl);
{$ENDIF}
  frxObjects.RegisterObject1(TfrxPDFView, nil, '', '', 0, 85);
  frxPropertyEditors.Register(TypeInfo(TfrxDrawOptions), nil, '',
  TfrxDrawOptionsProperty);

finalization
  frxObjects.UnRegister(TfrxPDFView);

end.
