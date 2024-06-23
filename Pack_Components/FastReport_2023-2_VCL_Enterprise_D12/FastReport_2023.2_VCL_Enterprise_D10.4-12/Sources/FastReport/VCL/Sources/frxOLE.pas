
{******************************************}
{                                          }
{             FastReport VCL               }
{               OLE object                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxOLE;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFNDEF FPC}
  OleCtnrs,
  {$ENDIF}
  StdCtrls, ExtCtrls, frxClass, frCore
  {$IFNDEF FPC}
  , ActiveX
  {$ENDIF}
  {$IFDEF FPC}
  , LCLType, LCLIntf, LazHelper
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF}
{$IFDEF FR_COM}
, FastReport_TLB
{$ENDIF};


type
  TfrxSizeMode = (fsmClip, fsmScale, fsmAutoSize);
{$IFDEF DELPHI16}
/// <summary>
///   The TfrxOLEObject allows the use of OLE objects in your report.
///   TfrxOLEObject is an empty component. It is used to add thefrxOLE.pas file
///   to the "uses" list. The main component is TfrxOLEView.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxOLEObject = class(TComponent)  // fake component
  end;

{$IFDEF FR_COM}
  TfrxOLEView = class(TfrxView, IfrxOLEView)
{$ELSE}
  /// <summary>
  ///   The TfrxOLEView component represents an OLE object. Component can show
  ///   an OLE object from the DB field (you should set DataSet, DataField
  ///   properties).
  /// </summary>
  TfrxOLEView = class(TfrxView)
{$ENDIF}
  private
    FOleContainer: TOleContainer;
    FSizeMode: TfrxSizeMode;
    FStretched: Boolean;
    FZoom: Extended;
    procedure ReadData(Stream: TStream);
    procedure SetStretched(const Value: Boolean);
    procedure WriteData(Stream: TStream);
    function GetOriginalSize(var OriginalSize: TPoint): Boolean;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure SetWidth(Value: Extended); override;
    procedure SetHeight(Value: Extended); override;
{$IFDEF FR_COM}
    function Get_OleContainer(out Value: IUnknown): HResult; stdcall;
    function Get_SizeMode(out Value: Integer): HResult; stdcall;
    function Set_SizeMode(Value: Integer): HResult; stdcall;
    function Get_Stretched(out Value: WordBool): HResult; stdcall;
    function Set_Stretched(Value: WordBool): HResult; stdcall;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure GetData; override;
    class function GetDescription: String; override;
    /// <summary>
    ///   Reference to internal TOleContainer object.
    /// </summary>
    property OleContainer: TOleContainer read FOleContainer;
    function IsEMFExportable: Boolean; override;
  published
    property BrushStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    property FillType;
    property Fill;
    property Frame;
    property SizeMode: TfrxSizeMode read FSizeMode write FSizeMode default fsmClip;
    /// <summary>
    ///   Determines if it is necessary to stretch an OLE object to the area
    ///   occupied by the object in a report. It may be useful for showing MS
    ///   Excel objects.
    /// </summary>
    property Stretched: Boolean read FStretched write SetStretched default False;
    property Style;
    property Zoom: Extended read FZoom write FZoom;
    property TagStr;
    property URL;
  end;

/// <summary>
///   This method copies the contents from ContFrom to ContTo OLE container.
/// </summary>
procedure frxAssignOle(ContFrom, ContTo: TOleContainer);


implementation

uses 
  frxOLERTTI, 
{$IFNDEF NO_EDITORS}
  frxOLEEditor, 
{$ENDIF}
  frxDsgnIntf, frxRes;


procedure frxAssignOle(ContFrom, ContTo: TOleContainer);
var
  st: TMemoryStream;
