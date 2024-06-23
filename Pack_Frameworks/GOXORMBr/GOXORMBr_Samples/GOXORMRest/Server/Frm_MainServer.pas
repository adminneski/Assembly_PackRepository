unit Frm_MainServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,  Vcl.ExtCtrls,
  // WiRL units
  JOSE.Core.JWA,
  WiRL.Configuration.Core,
  WiRL.Configuration.Auth,
  WiRL.Configuration.JWT,
  WiRL.Configuration.Neon,
  WiRL.http.Server,
  WiRL.http.Server.Indy,
  WiRL.Core.Engine,
  WiRL.Core.Application,
  WiRL.Core.MessageBodyReader,
  WiRL.Core.MessageBodyWriter,
  WiRL.http.Filters,
  WiRL.Core.Registry,
  WiRL.Core.Converter,
  WiRL.Configuration.Converter,
  //
  Core.Database.Connection.Manager,
  System.TypInfo,
  Neon.Core.Types,
  Core.Server.TokenClaim;

type
  TFrmMainServer = class(TForm)
    Panel1: TPanel;
    btnStart: TButton;
    btnStop: TButton;
    EdtPort: TEdit;
    Label1: TLabel;
    Shape_ServerStatus: TShape;
    Log: TMemo;
    Shape_DatabaseStatus: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Params: TMemo;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FServer: TWiRLServer;
    procedure ServerStatus(AActive:Boolean);
    procedure DatabaseStatus(AActive:Boolean);
  public
    { Public declarations }
  end;

var
  FrmMainServer: TFrmMainServer;

implementation



{$R *.dfm}

procedure TFrmMainServer.btnStartClick(Sender: TObject);
var
  LSecret : String;
//  LSession : ISessionServer;
begin
  try
    FServer.Active := true;
    //FSession.DatabaseConnection.FDConnection.Connected := true;
    //
    ServerStatus(FServer.Active);

//    LSession := TSessionServer.New(;
//    DatabaseStatus(LSession.DatabaseConnection.FDConnection.Connected);
    //
  Except on E: Exception do
    ShowMessage(e.Message);
  End;
end;

procedure TFrmMainServer.btnStopClick(Sender: TObject);
begin
  try
    FServer.Active := false;
    //FSession.DatabaseConnection.FDConnection.Connected := false;
    //
    ServerStatus(FServer.Active);

    Params.Lines.Clear;
  Except on E: Exception do
    ShowMessage(e.Message);
  End;
end;

procedure TFrmMainServer.DatabaseStatus(AActive: Boolean);
begin
  Params.Lines.Clear;
  Params.Lines.Text := TDatabaseConnectionManager.Get.ManagerParams;
  if FServer.Active then
  begin
    Shape_DatabaseStatus.Brush.Color := clGreen;
    btnStart.Enabled := false;
    btnStop.Enabled  := true;
  end
  else
  begin
    Shape_DatabaseStatus.Brush.Color := clRed;
    btnStart.Enabled := true;
    btnStop.Enabled  := false;
  end;

end;

procedure TFrmMainServer.FormActivate(Sender: TObject);
begin
   Self.Top := 10;
   Self.Left := 10;
   btnStart.Click;
end;

procedure TFrmMainServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FrmMainServer.Log.Lines.SaveToFile('C:\Temp\logerror.txt');
  if FServer.Active then
  btnStop.Click;
end;

procedure TFrmMainServer.FormCreate(Sender: TObject);
var
  LSecret : String;
begin
  Try
    //
    LSecret := '{CAE86A78-D9A5-43CA-9F97-200654072521}';
    //
    // Server & Apps configuration
    FServer := TWiRLServer.Create(nil);
    FServer
      .SetPort(StrToIntDef(EdtPort.Text,8080))
      .SetThreadPoolSize(1000)
     // Engine configuration
     .AddEngine<TWiRLEngine>('rest')
       .SetEngineName('Rest Service')
     // App base configuration
     .AddApplication('api')
       .SetAppName('Rest App')
       .SetFilters(['*'])
       .SetResources(['*'])
       .SetWriters('*.*')
       .SetReaders('*.*')
     //
//     .Plugin.Configure<IWiRLFormatSetting>
//       .AddFormat(TypeInfo(TDateTime), TWiRLFormatSetting.ISODATE_UTF)
//       .BackToApp
//     //
//     .Plugin.Configure<IWiRLConfigurationNeon>
//      .SetUseUTCDate(True)
//      .SetVisibility([mvPublic, mvPublished])
//      .SetMemberCase(TNeonCase.PascalCase)
     // Auth configuration (App plugin configuration)
     .Plugin.Configure<IWiRLConfigurationAuth>
       .SetTokenType(TAuthTokenType.JWT)
       .SetTokenLocation(TAuthTokenLocation.Bearer)
       .BackToApp
     // JWT configuration (App plugin configuration)
     .Plugin.Configure<IWiRLConfigurationJWT>
       .SetClaimClass(TKernelServerTokenClaim)
       .SetAlgorithm(TJOSEAlgorithmId.HS256)
       .SetSecret(TEncoding.UTF8.GetBytes(LSecret));

  Except on E: Exception do
    ShowMessage(e.Message);
  End;
end;

procedure TFrmMainServer.FormDestroy(Sender: TObject);
begin
  FrmMainServer.Log.Lines.SaveToFile('C:\Temp\logerror.txt');
  FreeAndNil(FServer);
end;

procedure TFrmMainServer.FormShow(Sender: TObject);
begin
  btnStop.Click;
end;

procedure TFrmMainServer.ServerStatus(AActive: Boolean);
begin
  if FServer.Active then
  begin
    Shape_ServerStatus.Brush.Color := clGreen;
    btnStart.Enabled := false;
    btnStop.Enabled  := true;
  end
  else
  begin
    Shape_ServerStatus.Brush.Color := clRed;
    btnStart.Enabled := true;
    btnStop.Enabled  := false;
  end;
end;

procedure TFrmMainServer.Timer1Timer(Sender: TObject);
begin
//  Label4.Caption :=   TResolveDBConnection.Get.ConnCount.ToString
end;

end.
