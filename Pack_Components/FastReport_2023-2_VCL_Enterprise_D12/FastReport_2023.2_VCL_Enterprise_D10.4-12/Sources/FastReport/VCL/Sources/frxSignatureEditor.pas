unit frxSignatureEditor;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLType, LCLIntf, LCLProc, LazHelper, ColorBox,
{$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, Dialogs, StdCtrls,
  ExtCtrls,
  frxClass, frxDsgnIntf, frxBaseForm
{$IFDEF FPC}
  , EditBtn
{$ENDIF};

type
  TfrxSignatureEditorForm = class(TfrxBaseForm)
    SignatureGroupBox: TGroupBox;
    OkButton: TButton;
    CancelButton: TButton;
    FontDialog: TFontDialog;
    SamplePaintBox: TPaintBox;
    OptionsPageControl: TPageControl;
    GeneralTabSheet: TTabSheet;
    KeepAspectCheckBox: TCheckBox;
    FillButton: TButton;
    FrameButton: TButton;
    CustomizableTabSheet: TTabSheet;
    CustomizableCheckBox: TCheckBox;
    ConfigureGraphicGroupBox: TGroupBox;
    gtImportedRadioButton: TRadioButton;
    gtNameRadioButton: TRadioButton;
    ImpotrGraphicButton: TButton;
    gtNoRadioButton: TRadioButton;
    ConfigureTextGroupBox: TGroupBox;
    ImportLogoButton: TButton;
    NameCheckBox: TCheckBox;
    LocationCheckBox: TCheckBox;
    DistinguishedNameCheckBox: TCheckBox;
    LogoCheckBox: TCheckBox;
    DateCheckBox: TCheckBox;
    ReasonCheckBox: TCheckBox;
    ProgramVersionCheckBox: TCheckBox;
    LabelsCheckBox: TCheckBox;
    TextPropertyGroupBox: TGroupBox;
    RTLCheckBox: TCheckBox;
    FontButton: TButton;
    ImportPictureButton: TButton;

    procedure FormShow(Sender: TObject);
    procedure SamplePaintBoxPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure FontButtonClick(Sender: TObject);
    procedure ImpotrGraphicButtonClick(Sender: TObject);
    procedure FrameButtonClick(Sender: TObject);
    procedure ConfigureGraphicRadioButtonClick(Sender: TObject);
    procedure ImportLogoButtonClick(Sender: TObject);
    procedure ImportPictureButtonClick(Sender: TObject);
    procedure KeepAspectCheckBoxClick(Sender: TObject);
    procedure CustomizableCheckBoxClick(Sender: TObject);
    procedure FillButtonClick(Sender: TObject);
  private
    FSignature: TfrxDigitalSignatureView;
    FOriginalSignature: TfrxDigitalSignatureView;
    FReportDesigner: TfrxCustomDesigner;

    procedure Change;
    procedure FontToButton(Font: TFont; Button: TButton);
    procedure FontDialogToButton(Font: TFont; Button: TButton);
    procedure SetSignature(const Value: TfrxDigitalSignatureView);
    procedure ImportPicture(const SignaturePicture: TPicture);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateResouces; override;

    property Signature: TfrxDigitalSignatureView read FSignature write SetSignature;
    property ReportDesigner: TfrxCustomDesigner read FReportDesigner write FReportDesigner;
  end;

implementation

{$IFNDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

uses
  frxEditFrame, frxEditFill, Math, frxRes,
  frxCustomEditors, frxUtils, frDPIAwareUtils, frxEditPicture;

type
  TfrxCustomSignatureData = class(frxClass.TfrxCustomSignatureData); // access to protected

{ Functions}

procedure Translate(WinControl: TWinControl);

  procedure AssignTexts(Root: TControl);
  var
    i: Integer;
  begin
    with Root do
    begin
      if Tag > 0 then
        SetTextBuf(PChar(GetStr(IntToStr(Tag))));

      if Root is TWinControl then
        with Root as TWinControl do
          for i := 0 to ControlCount - 1 do
            if Controls[i] is TControl then
              AssignTexts(Controls[i] as TControl);
    end;
  end;

begin
  AssignTexts(WinControl);

  if WinControl.UseRightToLeftAlignment then
    WinControl.FlipChildren(True);
end;


type
  TfrxSignatureEditor = class(TfrxViewEditor)
  private
  public
    function Edit: Boolean; override;
    function HasEditor: Boolean; override;
  end;

{ TfrxSignatureEditor }

function TfrxSignatureEditor.Edit: Boolean;
begin
  with TfrxSignatureEditorForm.Create(nil) do
  begin
    Signature := TfrxDigitalSignatureView(Component);
    ReportDesigner := Self.Designer;
    Result := ShowModal = mrOk;
    Free;
  end;
end;

function TfrxSignatureEditor.HasEditor: Boolean;
begin
  Result := True;
end;

{ TfrxSignatureEditorForm }

procedure TfrxSignatureEditorForm.Change;
begin
  SamplePaintBox.Refresh;
end;

procedure TfrxSignatureEditorForm.CheckBoxClick(Sender: TObject);
  function IsSender(CheckBox: TCheckBox; var Parameter: Boolean): Boolean;
  begin
    Result := Sender = CheckBox;
    if Result then
      Parameter := CheckBox.Checked;
  end;
begin
  with TfrxCustomSignatureData(FSignature.CustomData) do
    if IsSender(NameCheckBox, FShowName) or
       IsSender(LocationCheckBox, FShowLocation) or
       IsSender(DistinguishedNameCheckBox, FShowDistinguishedName) or
       IsSender(LogoCheckBox, FShowLogo) or
       IsSender(DateCheckBox, FShowDate) or
       IsSender(ReasonCheckBox, FShowReason) or
       IsSender(ProgramVersionCheckBox, FShowProgramVersion) or
       IsSender(LabelsCheckBox, FShowLabels) or
       IsSender(RTLCheckBox, FRTL)
    then
      Change;
end;

procedure TfrxSignatureEditorForm.ImportLogoButtonClick(Sender: TObject);
begin
  ImportPicture(FSignature.CustomData.LogoPicture);
end;

procedure TfrxSignatureEditorForm.ImportPicture(const SignaturePicture: TPicture);
var
  Picture: TPicture;
begin
  with TfrxPictureEditorForm.Create(nil) do
  try
    Picture := SignaturePicture;
    Image.Picture.Assign(Picture);
    if ShowModal = mrOk then
    begin
      Picture.Assign(Image.Picture);
      if SignaturePicture = FSignature.Picture then
        FReportDesigner.AddPictureToCache(FSignature);
      Change;
    end;
  finally
    Free;
  end;
end;

procedure TfrxSignatureEditorForm.ImportPictureButtonClick(Sender: TObject);
begin
  ImportPicture(FSignature.Picture);
end;

procedure TfrxSignatureEditorForm.ImpotrGraphicButtonClick(Sender: TObject);
begin
  ImportPicture(FSignature.CustomData.NamePicture);
end;

procedure TfrxSignatureEditorForm.KeepAspectCheckBoxClick(Sender: TObject);
begin
  if FSignature.KeepAspectRatio <> KeepAspectCheckBox.Checked then
  begin
    FSignature.KeepAspectRatio := KeepAspectCheckBox.Checked;
    Change;
  end;
end;

procedure TfrxSignatureEditorForm.FillButtonClick(Sender: TObject);
begin
  with TfrxFillEditorForm.Create(nil) do
  begin
    IsSimpleFill := False;
    Fill := FSignature.Fill;
    if ShowModal = mrOK  then
    begin
      if Fill is TfrxBrushFill then         FSignature.FillType := ftBrush
      else if Fill is TfrxGradientFill then FSignature.FillType := ftGradient
      else if Fill is TfrxGlassFill then    FSignature.FillType := ftGlass;
      FSignature.Fill.Assign(Fill);
    end;
    Free;
    Change;
  end;
end;

procedure TfrxSignatureEditorForm.FontButtonClick(Sender: TObject);
begin
  FontDialogToButton(FSignature.Font, FontButton);
  Change;
end;

procedure TfrxSignatureEditorForm.FontDialogToButton(Font: TFont; Button: TButton);
var
  ctx: FRX_DPI_AWARENESS_CONTEXT;
begin
  FontDialog.Font.Assign(Font);
  { awoid common Dialogs bug with HiDPi Per monitor v2 }
  ctx := frxGetThreadDpiAwarenessContext;
  frxSetThreadDpiAwarenessContext(FRX_DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED);
  try
    if FontDialog.Execute then
    begin
      Font.Assign(FontDialog.Font);
      FontToButton(Font, Button);
      Change;
    end;
  finally
    frxSetThreadDpiAwarenessContext(ctx);
  end;
end;

procedure TfrxSignatureEditorForm.FontToButton(Font: TFont; Button: TButton);
var
  FontSize: Integer;
begin
  Button.Caption := Font.Name;
  FontSize := FontButton.Font.Size;
  Button.Font.Assign(Font);
  FontButton.Font.Size := FontSize;
end;

procedure TfrxSignatureEditorForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    FOriginalSignature.AssignAll(FSignature);
  FSignature.Free;
end;

procedure TfrxSignatureEditorForm.FormCreate(Sender: TObject);
begin
  {$IFDEF FPC}
    Font.Size := 8;
    {$IFDEF LCLGTK2}
    Font.Name := 'DejaVu Sans, Book';
    {$ELSE}
    Font.Name := 'Tahoma';
    {$ENDIF}
  {$ENDIF}
end;

procedure TfrxSignatureEditorForm.FormShow(Sender: TObject);
begin
  Change;
end;

procedure TfrxSignatureEditorForm.FrameButtonClick(Sender: TObject);
begin
  with TfrxFrameEditorForm.Create(nil) do
    try
      Frame := FSignature.Frame;
      if ShowModal = mrOK  then
        FSignature.Frame.Assign(Frame);
    finally
      Free;
    end;
  Change;
end;

procedure TfrxSignatureEditorForm.ConfigureGraphicRadioButtonClick(Sender: TObject);
  function IsSender(RadioButton: TRadioButton; gt: TfrxCustomSignatureGraphicType): Boolean;
  begin
    Result := Sender = RadioButton;
    if Result then
      FSignature.CustomData.GraphicType := gt;
  end;
begin
  if IsSender(gtNoRadioButton, gtNo) or
     IsSender(gtImportedRadioButton, gtImported) or
     IsSender(gtNameRadioButton, gtName)
  then
    Change;
end;

procedure TfrxSignatureEditorForm.SamplePaintBoxPaint(Sender: TObject);
var
  SaveLeftTop, SaveWidthHeight, Offset: TfrxPoint;
  Factor: Extended;
begin
  if (FSignature.Width < 1.0) or (FSignature.Height < 1.0) then
    Exit;

  SaveLeftTop := frxPoint(FSignature.Left, FSignature.Top);
  SaveWidthHeight := frxPoint(FSignature.Width, FSignature.Height);

  FSignature.Left := 0.0;
  FSignature.Top := 0.0;
  Factor := MinValue([1.0, SamplePaintBox.Width / FSignature.Width,
    SamplePaintBox.Height / FSignature.Height]);
  FSignature.Width := FSignature.Width * Factor;
  FSignature.Height := FSignature.Height * Factor;
  Offset := frxPoint((SamplePaintBox.Width - FSignature.Width) / 2,
                     (SamplePaintBox.Height - FSignature.Height) / 2);

  SamplePaintBox.Canvas.Lock;
  try
    FSignature.Draw(SamplePaintBox.Canvas, 1, 1, Offset.X, Offset.Y);
  finally
    SamplePaintBox.Canvas.Unlock;

    FSignature.Left := SaveLeftTop.X;
    FSignature.Top := SaveLeftTop.Y;
    FSignature.Width := FSignature.Width / Factor;
    FSignature.Height := FSignature.Height / Factor;
  end;
end;

procedure TfrxSignatureEditorForm.SetSignature(const Value: TfrxDigitalSignatureView);
begin
  FOriginalSignature := Value;
  FSignature := TfrxDigitalSignatureView.Create(nil);;
  FSignature.AssignAll(FOriginalSignature);
  FSignature.frComponentState := FOriginalSignature.frComponentState;

  KeepAspectCheckBox.Checked := FSignature.KeepAspectRatio;
  CustomizableCheckBox.Checked := FSignature.Customizable;

  case FSignature.CustomData.GraphicType of
    gtNo:       gtNoRadioButton.Checked := True;
    gtImported: gtImportedRadioButton.Checked := True;
    gtName:     gtNameRadioButton.Checked := True;
  end;

  NameCheckBox.Checked := FSignature.CustomData.ShowName;
  LocationCheckBox.Checked := FSignature.CustomData.ShowLocation;
  DistinguishedNameCheckBox.Checked := FSignature.CustomData.ShowDistinguishedName;
  LogoCheckBox.Checked := FSignature.CustomData.ShowLogo;
  DateCheckBox.Checked := FSignature.CustomData.ShowDate;
  ReasonCheckBox.Checked := FSignature.CustomData.ShowReason;
  ProgramVersionCheckBox.Checked := FSignature.CustomData.ShowProgramVersion;
  LabelsCheckBox.Checked := FSignature.CustomData.ShowLabels;

  RTLCheckBox.Checked := FSignature.CustomData.RTL;

  FontToButton(FSignature.Font, FontButton);
end;

constructor TfrxSignatureEditorForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  rePadding(Self);
end;

procedure TfrxSignatureEditorForm.CustomizableCheckBoxClick(Sender: TObject);
begin
  if FSignature.Customizable <> CustomizableCheckBox.Checked then
  begin
    FSignature.Customizable := CustomizableCheckBox.Checked;
    Change;
  end;
end;

procedure TfrxSignatureEditorForm.UpdateResouces;
begin
  inherited;
  Translate(Self);
  ImpotrGraphicButton.Hint := frxGet(6726);
  ImportLogoButton.Hint := frxGet(6726);
end;

initialization
  frxComponentEditors.Register(TfrxDigitalSignatureView, TfrxSignatureEditor);

end.
