
{******************************************}
{                                          }
{             FastReport VCL               }
{         Server HTTP Form Controls        }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerFormControls;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  Classes, SysUtils, Graphics, frxClass, frxDCtrl, frxUtils,
  frxServerTemplates;

type
  TfrxCustomWebControl = class(TObject)
  private
    FAlignment: TAlignment;
    FColor: TColor;
    FEnabled: Boolean;
    FFont: TFont;
    FHeight: Extended;
    FLeft: Extended;
    FName: String;
    FReadonly: Boolean;
    FTabindex: Integer;
    FTop: Extended;
    FWidth: Extended;
    FVisible: Boolean;
    FTemplate: TfrxServerTemplate;
    procedure SetFont(Value: TFont);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Build: AnsiString; virtual; abstract;
    function PadText(s: String; width: Integer): String;
    procedure Assign(Value: TfrxDialogControl); virtual;

    property Name: String read FName write FName;
    property Left: Extended read FLeft write FLeft;
    property Top: Extended read FTop write FTop;
    property Width: Extended read FWidth write FWidth;
    property Height: Extended read FHeight write FHeight;
    property Font: TFont read FFont write SetFont;
    property Color: TColor read FColor write FColor;
    property Alignment: TAlignment read FAlignment write FAlignment;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Readonly: Boolean read FReadonly write FReadonly;
    property Tabindex: Integer read FTabindex write FTabindex;
    property HTML: AnsiString read Build;
    property Visible: Boolean read FVisible write FVisible;
    property Template: TfrxServerTemplate read FTemplate;
  end;

// TLabel
  TfrxWebLabelControl = class(TfrxCustomWebControl)
  private
    FCaption: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Caption: String read FCaption write FCaption;
  end;

// TEdit
  TfrxWebTextControl = class(TfrxCustomWebControl)
  private
    FText: String;
    FSize: Integer;
    FMaxlength: Integer;
    FPassword: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Text: String read Ftext write FText;
    property Size: Integer read FSize write FSize;
    property Maxlength: Integer read FMaxlength write FMaxlength;
    property Password: Boolean read FPassword write FPassword;
  end;

// TDateEdit
  TfrxWebDateControl = class(TfrxCustomWebControl)
  private
    FText: String;
    FSize: Integer;
    FMaxlength: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Text: String read Ftext write FText;
    property Size: Integer read FSize write FSize;
    property Maxlength: Integer read FMaxlength write FMaxlength;
  end;

// TMemo
  TfrxWebTextAreaControl = class(TfrxCustomWebControl)
  private
    FText: TStrings;
    FCols: Integer;
    FRows: Integer;
    procedure SetText(Value: TStrings);
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Text: TStrings read FText write SetText;
    property Cols: Integer read FCols write FCols;
    property Rows: Integer read FRows write FRows;
  end;

// TCheckBox
  TfrxWebCheckBoxControl = class(TfrxCustomWebControl)
  private
    FCaption: String;
    FChecked: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Caption: String read FCaption write FCaption;
    property Checked: Boolean read FChecked write FChecked;
  end;

// TRadioButton
  TfrxWebRadioControl = class(TfrxCustomWebControl)
  private
    FCaption: String;
    FChecked: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Caption: String read FCaption write FCaption;
    property Checked: Boolean read FChecked write FChecked;
  end;


// TListBox
  TfrxWebSelectControl = class(TfrxCustomWebControl)
  private
    FItems: TStrings;
    FCheckedValue: Integer;
    procedure SetItems(Value: TStrings);
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Items: TStrings read FItems write SetItems;
    property CheckedValue: Integer read FCheckedValue write FCheckedValue;
  end;

// TButton
  TfrxWebSubmitControl = class(TfrxCustomWebControl)
  private
    FCaption: String;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Caption: String read FCaption write FCaption;
  end;

  // TImage
  TfrxWebImageControl = class(TfrxCustomWebControl)
  private
    FSession: String;
  public
    function Build: AnsiString; override;
    procedure Assign(Value: TfrxDialogControl); override;

    property Session: String read FSession write FSession;
  end;

implementation

uses frxServerUtils, frxServerConfig;

{ TfrxCustomWebControl }