begin
  {$IFNDEF FPC}
  if (ContFrom = nil) or (ContFrom.OleObjectInterface = nil) then
  begin
    ContTo.DestroyObject;
    Exit;
  end;
  st := TMemoryStream.Create;
  ContFrom.SaveToStream(st);
  st.Position := 0;
  ContTo.LoadFromStream(st);
  st.Free;
  {$ENDIF}
end;

function HimetricToPixels(const P: TPoint): TPoint;
begin
  Result.X := MulDiv(P.X, Screen.PixelsPerInch, 2540);
  Result.Y := MulDiv(P.Y, Screen.PixelsPerInch, 2540);
end;


{ TfrxOLEView }

constructor TfrxOLEView.Create(AOwner: TComponent);
begin
  inherited;
  Font.Name := 'Tahoma';
  Font.Size := 8;
  FZoom := 1;

  FOleContainer := TOleContainer.Create(nil);
  with FOleContainer do
  begin
    Parent := frxParentForm;
    {$IFNDEF FPC}
    SendMessage(frxParentForm.Handle, WM_CREATEHANDLE, frInteger(FOleContainer), 0);
    AllowInPlace := False;
    AutoVerbMenu := False;
    BorderStyle := bsNone;
    SizeMode := smClip;
    {$ENDIF}
  end;
end;

destructor TfrxOLEView.Destroy;
begin
  {$IFNDEF FPC}
  SendMessage(frxParentForm.Handle, WM_DESTROYHANDLE, frInteger(FOleContainer), 0);
  {$ENDIF}
  FOleContainer.Free;
  inherited;
end;

class function TfrxOLEView.GetDescription: String;
begin
  Result := frxResources.Get('obOLE');
end;

procedure TfrxOLEView.DefineProperties(Filer: TFiler);
begin
  inherited;
  {$IFNDEF FPC}
  Filer.DefineBinaryProperty('OLE', ReadData, WriteData,
    OleContainer.OleObjectInterface <> nil);
  {$ENDIF}
end;

procedure TfrxOLEView.SetWidth(Value: Extended);
var
  S: TPoint;
begin
  inherited;
  if (Self.SizeMode = fsmAutoSize) then
    if (GetOriginalSize(S)) then
      FZoom := Width / S.X;
end;

procedure TfrxOLEView.SetHeight(Value: Extended);
var
  S: TPoint;
begin
  inherited;
  if (Self.SizeMode = fsmAutoSize) then
    if (GetOriginalSize(S)) then
      FZoom := Height / S.Y;
end;

procedure TfrxOLEView.ReadData(Stream: TStream);
begin
  {$IFNDEF FPC}
  FOleContainer.LoadFromStream(Stream);
  {$ENDIF}
end;

procedure TfrxOLEView.WriteData(Stream: TStream);
begin
  {$IFNDEF FPC}
  FOleContainer.SaveToStream(Stream);
  {$ENDIF}
end;

function TfrxOLEView.GetOriginalSize(var OriginalSize: TPoint): Boolean;
var
  ViewObject2: IViewObject2;
begin
  Result := Succeeded(FOleContainer.OleObjectInterface.QueryInterface(IViewObject2, ViewObject2));
  if (Result) then
  begin
    ViewObject2.GetExtent(DVASPECT_CONTENT, -1, nil, OriginalSize);
    OriginalSize := HimetricToPixels(OriginalSize);
  end;
end;

procedure TfrxOLEView.SetStretched(const Value: Boolean);
var
  VS: TPoint;
begin
  FStretched := Value;
  {$IFNDEF FPC}
  if not Stretched then
    with FOleContainer do
      if OleObjectInterface <> nil then
      begin
        Run;
        VS.X := MulDiv(Width, 2540, Screen.PixelsPerInch);
        VS.Y := MulDiv(Height, 2540, Screen.PixelsPerInch);
{$IFDEF WIN64}
        OleObjectInterface.SetExtent(DVASPECT_CONTENT, @VS);
{$ELSE}
        OleObjectInterface.SetExtent(DVASPECT_CONTENT, VS);
{$ENDIF}
      end;
  {$ENDIF}
