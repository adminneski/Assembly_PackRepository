
{******************************************}
{                                          }
{             FastReport VCL               }
{         Checkbox Add-In Object           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxChBox;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Menus, frxClass
  {$IFDEF FPC}
  , LCLType, LMessages, LCLIntf, LazarusPackageIntf, LazHelper
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF}
{$IFDEF DELPHI16}
 , Vcl.Controls
{$ELSE}
 , Controls
{$ENDIF};


type
  /// <summary>
  ///   Checked style of the checkbox - cross, check, crossline, plus.
  /// </summary>
  TfrxCheckStyle = (csCross, csCheck, csLineCross, csPlus);
  /// <summary>
  ///   UnChecked style of the checkbox - empty, cross, crossline, minus.
  /// </summary>
  TfrxUncheckStyle = (usEmpty, usCross, usLineCross, usMinus);

{$IFDEF DELPHI16}
  /// <summary>
  ///   The TfrxCheckBoxObject allows the use of the CheckBox component in your
  ///   <br />report. TfrxCheckBoxObject is an empty component. It is used to
  ///   add the <br />frxChBox.pas file to the "uses" list. The main component
  ///   is <br />TfrxCheckBoxView.
  /// </summary>
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxCheckBoxObject = class(TComponent)  // fake component
  end;

  /// <summary>
  ///   The TfrxCheckBoxView component represents a box containing a mark -
  ///   check or cross. Component shows the check if Checked property value is
  ///   True. Also it can show a check from the DB field (you should set
  ///   DataSet, DataField properties) or from an expression(Expression
  ///   property). <br />
  /// </summary>
  TfrxCheckBoxView = class(TfrxView)
  private
    FCheckColor: TColor;
    FChecked: Boolean;
    FCheckStyle: TfrxCheckStyle;
    FUncheckStyle: TfrxUncheckStyle;
    FExpression: String;
    procedure DrawCheck(ARect: TRect);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure GetData; override;
    class function GetDescription: String; override;
    function DoMouseDown(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean; override;
  published
    property BrushStyle;
    /// <summary>
    ///   Color of the check.
    /// </summary>
    property CheckColor: TColor read FCheckColor write FCheckColor;
    /// <summary>
    ///   Determines whether to show the check.
    /// </summary>
    property Checked: Boolean read FChecked write FChecked default True;
    /// <summary>
    ///   Checked style of the check.
    /// </summary>
    property CheckStyle: TfrxCheckStyle read FCheckStyle write FCheckStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    /// <summary>
    ///   Value of the expression determines whether to show the check.
    /// </summary>
    property Expression: String read FExpression write FExpression;
    property Editable default [ferAllowInPreview];
    property FillType;
    property Fill;
    property Frame;
    property Style;
    property TagStr;
    /// <summary>
    ///   Unchecked style of the check.
    /// </summary>
    property UncheckStyle: TfrxUncheckStyle read FUncheckStyle write FUncheckStyle default usEmpty;
    property URL;
  end;

  {$IFDEF FPC}
  //procedure Register;
  {$ENDIF}

implementation

uses frxChBoxRTTI, frxDsgnIntf, frxRes, frxUtils;


constructor TfrxCheckBoxView.Create(AOwner: TComponent);
begin
  inherited;
  FChecked := True;
  Height := fr01cm * 5;
  Width := fr01cm * 5;
  Editable := [ferAllowInPreview];
end;

class function TfrxCheckBoxView.GetDescription: String;
begin
  Result := frxResources.Get('obChBox');
end;

procedure TfrxCheckBoxView.DrawCheck(ARect: TRect);
var
{$IFDEF DELPHI12}
  Sz: TSize;
  s: AnsiString;
{$ELSE}
 {$IFDEF FPC}
  s: WideString;
 {$ELSE}
  s: String;
 {$ENDIF}
{$ENDIF}
const
  {$IFDEF FPC}
  CrossMark = WideChar($F0FB);
  CheckMark = WideChar($F0FC);
  {$ELSE}
  CrossMark = #251;
  CheckMark = #252;
  {$ENDIF}
begin
  with FCanvas, ARect do
    if FChecked then
    begin
      if FCheckStyle in [csCross, csCheck] then
      begin
        Font.Name := 'Wingdings';
        Font.Color := FCheckColor;
        Font.Style := [];
        Font.Height := - (Bottom - Top);
        Font.CharSet :=  SYMBOL_CHARSET;
        if FCheckStyle = csCross then
          s := CrossMark else
          s := CheckMark;
        frxSetBkMode(FCanvas, Transparent);
{$IFDEF DELPHI12}
        GetTextExtentPoint32A(Handle, PAnsiChar(s), Length(s), Sz);
        ExtTextOutA(Handle, Left + (Right - Left - Sz.cx) div 2,
          Top, ETO_CLIPPED, @ARect, PAnsiChar(s), 1, nil);
{$ELSE}
  {$IFNDEF FPC}
        ExtTextOut(Handle, Left + (Right - Left - TextWidth(s)) div 2,
          Top, ETO_CLIPPED, @ARect, PChar(s), 1, nil);
  {$ELSE}
        ExtTextOutExtrW(FCanvas, Left + (Right - Left - TextWidth(s)) div 2,
          Top, ETO_CLIPPED, @ARect, PWideChar(s), 4, nil);
  {$ENDIF}
{$ENDIF}
      end
      else if FCheckStyle = csLineCross then
      begin
        Pen.Style := psSolid;
        Pen.Color := FCheckColor;
        DrawLine(Left, Top, Right, Bottom, FFrameWidth);
        DrawLine(Left, Bottom, Right, Top, FFrameWidth);
      end
      else if FCheckStyle = csPlus then
      begin
        Pen.Style := psSolid;
        Pen.Color := FCheckColor;
        DrawLine(Left + 3, Top + (Bottom - Top) div 2, Right - 2, Top + (Bottom - Top) div 2, FFrameWidth);
        DrawLine(Left + (Right - Left) div 2, Top + 3, Left + (Right - Left) div 2, Bottom - 2, FFrameWidth);
      end
    end
    else
    begin
      if FUncheckStyle = usCross then
      begin
        Font.Name := 'Wingdings';
        Font.Color := FCheckColor;
        Font.Style := [];
        Font.Height := - (Bottom - Top);
        Font.CharSet := SYMBOL_CHARSET;
        s := CrossMark;
        frxSetBkMode(FCanvas, Transparent);
{$IFDEF DELPHI12}
        GetTextExtentPoint32A(Handle, PAnsiChar(s), Length(s), Sz);
        ExtTextOutA(Handle, Left + (Right - Left - Sz.cx) div 2,
          Top, ETO_CLIPPED, @ARect, PAnsiChar(s), 1, nil);
{$ELSE}
  {$IFNDEF FPC}
        ExtTextOut(Handle, Left + (Right - Left - TextWidth(s)) div 2,
          Top, ETO_CLIPPED, @ARect, PChar(s), 1, nil);
  {$ELSE}
        ExtTextOutExtrW(FCanvas, Left + (Right - Left - TextWidth(s)) div 2,
          Top, ETO_CLIPPED, @ARect, PWideChar(s), 4, nil);
  {$ENDIF}
{$ENDIF}
      end
      else if FUncheckStyle = usLineCross then
      begin
        Pen.Style := psSolid;
        Pen.Color := FCheckColor;
        DrawLine(Left, Top, Right, Bottom, FFrameWidth);
        DrawLine(Left, Bottom, Right, Top, FFrameWidth);
      end
      else if FUncheckStyle = usMinus then
      begin
        Pen.Style := psSolid;
        Pen.Color := FCheckColor;
        DrawLine(Left + 3, Top + (Bottom - Top) div 2, Right - 2, Top + (Bottom - Top) div 2, FFrameWidth);
      end
    end;
end;

function TfrxCheckBoxView.DoMouseDown(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := False;
  if IsDesigning then Exit;  
  EventParams.Refresh := True;
  EventParams.Modified := True;
  Checked := not Checked;
end;

procedure TfrxCheckBoxView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  DrawBackground;
  DrawCheck(Rect(FX, FY, FX1, FY1));
  DrawFrame;
end;

procedure TfrxCheckBoxView.GetData;
var
  v: Variant;
begin
  inherited;
  if IsDataField then
  begin
    v := DataSet.Value[DataField];
    if v = Null then
      v := False;
    FChecked := v;
  end
  else if FExpression <> '' then
    FChecked := Report.Calc(FExpression);
end;

{$IFDEF FPC}
{procedure RegisterUnitfrxChBox;
begin
  RegisterComponents('Fast Report 6',[TfrxCheckBoxObject]);
end;

procedure Register;
begin
  RegisterUnit('frxChBox',@RegisterUnitfrxChBox);
end;}
{$ENDIF}

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxCheckBoxObject, TControl);
{$ENDIF}
  frxObjects.RegisterObject1(TfrxCheckBoxView, nil, '', '', 0, 24);

finalization
  frxObjects.UnRegister(TfrxCheckBoxView);


end.