constructor TfrxCustomWebControl.Create;
begin
  FName := '';
  FLeft := 0;
  FTop := 0;
  FWidth := 1;
  FHeight := 1;
  FFont := TFont.Create;
  FFont.Color := clBlack;
  FFont.Size := 10;
  FFont.Style := [];
  FFont.Name := 'Arial';
  FColor := clWhite;
  FAlignment := taLeftJustify;
  FEnabled := True;
  FReadonly := False;
  FTabindex := 0;
  FTemplate := TfrxServerTemplate.Create;
end;

destructor TfrxCustomWebControl.Destroy;
begin
  FTemplate.Free;
  FFont.Free;
  inherited;
end;

procedure TfrxCustomWebControl.Assign(Value: TfrxDialogControl);
begin
  if Value.Parent <> nil then
    Name := Value.Parent.Name + '_' + Value.Name
  else Name := Value.Name;
  Left := Value.Left;
  Top := Value.Top;
  Width := Value.Width;
  Height := Value.Height;
  Font := Value.Font;
  Color := Value.Color;
  Enabled := Value.Enabled;
  Visible := Value.Visible;
end;

procedure TfrxCustomWebControl.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

function TfrxCustomWebControl.PadText(s: String; width: Integer): String;
var
  i: Integer;
begin
  i := ((width div 10) - Length(s)) div 2;
  Result :=  StringOfChar(' ', i) + Trim(s) + StringOfChar(' ', i);
end;

{ TfrxWebLabelControl }

constructor TfrxWebLabelControl.Create;
begin
  inherited;
  FCaption := 'Label';
end;

destructor TfrxWebLabelControl.Destroy;
begin
  inherited;
end;

procedure TfrxWebLabelControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxLabelControl;
begin
  inherited Assign(Value);
  if Value is TfrxLabelControl then
  begin
    b := TfrxLabelControl(Value);
    FCaption := b.Caption;
  end;
end;

function TfrxWebLabelControl.Build: AnsiString;
begin
  if Visible then
  begin
    Template.SetTemplate('form_label');
    Template.Variables.AddVariable('FONT_NAME', FFont.Name);
    Template.Variables.AddVariable('FONT_SIZE', IntToStr(Round(FFont.Size * 96 / 72)));
    Template.Variables.AddVariable('FONT_COLOR', HTMLRGBColor(FFont.Color));
    Template.Variables.AddVariable('BCOLOR', HTMLRGBColor(FColor));
    Template.Variables.AddVariable('CAPTION', FCaption);
    Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
  end
  else
    Result := '';
end;

{ TfrxWebTextControl }

constructor TfrxWebTextControl.Create;
begin
  inherited;
  FText := '';
  FSize := 10;
  FMaxlength := 50;
  FPassword := False;
end;

destructor TfrxWebTextControl.Destroy;
begin
  inherited;
end;

function TfrxWebTextControl.Build: AnsiString;
const
  a: array [Boolean] of String = ('hidden', 'text');
var
  s: String;
begin
  Template.SetTemplate('form_text');
  Template.Variables.AddVariable('VISIBLE', a[Visible]);
  Template.Variables.AddVariable('NAME', FName);
  Template.Variables.AddVariable('VALUE', FText);
  Template.Variables.AddVariable('SIZE', IntToStr(Round(Width / 10)));
  Template.Variables.AddVariable('LENGTH', IntToStr(FMaxlength));
  if FReadonly then
    s := 'readonly'
  else
    s := '';
  Template.Variables.AddVariable('READONLY', s);
  Template.Prepare;
{$IFDEF DELPHI12}
  Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
  Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
end;

procedure TfrxWebTextControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxEditControl;
begin
  inherited Assign(Value);
  if Value is TfrxEditControl then
  begin
    b := TfrxEditControl(Value);
    FText := b.Text;
    if b.MaxLength > 0 then
      FMaxlength := b.MaxLength;
  end;
end;

{ TfrxWebTextAreaControl }

constructor TfrxWebTextAreaControl.Create;
begin
  inherited;
  FText := TStringList.Create;
  FCols := 40;
  FRows := 3;
end;

destructor TfrxWebTextAreaControl.Destroy;
begin
  FText.Free;
  inherited;
end;

procedure TfrxWebTextAreaControl.SetText(Value: TStrings);
begin
  FText.Clear;
  FText.Assign(Value);
end;

