unit Frm_MainClient;

interface

uses
  REST.Json,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Dtm_MainClient, Vcl.Samples.Gauges,
  Vcl.StdCtrls, WiRL.Client.Application, System.Net.HttpClient.Win, WiRL.http.Client, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TFrmMainClient = class(TForm)
    Gauge: TGauge;
    Panel1: TPanel;
    Panel2: TPanel;
    btnSelectALL: TButton;
    Button4: TButton;
    PageControl1: TPageControl;
    TabSheet_DataSet: TTabSheet;
    TabSheet_ObjectSet: TTabSheet;
    DataSource1: TDataSource;
    Memo1: TMemo;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGrid2: TDBGrid;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    Button2: TButton;
    Button1: TButton;
    pnLength: TPanel;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnSelectALLClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    FDtmMainClient : TDtmMainClient;
  public
    { Public declarations }
    property Dtm: TDtmMainClient read FDtmMainClient write FDtmMainClient;
  end;

var
  FrmMainClient: TFrmMainClient;

implementation

{$R *.dfm}

procedure TFrmMainClient.btnSelectALLClick(Sender: TObject);
begin
  Dtm.Contacts_SelectALL_DataSet;
end;

procedure TFrmMainClient.Button1Click(Sender: TObject);
begin
  Dtm.Contacts_Incluir_Dataset1000;
end;

procedure TFrmMainClient.Button2Click(Sender: TObject);
begin
  Dtm.Contacts_Incluir_Dataset100;
end;

procedure TFrmMainClient.Button3Click(Sender: TObject);
begin
  Dtm.Contacts_SelectALL_ObjectSet;
end;

procedure TFrmMainClient.Button4Click(Sender: TObject);
begin
  Dtm.Contacts_FindFrom;
end;

procedure TFrmMainClient.FormCreate(Sender: TObject);
begin
  FDtmMainClient := TDtmMainClient.Create(Self);
end;

procedure TFrmMainClient.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDtmMainClient);
end;

end.
