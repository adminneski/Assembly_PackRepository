unit frxSearchForm;

{$I frx.inc}

interface

uses
  {$IFDEF FPC}
  LCLIntf, LCLType, LMessages,
  {$ENDIF}
  {$IFNDEF FPC}
  Windows,
  {$ENDIF}
   Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, frxBaseForm, frxRes;

type

  { TfrxSearchForm }

{$IFNDEF FPC}
  TTView = class(TTreeView)
    procedure WM_MouseWheel(var Msg: TWMMouseWheel); message WM_MouseWheel; //TWMMouseWheel
  end;
{$ENDIF}

  TfrxSearchForm = class(TfrxBaseForm)
    pnlSearch: TPanel;
    edtFind: TEdit;
    lblFind: TLabel;
    btnFind: TButton;
    gbSearch: TGroupBox;
    chkBeg: TCheckBox;
    chkCase: TCheckBox;
    chkFindAll: TCheckBox;
{$IFDEF  FPC}
    procedure chkFindAllChange(Sender: TObject);
{$ELSE}
    procedure chkFindAllClick(Sender: TObject);
{$ENDIF}
    procedure edtFindKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    trvFind: {$IFNDEF FPC}TTView{$ELSE}TTreeView{$ENDIF};
    destructor Destroy; override;
    procedure UpdateResouces; override;
    procedure CleartrvFind();
  end;

//var
//  frxSearchForm: TfrxSearchForm;

const
  EventScrollFind = High(SmallInt);

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}
uses frxPreview;

{$IFNDEF FPC}
procedure TTView.WM_MouseWheel(var Msg: TWMMouseWheel);
begin
  Msg.XPos := EventScrollFind;
  Msg.YPos := EventScrollFind;
  Inherited;
end;
{$ENDIF}

{$IFDEF FPC}
procedure TfrxSearchForm.chkFindAllChange(Sender: TObject);
{$ELSE}
procedure TfrxSearchForm.chkFindAllClick(Sender: TObject);
{$ENDIF}
begin
  //CleartrvFind();
  trvFind.Visible := chkFindAll.Checked;
end;


  procedure TfrxSearchForm.UpdateResouces;
  begin
    inherited;
    lblFind.Caption := frxGet(301);
    chkCase.Caption := frxGet(305);
    btnFind.Caption := frxGet(300);
    chkBeg.Caption := frxGet(304);
    gbSearch.Caption := frxGet(302);
    chkFindAll.Caption := frxGet(306);
  end;

{procedure TfrxSearchForm.edtFindEnter(Sender: TObject);
begin
  if Self.Parent.Parent is TfrxPreviewForm then
    begin
      CopyShortCut := TfrxPreviewForm(Self.Parent.Parent).CopyCmd.ShortCut;
      TfrxPreviewForm(Self.Parent.Parent).CopyCmd.ShortCut := 0;
      PasteShortCut := TfrxPreviewForm(Self.Parent.Parent).PasteCmd.ShortCut;
      TfrxPreviewForm(Self.Parent.Parent).PasteCmd.ShortCut := 0;
    end;
end;

procedure TfrxSearchForm.edtFindExit(Sender: TObject);
begin
  if Self.Parent.Parent is TfrxPreviewForm then
    begin
      TfrxPreviewForm(Self.Parent.Parent).CopyCmd.ShortCut := CopyShortCut;
      TfrxPreviewForm(Self.Parent.Parent).PasteCmd.ShortCut := PasteShortCut;
    end;
end; }

procedure TfrxSearchForm.edtFindKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then btnFind.OnClick(nil);
end;

procedure TfrxSearchForm.FormCreate(Sender: TObject);
begin
    trvFind := {$IFNDEF FPC}TTView.Create(nil){$ELSE}TTreeView.Create(nil){$ENDIF};
    with trvFind do
      begin
        Parent := Self;
        Left := 0;
        Top := pnlSearch.Height;
        Width := pnlSearch.Width;
        Height := 231;
        Align := alClient;
        AutoExpand := True;
        Indent := 19;
        TabOrder := 1;
        Visible := False;
      end;
end;

destructor TfrxSearchForm.Destroy;
begin
  FreeAndNil(trvFind);
  inherited;
end;

procedure TfrxSearchForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ssCtrl in Shift then
    begin
      if Self.Parent.Parent is TfrxPreviewForm then
        begin
          TfrxPreviewForm(Self.Parent.Parent).CopyCmd.ShortCut := 0;
          TfrxPreviewForm(Self.Parent.Parent).PasteCmd.ShortCut := 0;
        end;
      if Key = Ord('F') then
        begin
           if Self.Parent.Parent is TfrxPreviewForm then
             TfrxPreviewForm(Self.Parent.Parent).FindB.Down := False;
           TfrxPreview(Self.Parent).FindFmVisible := False;
           Hide;
           TfrxPreview(Self.Parent).SetFocus;
        end;
    end;
end;

procedure TfrxSearchForm.FormShow(Sender: TObject);
begin
  edtFind.SetFocus;
  edtFind.SelectAll;
end;

procedure TfrxSearchForm.CleartrvFind();
var
  i: Integer;
  data: PfrxTrvData;
begin
  for i := 0 to trvFind.Items.Count - 1 do
  begin
    data := trvFind.Items[i].Data;
    if data <> nil then
      Dispose(data);
  end;
  trvFind.Items.Clear();
end;

end.
