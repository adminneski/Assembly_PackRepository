unit Gobt_BoxTitle;

interface

uses
  Vcl.ComCtrls, Vcl.Graphics, System.Classes, Vcl.Controls,
  Winapi.Messages, System.Types, Vcl.ExtCtrls, System.SysUtils, Vcl.StdCtrls,
  Vcl.Dialogs;

type

  TGoBoxTitle = class(TPanel)
  private
    FTitlePanel: TPanel;
    FTitle: String;
    FTitleColor : TColor;
    FTitleFont : TFont;
    FTitleParentBackground : Boolean;
    FFlowPanelActive : Boolean;

    FFlowPanel : TFlowPanel;
    function GetFlowPanelActive: Boolean;
    procedure SetFlowPanelActive(const Value: Boolean);
    procedure CreateFlowPanel(AActive :Boolean);
    procedure OnResize(Sender: TObject);

  protected
  public
    { Public declarations }
    FlowPanel : TFlowPanel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    property Title: String read FTitle write FTitle;
    property TitleColor: TColor read FTitleColor write FTitleColor;
    property TitleFont: TFont read FTitleFont write FTitleFont;
    property TitleParentBackground: Boolean read FTitleParentBackground write FTitleParentBackground;
    property FlowActive: Boolean read GetFlowPanelActive write SetFlowPanelActive;
  end;

implementation


function AdjustedAlignment(RightToLeftAlignment: Boolean; Alignment: TAlignment): TAlignment;
begin
  Result := Alignment;
  if RightToLeftAlignment then
    case Result of
      taLeftJustify: Result := taRightJustify;
      taRightJustify: Result := taLeftJustify;
    end;
end;

{ TGoBoxTitle }
constructor TGoBoxTitle.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BevelOuter := bvNone;
  Width := 500;
  Height := 150;
  Caption := Self.Name;
  FTitleParentBackground := True;
  //
  FTitlePanel := TPanel.Create(Self);
  FTitlePanel.Parent := Self;
  FTitlePanel.Align := alTop;
  FTitlePanel.AlignWithMargins := False;
  FTitlePanel.Alignment := taLeftJustify;
  FTitlePanel.BevelOuter := bvNone;
  FTitlePanel.Font.Size := 10;
  FTitlePanel.Height := 30;
  FTitlePanel.Padding.Bottom := 3;
  FTitlePanel.ParentBackground := FTitleParentBackground;

  //
  FTitle := 'Title';
  FTitleColor := clWhite;
  FTitleFont := TFont.Create;
  FTitleFont.Size := 12;
  FTitleFont.Name := 'Arial';
  //
  FFlowPanelActive := false;
end;


procedure TGoBoxTitle.CreateFlowPanel(AActive: Boolean);
begin
  if AActive = true then
  begin
    if not Assigned(FlowPanel) then
    begin
       FlowPanel := TFlowPanel.Create(Self);
       FlowPanel.Parent      := Self;
       FlowPanel.Align       := alTop;
       FlowPanel.BevelOuter  := bvNone;
       FlowPanel.AutoSize    := false;
       FlowPanel.Caption     := '';
       FlowPanel.FlowStyle   := fsTopBottomLeftRight;
       FlowPanel.TabStop     := False;
       FlowPanel.Width       := Self.Width;
       FlowPanel.OnResize    := OnResize;
    end;
  end
  else
  begin
    if Assigned(FlowPanel) then
     FreeAndNil(FlowPanel);
    Self.Height := 150;
  end;
end;

destructor TGoBoxTitle.Destroy;
begin
  FreeAndNil(FTitleFont);
  FreeAndNil(FTitlePanel);
  inherited;
end;

function TGoBoxTitle.getFlowPanelActive: Boolean;
begin
  Result := FFlowPanelActive;
  CreateFlowPanel(FFlowPanelActive);
end;


procedure TGoBoxTitle.OnResize(Sender: TObject);
begin
  Self.Height := FlowPanel.Height;
end;

procedure TGoBoxTitle.Paint;
begin
  inherited;
  FTitlePanel.Caption := FTitle;
  FTitlePanel.Color := FTitleColor;
  FTitlePanel.Font := FTitleFont;
end;

procedure TGoBoxTitle.SetFlowPanelActive(const Value: Boolean);
begin
  FFlowPanelActive := Value;
  CreateFlowPanel(FFlowPanelActive);
end;

end.
