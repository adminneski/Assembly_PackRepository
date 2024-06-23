unit Core.Database.Connection;

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
  {$IFDEF MSWINDOWS}
  FireDAC.VCLUI.Wait,
  {$ENDIF MSWINDOWS}
  FireDAC.ConsoleUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Phys,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.ODBCDef,
  FireDAC.Phys.ODBC,
  //goxorm
  goxormbr.core.abstract.types,
  Core.Database.Connection.Manager,
  Core.Logtxt,
  goxormbr.engine.connection;


type
  TDatabaseConnection = class
  strict private
    { Private declarations }
  private
    FGOXDBConnection: TGOXDBConnectionEngine;
    FFDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    //
    FDatabase_ConnectionDef:String;
    FDatabase_Host:String;
    FDatabase_Port:Integer;
    FDatabase_Name:String;
    FDatabase_Login:String;
    FDatabase_Password:String;
    //
    property FDConnection: TGOXDBConnectionEngine read FGOXDBConnection write FGOXDBConnection;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    //
    function GetSQLSequence(ASequenceName: String): Int64;
    procedure ZeraSQLSequence(ASequenceName: String);
    //
    function GOXDBConnection:TGOXDBConnectionEngine;
  end;

implementation

{ TDatabaseConnection }

constructor TDatabaseConnection.Create;
begin
  inherited;
  try
    //Cria Componentes FDConnection
    FGOXDBConnection := TGOXDBConnectionEngine.Create(Nil,dnMSSQL);
    FFDPhysMSSQLDriverLink := TFDPhysMSSQLDriverLink.Create(Nil);
    //Config PhysDriveLink
    FFDPhysMSSQLDriverLink.DriverID := 'MSSQL';
    FFDPhysMSSQLDriverLink.ODBCDriver := 'ODBC Driver 17 for SQL Server';
    //Configura FDConnection
    FGOXDBConnection.Connected := False;
    FGOXDBConnection.ConnectionDefName :=  TDatabaseConnectionManager.Get.POOLCONNECTIONNAME;
    //
    FGOXDBConnection.FormatOptions.CheckPrecision := true;
    FGOXDBConnection.FormatOptions.MaxBcdPrecision := 38;
    FGOXDBConnection.FormatOptions.MaxBcdScale := 10;
    FGOXDBConnection.FormatOptions.OwnMapRules := True;
    //MapRules
    With FGOXDBConnection.FormatOptions do
    begin
      with MapRules.Add do
      begin
        ScaleMin := 2;
        ScaleMax := 10;
        PrecMin := 18;
        PrecMax := 38;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtDouble;
      end;
      with MapRules.Add do
      begin
        ScaleMin := 2;
        ScaleMax := 10;
        PrecMin := 18;
        PrecMax := 38;
        SourceDataType := dtBCD;
        TargetDataType := dtDouble;
      end;
      with MapRules.Add do
      begin
        ScaleMin := 2;
        ScaleMax := 4;
        PrecMin := 18;
        PrecMax := 38;
        SourceDataType := dtFmtBCD;
        TargetDataType := dtCurrency;
      end;
      with MapRules.Add do
      begin
        ScaleMin := 2;
        ScaleMax := 4;
        PrecMin := 18;
        PrecMax := 38;
        SourceDataType := dtBCD;
        TargetDataType := dtCurrency;
      end;
      with MapRules.Add do
      begin
        SourceDataType := dtDateTimeStamp;
        TargetDataType := dtDateTime;
      end;
    end;
    FGOXDBConnection.Connected := True;

    FDatabase_ConnectionDef := FGOXDBConnection.ResultConnectionDef.Params.ConnectionDef;
    FDatabase_Host          := FGOXDBConnection.ResultConnectionDef.Params.Values['server'];
    FDatabase_Name          := FGOXDBConnection.ResultConnectionDef.Params.Values['database'];
    FDatabase_Login         := FGOXDBConnection.ResultConnectionDef.Params.Values['username'];
    FDatabase_Password      := FGOXDBConnection.ResultConnectionDef.Params.Values['password'];


  Except on E: Exception do
   TLogTxt.Get.AddLog('FireDAC - Falha TDatabaseConnection: [ '+FDatabase_Host+','+FDatabase_Port.ToString+':'+FDatabase_Name+' ].'+#13+E.Message);
  end;
  //
//  //Cria Conexão GOXORM
//  if (FGOXDBConnection.Connected)then
//  begin
//    raise Exception.Create('conectou');
//  end;
end;


function TDatabaseConnection.GetSQLSequence(ASequenceName: String): Int64;
//var
////  oDBRSet : IDBResultSet;
//  LQuery : TFDQuery;
//  LSQL : String;
begin
//   Result := -1;
//   try
//     LSQL:= 'SELECT NEXT VALUE FOR '+ASequenceName+' AS SEQUENCE';
//     //
//     LQuery := TFDQuery.Create(nil);
//     LQuery.Connection := FDConnection;
//     LQuery.Open(LSQL);
//     if LQuery.RecordCount > 0 then
//       Result := LQuery.FieldByName('SEQUENCE').AsLargeInt;
//     FreeAndNil(LQuery);
//
//
//
//
//
////   try
////     LSQL:= 'SELECT NEXT VALUE FOR '+ASequenceName+' AS SEQUENCE';
////     //
////     oDBRSet := ORMBrFD.CreateResultSet(LSQL);
////     //
////     if oDBRSet.RecordCount > 0 then
////     begin
////       Result := oDBRSet.GetFieldValue('SEQUENCE');
////     end;
//  except on E: Exception do
//    TLogTxt.Get.AddLog('GetSQLSequence ::: '+E.Message);
//  end;
end;

function TDatabaseConnection.GOXDBConnection: TGOXDBConnectionEngine;
begin
  Result := FGOXDBConnection;
end;

procedure TDatabaseConnection.ZeraSQLSequence(ASequenceName: String);
begin
//  ORMBrFD.ExecuteDirect('ALTER SEQUENCE '+ASequenceName+' RESTART WITH 1');
end;

destructor TDatabaseConnection.Destroy;
begin
  FGOXDBConnection.Close;
  FreeAndNil(FFDPhysMSSQLDriverLink);
  FreeAndNil(FGOXDBConnection);
  inherited;
end;

initialization
finalization

end.
