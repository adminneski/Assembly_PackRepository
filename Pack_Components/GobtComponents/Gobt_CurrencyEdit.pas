unit Gobt_CurrencyEdit;

interface

uses
   Messages, SysUtils, Classes, Controls, Forms, Dialogs, ExtCtrls,
   StdCtrls, Mask, Windows, Menus, Grids, Graphics, DateUtils;

type
   //
   // TNSKCustomCurrencyEdit.
   //
   TGoCustomCurrencyEdit = class(TCustomMaskEdit)
   private
      FCanvas: TControlCanvas;
      FAlignment: TAlignment;
      FFocused: Boolean;
      FValue: Double;
      FMinValue, FMaxValue: Double;
      FDecimalPlaces: Integer;
      FBeepOnError: Boolean;
      FDisplayFormat: String;
      FText: string;
      function GetTextMargins: TPoint;
      procedure SetFocused(Value: Boolean);
      procedure SetAlignment(Value: TAlignment);
      procedure SetDisplayFormat(const Value: string);
      function GetDisplayFormat: string;
      procedure SetDecimalPlaces(Value: Integer);
      function GetValue: Double;
      procedure SetValue(AValue: Double);
      function GetAsInteger: Longint;
      procedure SetAsInteger(AValue: Longint);
      procedure SetMaxValue(AValue: Double);
      procedure SetMinValue(AValue: Double);
      function GetText: string;
      procedure SetText(const AValue: string);
      procedure DataChanged;
      function TextToValText(const AValue: string): string;
      function CheckValue(NewValue: Double): Double;
      function IsFormatStored: Boolean;
      procedure WMPaste(var Message: TMessage); message WM_PASTE;
      procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
      procedure CMExit(var Message: TCMExit); message CM_EXIT;
      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
      procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
      function DelESpace(const S: string): string;
      function DelChars(const S: string; Chr: Char): string;
   protected
      function DefaultDisplayFormat: String; virtual;
      procedure KeyPress(var Key: Char); override;
      function IsValidChar(var Key: Char): Boolean; virtual;
      function GetDisplayText: string;
      property Alignment: TAlignment read FAlignment write SetAlignment
      default taRightJustify;
      property BeepOnError: Boolean read FBeepOnError write FBeepOnError
      default True;
      property DecimalPlaces: Integer read FDecimalPlaces write SetDecimalPlaces default 2;
      property DisplayFormat: string read GetDisplayFormat write SetDisplayFormat
      stored IsFormatStored;
      property MaxValue: Double read FMaxValue write SetMaxValue;
      property MinValue: Double read FMinValue write SetMinValue;
      property Text: string read GetText write SetText;
      property Value: Double read GetValue write SetValue;
      property MaxLength default 0;
   public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure UpdateData;
      property AsInteger: Longint read GetAsInteger write SetAsInteger;
      property DisplayText: string read GetDisplayText;
      function IsValidFloat(const Value: string): Boolean;
   end;
   //

   //
   TGoCurrencyEdit = class(TGoCustomCurrencyEdit)
   protected
      function DefaultDisplayFormat: String; override;
   published
      property Align;
      property Alignment;
      property AutoSelect;
      property AutoSize;
      property BeepOnError;
      property BorderStyle;
      property Color;
      property Ctl3D;
      property DecimalPlaces;
      property DisplayFormat;
      property DragCursor;
      property DragMode;
      property Enabled;
      property Font;
      property HideSelection;
      property ImeMode;
      property ImeName;
      property MaxLength;
      property MaxValue;
      property MinValue;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ReadOnly;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property Text;
      property Value;
      property Visible;
      property OnChange;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnStartDrag;
   end;

procedure Register;

implementation

procedure Register;
begin
end;

function TGoCustomCurrencyEdit.IsValidFloat(const Value: string): Boolean;
var
   I: Integer;
   RetValue: Double;
   Buffer: array[0..63] of Char;
begin
   Result := False;
   for I := 1 to Length(Value) do
      if not CharInSet(Value[I], [FormatSettings.DecimalSeparator, '-', '0'..'9']) then
	     Exit;
   Result := TextToFloat(StrPLCopy(Buffer, Value, SizeOf(Buffer) - 1), RetValue, fvExtended);
end;

function TGoCustomCurrencyEdit.DelESpace(const S: string): string;
var
   I: Integer;
begin
   I := 0;
   if S <> '' then
   begin
      I := Length(S);
      while (I > 0) and (S[I] = ' ') do
         Dec(I);
   end;
   Result := Copy(S, 1, I);
end;

function TGoCustomCurrencyEdit.DelChars(const S: string; Chr: Char): string;
var
   I: Integer;
begin
   Result := S;
   for I := Length(Result) downto 1 do
   begin
      if Result[I] = Chr then Delete(Result, I, 1);
   end;
end;

{ TGoCustomCurrencyEdit. }