function TfrxWebTextAreaControl.Build: AnsiString;
begin
  if Visible then
  begin
    Template.SetTemplate('form_memo');
    Template.Variables.AddVariable('NAME', FName);
    Template.Variables.AddVariable('ROWS', IntToStr(FRows));
    Template.Variables.AddVariable('COLS', IntToStr(FCols));
    Template.Variables.AddVariable('TEXT', Text.Text);
    Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
  end
  else
    Result := '';
end;

procedure TfrxWebTextAreaControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxMemoControl;
begin
  inherited Assign(Value);
  if Value is TfrxMemoControl then
  begin
    b := TfrxMemoControl(Value);
    Text := b.Lines;
    FRows := Round(b.Height / 10);
    FCols := Round(b.Width / 10);
  end;
end;

{ TfrxWebCheckBoxControl }

constructor TfrxWebCheckBoxControl.Create;
begin
  inherited;
  FCaption := 'Checkbox';
  FChecked := False;
end;

destructor TfrxWebCheckBoxControl.Destroy;
begin
  inherited;
end;

procedure TfrxWebCheckBoxControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxCheckBoxControl;
begin
  inherited Assign(Value);
  if Value is TfrxCheckBoxControl then
  begin
    b := TfrxCheckBoxControl(Value);
    FCaption := b.Caption;
    FChecked := b.Checked;
  end;
end;

function TfrxWebCheckBoxControl.Build: AnsiString;
var
  s: String;
begin
  if Visible then
  begin
    if FChecked then
      s := 'checked'
    else s := '';
    Template.SetTemplate('form_checkbox');
    Template.Variables.AddVariable('NAME', Name);
    Template.Variables.AddVariable('CHECKED', s);
    Template.Variables.AddVariable('FONT_NAME', FFont.Name);
    Template.Variables.AddVariable('FONT_SIZE', IntToStr(Round(FFont.Size * 96 / 72)));
    Template.Variables.AddVariable('FONT_COLOR', HTMLRGBColor(FFont.Color));
    Template.Variables.AddVariable('BCOLOR', HTMLRGBColor(FColor));
    Template.Variables.AddVariable('CAPTION', FCaption);
    Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
  end
  else Result := '';
end;

{ TfrxWebRadioControl }

constructor TfrxWebRadioControl.Create;
begin
  inherited;
  FCaption := 'Radiobutton';
  FChecked := False;
end;

destructor TfrxWebRadioControl.Destroy;
begin
  inherited;
end;

procedure TfrxWebRadioControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxRadioButtonControl;
begin
  inherited Assign(Value);
  if Value is TfrxRadioButtonControl then
  begin
    b := TfrxRadioButtonControl(Value);
    FCaption := b.Caption;
    FChecked := b.Checked;
  end;
end;

function TfrxWebRadioControl.Build: AnsiString;
var
  s, n: String;
  i: Integer;
begin
  if Visible then
  begin
    if FChecked then
      s := 'checked'
    else s := '';
    i := Pos('_', Name);
    if i > 0 then
      n := Copy(Name, 1, i - 1)
    else
      n := Name;
    Template.SetTemplate('form_radio');
    Template.Variables.AddVariable('NAME', n);
    Template.Variables.AddVariable('VALUE', Name);
    Template.Variables.AddVariable('CHECKED', s);
    Template.Variables.AddVariable('NAME', n);
    Template.Variables.AddVariable('NAME', n);
    Template.Variables.AddVariable('FONT_NAME', FFont.Name);
    Template.Variables.AddVariable('FONT_SIZE', IntToStr(Round(FFont.Size * 96 / 72)));
    Template.Variables.AddVariable('FONT_COLOR', HTMLRGBColor(FFont.Color));
    Template.Variables.AddVariable('BCOLOR', HTMLRGBColor(FColor));
    Template.Variables.AddVariable('CAPTION', FCaption);
    Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
  end
  else Result:= '';
end;

{ TfrxWebSelectControl }

constructor TfrxWebSelectControl.Create;
begin
  inherited;
  FItems := TStringList.Create;
end;

destructor TfrxWebSelectControl.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TfrxWebSelectControl.SetItems(Value: TStrings);
begin
  FItems.Clear;
  FItems.Assign(Value);
end;

procedure TfrxWebSelectControl.Assign(Value: TfrxDialogControl);
var i:integer;
begin
  inherited Assign(Value);
  if Value is TfrxComboboxControl then
  begin
    Items.Clear;
    for i:=0 to TfrxComboBoxControl(Value).Items.count-1 do
     Items.Add(TfrxComboBoxControl(Value).Items[i]);
    CheckedValue:=TfrxComboBoxControl(Value).ItemIndex;
  end;
