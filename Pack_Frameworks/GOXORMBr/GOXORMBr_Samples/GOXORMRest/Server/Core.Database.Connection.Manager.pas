unit Core.Database.Connection.Manager;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  System.StrUtils,
  //FireDac
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  {$IFDEF MSWINDOWS}
  FireDAC.VCLUI.Wait,
  {$ENDIF MSWINDOWS}
  FireDAC.ConsoleUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  Core.Logtxt;

type
  TDatabaseConnectionManager = class
  strict private
    { Private declarations }
  private
    FFDManager: TFDManager;
    FParams : TStrings;
    class var fInstance : TDatabaseConnectionManager;
    constructor CreatePrivate;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    class function Get: TDatabaseConnectionManager;
    //
    const POOLCONNECTIONNAME = 'GOXORM_POOL_CONN';
    function ManagerParams:String;
    //
    property FDManagerParams: TStrings read FParams write FParams;
  end;

implementation

{ TDatabaseConnectionManager }

constructor TDatabaseConnectionManager.Create;
begin
  raise Exception.Create('Para Obter uma Instância de '+Self.ClassName+', use Get');
end;

constructor TDatabaseConnectionManager.CreatePrivate;
begin
  try
    FFDManager := TFDManager.Create(nil);
    //
    FFDManager.Close;
    FParams := TStringList.Create;
    FParams.Add('Server=LOCALHOST\GOXCODE');
    FParams.Add('Database=GOXORM_DB');
    FParams.Add('User_Name=sa');
    FParams.Add('Password=Goxcode2042**');
    FParams.Add('LoginTimeout=60');
    FParams.Add('Encrypt=No');
    FParams.Add('Protocol=TCPIP');
    FParams.Add('Port=1433');
    FParams.Add('MARS=Yes');
    FParams.Add('MetaDefSchema=dbo');
    FParams.Add('MetaDefCatalog=Northwind');
    FParams.Add('PoolCleanupTimeout=10000');
    FParams.Add('PoolExpireTimeout=90000');
    FParams.Add('DriverID=MSSQL');
    //
    FFDManager.AddConnectionDef(POOLCONNECTIONNAME,'MSSQL',FParams);
    FFDManager.Open;
    FFDManager.ConnectionDefs.ConnectionDefByName(POOLCONNECTIONNAME).Params.Pooled := true;
    FFDManager.ConnectionDefs.ConnectionDefByName(POOLCONNECTIONNAME).Params.PoolMaximumItems := 6000;
  except on E: Exception do
    TLogTxt.Get.AddLog('Error Database:'+#13+E.Message);
  end;
end;

destructor TDatabaseConnectionManager.Destroy;
begin
  FParams.Free;
  FreeAndNil(FFDManager);
  inherited;
end;

class function TDatabaseConnectionManager.Get: TDatabaseConnectionManager;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := TDatabaseConnectionManager.CreatePrivate;
  end;
  Result := FInstance;
end;

function TDatabaseConnectionManager.ManagerParams: String;
begin
  Result := FDManager.ConnectionDefs.ConnectionDefByName(POOLCONNECTIONNAME).Params.Text;
end;

initialization
finalization
   if Assigned(TDatabaseConnectionManager.FInstance) then
     TDatabaseConnectionManager.FInstance.Free;

end.
