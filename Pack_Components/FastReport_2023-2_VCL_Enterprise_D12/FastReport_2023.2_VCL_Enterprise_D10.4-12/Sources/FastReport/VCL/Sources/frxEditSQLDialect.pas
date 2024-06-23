
{******************************************}
{                                          }
{             FastReport VCL               }
{               SQL editor                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditSQLDialect;

interface

{$I frx.inc}

uses
  SysUtils,
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ToolWin, frxSynMemo,
  frxBaseForm, frxInsp
  {$IFDEF FPC}
  , LResources, LCLType
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
  TfrxSQLDialectForm = class(TfrxBaseLoadSavePrefForm)
    PnTree: TPanel;
    TVStyles: TTreeView;
    ToolBar: TToolBar;
    TBNewDialect: TToolButton;
    TBNewStyle: TToolButton;
    Splitter1: TSplitter;
    TBDelete: TToolButton;
    PnInsp: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure TBNewDialectClick(Sender: TObject);
    procedure TBNewStyleClick(Sender: TObject);
    procedure TVStylesChange(Sender: TObject; Node: TTreeNode);
    procedure TVStylesEdited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure TBDeleteClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    FInspector: TfrxObjectInspector;
    FSynDialectStyles: TfrxSynDialectStyles;
    procedure FillDialects;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    property SynDialectStyles: TfrxSynDialectStyles read FSynDialectStyles write FSynDialectStyles;
  end;


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses frxClass, frxRes, frxEditQueryParams;


constructor TfrxSQLDialectForm.Create(AOwner: TComponent);
begin
  inherited;
  FInspector := TfrxObjectInspector.Create(Owner.Owner);
  with FInspector do
  begin
    SplitterPos := PnInsp.Width div 2;
    Box.Parent := PnInsp;
    Box.Align := alClient;
    UpdateFormPPI(CurrentFormPPI);
  end;
  OnMouseWheelDown := FInspector.FormMouseWheelDown;
  OnMouseWheelUp := FInspector.FormMouseWheelUp;
end;

procedure TfrxSQLDialectForm.FillDialects;
var
  i, j: Integer;
  Node: TTreeNode;
begin
  TVStyles.Items.Clear;
  TVStyles.Items.BeginUpdate;
  for i := 0 to SynDialectStyles.Count - 1 do
  begin
    Node := TVStyles.Items.AddChild(nil, SynDialectStyles[i].Name);
    Node.Data := SynDialectStyles[i];
    for j := 0 to SynDialectStyles[i].AttributeStyles.Count - 1 do
      TVStyles.Items.AddChild(Node, 'Style.' + IntToStr(j)).Data := SynDialectStyles[i].AttributeStyles.Items[j];
    Node.Expand(True);
  end;
  TVStyles.Items.EndUpdate;
end;

procedure TfrxSQLDialectForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxSQLDialectForm.FormHide(Sender: TObject);
begin
  FInspector.FormDeactivate(nil);
end;

procedure TfrxSQLDialectForm.FormShow(Sender: TObject);
begin
  FillDialects;
end;

procedure TfrxSQLDialectForm.TBDeleteClick(Sender: TObject);
var
  SelNode: TTreeNode;
begin
  SelNode := TVStyles.Selected;
  if SelNode = nil then Exit;
  TVStyles.Items.BeginUpdate;
  TObject(SelNode.Data).Free;
  TVStyles.Items.Delete(SelNode);
  TVStyles.Items.EndUpdate;
  if TVStyles.Selected = nil then
    FInspector.Inspect([nil]);
end;

procedure TfrxSQLDialectForm.TBNewDialectClick(Sender: TObject);
begin
  SynDialectStyles.Add.Name := 'SQL.Custom.' + IntToStr(SynDialectStyles.Count);
  FillDialects;
end;

procedure TfrxSQLDialectForm.TBNewStyleClick(Sender: TObject);
var
  SelNode: TTreeNode;
  Attr: TfrxAttributeStyles;
begin
  SelNode := TVStyles.Selected;
  if SelNode = nil then Exit;
  Attr := nil;
  if TObject(SelNode.Data) is TfrxSynDialectStyle then
    Attr := TfrxSynDialectStyle(SelNode.Data).AttributeStyles
  else if TObject(SelNode.Data) is TfrxAttributeStyle then
    Attr := TfrxAttributeStyles(TfrxAttributeStyle(SelNode.Data).Collection);

  if Attr = nil then Exit;
  Attr.Add;
  FillDialects;
end;

procedure TfrxSQLDialectForm.TVStylesChange(Sender: TObject; Node: TTreeNode);
begin
  if (Node <> nil) and (Node.Data <> nil) then
    FInspector.Inspect([TPersistent(Node.Data)])
  else
    FInspector.Inspect([nil]);
end;

procedure TfrxSQLDialectForm.TVStylesEdited(Sender: TObject; Node: TTreeNode;
  var S: string);
begin
  if TObject(Node.Data) is TfrxSynDialectStyle then
    TfrxSynDialectStyle(Node.Data).Name := S;
end;

procedure TfrxSQLDialectForm.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = vk_Return) and (ssCtrl in Shift) then
    ModalResult := mrOk
  else if Key = vk_Escape then
    ModalResult := mrCancel
  else if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxSQLDialectForm.UpdateFormPPI(aNewPPI: Integer);
{$IFDEF FPC}
var
  i: Integer;
{$ENDIF}
begin
  inherited;
  ToolBar.Images := frxImages.MainButtonImages;
{$IFDEF FPC}
  Toolbar.ImagesWidth := Toolbar.Images.Width;
  for i := 0 to ToolBar.ButtonCount - 1 do
    ToolBar.Buttons[i].AutoSize:= true;
{$ENDIF}
  Toolbar.ButtonWidth := 0;
  Toolbar.ButtonHeight := 0;
  FInspector.SendPPIMessage(FInspector, aNewPPI);
end;

procedure TfrxSQLDialectForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(6701);
  TBNewDialect.Hint := frxGet(6702);
  TBNewStyle.Hint := frxGet(6703);
  TBDelete.Hint := frxGet(6704);
end;

end.

