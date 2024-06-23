unit Narte_DBNavigator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Gobt_ButtonAdvanced, System.ImageList, Vcl.ImgList;

type
  TFrameDBNavigator = class(TFrame)
    DataSourceNAV: TDataSource;
    btnInsert: TGoButtonAdvanced;
    btnEdit: TGoButtonAdvanced;
    btnDelete: TGoButtonAdvanced;
    btnPost: TGoButtonAdvanced;
    btnCancel: TGoButtonAdvanced;
    IMG32X32: TImageList;
    IMG32X32Disable: TImageList;
    IMG32X32Hot: TImageList;
    procedure DataSourceNAVStateChange(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FShowCaption: Boolean;
    procedure SetShowCaption(const Value: Boolean);
    { Private declarations }
  published
  { published declarations }
    property ShowCaption: Boolean read FShowCaption write SetShowCaption;
    property DataSource : TDataSource read DataSourceNAV write DataSourceNAV;


    property ButtonInsert : TGoButtonAdvanced read btnInsert write btnInsert;
    property ButtonEdit   : TGoButtonAdvanced read btnEdit   write btnEdit;
    property ButtonDelete : TGoButtonAdvanced read btnDelete write btnDelete;
    property ButtonPost   : TGoButtonAdvanced read btnPost   write btnPost;
    property ButtonCancel : TGoButtonAdvanced read btnCancel write btnCancel;


  public
    { Public declarations }
   constructor Create(AOwner: TComponent); override;

  end;

implementation

{$R *.dfm}

{ TFrameDBNavigator }

procedure TFrameDBNavigator.btnCancelClick(Sender: TObject);
begin
  DataSourceNAV.DataSet.Cancel;
end;

procedure TFrameDBNavigator.btnDeleteClick(Sender: TObject);
begin
  if DataSourceNAV.DataSet.RecordCount > 0 then
  DataSourceNAV.DataSet.Delete;
end;

procedure TFrameDBNavigator.btnEditClick(Sender: TObject);
begin
  if DataSourceNAV.DataSet.RecordCount > 0 then
  DataSourceNAV.DataSet.Edit;
end;

procedure TFrameDBNavigator.btnInsertClick(Sender: TObject);
begin
  DataSourceNAV.DataSet.Append;
end;

procedure TFrameDBNavigator.btnPostClick(Sender: TObject);
begin
  DataSourceNAV.DataSet.Post;
end;

constructor TFrameDBNavigator.Create(AOwner: TComponent);
begin
  inherited;
  DataSourceNAV.SetSubComponent(True);
  btnInsert.SetSubComponent(True);
  btnEdit.SetSubComponent(True);
  btnDelete.SetSubComponent(True);
  btnPost.SetSubComponent(True);
  btnCancel.SetSubComponent(True);
end;

procedure TFrameDBNavigator.DataSourceNAVStateChange(Sender: TObject);
begin
  if DataSourceNAV.DataSet.State in [dsInsert,dsEdit] then
  begin
    btnInsert.Enabled := false;
    btnEdit.Enabled := false;
    btnDelete.Enabled := false;
    btnPost.Enabled := true;
    btnCancel.Enabled := true;
  end
  else
  begin
    btnInsert.Enabled := true;
    btnEdit.Enabled := True;
    btnDelete.Enabled := True;
    btnPost.Enabled := false;
    btnCancel.Enabled := false;
  end;
end;

procedure TFrameDBNavigator.SetShowCaption(const Value: Boolean);
begin
  FShowCaption := Value;
  btnInsert.ShowCaption := FShowCaption;
  btnEdit.ShowCaption   := FShowCaption;
  btnDelete.ShowCaption := FShowCaption;
  btnPost.ShowCaption   := FShowCaption;
  btnCancel.ShowCaption := FShowCaption;
end;

end.
