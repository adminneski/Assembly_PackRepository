
{******************************************}
{                                          }
{             FastReport VCL               }
{          Barcode2D design editor         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcode2DEditor;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, Buttons, frxClass, frxBarcode2D , frxCustomEditors,
  frxCtrls, ComCtrls, frxBaseForm,TypInfo, Grids, ValEdit
{$IFDEF FPC}
  ,LCLType
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
  TfrxBarcode2DEditor = class(TfrxViewEditor)
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
    procedure GetMenuItems; override;
    function Execute(Tag: Integer; Checked: Boolean): Boolean; override;
  end;

  TfrxBarcode2DEditorForm = class(TfrxBaseForm)
    CancelB: TButton;
    OkB: TButton;
    CodeE: TfrxComboEdit;
    CodeLbl: TLabel;
    TypeCB: TComboBox;
    TypeLbl: TLabel;
    ExampleBvl: TBevel;
    ExamplePB: {$IFNDEF FPC}TPaintBox{$ELSE}TImage{$ENDIF};
    OptionsLbl: TGroupBox;
    ZoomLbl: TLabel;
    AutoSizeCB: TCheckBox;
    ViewTextCB: TCheckBox;
    ZoomE: TEdit;
    UpDown1: TUpDown;
    RotationLbl: TGroupBox;
    Rotation0RB: TRadioButton;
    Rotation90RB: TRadioButton;
    Rotation180RB: TRadioButton;
    Rotation270RB: TRadioButton;
    EditText: TEdit;
    BarPropertiesLb1: TGroupBox;
    BarVList: TValueListEditor;
    BarPageControl: TPageControl;
    TabGeneral: TTabSheet;
    TabAdditional: TTabSheet;
    procedure ExprBtnClick(Sender: TObject);
    procedure UpBClick(Sender: TObject);
    procedure DownBClick(Sender: TObject);
    procedure ExamplePBPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GetBarProperties(PBarcode:TfrxBarcode2DView);
    procedure SetBarProperties(PBarcode:TfrxBarcode2DView; NameProp: String);
    procedure TypeCBChange(Sender: TObject);
    procedure BarVListSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EditTextKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditTextClick(Sender: TObject);
  private
    { Private declarations }
    FBarcode: TfrxBarcode2DView;
  public
    { Public declarations }
    procedure UpdateResouces; override;
    property Barcode: TfrxBarcode2DView read FBarcode write FBarcode;
  end;


implementation

uses frxDsgnIntf, frxRes, frxUtils;

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

const
  cbDefaultText = '12345678';

var
  LockVProp: Boolean;
  OldBarcode: TfrxBarcode2DView;

{ TfrxBarcode2DEditor }

function TfrxBarcode2DEditor.HasEditor: Boolean;
begin
  Result := True;
end;

function TfrxBarcode2DEditor.Edit: Boolean;
begin
  with TfrxBarcode2DEditorForm.Create(Designer) do
  begin
    Barcode := TfrxBarcode2DView(Component);
    Result := ShowModal = mrOk;
    Free;
  end;
end;

function TfrxBarcode2DEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
var
  i: Integer;
  c: TfrxComponent;
  v: TfrxBarcode2DView;
begin
  Result := inherited Execute(Tag, Checked);
  for i := 0 to Designer.SelectedObjects.Count - 1 do
  begin
    c := Designer.SelectedObjects[i];
    if (c is TfrxBarcode2DView) and not (rfDontModify in c.Restrictions) then
    begin
      v := TfrxBarcode2DView(c);
      if Tag = 1 then
        v.AutoSize := Checked
      else if Tag = 2 then
        v.ShowText := Checked;
      Result := True;
    end;
  end;
end;

procedure TfrxBarcode2DEditor.GetMenuItems;
var
  v: TfrxBarcode2DView;
begin
  v := TfrxBarcode2DView(Component);
  AddItem(frxResources.Get('pvAutoSize'), 1, v.AutoSize);
  AddItem(frxResources.Get('bcShowText'), 2, v.ShowText);
  inherited;
end;


{ TfrxBarcode2DEditorForm }

procedure TfrxBarcode2DEditorForm.GetBarProperties(PBarcode:TfrxBarcode2DView);
var
  PropList: PPropList;
  i: integer;
  j, PropCount: integer;
  ValueProp: String;
begin
  LockVProp := True;
  while BarVList.Strings.Count > 0 do
    BarVList.DeleteRow(1);
  PropCount := GetTypeData(PBarcode.BarProperties.ClassInfo).PropCount;
  if PropCount = 0 then
  begin
    LockVProp := False;
    Exit;
  end;
  GetMem(PropList, PropCount * SizeOf(PPropInfo));
  i := 0;
  try
    GetPropList(PBarcode.BarProperties.ClassInfo, tkProperties, PropList);
    while (PropList <> nil) and (PropList^[i] <> nil) and (i < PropCount) do
    begin
      ValueProp := string(GetPropValue(PBarcode.BarProperties,
                    string(PropList^[i].Name),True));
      {$IFDEF FPC}
      if (PropList^[i].PropType^.Kind = tkBool) then
      begin
        if ValueProp = '0' then
          ValueProp := 'False'
        else
          ValueProp := 'True';
      end;
      {$ENDIF}

      BarVList.InsertRow(string(PropList^[i].Name), ValueProp, True);

      if (PropList^[i].PropType^.Kind = tkEnumeration) {$IFDEF FPC} or (PropList^[i].PropType^.Kind = tkBool) {$ENDIF} then
      begin
        BarVList.ItemProps[i].EditStyle := esPickList;
       {$IFNDEF FPC}
        with GetTypeData(PropList^[i].PropType^)^ do
       {$ELSE}
        with GetTypeData(PropList^[i].PropType)^ do
       {$ENDIF}
          for j := MinValue to MaxValue do
          begin
           {$IFNDEF FPC}
            ValueProp := (GetEnumName(PropList^[i].PropType^, j));
           {$ELSE}
            ValueProp := (GetEnumName(PropList^[i].PropType, j));
           {$ENDIF}
            BarVList.ItemProps[i].PickList.Add(ValueProp);
          end;
      end;
      Inc(i);
    end;
  finally
    FreeMem(PropList);
  end;
  LockVProp := False;
end;

procedure TfrxBarcode2DEditorForm.SetBarProperties(PBarcode:TfrxBarcode2DView;
  NameProp: String);
var
  PropList: PPropList;
  i: integer;
  j, PropCount: integer;
  Value: String;
  all : Boolean;
begin
  if LockVProp = True then exit;

  PropCount := GetTypeData(PBarcode.BarProperties.ClassInfo).PropCount;
  if PropCount = 0 then
    Exit;
  GetMem(PropList, PropCount * SizeOf(PPropInfo));
  i := 0;
  try
    all := True;
    GetPropList(PBarcode.BarProperties.ClassInfo, tkProperties, PropList);
    if ((NameProp = '') and (all)) and (PropList <> nil)then
        NameProp := string(PropList^[i].Name)
    else
      all := False;

    while (PropList <> nil) and (PropList^[i] <> nil) and (i < PropCount) do
    begin

      if ((not (NameProp = string(PropList^[i].Name))) and (not all)) then
      begin
        Inc(i);
        Continue;
      end;

      if all then
      NameProp := string(PropList^[i].Name);

      Value := BarVList.Values[NameProp];
       if Value = '' then break;
      BarVList.Values[NameProp];
      if Assigned(PropList^[i].SetProc) then
      case PropList^[i].PropType^.Kind of
        tkInteger:
          {$IFDEF CPU64}
          SetOrdProp(PBarcode.BarProperties,PropList^[i], StrToInt64(Value));
          {$ELSE}
          SetOrdProp(PBarcode.BarProperties,PropList^[i], StrToInt(Value));
          {$ENDIF}
        tkFloat:
          SetFloatProp(PBarcode.BarProperties,PropList^[i], StrToFloat(Value));
        tkEnumeration{$IFDEF FPC}, tkBool{$ENDIF}:
          begin
            {$IFDEF FPC}
            j := GetEnumValue(PropList^[i].PropType, Value);
            {$ELSE}
            j := GetEnumValue(PropList^[i].PropType^, Value);
            {$ENDIF}
            if j < 0 then
              raise Exception.Create(frxResources.Get('prInvProp'));
            SetOrdProp(PBarcode.BarProperties, PropList^[i], j);
          end;
      end;
      Inc(i);
    end;
  finally
    FreeMem(PropList);
  end;
end;

procedure TfrxBarcode2DEditorForm.TypeCBChange(Sender: TObject);
begin
  if FBarcode.BarType <> TfrxBarcode2DType(TypeCB.ItemIndex) then
  begin
    FBarcode.BarType := TfrxBarcode2DType(TypeCB.ItemIndex);

    BarPageControl.Pages[1].TabVisible := GetTypeData(FBarcode.BarProperties.ClassInfo).PropCount <> 0;

    GetBarProperties(FBarcode);

    if (LockVProp = False) then
    ExamplePBPaint(nil);
  end;
end;

procedure TfrxBarcode2DEditorForm.FormShow(Sender: TObject);
var
  i: TfrxBarcode2DType;
begin
  OldBarcode := TfrxBarcode2DView.Create(Self);
  OldBarcode.AssignAll(FBarcode);
  TypeCB.Items.Clear;
  for i := Low(TfrxBarcode2DType) to High(TfrxBarcode2DType) do
    TypeCB.Items.Add(frxResources.Get(GetEnumName(TypeInfo(TfrxBarcode2DType),Ord(i))));

  CodeE.Text := FBarcode.Expression;
  TypeCB.ItemIndex := Integer(FBarcode.BarType);
  BarPageControl.Pages[1].TabVisible := GetTypeData(FBarcode.BarProperties.ClassInfo).PropCount <> 0;
  AutoSizeCB.Checked := FBarcode.AutoSize;
  ViewTextCB.Checked := FBarcode.ShowText;
  ZoomE.Text := FloatToStr(FBarcode.Zoom);
  EditText.Text := FBarcode.Text;
  BarPropertiesLb1.Caption := frxResources.Get('oiProp') +' '+
      frxResources.Get(GetEnumName(TypeInfo(TfrxBarcode2DType),Ord(TypeCB.ItemIndex)));
  BarPageControl.TabIndex := 0;
  GetBarProperties(FBarcode);

  case FBarcode.Rotation of
    90:  Rotation90RB.Checked := True;
    180: Rotation180RB.Checked := True;
    270: Rotation270RB.Checked := True;
    else Rotation0RB.Checked := True;
  end;

  ExamplePBPaint(nil);
end;

procedure TfrxBarcode2DEditorForm.FormHide(Sender: TObject);
begin
  if ModalResult = mrOk then
  begin
    FBarcode.Expression := CodeE.Text;
    FBarcode.BarType := TfrxBarcode2DType(TypeCB.ItemIndex);
    FBarcode.AutoSize := AutoSizeCB.Checked;
    FBarcode.ShowText := ViewTextCB.Checked;
    FBarcode.Zoom := frxStrToFloat(ZoomE.Text);

    if Rotation90RB.Checked then
      FBarcode.Rotation := 90
    else if Rotation180RB.Checked then
      FBarcode.Rotation := 180
    else if Rotation270RB.Checked then
      FBarcode.Rotation := 270
    else
      FBarcode.Rotation := 0;

    if FBarcode.Height < 17 then
       FBarcode.Height := 50;

    SetBarProperties(FBarcode,'');
    BarVList.Strings.Clear;
  end
  else
  begin
    FBarcode.AssignAll(OldBarcode);
    OldBarcode.Free;
  end;

end;

procedure TfrxBarcode2DEditorForm.ExprBtnClick(Sender: TObject);
var
  s: String;
begin
  s := TfrxCustomDesigner(Owner).InsertExpression(CodeE.Text);
  if s <> '' then
    CodeE.Text := s;
end;

procedure TfrxBarcode2DEditorForm.UpBClick(Sender: TObject);
var
  i: Double;
begin
  i := frxStrToFloat(ZoomE.Text);
  i := i + 0.1;
  ZoomE.Text := FloatToStr(i);
end;

procedure TfrxBarcode2DEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(3500) + ' 2D';
  CodeLbl.Caption := frxGet(3501);
  TypeLbl.Caption := frxGet(3502);
  ZoomLbl.Caption := frxGet(3503);
  OptionsLbl.Caption := frxGet(3504);
  RotationLbl.Caption := frxGet(3505);
  CancelB.Caption := frxGet(2);
  OkB.Caption := frxGet(1);
  AutoSizeCB.Caption := frxResources.Get('pvAutoSize');
  ViewTextCB.Caption := frxGet(3507);
  Rotation0RB.Caption := frxGet(3508);
  Rotation90RB.Caption := frxGet(3509);
  Rotation180RB.Caption := frxGet(3510);
  Rotation270RB.Caption := frxGet(3511);
  BarPropertiesLb1.Caption := frxResources.Get('oiProp');
  BarPageControl.Pages[0].Caption := frxGet(4701);
  BarPageControl.Pages[1].Caption := frxGet(2716);
end;


procedure TfrxBarcode2DEditorForm.BarVListSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
if (BarVList.Strings.Count >0) then
  begin
     SetBarProperties(Barcode,TValueListEditor(Sender).Keys[ARow]);
     if (LockVProp = False) then
     ExamplePBPaint(nil);
  end;
end;

procedure TfrxBarcode2DEditorForm.DownBClick(Sender: TObject);
var
  i: Double;
begin
  i := frxStrToFloat(ZoomE.Text);
  i := i - 0.1;
  if i <= 0 then i := 1;
  ZoomE.Text := FloatToStr(i);
end;

procedure TfrxBarcode2DEditorForm.EditTextClick(Sender: TObject);
begin
  if (FBarcode.BarType = bcGS1DatabarE)
    or (FBarcode.BarType = bcGS1DatabarES) then
    begin
      FBarcode.Text := EditText.Text;
      ExamplePBPaint(nil);
    end
end;

procedure TfrxBarcode2DEditorForm.EditTextKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (FBarcode.BarType <> bcGS1DatabarE)
      and (FBarcode.BarType <> bcGS1DatabarES) then
  begin
    FBarcode.Text := EditText.Text;
    ExamplePBPaint(nil);
  end;
end;

procedure TfrxBarcode2DEditorForm.ExamplePBPaint(Sender: TObject);
var
  Barcode: TfrxBarcode2DView;
  ScaleX, ScaleY: Extended;
begin
  Barcode := TfrxBarcode2DView.Create(Self);
  Barcode.AssignAll(FBarcode);
  Barcode.BarType := TfrxBarcode2DType(TypeCB.ItemIndex);

  Barcode.Zoom := 1;
  Barcode.ShowText := ViewTextCB.Checked;
  Barcode.Text := FBarcode.Text;
  EditText.Text := Barcode.Text;

  if (Barcode.BarType = bcGS1DatabarE)
    or (Barcode.BarType = bcGS1DatabarES) then
   if Barcode.Height < 17 then
       Barcode.Height := 50;

   Barcode.Top := 0;
   Barcode.Left := 0;

  BarPropertiesLb1.Caption := frxResources.Get('oiProp') +' '+
      frxResources.Get(GetEnumName(TypeInfo(TfrxBarcode2DType),Ord(TypeCB.ItemIndex)));

  if Rotation0RB.Checked then
    Barcode.Rotation := 0
  else if Rotation90RB.Checked then
    Barcode.Rotation := 90
  else if Rotation180RB.Checked then
    Barcode.Rotation := 180
  else
    Barcode.Rotation := 270;

    EditText.Enabled :=  ViewTextCB.Checked;

  ScaleX := 2;
  ScaleY := 2;

  if (Barcode.BarType = bcCodePDF417)
    or (Barcode.BarType = bcCodeMaxiCode)
    or (Barcode.BarType = bcGS1DatabarE)
    or (Barcode.BarType = bcGS1DatabarES) then
  begin
    ScaleX := 1;
    ScaleY := 1;
  end;

  with ExamplePB.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(Rect(0, 0, ExamplePB.Width, ExamplePB.Height));
    Barcode.Draw(ExamplePB.Canvas,ScaleX, ScaleY,
      (ExamplePB.Width/2) - (Barcode.Width/2)*ScaleX,
      (ExamplePB.Height/2) - (Barcode.Height/2)*ScaleY);
  end;

  Barcode.Free;
end;

procedure TfrxBarcode2DEditorForm.FormCreate(Sender: TObject);
begin
  rePadding(Self);
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;


procedure TfrxBarcode2DEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

initialization
  frxComponentEditors.Register(TfrxBarcode2DView, TfrxBarcode2DEditor);

end.
