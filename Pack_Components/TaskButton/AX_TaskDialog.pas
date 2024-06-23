unit AX_TaskDialog;

{$I AX_TaskDialog.inc}

interface

uses
  Windows, Messages, SysUtils, Controls, Graphics, Classes, Forms, Dialogs,
  ExtCtrls, StdCtrls, Math, MMSystem, ShellAPI, AX_TaskButton, ImgList,
  TypInfo, AX_Ctrls , Variants, StrUtils, ComCtrls, Themes, Winapi.CommCtrl;

const
  chPanelTitleS = 20;
  chPanelTitle = 45;
  chPanelTitleTextFooter = 40;
  chPanelText = 150;
  chPanelExpandedText = 100;
  chPanelProgress = 30;
  chPanelComboBox = 36;
  chPanelURLText = 25;
  chPanelButtons = 55;
  chPanelButtonsNoCheck = 35;
  chPanelMemoText = 118;
  chPanelFooterText = 30;

  chButtonLink = 50;
  chButtonSpacer = 5;
  chRadioButton = 20;
  chRadioButtonSpacer = 2;
  cwFormWidth = 450;
  clCompsLeft = 50;
  crCompsRight = 15;
  ctCompsIdent = 10;

type
  TaxHackWinControl = class(TCustomControl);

  TaxCustomTaskDialog = class;

  TaxTaskDialogFlag = (tfEnableHyperlinks, tfUseHiconMain,
    tfUseHiconFooter, tfUseCommandLinks, tfUseCommandLinksNoIcon,
    tfExpandFooterArea, tfExpandedByDefault, tfVerificationFlagChecked,
    tfShowProgressBar, tfShowMarqueeProgressBar, tfCallbackTimer,
    tfNoDefaultRadioButton, tfUseComboBox);
  TaxTaskDialogFlags = set of TaxTaskDialogFlag;

  TaxTaskDialogCommonButton = (tcbOk, tcbYes, tcbNo, tcbCancel, tcbRetry, tcbClose, tcbNone);
  TaxTaskDialogCommonButtons = set of TaxTaskDialogCommonButton;

  TaxTaskDialogIcon = (tdiNone, tdiWarning, tdiError, tdiInformation, tdiShield, tdiQuestion);

  TTaskDialogButtonClickEvent = procedure(Sender: TObject; ButtonID: integer) of object;
  TaxTaskDialogProgressEvent = procedure(Sender: TObject; var Pos: integer; var State: TProgressBarState) of object;
  TaxTaskDialogVerifyClickEvent = procedure(Sender: TObject; Checked: boolean) of object;

  TaxRadioButton = class(TRadioButton)
  private
    FOriginalCaption: string;
    FSetCaption: Boolean;
    procedure WMPaint(var msg: TWMPaint); message WM_PAINT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  end;

  TaxCheckBox = class(TCheckBox)
  private
    FOriginalCaption: string;
    FSetCaption: Boolean;
    procedure WMPaint(var msg: TWMPaint); message WM_PAINT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  end;

  TaxTaskDialogProgressBar = class(TPersistent)
  private
    FClient: TaxCustomTaskDialog;
    FMarqueeInterval: Integer;
    FMax: Integer;
    FMin: Integer;
    FPosition: Integer;
    FState: TProgressBarState;
    procedure SetMarqueeInterval(const Value: Integer);
    procedure SetMax(const Value: Integer);
    procedure SetMin(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetState(const Value: TProgressBarState);
  public
    constructor Create(AClient: TaxCustomTaskDialog);
  published
    property MarqueeInterval: Integer read FMarqueeInterval write SetMarqueeInterval default 0;
    property Max: Integer read FMax write SetMax default 100;
    property Min: Integer read FMin write SetMin default 0;
    property Position: Integer read FPosition write SetPosition default 0;
    property State: TProgressBarState read FState write SetState default pbsNormal;
  end;

  TaxTaskDialogBaseButtonItem = class(TCollectionItem)
  private
    FCaption: string;
    function GetDefault: Boolean;
    procedure SetCaption(const Value: string);
    procedure SetDefault(const Value: Boolean);
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property Caption: string read FCaption write SetCaption;
    property Default: Boolean read GetDefault write SetDefault default False;
  end;

  TaxTaskDialogButtonItem = class(TaxTaskDialogBaseButtonItem)
  private
    FCommandLinkHint: String;
  public
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; override;
  published
    property CommandLinkHint: String read FCommandLinkHint write FCommandLinkHint;
  end;

  TaxTaskDialogComboBoxItem = class(TaxTaskDialogBaseButtonItem)
  public
    constructor Create(ACollection: TCollection); override;
  end;

  TaxTaskDialogRadioButtonItem = class(TaxTaskDialogBaseButtonItem)
  public
    constructor Create(ACollection: TCollection); override;
  end;

  TaxTaskDialogButtons = class(TOwnedCollection)
  private
    FDefaultButton: TaxTaskDialogBaseButtonItem;
    function GetItem(Index: Integer): TaxTaskDialogBaseButtonItem;
    procedure SetDefaultButton(const Value: TaxTaskDialogBaseButtonItem);
    procedure SetItem(Index: Integer; const Value: TaxTaskDialogBaseButtonItem);
  public
    function Add: TaxTaskDialogBaseButtonItem;
    property DefaultButton: TaxTaskDialogBaseButtonItem read FDefaultButton write SetDefaultButton;
    property Items[Index: Integer]: TaxTaskDialogBaseButtonItem read GetItem write SetItem; default;
  end;

  TaxTaskDialogMetroStyle = class(TPersistent)
  private
    FClient: TaxCustomTaskDialog;
    FTaskDialogMetro: Boolean;
    FTaskDialogColor: TColor;
    FTaskDialogFontColor: TColor;
    procedure SetTaskDialogMetro(const Value: Boolean);
    procedure SetTaskDialogFontColor(const Value: TColor);
  public
    constructor Create(AClient: TaxCustomTaskDialog);
  published
    property TaskDialogColor: TColor read FTaskDialogColor write FTaskDialogColor;
    property TaskDialogMetro: Boolean read FTaskDialogMetro write SetTaskDialogMetro;
    property TaskDialogFontColor: TColor read FTaskDialogFontColor write SetTaskDialogFontColor;
  end;

  TaxCustomTaskDialog = class(TComponent)
  private
    // Variáveis do Form
    FPnlTitleS: TaxCustomControl;
    FPnlTitle: TaxCustomControl;
    FPnlText: TaxCustomControl;
    FPnlExpandedText: TaxCustomControl;
    FPnlProgress: TaxCustomControl;
    FPnlComboBox: TaxCustomControl;
    FPnlRadioButtons: TaxCustomControl;
    FPnlCommandButtons: TaxCustomControl;
    FPnlButtons: TaxCustomControl;
    FPnlURLText: TaxCustomControl;
    FPnlFooterText: TaxCustomControl;
    FPnlMemoText: TaxCustomControl;

    FImgMain: TImage;
    FImgText: TImage;
    FImgShowHideDetails: TImage;
    FLblShowHideDetails: TLabel;
    FBtn1: TButton;
    FBtn2: TButton;
    FBtn3: TButton;
    FLblVerificationText: TaxCheckBox;
    FImgFooter: TImage;
    FBevel1: TBevel;
    FBevel2: TBevel;
    FBevel3: TBevel;
    FEdtMemoText: TMemo;
    FImgList: TImageList;
    FExpanded: boolean;
    FTimer: TTimer;
    FFormClient: TForm;
    FTextAutoSize: Boolean;
    FTextWordWrap: Boolean;
    // Variaveis do Componente
    FButton: TaxTaskDialogButtonItem;
    FButtons: TaxTaskDialogButtons;
    FCaption: string;
    FCommonButtons: TaxTaskDialogCommonButtons;
    FCustomFooterIcon: TIcon;
    FCustomMainIcon: TIcon;
    FDefaultButton: TaxTaskDialogCommonButton;
    FExpandButtonCaption: string;
    FExpandedText: string;
    FFlags: TaxTaskDialogFlags;
    FFooterIcon: TaxTaskDialogIcon;
    FFooterText: string;
    FHelpContext: Integer;
    FMainIcon: TaxTaskDialogIcon;
    FModalResult: TModalResult;
    FProgressBar: TaxTaskDialogProgressBar;
    FRadioButton: TaxTaskDialogRadioButtonItem;
    FRadioButtons: TaxTaskDialogButtons;
    FComboBoxList: TaxTaskDialogComboBoxItem;
    FComboBoxLists: TaxTaskDialogButtons;
    FText: string;
    FTitle: string;
    FURLText: string;
    FURL: string;
    FVerificationText: string;
    FPlaySystemSounds: Boolean;
    FFormWidth: Integer;
    FMemoText: string;
    FColors: array[0..4] of TColor;
    FTitleColor: TColor;
    FTitleFont: TFont;
    FMetroStyle: TaxTaskDialogMetroStyle;

    // Variáveis de retorno
    FRadioButtonResult: Integer;
    FButtonResult: Integer;
    FComboBoxResult: Integer;
    FVerificationResult: Boolean;
//    FOnButtonClicked: TTaskDlgClickEvent;
//    FOnDialogConstructed: TNotifyEvent;
//    FOnDialogCreated: TNotifyEvent;
//    FOnDialogDestroyed: TNotifyEvent;
    FOnExpande: TNotifyEvent;
    FOnHyperlinkClick: TNotifyEvent;
//    FOnNavigated: TNotifyEvent;
    FOnRadioButtonClick: TTaskDialogButtonClickEvent;
    FOnTimer: TNotifyEvent;
    FOnDialogProgress: TaxTaskDialogProgressEvent;
    FOnVerifyClick: TaxTaskDialogVerifyClickEvent;

    FPBar: TProgressBar;
    FCbx: TComboBox;
    FRad: TaxRadioButton;
    FCmd: TaxTaskButton;
    // Metodos do Form
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DoShowHideDetailsClick(Sender: TObject);
    procedure DoShowHideDetailsMouseEnter(Sender: TObject);
    procedure DoShowHideDetailsMouseLeave(Sender: TObject);
    procedure DoURLTextClick(Sender: TObject);
    procedure DoVerificationTextClick(Sender: TObject);
    procedure DoButtonClick(Sender: TObject);
    procedure DoRadioClick(Sender: TObject);
    procedure DoComboBoxChange(Sender: TObject);
    procedure DoTimer(Sender: TObject);
    // Metodos do Componente
    function GetColor( index: Integer ): TColor;
    procedure SetColor( index: Integer; AValue: TColor );
    procedure SetButtons(const Value: TaxTaskDialogButtons);
    procedure SetExpandedText(const Value: string);
    procedure SetFooterIcon(const Value: TaxTaskDialogIcon);
    procedure SetFooterText(const Value: string);
    procedure SetFlags(const Value: TaxTaskDialogFlags);
    procedure SetMainIcon(const Value: TaxTaskDialogIcon);
    procedure SetRadioButtons(const Value: TaxTaskDialogButtons);
    procedure SetComboBoxLists(const Value: TaxTaskDialogButtons);
    procedure SetText(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetCustomFooterIcon(const Value: TIcon);
    procedure SetCustomMainIcon(const Value: TIcon);

    procedure DoSetParentColor;
    procedure DoCreateForm;
    procedure DoSizeRecalcForm;
    procedure DoSetFontColor;
    procedure SetTextAutoSize(const Value: Boolean);
    procedure SetTextWordWrap(const Value: Boolean);
  protected
    function DoExecute: TModalResult;
    property FormClient: TForm read FFormClient write FFormClient;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: TModalResult;
    property TextAutoSize: Boolean read FTextAutoSize write SetTextAutoSize;
    property TextWordWrap: Boolean read FTextWordWrap write SetTextWordWrap;
    property Button: TaxTaskDialogButtonItem read FButton write FButton;
    property Buttons: TaxTaskDialogButtons read FButtons write SetButtons;
    property Caption: string read FCaption write FCaption;
    property CommonButtons: TaxTaskDialogCommonButtons read FCommonButtons write FCommonButtons default [tcbOk, tcbCancel];
    property CustomFooterIcon: TIcon read FCustomFooterIcon write SetCustomFooterIcon;
    property CustomMainIcon: TIcon read FCustomMainIcon write SetCustomMainIcon;
    property DefaultButton: TaxTaskDialogCommonButton read FDefaultButton write FDefaultButton default tcbOk;
    property ExpandButtonCaption: string read FExpandButtonCaption write FExpandButtonCaption;
    property Expanded: Boolean read FExpanded;
    property ExpandedText: string read FExpandedText write SetExpandedText;
    property Flags: TaxTaskDialogFlags read FFlags write SetFlags;
    property FooterIcon: TaxTaskDialogIcon read FFooterIcon write SetFooterIcon default tdiNone;
    property FooterText: string read FFooterText write SetFooterText;
    property HelpContext: Integer read FHelpContext write FHelpContext default 0;
    property MainIcon: TaxTaskDialogIcon read FMainIcon write SetMainIcon default tdiInformation;
    property ModalResult: TModalResult read FModalResult write FModalResult;
    property ProgressBar: TaxTaskDialogProgressBar read FProgressBar write FProgressBar;
    property RadioButton: TaxTaskDialogRadioButtonItem read FRadioButton;
    property RadioButtons: TaxTaskDialogButtons read FRadioButtons write SetRadioButtons;
    property ComboBoxList: TaxTaskDialogComboBoxItem read FComboBoxList;
    property ComboBoxLists: TaxTaskDialogButtons read FComboBoxLists write SetComboBoxLists;
    property Text: string read FText write SetText;
    property Title: string read FTitle write SetTitle;
    property URLText: string read FURLText write FURLText;
    property URL: string read FURL write FURL;
    property VerificationText: string read FVerificationText write FVerificationText;
    property PlaySystemSounds: Boolean read FPlaySystemSounds write FPlaySystemSounds;
    property FormWidth: Integer read FFormWidth write FFormWidth default cwFormWidth;
    property MemoText: string read FMemoText write FMemoText;
    property ButtonsColor: TColor index 0 read GetColor write SetColor default clWhite;
    property ButtonsBorderColor: TColor index 3 read GetColor write SetColor default clSilver;
    property ButtonsShadowColor: TColor index 4 read GetColor write SetColor default clBlack;
    property TitleColor: TColor read FTitleColor write FTitleColor;
    property TitleFont: TFont read FTitleFont write FTitleFont;
    property MetroStyle: TaxTaskDialogMetroStyle read FMetroStyle write FMetroStyle;
//    property OnButtonClicked: TTaskDlgClickEvent read FOnButtonClicked write FOnButtonClicked;
//    property OnDialogConstructed: TNotifyEvent read FOnDialogConstructed write FOnDialogConstructed;
//    property OnDialogCreated: TNotifyEvent read FOnDialogCreated write FOnDialogCreated;
//    property OnDialogDestroyed: TNotifyEvent read FOnDialogDestroyed write FOnDialogDestroyed;
    property OnDialogExpandeClick: TNotifyEvent read FOnExpande write FOnExpande;
    property OnDialogHyperlinkClick: TNotifyEvent read FOnHyperlinkClick write FOnHyperlinkClick;
//    property OnNavigated: TNotifyEvent read FOnNavigated write FOnNavigated;
    property OnDialogRadioButtonClick: TTaskDialogButtonClickEvent read FOnRadioButtonClick write FOnRadioButtonClick;
    property OnDialogVerifyClick: TaxTaskDialogVerifyClickEvent read FOnVerifyClick write FOnVerifyClick;
    property OnDialogTimer: TNotifyEvent read FOnTimer write FOnTimer;
    property OnDialogProgress: TaxTaskDialogProgressEvent read FOnDialogProgress write FOnDialogProgress;

    property RadioButtonResult: Integer read FRadioButtonResult write FRadioButtonResult;
    property ButtonResult: Integer read FButtonResult write FButtonResult;
    property ComboBoxResult: Integer read FComboBoxResult write FComboBoxResult;
    property VerifyResult: Boolean read FVerificationResult write FVerificationResult;
  end;

  TaxTaskDialog = class(TaxCustomTaskDialog)
  private
    { Private declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property Buttons;
    property Caption;
    property CommonButtons;
    property CustomFooterIcon;
    property CustomMainIcon;
    property DefaultButton;
    property ExpandButtonCaption;
    property ExpandedText;
    property Flags;
    property FooterIcon;
    property FooterText;
    property HelpContext;
    property MainIcon;
    property ProgressBar;
    property RadioButtons;
    property ComboBoxLists;
    property Text;
    property Title;
    property VerificationText;
    property ButtonsColor;
    property ButtonsBorderColor;
    property ButtonsShadowColor;
    property TitleColor;
    property TitleFont;
    property URLText;
    property URL;
    property PlaySystemSounds;
    property FormWidth;
    property MemoText;
    property MetroStyle;
//    property OnButtonClicked;
//    property OnDialogConstructed;
//    property OnDialogCreated;
//    property OnDialogDestroyed;
    property OnDialogExpandeClick;
    property OnDialogHyperlinkClick;
//    property OnNavigated;
    property OnDialogRadioButtonClick;
    property OnDialogTimer;
    property OnDialogProgress;
    property OnDialogVerifyClick;
  end;

procedure Register;

function IfThen(AValue: Boolean; const ATrue: Variant; AFalse: Variant): variant;
procedure TaskShowMessage(const Msg: string);
function  TaskMessageBox(const Msg, Title: string; Buttons: TaxTaskDialogCommonButtons;
  Icon: TaxTaskDialogIcon): TModalResult;
procedure TaskShowAlert(const Title, Msg: string);

implementation

{$R AX_TaskDialog.res}

procedure Register;
begin
  RegisterComponents('Dialogs', [TaxTaskDialog]);
end;

procedure TaxCustomTaskDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if  (Shift = []) and (Key = VK_RETURN) then
   begin
      if FFormClient.ActiveControl is TComboBox then
         Keybd_event(VK_TAB, 0, 0, 0);
   end
   else
   if  (Shift = []) and (Key = VK_ESCAPE) then
   begin
      FFormClient.ModalResult := mrCancel;
   end;
   if ((Shift = []) or (Shift = [ssAlt])) and (Key = Ord('M')) and
       (FImgShowHideDetails.Visible) and (not FExpanded) then
   begin
      FLblShowHideDetails.OnClick(Self);
   end;
   if ((Shift = []) or (Shift = [ssAlt])) and (Key = Ord('E')) and
       (FImgShowHideDetails.Visible) and (FExpanded) then
   begin
      FLblShowHideDetails.OnClick(Self);
   end;
end;

procedure TaxCustomTaskDialog.DoVerificationTextClick(Sender: TObject);
begin
   FVerificationResult := FLblVerificationText.Checked;
   if FVerificationResult then
      Include(FFlags, tfVerificationFlagChecked);

   if Assigned(FOnVerifyClick) then
      FOnVerifyClick(Self, FLblVerificationText.Checked);
end;

procedure TaxCustomTaskDialog.DoURLTextClick(Sender: TObject);
begin
   ShellExecute(0, 'Open', PChar(FPnlURLText.Hint), nil, nil, SW_SHOWNORMAL);
   if Assigned(FOnHyperlinkClick) then
      FOnHyperlinkClick(Self);
end;

procedure TaxCustomTaskDialog.DoSetFontColor;
var
  iFor: Integer;
begin
   FPnlTitle.Font.Color := FMetroStyle.TaskDialogFontColor;
   FPnlText.Font.Color := FMetroStyle.TaskDialogFontColor;;
   FPnlExpandedText.Font.Color := FMetroStyle.TaskDialogFontColor;
   FPnlFooterText.Font.Color := FMetroStyle.FTaskDialogFontColor;
   FLblShowHideDetails.Font.Color := FMetroStyle.FTaskDialogFontColor;

//   FLblURLText: TLabel;
   FLblVerificationText.Font.Color := FMetroStyle.FTaskDialogFontColor;
end;

procedure TaxCustomTaskDialog.DoSetParentColor;
begin
   if FMetroStyle.TaskDialogMetro then
   begin
     FPnlTitleS.ParentColor := True;
     FPnlTitle.ParentColor := True;
     FPnlText.ParentColor := True;
     FPnlExpandedText.ParentColor := True;
     FPnlProgress.ParentColor := True;
     FPnlComboBox.ParentColor := True;
     FPnlRadioButtons.ParentColor := True;
     FPnlCommandButtons.ParentColor := True;
     FPnlButtons.ParentColor := True;
     FPnlURLText.ParentColor := True;
     FPnlFooterText.ParentColor := True;
     FPnlMemoText.ParentColor := True;
   end
   else
   begin
     FPnlTitleS.ParentColor := False;
     FPnlTitle.ParentColor := False;
     FPnlText.ParentColor := False;
     FPnlExpandedText.ParentColor := False;
     FPnlProgress.ParentColor := False;
     FPnlComboBox.ParentColor := False;
     FPnlRadioButtons.ParentColor := False;
     FPnlCommandButtons.ParentColor := False;
     FPnlButtons.ParentColor := False;
     FPnlURLText.ParentColor := False;
     FPnlFooterText.ParentColor := False;
     FPnlMemoText.ParentColor := False;
   end;
end;

procedure TaxCustomTaskDialog.DoShowHideDetailsClick(Sender: TObject);
begin
   FExpanded := not FExpanded;
//   FLblShowHideDetails.Caption := ifthen(FExpanded, '&Esconder detalhe', '&Mostrar detalhe');

   if FExpandedText <> '' then
      FPnlExpandedText.Visible := FExpanded
   else
   if FMemoText <> '' then
      FPnlMemoText.Visible := FExpanded;

   try
     with FImgShowHideDetails.Picture.Bitmap do
     begin
        if FExpanded then
           LoadFromResourceName(HInstance, 'ARROW_UP_BW')
        else
           LoadFromResourceName(HInstance, 'ARROW_DOWN_BW');
     end;
   except
   end;
//   DoSizeRecalcForm;

   if Assigned(FOnExpande) then
      FOnExpande(Self);
end;

procedure TaxCustomTaskDialog.DoShowHideDetailsMouseEnter(Sender: TObject);
begin
   try
     with FImgShowHideDetails.Picture.Bitmap do
     begin
        if FExpanded then
           LoadFromResourceName(HInstance, 'ARROW_UP_COLOR')
        else
           LoadFromResourceName(HInstance, 'ARROW_DOWN_COLOR');
     end;
   except
   end;
end;

procedure TaxCustomTaskDialog.DoShowHideDetailsMouseLeave(Sender: TObject);
begin
   try
     with FImgShowHideDetails.Picture.Bitmap do
     begin
        if FExpanded then
           LoadFromResourceName(HInstance, 'ARROW_UP_BW')
        else
           LoadFromResourceName(HInstance, 'ARROW_DOWN_BW');
     end;
   except
   end;
end;

procedure TaxCustomTaskDialog.DoSizeRecalcForm;
begin
   with FFormClient do
   begin
      ClientHeight := 0;

      if FPnlTitleS.Visible then
         ClientHeight := ClientHeight + FPnlTitleS.Height;

      if FPnlTitle.Visible then
         ClientHeight := ClientHeight + FPnlTitle.Height;

      if FPnlComboBox.Visible then
         ClientHeight := ClientHeight + FPnlComboBox.Height;

      if FPnlProgress.Visible then
         ClientHeight := ClientHeight + FPnlProgress.Height;

      if FPnlButtons.Visible then
         ClientHeight := ClientHeight + FPnlButtons.Height;

      if FPnlCommandButtons.Visible then
         ClientHeight := ClientHeight + FPnlCommandButtons.Height;

      if FPnlFooterText.Visible then
         ClientHeight := ClientHeight + FPnlFooterText.Height;

      if FPnlRadioButtons.Visible then
         ClientHeight := ClientHeight + FPnlRadioButtons.Height;

      if FPnlText.Visible then
         ClientHeight := ClientHeight + FPnlText.Height;

      if FPnlURLText.Visible then
         ClientHeight := ClientHeight + FPnlURLText.Height;

      if FPnlExpandedText.Visible then
         ClientHeight := ClientHeight + FPnlExpandedText.Height;

      if FPnlMemoText.Visible then
         ClientHeight := ClientHeight + FPnlMemoText.Height;
   end;
end;

procedure TaxCustomTaskDialog.DoTimer(Sender: TObject);
var
  State: TProgressBarState;
  Pos: Integer;
begin
   if (tfCallbackTimer in FFlags) then
      if Assigned(FOnTimer) then
         FOnTimer(Sender);

   if not (tfShowMarqueeProgressBar in FFlags) then
   begin
      if Assigned(FOnDialogProgress) then
      begin
         if Assigned(FPBar) then
         begin
            Pos := FProgressBar.Position;
            FOnDialogProgress(Self, Pos, State);
            FProgressBar.SetPosition(Pos);
            FPBar.Perform(PBM_SETPOS, FProgressBar.Position, FProgressBar.Max)
         end;
      end;
   end;
end;

procedure TaxCustomTaskDialog.DoRadioClick(Sender: TObject);
begin
   FRadioButtonResult := TaxRadioButton(Sender).Tag;

   if Assigned(FOnRadioButtonClick) then
      FOnRadioButtonClick(Self, FRadioButtonResult);
end;

procedure TaxCustomTaskDialog.DoButtonClick(Sender: TObject);
begin
   FButtonResult := TaxTaskButton(Sender).Tag;
   FFormClient.ModalResult := mrYesToAll;
end;

procedure TaxCustomTaskDialog.DoComboBoxChange(Sender: TObject);
begin
   FComboBoxResult := TComboBox(Sender).ItemIndex;
end;

procedure TaxCustomTaskDialog.DoCreateForm;
const
  axLeftObjects = 50;
  axBorderWidth = 7;
  axLeftImage = 9;
  axTopPanel = 5;
var
  pColorPropInfo: PPropInfo;
begin
   if not Assigned(FFormClient) then
      FFormClient := TForm.Create(nil);

   FFormClient.AlphaBlend := false;
   FFormClient.AlphaBlendValue := 230;
   with FFormClient do
   begin
      BorderWidth := axBorderWidth;
      ClientHeight := 0;
      ClientWidth  := cwFormWidth;
      Color := FMetroStyle.TaskDialogColor;
      KeyPreview := True;
      OnKeyDown := FormKeyDown;
      Position := poDefault;
      BorderStyle := bsNone;
      // Spacer
      FPnlTitleS := TaxCustomControl.Create(FFormClient);
      with FPnlTitleS do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 0;
      end;
      // Title
      FPnlTitle := TaxCustomControl.Create(FFormClient);
      with FPnlTitle do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 1;
         // Child do FPnlTitle
         FImgMain := TImage.Create(FPnlTitle);
         with FImgMain do
         begin
            Parent := FPnlTitle;
            Left   := axLeftImage;
            Top    := axTopPanel;
            AutoSize := True;
            Transparent := True;
         end;
      end;
      // Text
      FPnlText := TaxCustomControl.Create(FFormClient);
      with FPnlText do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 2;
         // Child Text
         FImgText := TImage.Create(FPnlText);
         with FImgText do
         begin
            Parent := FPnlText;
            Transparent := True;
         end;
      end;
      // Progress
      FPnlProgress := TaxCustomControl.Create(FFormClient);
      with FPnlProgress do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 3;
      end;
      // ComboBox
      FPnlComboBox := TaxCustomControl.Create(FFormClient);
      with FPnlComboBox do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 4;
      end;
      // Radio Buttons
      FPnlRadioButtons := TaxCustomControl.Create(FFormClient);
      with FPnlRadioButtons do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 5;
      end;
      // Command Buttons
      FPnlCommandButtons := TaxCustomControl.Create(FFormClient);
      with FPnlCommandButtons do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 6;
      end;
      // URL Text
      FPnlURLText := TaxCustomControl.Create(FFormClient);
      with FPnlURLText do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 7;
         OnClick := DoURLTextClick;
      end;
      // Painel de Buttons
      FPnlButtons := TaxCustomControl.Create(FFormClient);
      with FPnlButtons do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 8;
         // Filho do Painel de Botões
         FImgShowHideDetails := TImage.Create(FPnlButtons);
         with FImgShowHideDetails do
         begin
            Parent := FPnlButtons;
            OnClick := DoShowHideDetailsClick;
         {$IFDEF Delphi9}
            OnMouseEnter := DoShowHideDetailsMouseEnter;
            OnMouseLeave := DoShowHideDetailsMouseLeave;
         {$ENDIF}
         end;
         // Filho do Painel de Botões
         FLblShowHideDetails := TLabel.Create(FPnlButtons);
         with FLblShowHideDetails do
         begin
            Parent := FPnlButtons;
            OnClick := DoShowHideDetailsClick;
         {$IFDEF Delphi9}
            OnMouseEnter := DoShowHideDetailsMouseEnter;
            OnMouseLeave := DoShowHideDetailsMouseLeave;
         {$ENDIF}
         end;
         // Button 1
         FBtn1 := TButton.Create(FPnlButtons);
         with FBtn1 do
         begin
            Parent := FPnlButtons;
            TabOrder := 0;
         end;
         // Button 2
         FBtn2 := TButton.Create(FPnlButtons);
         with FBtn2 do
         begin
            Parent := FPnlButtons;
            TabOrder := 1;
         end;
         // Button 3
         FBtn3 := TButton.Create(FPnlButtons);
         with FBtn3 do
         begin
            Parent := FPnlButtons;
            TabOrder := 2;
         end;
         // Verification
         FLblVerificationText := TaxCheckBox.Create(FPnlButtons);
         with FLblVerificationText do
         begin
            Parent := FPnlButtons;
         {$IFDEF Delphi7}
            WordWrap := True;
         {$ENDIF}
            TabOrder := 3;
            OnClick := DoVerificationTextClick;
         end;
      end;
      // Expanded
      FPnlExpandedText := TaxCustomControl.Create(FFormClient);
      with FPnlExpandedText do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 9;
         FBevel3 := TBevel.Create(FPnlExpandedText);
         with FBevel3 do
         begin
            Parent := FPnlExpandedText;
            Height := 9;
            Align := alTop;
            Shape := bsTopLine;
         end;
      end;
      // Memo Text
      FPnlMemoText := TaxCustomControl.Create(FFormClient);
      with FPnlMemoText do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 10;
         FBevel2 := TBevel.Create(FPnlMemoText);
         with FBevel2 do
         begin
            Parent := FPnlMemoText;
            Height := 9;
            Align := alTop;
            Shape := bsTopLine;
         end;
         // Memo
         FEdtMemoText := TMemo.Create(FPnlMemoText);
         with FEdtMemoText do
         begin
            Parent := FPnlMemoText;
            ScrollBars := ssVertical;
            TabOrder := 0;
         end;
      end;
      // Footer
      FPnlFooterText := TaxCustomControl.Create(FFormClient);
      with FPnlFooterText do
      begin
         Parent := FFormClient;
         Align := alTop;
         TabOrder := 11;
         FBevel1 := TBevel.Create(FPnlFooterText);
         with FBevel1 do
         begin
            Parent := FPnlFooterText;
            Height := 9;
            Align := alTop;
            Shape := bsTopLine;
         end;
         // Image Footer
         FImgFooter := TImage.Create(FPnlFooterText);
         with FImgFooter do
         begin
            Parent := FPnlFooterText;
            Transparent := True;
            Center := True
         end;
      end;
      FImgList := TImageList.Create(FFormClient);
   end;
   FRadioButtonResult := -1;
   FButtonResult := -1;
   FComboBoxResult := -1;
   FVerificationResult := (tfVerificationFlagChecked in FFlags);
end;

function IfThen(AValue: Boolean; const ATrue: Variant;
  AFalse: Variant): Variant;
begin
   if AValue then
      Result := ATrue
   else
      Result := AFalse;
end;

{ TaxTaskDialogBaseButtonItem }

constructor TaxTaskDialogBaseButtonItem.Create(ACollection: TCollection);
begin
  inherited;
  FCaption := '';
end;

destructor TaxTaskDialogBaseButtonItem.Destroy;
begin

  inherited;
end;

function TaxTaskDialogBaseButtonItem.GetDefault: Boolean;
begin
  Result := TaxTaskDialogButtons(Collection).DefaultButton = Self;
end;

procedure TaxTaskDialogBaseButtonItem.SetCaption(const Value: string);
begin
  if Value <> FCaption then
  begin
    if Value = '' then
      raise Exception.Create('Caption está em branco!');
    FCaption := Value;
  end;
end;

procedure TaxTaskDialogBaseButtonItem.SetDefault(const Value: Boolean);
begin
  if Value then
    TaxTaskDialogButtons(Collection).DefaultButton := Self
  else
    TaxTaskDialogButtons(Collection).DefaultButton := nil;
end;

{ TaxTaskDialogButtonItem }

constructor TaxTaskDialogButtonItem.Create(ACollection: TCollection);
begin
  inherited;
end;

destructor TaxTaskDialogButtonItem.Destroy;
begin
  inherited;
end;

{ TaxTaskDialogRadioButtonItem }

constructor TaxTaskDialogRadioButtonItem.Create(ACollection: TCollection);
begin
  inherited;

end;

{ TaxTaskDialogButtons }

function TaxTaskDialogButtons.Add: TaxTaskDialogBaseButtonItem;
begin
  Result := TaxTaskDialogBaseButtonItem(inherited Add);
end;

function TaxTaskDialogButtons.GetItem(Index: Integer): TaxTaskDialogBaseButtonItem;
begin
  Result := TaxTaskDialogBaseButtonItem(inherited GetItem(Index));
end;

procedure TaxTaskDialogButtons.SetDefaultButton(
  const Value: TaxTaskDialogBaseButtonItem);
begin
  if Value <> FDefaultButton then
     FDefaultButton := Value;
end;

procedure TaxTaskDialogButtons.SetItem(Index: Integer;
  const Value: TaxTaskDialogBaseButtonItem);
begin
  inherited SetItem(Index, Value);
end;

{ TaxCustomTaskDialog }

constructor TaxCustomTaskDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TaxTaskDialogButtons.Create(Self, TaxTaskDialogButtonItem);
  FRadioButtons := TaxTaskDialogButtons.Create(Self, TaxTaskDialogRadioButtonItem);
  FComboBoxLists := TaxTaskDialogButtons.Create(Self, TaxTaskDialogComboBoxItem);
  FCustomMainIcon := TIcon.Create;
  FCustomFooterIcon := TIcon.Create;
  FTitleFont := TFont.Create;
  FMetroStyle := TaxTaskDialogMetroStyle.Create(Self);

  FCommonButtons := [tcbOk, tcbCancel];
  FDefaultButton := tcbNone;
  FFlags := [];
  FFooterIcon := tdiNone;
  FMainIcon := tdiInformation;
  FProgressBar := TaxTaskDialogProgressBar.Create(Self);
  FExpanded := False;
  FPlaySystemSounds := true;
  FFormWidth := cwFormWidth;
  FTextAutoSize := False;
  FTextWordWrap := True;
  FTitleColor := clWhite;

  FTitleFont.Color := clNavy;
  FTitleFont.Size  := 12;
  FTitleFont.Name  := 'Arial';

  Caption := '';
  FTitle  := '';
  FText   := '';
  FExpandedText := '';
  FURLText := '';
  FURL := '';
  FVerificationText := '';
  FFooterText := '';
  FMemoText := '';
  //
  FColors[0] := clWhite;
  FColors[1] := TColor( $D8ACB0 );
  FColors[2] := TColor( $C7879F );
  FColors[3] := clSilver;
  FColors[4] := clBlack;
end;

destructor TaxCustomTaskDialog.Destroy;
begin
  if Assigned(FTimer) then FTimer.Free;
  FButtons.Free;
  FCustomFooterIcon.Free;
  FCustomMainIcon.Free;
  FProgressBar.Free;
  FRadioButtons.Free;
  FComboBoxLists.Free;
  FTitleFont.Free;
  FMetroStyle.Free;
  inherited;
end;

function TaxCustomTaskDialog.DoExecute: TModalResult;
var
intFor, intBtn, intHeight: Integer;
TextRect: TRect;
begin
   FRad  := nil;
   FCmd  := nil;
   FCbx  := nil;
   FPBar := nil;

   // Criar o Form e seus Componentes
   DoCreateForm;

   FExpanded := (tfExpandedByDefault in FFlags) or (tfExpandFooterArea in FFlags);
   //
   FFormClient.Caption  := FCaption;
   FFormClient.Width    := ifThen(FFormWidth > 0, FFormWidth, cwFormWidth);
   FFormClient.AutoSize := True;

   FPnlTitleS.Width := FFormClient.ClientWidth;
   FPnlTitle.Width := FFormClient.ClientWidth;
   FPnlText.Width := FFormClient.ClientWidth;
   FPnlExpandedText.Width := FFormClient.ClientWidth;
   FPnlProgress.Width := FFormClient.ClientWidth;
   FPnlComboBox.Width := FFormClient.ClientWidth;
   FPnlRadioButtons.Width := FFormClient.ClientWidth;
   FPnlCommandButtons.Width := FFormClient.ClientWidth;
   FPnlButtons.Width := FFormClient.ClientWidth;
   FPnlURLText.Width := FFormClient.ClientWidth;
   FPnlFooterText.Width := FFormClient.ClientWidth;
   FPnlMemoText.Width := FFormClient.ClientWidth;

   // Configura som da mensagem
   // SystemDefault
   // SystemAsterisk
   // SystemExclamation
   // SystemExit
   // SystemHand
   // SystemQuestion
   // SystemStart
   if (FPlaySystemSounds) then
   begin
      case FMainIcon of
         tdiInformation: PlaySound(PChar('SystemAsterisk'), 0, SND_ASYNC);
         tdiQuestion:    PlaySound(PChar('SystemQuestion'), 0, SND_ASYNC);
         tdiWarning:     PlaySound(PChar('SystemExclamation'), 0, SND_ASYNC);
         tdiError:       PlaySound(PChar('SystemHand'), 0, SND_ASYNC);
         tdiShield:      PlaySound(PChar('SystemHand'), 0, SND_ASYNC);
      end;
   end;
   FPnlTitleS.Height := chPanelTitleS;
   if FPnlTitleS.Visible then
   begin
     with FPnlTitleS do
     begin
       Caption := FCaption;
       Alignment := taCenter;
       Bounds(0, 0, FFormClient.ClientWidth, chPanelTitleS);
       ParentBackground := False;
       ParentColor := True;
       Font.Size := 10;
       if FMetroStyle.TaskDialogMetro then
          Font.Color := FMetroStyle.TaskDialogFontColor
       else
          Font.Color := FTitleFont.Color;
     end;
   end;
   // Configura Instrução
   FPnlTitle.Visible := FTitle <> '';
   if FPnlTitle.Visible then
   begin
      with FPnlTitle do
      begin
        LeftIndent := clCompsLeft;
        TopIndent  := 5;
        BottomIndent := 5;
        RightIndent := 5;
        Caption := FTitle;
        Height := chPanelTitle;
        Color := FTitleColor;
        ParentBackground := False;
        Font.Assign(FTitleFont);
        WordWrap := True;
        EllipsisPosition := epEndEllipsis;
        {$IF DEBUG}
        Layout := tlTop;
        {$ENDIF}
      end;
      //  Configura icone do título
      if (tfUseHiconMain in FFlags) and (FCustomMainIcon <> nil) then
      begin
         FImgMain.Picture.Icon.Assign(FCustomMainIcon);
      end
      else
      begin
         with FImgMain.Picture.Bitmap do
         begin
           try
             case FMainIcon of
                tdiNone: ;
                tdiInformation: LoadFromResourceName(HInstance, 'ICON_INFORMATION_32X32');
                tdiQuestion:    LoadFromResourceName(HInstance, 'ICON_QUESTION_32X32');
                tdiWarning:     LoadFromResourceName(HInstance, 'ICON_WARNING_32X32');
                tdiError:       LoadFromResourceName(HInstance, 'ICON_ERROR_32X32');
                tdiShield:      LoadFromResourceName(HInstance, 'ICON_SHIELD_32X32');
             end;
           except
           end;
         end;
      end;
      FImgMain.Left := ctCompsIdent;
      FImgMain.Top := 5;
      FImgMain.Width := 32;
      FImgMain.Height := 32;
   end;
   // Configurar Content
   FPnlText.Visible := FText <> '';
   FPnlText.Height := chPanelText;
   if FPnlText.Visible then
   begin
      with FPnlText do
      begin
        LeftIndent := clCompsLeft;
        TopIndent  := 3;
        BottomIndent := 3;
        RightIndent := 3;
        Font.Size := 10;
        Caption := FText;
        Color := clWindow;
        ParentBackground := False;
        WordWrap := FTextWordWrap;
        if FTextAutoSize then
           AutoSize := FTextAutoSize;
        if not AutoSize then
           EllipsisPosition := epEndEllipsis;
      end;
      // Configura a Imagem do Texto
      FImgText.Visible := not FPnlTitle.Visible;
      if FImgText.Visible then
      begin
         with FImgText do
         begin
            Left := ctCompsIdent;
            Top := 3;
            Width := 32;
            Height := 32;
         end;
         if (tfUseHiconMain in FFlags) and (FCustomMainIcon <> nil) then
         begin
            FImgText.Picture.Icon.Assign(FCustomMainIcon);
         end
         else
         begin
            with FImgText.Picture.Bitmap do
            begin
               try
                 case FMainIcon of
                    tdiNone: ;
                    tdiInformation: LoadFromResourceName(HInstance, 'ICON_INFORMATION_32X32');
                    tdiQuestion:    LoadFromResourceName(HInstance, 'ICON_QUESTION_32X32');
                    tdiWarning:     LoadFromResourceName(HInstance, 'ICON_WARNING_32X32');
                    tdiError:       LoadFromResourceName(HInstance, 'ICON_ERROR_32X32');
                    tdiShield:      LoadFromResourceName(HInstance, 'ICON_SHIELD_32X32');
                 end;
               except
               end;
            end;
         end;
      end;
   end;
   if (tfCallbackTimer in FFlags) then
   begin
     FTimer := TTimer.Create(Self);
     FTimer.Interval := 100;
     FTimer.OnTimer := DoTimer;
     FTimer.Enabled := True;
   end;

   // Configurar ProgressBar
   FPnlProgress.Visible := (tfShowProgressBar in FFlags);
   FPnlProgress.Height := chPanelProgress;
   if FPnlProgress.Visible then
   begin
      FPBar := TProgressBar.Create(FPnlProgress);
      with FPBar do
      begin
        Parent     := FPnlProgress;
        BoundsRect := Rect(clCompsLeft, 5, FPnlProgress.Width - crCompsRight, 20);
        Max        := FProgressBar.Max;
        Min        := FProgressBar.Min;
        Position   := FProgressBar.Position;
        State      := FProgressBar.State;
        if (tfShowMarqueeProgressBar in FFlags) then
        begin
           MarqueeInterval := FProgressBar.MarqueeInterval;
           Style := pbstMarquee;
        end;
        if not Assigned(FTimer) then
        begin
          FTimer := TTimer.Create(Self);
          FTimer.Interval := 100;
          FTimer.OnTimer  := DoTimer;
          FTimer.Enabled  := True;
        end;
      end;
   end;
   // Configurar ComboBox
   FPnlComboBox.Visible := (tfUseComboBox in FFlags) and (FComboBoxLists.Count > 0);
   FPnlComboBox.Height  := chPanelComboBox;
   if FPnlComboBox.Visible then
   begin
     FCbx := TComboBox.Create(FPnlComboBox);
     with FCbx do
     begin
        Parent     := FPnlComboBox;
        BoundsRect := Rect(clCompsLeft, 5, FPnlComboBox.Width - crCompsRight, 21);
        Style      := csDropDownList;
        OnChange   := DoComboBoxChange;
        for intFor := 0 to FComboBoxLists.Count - 1 do
        begin
           Items.Add(FComboBoxLists[intFor].Caption);
           if FComboBoxLists[intFor].Default then
              ItemIndex := intFor;
        end;
        if ItemIndex = -1 then
           ItemIndex := 0;
     end;
     FComboBoxResult := 0;
   end;
   // Configurar RadioButtons
   FPnlRadioButtons.Visible := FRadioButtons.Count > 0;
   if FPnlRadioButtons.Visible then
   begin
     FPnlRadioButtons.Height := (chRadioButton * FRadioButtons.Count) + chRadioButtonSpacer;
     for intFor := 0 to FRadioButtons.Count -1 do
     begin
       FRad := TaxRadioButton.Create(FPnlRadioButtons);
       with FRad do
       begin
          Parent  := FPnlRadioButtons;
          Left    := clCompsLeft;
          Top     := (chRadioButton * intFor) + chRadioButtonSpacer;
          Width   := FPnlRadioButtons.Width - clCompsLeft - crCompsRight;
          Caption := FRadioButtons[intFor].Caption;
          Tag     := intFor;
          OnClick := DoRadioClick;
          if (tfNoDefaultRadioButton in FFlags) then
             Checked := false
          else
             Checked := FRadioButtons[intFor].Default;

          if FMetroStyle.TaskDialogMetro then
             Font.Color := FMetroStyle.TaskDialogFontColor;
       end;
       if FRadioButtons[intFor].Default then
          RadioButtonResult := intFor;
     end;
   end;
   // Configurar CommandButtons
   FPnlCommandButtons.Visible := (tfUseCommandLinks in FFlags) and (FButtons.Count > 0);
   if FPnlCommandButtons.Visible then
   begin
     FPnlCommandButtons.Height  := chButtonLink * FButtons.Count;
     for intFor := 0 to FButtons.Count -1 do
     begin
       FCmd := TaxTaskButton.Create(FPnlCommandButtons);
       with FCmd do
       begin
          Parent    := FPnlCommandButtons;
          Left      := clCompsLeft;
          Top       := (chButtonLink * intFor) + chButtonSpacer;
          Height    := chButtonLink;
          Width     := FPnlCommandButtons.Width - clCompsLeft - crCompsRight;
          Caption   := TaxTaskDialogButtonItem(FButtons[intFor]).Caption;
          Tag       := intFor;
          Font.Size := 12;
          try
            if (tfUseCommandLinksNoIcon in FFlags) then
               FImgList.ResourceLoad(rtBitmap, 'WHITE_ARROW', clWhite)
            else
               FImgList.ResourceLoad(rtBitmap, 'GREEN_ARROW', clWhite)
          except
          end;
          Normal := FImgList;
          ImageIndex := 0;
          Color := ButtonsColor;
          BorderColor  := ButtonsBorderColor;
          ShadowColor  := ButtonsShadowColor;
          OnClick := DoButtonClick;
          CommandLinkHint := TaxTaskDialogButtonItem(FButtons[intFor]).CommandLinkHint;
          if FMetroStyle.TaskDialogMetro then
          begin
             Color := TaxCustomControl(FPnlCommandButtons.Parent).Color;
             Font.Color := FMetroStyle.TaskDialogFontColor;
             Transparent := False;
          end;
       end;
       with FPnlCommandButtons do
         Height := Height + chButtonSpacer;
     end;
   end;
   // Configurar URL Text e URL
   FPnlURLText.Visible := (tfEnableHyperlinks in FFlags) and (FURLText <> '');
   FPnlURLText.Height  := chPanelURLText;
   if FPnlURLText.Visible then
   begin
      with FPnlURLText do
      begin
        LeftIndent := clCompsLeft;
        TopIndent  := 3;
        BottomIndent := 0;
        RightIndent := 0;
        Caption := FURLText;
        Hint := FURL;
        Color := clWindow;
        ParentBackground := False;
        WordWrap := False;
        EllipsisPosition := epNone;
        Font.Charset := DEFAULT_CHARSET;
        Font.Color := clBlue;
        Font.Height := -11;
        Font.Name := 'Tahoma';
        Font.Style := [fsUnderline];
        ParentFont := False;
        Width := FPnlURLText.Width - clCompsLeft - crCompsRight;
      end;
   end;
   FPnlButtons.Visible := not(FCommonButtons = [tcbNone]);
   FPnlButtons.Height  := chPanelButtons;
   if FPnlButtons.Visible then
   begin
      FPnlButtons.Color := clBtnFace;
      with FBtn1 do
      begin
         Top := 5;
         Width := 75;
         Height := 23;
      end;
      with FBtn2 do
      begin
         Top := 5;
         Width := 75;
         Height := 23;
      end;
      with FBtn3 do
      begin
         Top := 5;
         Width := 75;
         Height := 23;
      end;
      // Configurar Buttons
      if FCommonButtons = [tcbYes, tcbNo] then
      begin
         FBtn1.Visible := false;
         FBtn2.Caption := '&Sim';
         FBtn2.ModalResult := mrYes;
         FBtn3.Caption := '&Não';
         FBtn3.ModalResult := mrNo;
         FBtn3.Cancel := true;
         if FDefaultButton in [tcbYes] then FBtn2.Default := true
         else
         if FDefaultButton in [tcbNo]  then FBtn3.Default := true;
      end
      else
      if FCommonButtons = [tcbYes, tcbNo, tcbCancel] then
      begin
         FBtn1.Caption := '&Sim';
         FBtn1.ModalResult := mrYes;
         FBtn2.Caption := '&Não';
         FBtn2.ModalResult := mrNo;
         FBtn3.Caption := '&Cancela';
         FBtn3.ModalResult := mrCancel;
         FBtn3.Cancel := true;
         if FDefaultButton in [tcbYes]    then FBtn1.Default := true
         else
         if FDefaultButton in [tcbNo]     then FBtn2.Default := true
         else
         if FDefaultButton in [tcbCancel] then FBtn3.Default := true;
      end
      else
      if FCommonButtons = [tcbOk, tcbCancel] then
      begin
         FBtn1.Visible := false;
         FBtn2.Caption := '&OK';
         FBtn2.ModalResult := mrOK;
         FBtn3.Caption := '&Cancela';
         FBtn3.ModalResult := mrCancel;
         FBtn3.Cancel := true;
         if FDefaultButton in [tcbOk]     then FBtn2.Default := true
         else
         if FDefaultButton in [tcbCancel] then FBtn3.Default := true;
      end
      else
      if FCommonButtons = [tcbOk, tcbCancel, tcbRetry] then
      begin
         FBtn1.Caption := '&OK';
         FBtn1.ModalResult := mrYes;
         FBtn2.Caption := '&Cancela';
         FBtn2.ModalResult := mrNo;
         FBtn3.Caption := '&Repete';
         FBtn3.ModalResult := mrRetry;
         FBtn3.Cancel := true;
         if FDefaultButton in [tcbYes]   then FBtn1.Default := true
         else
         if FDefaultButton in [tcbNo]    then FBtn2.Default := true
         else
         if FDefaultButton in [tcbRetry] then FBtn3.Default := true;
      end
      else
      if FCommonButtons = [tcbOk] then
      begin
         FBtn1.Visible := false;
         FBtn2.Visible := false;
         FBtn3.Caption := '&OK';
         FBtn3.ModalResult := mrOK;
         FBtn3.Cancel := true;
         FBtn3.Default := true;
      end
      else
      if FCommonButtons = [tcbClose] then
      begin
         FBtn1.Visible := false;
         FBtn2.Visible := false;
         FBtn3.Caption := '&Fechar';
         FBtn3.ModalResult := mrCancel;
         FBtn3.Cancel := true;
         FBtn3.Default := true;
      end
      else
      if FCommonButtons = [tcbCancel] then
      begin
         FBtn1.Visible := false;
         FBtn2.Visible := false;
         FBtn3.Caption := '&Cancela';
         FBtn3.ModalResult := mrCancel;
         FBtn3.Cancel := true;
         FBtn3.Default := true;
      end
      else
      if FCommonButtons = [tcbNone] then
      begin
         FBtn1.Visible := false;
         FBtn2.Visible := false;
         FBtn3.Visible := false;
      end
      else
      begin
         FBtn1.Visible := false;
         FBtn2.Visible := false;
         FBtn3.Visible := false;
      end;
      FBtn1.TabStop := FBtn1.Visible;
      FBtn2.TabStop := FBtn2.Visible;
      FBtn3.TabStop := FBtn3.Visible;

      if FBtn1.Visible then
         FBtn1.Left := FFormClient.ClientWidth -245;

      if FBtn2.Visible then
         FBtn2.Left := FFormClient.ClientWidth -165;

      if FBtn3.Visible then
         FBtn3.Left := FFormClient.ClientWidth -85;
   end;
   // Verificação de Texto e Painel de Botões
   FLblVerificationText.Visible := FVerificationText <> '';
   if FLblVerificationText.Visible then
   begin
      with FLblVerificationText do
      begin
         Left := 13;
         Top := 32;
         Height := 17;
         Width   := FPnlButtons.Width - Left - crCompsRight;
         Caption := FVerificationText;
         Color   := clBtnFace;
         Checked := (tfVerificationFlagChecked in FFlags);
      end;
      if FMetroStyle.TaskDialogMetro then
         FLblVerificationText.Font.Color := FMetroStyle.FTaskDialogFontColor;
   end
   else
     FPnlButtons.Height := chPanelButtonsNoCheck;

   if (FVerificationText = '') and
      (FExpandedText = '') and
      (FMemoText = '') and
      (FCommonButtons = [tcbNone]) then
   begin
      FPnlButtons.Visible := False;
   end;
   // Configurar Expanded Text
   if FExpandedText = '' then
      FPnlExpandedText.Visible := False
   else
      FPnlExpandedText.Visible := FExpanded;

   // Configurar Expanded Text
   with FImgShowHideDetails do
   begin
      Parent := FPnlButtons;
      Left := ctCompsIdent;
      Top := 5;
      Width := 19;
      Height := 19;
      Transparent := True;
   end;
   with FLblShowHideDetails do
   begin
      Left := 33;
      Top := 7;
      Height := 17;
      AutoSize := True;
      Caption := FExpandButtonCaption;
   end;
   if (FExpandedText = '') and (FMemoText = '') then
   begin
     FLblShowHideDetails.Visible := false;
     FImgShowHideDetails.Visible := false;
   end
   else
   begin
     if FExpanded then
        FExpanded := false
     else
     begin
       try
         with FImgShowHideDetails.Picture.Bitmap do
         begin
           if FExpanded then
              LoadFromResourceName(HInstance, 'ARROW_UP_BW')
           else
              LoadFromResourceName(HInstance, 'ARROW_DOWN_BW')
         end;
       except
       end;
     end;
   end;
   with FPnlExpandedText do
   begin
     LeftIndent := ctCompsIdent;
     TopIndent  := ctCompsIdent;
     BottomIndent := 1;
     RightIndent := ctCompsIdent;
     Caption := FExpandedText;
     Height := chPanelExpandedText;
     Color := clBtnFace;
     ParentBackground := False;
     WordWrap := True;
     EllipsisPosition := epEndEllipsis;
   end;
   // Configurar Texto em Memo
   FPnlMemoText.Height := chPanelMemoText;
   FPnlMemoText.Color  := clBtnFace;
   with FEdtMemoText do
   begin
     Lines.Text := FMemoText;
     Top    := ctCompsIdent;
     Left   := ctCompsIdent;
     Height := 100;
     Width  := FPnlMemoText.Width - (ctCompsIdent * 2);
   end;

   FPnlMemoText.Visible := (tfExpandFooterArea in FFlags);
   if FPnlMemoText.Visible then
      DoShowHideDetailsClick(Self);

   // Configurar Footer Text
   FPnlFooterText.Visible := FFooterText <> '';
   FPnlFooterText.Height := chPanelFooterText;
   if FPnlFooterText.Visible then
   begin
      with FPnlFooterText do
      begin
        LeftIndent := 30;
        TopIndent  := ctCompsIdent;
        BottomIndent := 0;
        RightIndent := 0;
        Caption := FFooterText;
        Color := clBtnFace;
        ParentBackground := False;
        WordWrap := False;
        EllipsisPosition := epNone;
        Width := FPnlURLText.Width - clCompsLeft - crCompsRight;
      end;
      with FImgFooter do
      begin
         Left   := ctCompsIdent;
         Top    := ctCompsIdent;
         Width  := 16;
         Height := 16;
         if (tfUseHiconFooter in FFlags) and (FCustomFooterIcon <> nil) then
         begin
            Picture.Icon.Assign(FCustomFooterIcon);
         end
         else
         begin
            try
              with Picture.Bitmap do
              begin
                case FFooterIcon of
                  tdiNone: ;
                  tdiInformation: LoadFromResourceName(HInstance, 'ICON_INFORMATION_16X16');
                  tdiQuestion:    LoadFromResourceName(HInstance, 'ICON_QUESTION_16X16');
                  tdiWarning:     LoadFromResourceName(HInstance, 'ICON_WARNING_16X16');
                  tdiError:       LoadFromResourceName(HInstance, 'ICON_ERROR_16X16');
                  tdiShield:      LoadFromResourceName(HInstance, 'ICON_SHIELD_16X16');
                end;
              end;
            except
            end;
         end;
      end;
   end;
   DoSetParentColor;
   if FMetroStyle.TaskDialogMetro then
      DoSetFontColor;

   try
     FFormClient.Position := poScreenCenter;
     Result := FFormClient.ShowModal;
     if not Result in [mrOk, mrYes, mrYesToAll] then
     begin
        FRadioButtonResult := -1;
        FButtonResult      := -1;
        FComboBoxResult    := -1;
     end;
   finally
     FreeAndNil(FFormClient);
   end;
end;

function TaxCustomTaskDialog.Execute: TModalResult;
begin
   Result := DoExecute;
end;

function TaxCustomTaskDialog.GetColor(index: Integer): TColor;
begin
  Result := FColors[ index ];
end;

procedure TaxCustomTaskDialog.SetTextAutoSize(const Value: Boolean);
begin
  if Value <> FTextAutoSize then
  begin
     FTextAutoSize := Value;
  end;
end;

procedure TaxCustomTaskDialog.SetTextWordWrap(const Value: Boolean);
begin
  if Value <> FTextWordWrap then
  begin
     FTextWordWrap := Value;
  end;
end;

procedure TaxCustomTaskDialog.SetButtons(const Value: TaxTaskDialogButtons);
begin
  if Value <> FButtons then
     FButtons.Assign(Value);
end;

procedure TaxCustomTaskDialog.SetColor(index: Integer; AValue: TColor);
begin
  if GetColor(index) <> AValue then
  begin
    FColors[index] := AValue;
  end;
end;

procedure TaxCustomTaskDialog.SetComboBoxLists(
  const Value: TaxTaskDialogButtons);
begin
  if Value <> FComboBoxLists then
     FComboBoxLists.Assign(Value);
end;

procedure TaxCustomTaskDialog.SetCustomFooterIcon(const Value: TIcon);
begin
  if Value <> FCustomFooterIcon then
     FCustomFooterIcon.Assign(Value);
end;

procedure TaxCustomTaskDialog.SetCustomMainIcon(const Value: TIcon);
begin
  if Value <> FCustomMainIcon then
     FCustomMainIcon.Assign(Value);
end;

procedure TaxCustomTaskDialog.SetExpandedText(const Value: string);
begin
  if Value <> FExpandedText then
     FExpandedText := Value;
end;

procedure TaxCustomTaskDialog.SetFlags(const Value: TaxTaskDialogFlags);
begin
  if Value <> FFlags then
  begin
    FFlags := Value;
  end;
end;

constructor TaxTaskDialogMetroStyle.Create(AClient: TaxCustomTaskDialog);
begin
  inherited Create;
  FClient := AClient;
  FTaskDialogColor := $00795B06;
  FTaskDialogMetro := False;
  FTaskDialogFontColor := clWindowText;
end;

procedure TaxTaskDialogMetroStyle.SetTaskDialogFontColor(const Value: TColor);
begin
  if Value <> FTaskDialogFontColor then
  begin
    FTaskDialogFontColor := Value;
    if Assigned(FClient.FormClient) then
       if FTaskDialogMetro then
          FClient.DoSetFontColor;
  end;
end;

procedure TaxCustomTaskDialog.SetFooterIcon(const Value: TaxTaskDialogIcon);
begin
  if Value <> FFooterIcon then
     FFooterIcon := Value;
end;

procedure TaxCustomTaskDialog.SetFooterText(const Value: string);
begin
  if Value <> FFooterText then
     FFooterText := Value;
end;

procedure TaxCustomTaskDialog.SetMainIcon(const Value: TaxTaskDialogIcon);
begin
  if Value <> FMainIcon then
     FMainIcon := Value;
end;

procedure TaxCustomTaskDialog.SetRadioButtons(const Value: TaxTaskDialogButtons);
begin
  if Value <> FRadioButtons then
     FRadioButtons.Assign(Value);
end;

procedure TaxTaskDialogMetroStyle.SetTaskDialogMetro(const Value: Boolean);
begin
  if Value <> FTaskDialogMetro then
  begin
     FTaskDialogMetro := Value;
     if Assigned(FClient.FormClient) then
        FClient.DoSetParentColor;
  end;
end;

procedure TaxCustomTaskDialog.SetText(const Value: string);
begin
  if Value <> FText then
     FText := Value;
end;

procedure TaxCustomTaskDialog.SetTitle(const Value: string);
begin
  if Value <> FTitle then
     FTitle := Value;
end;

procedure TaskShowMessage(const Msg: string);
var
TskDlg: TaxTaskDialog;
begin
   TskDlg := TaxTaskDialog.Create(nil);
   TskDlg.Title := 'Sistema Neski';
   TskDlg.Caption := Application.Title;
   TskDlg.Text    := Msg + sLineBreak + sLineBreak;;
   TskDlg.TextAutoSize := True;
   TskDlg.CommonButtons := [tcbOk];
   TskDlg.MainIcon := tdiInformation;
   TskDlg.MetroStyle.TaskDialogMetro := True;
   TskDlg.MetroStyle.FTaskDialogFontColor := clWindow;
   try
     TskDlg.Execute;
   finally
     TskDlg.Free;
     TskDlg := nil;
   end;
end;

procedure TaskShowAlert(const Title, Msg: string);
var
TskDlg: TaxTaskDialog;
begin
   TskDlg := TaxTaskDialog.Create(nil);
   TskDlg.MetroStyle.TaskDialogColor := $002100C6;
   TskDlg.TitleColor := $002100C6;
   TskDlg.TitleFont.Color := clWhite;
   TskDlg.TitleFont.Style := [fsBold];
   TskDlg.TitleFont.Size  := 14;
   TskDlg.Caption := Application.Title;
   TskDlg.Title   := Title;
   TskDlg.Text    := Msg; // + sLineBreak + sLineBreak;;
   TskDlg.TextWordWrap := True;
   TskDlg.CommonButtons := [tcbOk];
   TskDlg.MainIcon := tdiShield;
   try
     TskDlg.Execute;
   finally
     TskDlg.Free;
     TskDlg := nil;
   end;
end;

function TaskMessageBox(const Msg, Title: string; Buttons: TaxTaskDialogCommonButtons;
  Icon: TaxTaskDialogIcon): TModalResult;
var
TskDlg: TaxTaskDialog;
begin
   TskDlg := TaxTaskDialog.Create(nil);
   TskDlg.Caption := Title;
   TskDlg.Text    := Msg + sLineBreak + sLineBreak;
   TskDlg.TextAutoSize := True;
   TskDlg.CommonButtons := Buttons;
   TskDlg.MainIcon := Icon;
   TskDlg.MetroStyle.TaskDialogMetro := True;
   TskDlg.MetroStyle.FTaskDialogFontColor := clWindow;
   try
     Result := TskDlg.Execute;
   finally
     TskDlg.Free;
     TskDlg := nil;
   end;
end;

{ TaxTaskDialogProgressBar }

constructor TaxTaskDialogProgressBar.Create(AClient: TaxCustomTaskDialog);
begin
  inherited Create;
  FClient := AClient;
  FMax := 100;
  FMin := 0;
  FPosition := 0;
  FMarqueeInterval := 10;
  FState := pbsNormal;
end;

procedure TaxTaskDialogProgressBar.SetMarqueeInterval(const Value: Integer);
begin
  if Value <> FMarqueeInterval then
  begin
    FMarqueeInterval := Value;
  end;
end;

procedure TaxTaskDialogProgressBar.SetMax(const Value: Integer);
begin
  if Value <> FMax then
  begin
    if Value < FMin then
       raise EInvalidOperation.CreateFmt('%s property out of range', [Classname]);
    FMax := Value;
  end;
end;

procedure TaxTaskDialogProgressBar.SetMin(const Value: Integer);
begin
  if Value <> FMin then
  begin
    if Value > FMax then
       raise EInvalidOperation.CreateFmt('%s property out of range', [Classname]);
    FMin := Value;
  end;
end;

procedure TaxTaskDialogProgressBar.SetPosition(const Value: Integer);
begin
  if Value <> FPosition then
  begin
    if (Value < 0) or (Value > High(Word)) then
       raise Exception.CreateFmt('Value must be between %d and %d', [0, High(Word)]);
    FPosition := Value;
  end;
end;

procedure TaxTaskDialogProgressBar.SetState(const Value: TProgressBarState);
begin
  if Value <> FState then
  begin
    FState := Value;
  end;
end;

{ TaxTaskDialogComboBoxItem }

constructor TaxTaskDialogComboBoxItem.Create(ACollection: TCollection);
begin
  inherited;
end;

{ TaxRadioButton }

procedure TaxRadioButton.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if FSetCaption then
     Exit;
  FOriginalCaption := Caption;
end;

procedure TaxRadioButton.WMPaint(var msg: TWMPaint);
var
  LBtnWidth: Integer;
  LTxtHeight: Integer;
  LCanvas: TControlCanvas;
  LRect: TRect;
begin
  LBtnWidth := GetSystemMetrics(SM_CXMENUCHECK);
  LRect := ClientRect;

  FSetCaption := True;
  if not (csDesigning in ComponentState) then
     Caption := '';
  FSetCaption := False;
  inherited;
  LCanvas := TControlCanvas.Create;
  try
    LCanvas.Control := Self;
    LCanvas.Font := Font;
    LTxtHeight := LCanvas.TextHeight(FOriginalCaption);
    SetBkMode(LCanvas.Handle, Ord(TRANSPARENT));
    LCanvas.TextOut(LBtnWidth +2, Trunc(LRect.Bottom / 2) - Trunc(LTxtHeight / 2) -1, FOriginalCaption);
  finally
    LCanvas.Free;
  end;
end;

{ TaxCheckBox }

procedure TaxCheckBox.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if FSetCaption then
     Exit;
  FOriginalCaption := Caption;
end;

procedure TaxCheckBox.WMPaint(var msg: TWMPaint);
var
  LBtnWidth: Integer;
  LTxtHeight: Integer;
  LCanvas: TControlCanvas;
  LRect: TRect;
begin
  LBtnWidth := GetSystemMetrics(SM_CXMENUCHECK);
  LRect := ClientRect;

  FSetCaption := True;
  if not (csDesigning in ComponentState) then
     Caption := '';
  FSetCaption := False;
  inherited;
  LCanvas := TControlCanvas.Create;
  try
    LCanvas.Control := Self;
    LCanvas.Font := Font;
    LTxtHeight := LCanvas.TextHeight(FOriginalCaption);
    SetBkMode(LCanvas.Handle, Ord(TRANSPARENT));
    LCanvas.TextOut(LBtnWidth +2, Trunc(LRect.Bottom / 2) - Trunc(LTxtHeight / 2) -1, FOriginalCaption);
  finally
    LCanvas.Free;
  end;
end;

end.