end;

function TfrxWebSelectControl.Build: AnsiString;
const 
  a: array[boolean] of string=('',' selected');
var 
  i: integer;
begin
  if Visible then
  begin
    Template.SetTemplate('form_select');
    Template.Variables.AddVariable('NAME', Name);
    Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
    for i := 0 to Items.count - 1 do
{$IFDEF DELPHI12}
      Result := Result + UTF8Encode(#13#10 + format('<option %s value="%s">%s</option>',
        [a[i = CheckedValue], IntTostr(i), Items[i]]));
{$ELSE}
      Result := Result + AnsiString(#13#10 + format('<option %s value="%s">%s</option>',
        [a[i = CheckedValue], IntTostr(i), Items[i]]));
{$ENDIF}
    Result := Result + #13#10 + '</select>';
  end
  else Result := '';
end;

{ TfrxWebSubmitControl }

constructor TfrxWebSubmitControl.Create;
begin
  inherited;
  FCaption := 'Button';
end;

destructor TfrxWebSubmitControl.Destroy;
begin
  inherited;
end;

procedure TfrxWebSubmitControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxButtonControl;
begin
  inherited Assign(Value);
  if Value is TfrxButtonControl then
  begin
    b := TfrxButtonControl(Value);
    FCaption := b.Caption;
  end;
end;

function TfrxWebSubmitControl.Build: AnsiString;
begin
  if Visible then
  begin
    Template.SetTemplate('form_button');
    Template.Variables.AddVariable('SIZE', IntToStr(Round(Width)));
    Template.Variables.AddVariable('VALUE', PadText(Caption, Round(Width)));
    Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
  end
  else Result := '';
end;

{ TfrxWebDateControl }

procedure TfrxWebDateControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxDateEditControl;
begin
  inherited Assign(Value);
  if Value is TfrxDateEditControl then
  begin
    b := TfrxDateEditControl(Value);
    FText := DateToStr(b.Date);
  end;
end;

function TfrxWebDateControl.Build: AnsiString;
const
  a: array [Boolean] of String = ('hidden', 'text');
var
  s: String;
begin
  Template.SetTemplate('form_date');
  Template.Variables.AddVariable('VISIBLE', a[Visible]);
  Template.Variables.AddVariable('NAME', FName);
  Template.Variables.AddVariable('VALUE', FText);
  Template.Variables.AddVariable('SIZE', IntToStr(Round(Width / 10)));
  Template.Variables.AddVariable('LENGTH', IntToStr(FMaxlength));
  if FReadonly then
    s := 'readonly'
  else
    s := '';
  Template.Variables.AddVariable('READONLY', s);
  Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
end;

constructor TfrxWebDateControl.Create;
begin
  inherited;
  FText := '';
  FSize := 10;
  FMaxlength := 50;
end;

destructor TfrxWebDateControl.Destroy;
begin

  inherited;
end;

{ TfrxWebImageControl }

procedure TfrxWebImageControl.Assign(Value: TfrxDialogControl);
var
  b: TfrxImageControl;
begin
  inherited Assign(Value);
  if Value is TfrxImageControl then
  begin
    b := TfrxImageControl(Value);
    if b.Image <> nil then
      if b.Image.Picture <> nil then
      begin
        b.Image.Picture.SaveToFile(frxGetAbsPathDir(ServerConfig.GetValue('server.http.rootpath'), ServerConfig.ConfigFolder) +
          FSession + PathDelim + FName + '.png');
      end;
  end;
end;

function TfrxWebImageControl.Build: AnsiString;
begin
  if Visible then
  begin
    Template.SetTemplate('form_image');
    Template.Variables.AddVariable('SRC', FSession + PathDelim + FName + '.png');
    Template.Variables.AddVariable('WIDTH', IntToStr(Round(Width)));
    Template.Variables.AddVariable('HEIGHT', IntToStr(Round(Height)));
    Template.Prepare;
{$IFDEF DELPHI12}
    Result := UTF8Encode(Template.TemplateStrings.Text);
{$ELSE}
    Result := AnsiString(Template.TemplateStrings.Text);
{$ENDIF}
  end
  else Result := '';
end;

end.