constructor TGoCustomCurrencyEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   MaxLength := 0;
   FBeepOnError := True;
   FAlignment := taRightJustify;
   FDisplayFormat := DefaultDisplayFormat;
   FText := '0';
   FDecimalPlaces := 2;
   DataChanged;
end;

destructor TGoCustomCurrencyEdit.Destroy;
begin
   FCanvas.Free;
   inherited Destroy;
end;

function TGoCustomCurrencyEdit.DefaultDisplayFormat: String;
begin
   Result := ',0.00';
end;

function TGoCustomCurrencyEdit.IsFormatStored: Boolean;
begin
   Result := (DisplayFormat <> DefaultDisplayFormat);
end;

function TGoCustomCurrencyEdit.IsValidChar(var Key: Char): Boolean;
var
   S: string;
   SelStart, SelStop, DecPos: Integer;
begin
   Result := False;
   S := EditText;
   GetSel(SelStart, SelStop);
   System.Delete(S, SelStart + 1, SelStop - SelStart);
   System.Insert(Key, S, SelStart + 1);
   S := TextToValText(S);
   DecPos := Pos(FormatSettings.DecimalSeparator, S);
   if (DecPos > 0) and ((Length(S) - DecPos) > FDecimalPlaces) then Exit;
   Result := IsValidFloat(S);
end;