end;

procedure TfrxOLEView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended);
{$IFNDEF FPC}
var
  DRect, R: TRect;
  W, H: Integer;
  S: TPoint;
{$ENDIF}
begin
  {$IFNDEF FPC}
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DRect := Rect(FX, FY, FX1, FY1);
  OleContainer.Width := FDX;
  OleContainer.Height := FDY;
  DrawBackground;
  if FZoom < 0.0001 then
    FZoom := 1;

  if (FDX > 0) and (FDY > 0) then
    with OleContainer do
      if OleObjectInterface <> nil then
      begin
        if (Self.SizeMode = fsmClip) then
          OleDraw(OleObjectInterface, DVASPECT_CONTENT, Canvas.Handle, DRect)
        else
        if (Self.SizeMode = fsmScale) then
        begin
          if (GetOriginalSize(S)) then
          begin;
            W := DRect.Right - DRect.Left;
            H := DRect.Bottom - DRect.Top;
            if W * S.Y > H * S.X then
            begin
              S.X := S.X * H div S.Y;
              S.Y := H;
            end
            else
            begin
              S.Y := S.Y * W div S.X;
              S.X := W;
            end;

            R.Left := DRect.Left + (W - S.X) div 2;
            R.Top := DRect.Top + (H - S.Y) div 2;
            R.Right := R.Left + S.X;
            R.Bottom := R.Top + S.Y;
            OleDraw(OleObjectInterface, DVASPECT_CONTENT, Canvas.Handle, R);
          end;
        end
        else
        if (Self.SizeMode = fsmAutoSize) then
        begin
          if (GetOriginalSize(S)) then
          begin
            R.Left := DRect.Left;
            R.Top := DRect.Top;
            R.Right := Round(R.Left + S.X * FZoom * FScaleX);
            R.Bottom := Round(R.Top + S.Y * FZoom * FScaleY);
            Self.Width := S.X * FZoom;
            Self.Height := S.Y * FZoom;
            OleDraw(OleObjectInterface, DVASPECT_CONTENT, Canvas.Handle, R);
          end;
        end;
      end
      else
        frxImages.ObjectImages.Draw(Canvas, FX + 1, FY + 2, 22);

  DrawFrame;
  {$ENDIF}
end;

procedure TfrxOLEView.GetData;
var
  s: TMemoryStream;
begin
  inherited;
  {$IFNDEF FPC}
  if IsDataField then
  begin
    s := TMemoryStream.Create;
    try
      DataSet.AssignBlobTo(DataField, s);
      FOleContainer.LoadFromStream(s);
    finally
      s.Free;
    end;
  end;
  {$ENDIF}
end;

function TfrxOLEView.IsEMFExportable: Boolean;
begin
  Result := False;
end;

{$IFDEF FR_COM}
function TfrxOLEView.Get_OleContainer(out Value: IUnknown): HResult; stdcall;
begin
  Value := OleContainer;
  Result := S_OK;
end;

function TfrxOLEView.Get_SizeMode(out Value: Integer): HResult; stdcall;
begin
  Value := Integer(SizeMode);
  Result := S_OK;
end;

function TfrxOLEView.Set_SizeMode(Value: Integer): HResult; stdcall;
begin
  SizeMode := TfrxSizeMode(Value);
  Result := S_OK;
end;

function TfrxOLEView.Get_Stretched(out Value: WordBool): HResult; stdcall;
begin
  Value := Stretched;
  Result := S_OK;
end;

function TfrxOLEView.Set_Stretched(Value: WordBool): HResult; stdcall;
begin
  Stretched := Value;
  Result := S_OK;
end;
{$ENDIF}


initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxOLEObject, TControl);
{$ENDIF}
  frxObjects.RegisterObject1(TfrxOLEView, nil, '', '', 0, 22);

finalization
  frxObjects.UnRegister(TfrxOLEView);

end.