procedure TGoCustomCurrencyEdit.KeyPress(var Key: Char);
begin
   inherited KeyPress(Key);
   if (CharInset(Key, [#32..#255])) and (not IsValidChar(Key)) then
   begin
      if BeepOnError then MessageBeep(0);
      Key := #0;
   end
   else if Key = #27 then
   begin
      DataChanged;
      SelectAll;
      Key := #0;
   end;
   if Key = '.' then Key := ',';
end;

procedure TGoCustomCurrencyEdit.SetAlignment(Value: TAlignment);
begin
   if FAlignment <> Value then
   begin
      FAlignment := Value;
      Invalidate;
   end;
end;

procedure TGoCustomCurrencyEdit.SetDisplayFormat(const Value: string);
begin
   if DisplayFormat <> Value then
   begin
      FDisplayFormat := Value;
      Invalidate;
      DataChanged;
   end;
end;

function TGoCustomCurrencyEdit.GetDisplayFormat: string;
begin
   Result := FDisplayFormat;
end;

procedure TGoCustomCurrencyEdit.SetFocused(Value: Boolean);
begin
   if FFocused <> Value then
   begin
      FFocused := Value;
      Invalidate;
      DataChanged;
   end;
end;

procedure TGoCustomCurrencyEdit.SetDecimalPlaces(Value: Integer);
begin
   if FDecimalPlaces <> Value then
   begin
      FDecimalPlaces := Value;
      DataChanged;
      Invalidate;
   end;
end;

function TGoCustomCurrencyEdit.GetDisplayText: string;
begin
   if DisplayFormat <> '' then
      Result := FormatFloat(DisplayFormat, FValue)
   else
      Result := FloatToStr(FValue);
end;

procedure TGoCustomCurrencyEdit.DataChanged;
var
   EditFormat: string;
begin
   EditFormat := '0';
   if FDecimalPlaces > 0 then
      EditFormat := EditFormat + '.' + StringOfChar ('#', FDecimalPlaces);
   //
   EditText := FormatFloat(EditFormat, FValue);
end;

function TGoCustomCurrencyEdit.CheckValue(NewValue: Double): Double;
begin
   Result := NewValue;
   if (FMaxValue <> FMinValue) then
   begin
      if (FMaxValue > FMinValue) then
      begin
         if NewValue < FMinValue then
            Result := FMinValue
         else if NewValue > FMaxValue then
            Result := FMaxValue;
      end
      else
      begin
         if FMaxValue = 0 then
         begin
            if NewValue < FMinValue then Result := FMinValue;
         end
         else if FMinValue = 0 then
         begin
            if NewValue > FMaxValue then Result := FMaxValue;
         end;
      end;
   end;
end;

procedure TGoCustomCurrencyEdit.UpdateData;
begin
   ValidateEdit;
   FValue := CheckValue(StrToFloat(TextToValText(EditText)));
end;

function TGoCustomCurrencyEdit.GetValue: Double;
begin
   if not (csDesigning in ComponentState) then
   try
      UpdateData;
   except
      FValue := FMinValue;
   end;
   Result := FValue;
end;

procedure TGoCustomCurrencyEdit.SetValue(AValue: Double);
begin
   if CheckValue(AValue) <> FValue then
   begin
      FValue := CheckValue(AValue);
      DataChanged;
      Invalidate;
   end;
end;

function TGoCustomCurrencyEdit.GetAsInteger: Longint;
begin
   Result := Trunc(Value);
end;

procedure TGoCustomCurrencyEdit.SetAsInteger(AValue: Longint);
begin
   SetValue(AValue);
end;

procedure TGoCustomCurrencyEdit.SetMinValue(AValue: Double);
begin
   if FMinValue <> AValue then
   begin
      FMinValue := AValue;
      Value := FValue;
   end;
end;

procedure TGoCustomCurrencyEdit.SetMaxValue(AValue: Double);
begin
   if FMaxValue <> AValue then
   begin
      FMaxValue := AValue;
      Value := FValue;
   end;
end;

function TGoCustomCurrencyEdit.GetText: string;
begin
   Result := FText;
end;

function TGoCustomCurrencyEdit.TextToValText(const AValue: string): string;
begin
   Result := DelESpace(AValue);
   if FormatSettings.DecimalSeparator <> FormatSettings.ThousandSeparator then
      Result := DelChars(Result, FormatSettings.ThousandSeparator);
   //
   if Result = '' then
      Result := '0'
   else if Result = '-' then
      Result := '-0';
end;

procedure TGoCustomCurrencyEdit.SetText(const AValue: string);
begin
   if not (csReading in ComponentState) then
   begin
      FText := AValue;
      FValue := CheckValue(StrToFloat(TextToValText(AValue)));
      DataChanged;
      Invalidate;
   end;
end;

procedure TGoCustomCurrencyEdit.WMPaste(var Message: TMessage);
var
   S: string;
begin
   S := EditText;
   try
      inherited;
      UpdateData;
   except
      EditText := S;
      SelectAll;
      SetFocus;
      raise;
   end;
end;

procedure TGoCustomCurrencyEdit.CMEnter(var Message: TCMEnter);
begin
   SetFocused(True);
   inherited;
end;

procedure TGoCustomCurrencyEdit.CMExit(var Message: TCMExit);
begin
   try
      UpdateData;
   except
      SelectAll;
      SetFocus;
      raise;
   end;
   SetFocused(False);
   SetCursor(0);
   DoExit;
end;

procedure TGoCustomCurrencyEdit.WMPaint(var Message: TWMPaint);
var
   Width, Left: Integer;
   Margins: TPoint;
   R: TRect;
   DC: HDC;
   PS: TPaintStruct;
   S: string;
begin
   if FFocused then
   begin
      inherited;
      Exit;
   end;
   if FCanvas = nil then
   begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
   end;
   DC := Message.DC;
   if DC = 0 then DC := BeginPaint(Handle, PS);
   FCanvas.Handle := DC;
   try
      FCanvas.Font := Font;
      with FCanvas do
      begin
         R := ClientRect;
         if {$IFDEF WIN32} not (NewStyleControls and Ctl3D) and {$ENDIF}
         (BorderStyle = bsSingle) then
         begin
            Brush.Color := clWindowFrame;
            FrameRect(R);
            InflateRect(R, -1, -1);
         end;
         Brush.Color := Color;
         S := GetDisplayText;
         Width := TextWidth(S);
         Margins := GetTextMargins;
         case FAlignment of
            taLeftJustify: Left := Margins.X;
            taRightJustify: Left := ClientWidth - Width - Margins.X - 1;
         else
            Left := (ClientWidth - Width) div 2;
         end;
         TextRect(R, Left, Margins.Y, S);
      end;
   finally
      FCanvas.Handle := 0;
      if Message.DC = 0 then EndPaint(Handle, PS);
   end;
end;

procedure TGoCustomCurrencyEdit.CMFontChanged(var Message: TMessage);
begin
   inherited;
   Invalidate;
end;

function TGoCustomCurrencyEdit.GetTextMargins: TPoint;
var
   DC: HDC;
   SaveFont: HFont;
   I: Integer;
   SysMetrics, Metrics: TTextMetric;
begin
   if NewStyleControls then
   begin
      if BorderStyle = bsNone then
         I := 0
      else if Ctl3D then
         I := 1
      else
         I := 2;
      Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
      Result.Y := I;
   end
   else
   begin
      if BorderStyle = bsNone then
         I := 0
      else
      begin
         DC := GetDC(0);
         GetTextMetrics(DC, SysMetrics);
         SaveFont := SelectObject(DC, Font.Handle);
         GetTextMetrics(DC, Metrics);
         SelectObject(DC, SaveFont);
         ReleaseDC(0, DC);
         I := SysMetrics.tmHeight;
         if I > Metrics.tmHeight then I := Metrics.tmHeight;
         I := I div 4;
      end;
      Result.X := I;
      Result.Y := I;
   end;
end;

function TGoCurrencyEdit.DefaultDisplayFormat: String;
begin
   Result := ',0.' + StringOfChar('0', FormatSettings.CurrencyDecimals);
   case FormatSettings.CurrencyFormat of
      0: Result := FormatSettings.CurrencyString + Result; { '$1' }
      1: Result := Result + FormatSettings.CurrencyString; { '1$' }
      2: Result := FormatSettings.CurrencyString + ' ' + Result; { '$ 1' }
      3: Result := Result + ' ' + FormatSettings.CurrencyString; { '1 $' }
   end;
   Result := Format('%s;-%s', [Result, Result]);
end;

end.

