unit Dtm_MigrationExpress;

interface

uses
  System.Classes
  ,FireDAC.Stan.Intf
  ,FireDAC.Stan.Option
  ,FireDAC.Stan.Error
  ,FireDAC.UI.Intf
  ,FireDAC.Phys.Intf
  ,FireDAC.Stan.Def
  ,FireDAC.Stan.Pool
  ,FireDAC.Stan.Async
  ,FireDAC.Phys
  ,FireDAC.Phys.MSSQL
  ,FireDAC.Phys.MSSQLDef
  ,FireDAC.VCLUI.Wait
  ,FireDAC.Phys.ODBCBase
  ,Data.DB
  ,FireDAC.Comp.Client
  ,FireDAC.Stan.Param
  ,FireDAC.DatS
  ,FireDAC.DApt.Intf
  ,FireDAC.DApt
  ,FireDAC.Comp.DataSet
  ,Vcl.StdCtrls
  ,Winapi.ShellAPI
  ,Vcl.Controls
  ,Vcl.Graphics

  // Uses para o ObjectList
  ,System.Generics.Collections

  // Uses para NumberBox
  ,Vcl.NumberBox

  // Uses para o Gauge
  ,Vcl.Samples.Gauges

  // MessageBox
  ,Vcl.Forms

  // Flags MessageBox
  ,Winapi.Windows

  // Uses para Timer
  ,Vcl.ExtCtrls

  // Uses para DirectoryListBox
  ,Vcl.FileCtrl


  // Conexao REST Neski_AUTHENTICATOR
//  ,Kernel.REST.Connection

  // Controller do ORMbr - AUTHENTICATOR REST

  // DTO da tabela Company Authenticator
//  ,Dto.COMPANYSimple

  // Json para Comunicação REST
  ,System.JSON

  // Codificar em MD5 a Senha
  ,Tools.Collections.Methods

  //MigrationExpress
  ,Core.Query
  ,Core.Register
  ,Model.Base

  // Colocado este uses para baixo pois estava conflitando com procedimento dentro do WinAPI.Windows
  // carrecando unit por ultimo ela fica como "Default" na busca do procedimento FindClose.
  ,System.SysUtils
  ,Vcl.Dialogs
  ,goxormbr.manager.objectset
  ,goxormbr.engine.connection
  ,goxormbr.core.types
  ,Core.Server.RESTConnection, Dto.COMPANY;

type
  TDtmMigrationExpress = class(TDataModule)
    MSSQLDriverLink: TFDPhysMSSQLDriverLink;
    FIL_00: TFDQuery;
    FIL_00FIL_CODIGO: TStringField;
    FIL_00COM_CODIGO: TIntegerField;
    FIL_00FIL_CNPJ: TStringField;
    FIL_00FIL_RAZAO: TStringField;
    FIL_00FIL_FANTASIA_OU_APELIDO: TStringField;
    FIL_00FIL_IE: TStringField;
    FIL_00UFS_SIGLA: TStringField;
    FIL_00FIL_DESATIVADO: TStringField;
    FIL_00FIL_SELECIONADO: TStringField;
    dtsFIL_00: TDataSource;
    TABLES: TFDQuery;
    SQLCorrige: TFDQuery;
    SQL_EXE: TFDQuery;
    FDQueryDestino: TFDQuery;
    FDQueryOrigem: TFDQuery;

    procedure FIL_00AfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }
    FControllerAUTHENTICATOR: TGOXManagerObjectSetRest;
    function CreateBodyAuthenticate(AUserName,APassword: String; AACC_CODIGO, ACOM_CODIGO: Integer): String;
    procedure AcertoCGA01_VinculacaoPDAemFAT;
  public
    { Public declarations }
    ConnectionOrigem, ConnectionDestino: TGOXDBConnectionEngine;
    FDQuery_VALORCOLUNA : TFDQuery;

    vCancelarLoop: Boolean;

    var NumeroRegistro : Integer;
    var LTempo : TTime;

    function ConectarOrigem(AServer,ASenha,ADatabase: String): boolean;
    function ConectarDestino(AServer,ASenha,ADatabase: String): boolean;

    function MessageDlgPosColor(const Msg: string; ATitle : String; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
    const HelpFileName: string; AColor, AColorFont : TColor): Integer;
    function MessageDlgColor(const Msg: string; ATitle : String; DlgType: TMsgDlgType;
      Buttons: TMsgDlgButtons; AColor, AColorFont : TColor): Integer;

    procedure AddComCodigoFilSelecionado_FIL00;
    procedure UpdateValorTodosCampos_ComCodigo(AProgressBar: TGauge; AFilCodigoOrigem, AComCodigoDestino : Integer; ALabelTabela : TLabel);
    procedure AlteracaoComCodigoAutomatico(AProgressBar: TGauge; AOrigem, ADestino : TNumberBox; ALabelTabela : TLabel);

    function VerificaCamposNOTNULLBanco(Column, Table : string) : Boolean;
    function RemoveChar(const pTexto: String; pEvento: Integer): String;

    function ValidaERPAtualizado(AVersionERP : Integer): Boolean;

    procedure AjustesAntes;
    procedure DeletandoForeignKeys;
    procedure DeletandoPrimaryKeys;
    procedure ExcluirIndicesExpress;
    procedure AcertosBaseExpress_Destino;
    procedure CriarCamposInexistentesExpress;
    procedure CriarCamposIntegracaoMovimentosSaida;
    procedure CriarCamposParaUnificacaoDEV_00NaOMF_00;
    procedure CriarNovosCamposDeConfiguracaoSetup;
    procedure CriarCampoComComCodigoEmTabelasDeCadastros;
    procedure AcertosBaseERP_Origem;

    procedure AjustesDepois;
    procedure AcertoID_SubTabelasOMF;
    procedure AcertoID_SubTabelasFAT;
    procedure AcertoID_IntegracoesOMF;
    procedure AcertoID_IntegracoesFAT;
    procedure AcertoCGA_01_VinculacaoPDAemFAT;
    procedure AcertoSequenciaNumOrcamentoFAT;
    procedure AcertoHistoricoPadraoReferenteMovOMF;
    procedure AcertoHistoricoPadraoReferenteMovFAT;
    procedure AcertoHistoricoPadraoReferenteMovPDA;
    procedure UpdatePedidoCompraZerado;
    procedure UpdatesCaminhosPastasNovasExpress;
    procedure AcertoCodigosTabelaCOD;
    procedure DeletarSequences;
    procedure DeletarCamposOLDAposConversao;

    procedure ExecutarConversao(AlblHoraInicio, AlblHoraFinal, AlblTempo, AlblTempoProcessamento, AlblTabelaAtual, AlblFuncao : TLabel;
  AGListCopyDataSet : TStringList; AlstTempoTabela : TListBox; AGaugeConversao, AGaugeWhile : TGauge; ATimerProcesamentoTabela : TTimer;
  AlblRowCopyRecord, AlblTotalRowCopyRecord : TLabel);

    procedure AbrirBackup;

    procedure FileSearch(const PathName, FileName : string; const InDir : boolean; pItems:TStrings);

    procedure UpdateXML_00(ALabelQuantidade , ALabelScript : TLabel);
  end;

var
  DtmMigrationExpress: TDtmMigrationExpress;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDtmMigrationExpress }

function TDtmMigrationExpress.ConectarOrigem(AServer, ASenha, ADatabase: String): boolean;
begin
  ConnectionOrigem.Connected                       := False;
  ConnectionOrigem.Params.Clear;
  ConnectionOrigem.DriverName                      := 'MSSQL';
  ConnectionOrigem.Params.DriverID                 := 'MSSQL';
  ConnectionOrigem.Params.Values['Server']         := AServer;
  ConnectionOrigem.Params.Values['DataBase']       := ADatabase;
  ConnectionOrigem.Params.Values['OSAuthent']      := 'No';
  ConnectionOrigem.Params.Values['User_Name']      := 'sa';
  ConnectionOrigem.Params.Values['Password']       := ASenha;
  ConnectionOrigem.Params.Values['MetaDefSchema']  := 'dbo';
  ConnectionOrigem.Params.Values['MetaDefCatalog'] := ADatabase;
  ConnectionOrigem.Params.Values['DriverID']       := 'MSSQL';
  ConnectionOrigem.Params.Values['DriverName']     := 'MSSQL';
  try
    ConnectionOrigem.Connected := True;
    Result := ConnectionOrigem.Connected;
  except on EXC: Exception do
    begin
      Result := ConnectionOrigem.Connected;
      Application.MessageBox(PChar('Falha na Conexão Com o Banco de Dados.' + #13 +
                                   'Instância: ' + AServer + #13 +
                                   'Database: ' + ADatabase + #13#13 +
                                   EXC.Message),'Perigo',MB_OK + MB_ICONWARNING);
    end;
  end;
end;

function TDtmMigrationExpress.CreateBodyAuthenticate(AUserName, APassword: String; AACC_CODIGO, ACOM_CODIGO: Integer): String;
var
  LInfoClient : TJSONObject;
  LInfoClientJSONString : String;
  LAuth: TJSONObject;
  LAuthJSONString: String;
  LBody: TJSONObject;
begin
  //Informações do divice Client
  LInfoClient := TJSONObject.Create;
  LInfoClient.AddPair('client_win_exename',ExtractFileName(ParamStr(0)));
  LInfoClient.AddPair('client_win_computername',ITools.OS.GetNameComputer);
  LInfoClient.AddPair('client_win_hdserialnumber',ITools.OS.GetHDSerialNumber);
  LInfoClient.AddPair('client_win_osversion','');
  LInfoClient.AddPair('client_mob_apkname','');
  LInfoClient.AddPair('client_mob_imei','');
  LInfoClient.AddPair('client_mob_phonenumber','');
  LInfoClient.AddPair('client_mob_packagename','');
  LInfoClient.AddPair('client_mob_Manufacturer','');
  LInfoClient.AddPair('client_mob_devicemodel','');
  LInfoClient.AddPair('client_mob_osversion','');
  LInfoClientJSONString := LInfoClient.ToJSON;
  FreeAndNil(LInfoClient);
  //
  //Auth
  LAuth := TJSONObject.Create;
  LAuth.AddPair('auth_account_user',AUserName);
  LAuth.AddPair('auth_account_password',APassword);
  LAuth.AddPair('auth_company_cnpjcpf','');
  LAuth.AddPair('auth_company_codigo',ACOM_CODIGO.ToString);
  LAuth.AddPair('auth_infojson_client',LInfoClientJSONString);
  LAuth.AddPair('auth_datetime_token_create',FormatDateTime('yyyy-mm-dd hh:mm',Now));
  LAuth.AddPair('auth_datetime_token_expiration','');
  LAuthJSONString := LAuth.ToJSON;
  FreeAndNil(LAuth);
  //
  //Body
  LBody := TJSONObject.Create;
  LBody.AddPair('token_request',ITools.Encoder.Encryption(LAuthJSONString));
  //
  Result := LBody.ToJSON;
  //
  FreeAndNil(LBody);
end;

procedure TDtmMigrationExpress.CriarCampoComComCodigoEmTabelasDeCadastros;
begin
  try
    // Criando campos COM_CODIGO em tabelas de cadastros - EXPRESS.
    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''AQT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE AQT_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''ATB_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE ATB_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''ATB_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE ATB_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''BCO_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE BCO_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''BOX_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE BOX_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CCP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CCP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CCU_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CCU_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CFOP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CFOP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CLF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CLF_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CRT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CRT_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CST_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CST_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CSTPC_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CSTPC_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CTA_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CTA_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CTA_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CTA_00_02 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CTA_00_03'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CTA_00_03 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CTA_00_04'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CTA_00_04 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CTA_00_05'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CTA_00_05 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CTB_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CTB_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''DIZ_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE DIZ_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''DSP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE DSP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FPG_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE FPG_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FSP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE FSP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FUN_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE FUN_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''GAI_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE GAI_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''GRD_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE GRD_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''GRP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE GRP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''HSP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE HSP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''IRF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE IRF_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''KEY_XX'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE KEY_XX ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''LEE_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE LEE_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''LEE_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE LEE_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''LEE_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE LEE_00_02 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''LEE_00_03'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE LEE_00_03 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''LEF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE LEF_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''MAR_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE MAR_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''MDO_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE MDO_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''MDV_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE MDV_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''MNF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE MNF_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''MTA_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE MTA_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''MTA_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE MTA_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''MVA_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE MVA_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''NCM_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE NCM_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''NCM_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE NCM_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''NLP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE NLP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''NTO_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE NTO_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PALM_CLI_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PALM_CLI_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PES_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PES_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PES_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PES_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PES_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PES_00_02 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PES_00_03'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PES_00_03 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PES_00_04'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PES_00_04 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PES_00_05'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PES_00_05 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PES_00_06'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PES_00_06 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PLC_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PLC_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRO_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRO_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRO_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRO_00_02 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRO_00_03'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRO_00_03 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRO_00_04'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRO_00_04 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRO_00_05'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRO_00_05 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRO_IMG'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRO_IMG ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRZ_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRZ_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRZ_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRZ_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''PRZ_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE PRZ_00_02 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''RBC_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE RBC_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''RCC_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE RCC_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''RCC_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE RCC_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''REG_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE REG_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''ROT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE ROT_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''ROT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE ROT_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''SEG_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE SEG_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''SGM_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE SGM_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''SGP_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE SGP_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''TAB_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE TAB_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''TAB_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE TAB_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''TDC_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE TDC_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''TXS_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE TXS_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''TXS_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE TXS_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''VEI_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE VEI_00 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''VEI_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE VEI_00_01 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''VEI_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE VEI_00_02 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''VEI_00_03'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''COM_CODIGO'') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE VEI_00_03 ADD COM_CODIGO INT DEFAULT 0 NOT NULL '+
                                  ' END; ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.CriarCampoComComCodigoEmTabelasDeCadastros' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.CriarCamposInexistentesExpress;
begin
  try
    // Campos novos que foram criados no ERP e que não existem no EXPRESS ainda.
    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''MDO_DESCRICAO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_02         ADD MDO_DESCRICAO VARCHAR(100) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''PRO_DESCRICAO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01         ADD PRO_DESCRICAO VARCHAR(100) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_TABELAPRECO_PRO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01         ADD FAT_TABELAPRECO_PRO VARCHAR(20) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' EXEC sys.sp_addextendedproperty N''MS_Description'' '+
                                  '   ,N''CAMPO CRIADO POR EDIELSON PROTEINORTE (Kifrango)  - NAO DELETAR'' '+
                                  '   ,''schema'' '+
                                  '   ,N''dbo'' '+
                                  '   ,''table'' '+
                                  '   ,N''FAT_00_01'' '+
                                  '   ,''column'' '+
                                  '   ,N''FAT_TABELAPRECO_PRO''; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_TOTALICMSDESONERADOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01         ADD FAT_TOTALICMSDESONERADOITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_MOTIVODESONERACAO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01         ADD FAT_MOTIVODESONERACAO VARCHAR(2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_ICMSDESONERADO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01         ADD FAT_ICMSDESONERADO VARCHAR(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_CODIGOBENEFICIO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01         ADD FAT_CODIGOBENEFICIO VARCHAR(10) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_OBSERVACAOPRODUTONFE'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01         ADD FAT_OBSERVACAOPRODUTONFE VARCHAR(250) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CONFIG_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''CFG_TIPOSELECAOPRODUTO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.CONFIG_00_01         ADD CFG_TIPOSELECAOPRODUTO VARCHAR(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''ETQ_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''ETQ_LOTEVALIDADE'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.ETQ_00_02         ADD ETQ_LOTEVALIDADE VARCHAR(30) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''AJU_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''AJU_DATAALTERACAO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.AJU_00         ADD AJU_DATAALTERACAO DATETIME NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_NUMEROREMESSA'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00         ADD FAT_NUMEROREMESSA VARCHAR(20) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_TOTALICMSDESONERADO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00         ADD FAT_TOTALICMSDESONERADO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_EXPEDIDO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00         ADD FAT_EXPEDIDO VARCHAR(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_RESERVARESTOQUE'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00         ADD FAT_RESERVARESTOQUE VARCHAR(1) NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_TIPOMOVTO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00         ADD FAT_TIPOMOVTO VARCHAR(3) NOT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_FATURADOPRODUTOS'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00         ADD FAT_FATURADOPRODUTOS VARCHAR(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_FATURADOSERVICOS'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00         ADD FAT_FATURADOSERVICOS VARCHAR(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_ID'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD FAT_ID INT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_01_ID'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD FAT_01_ID INT NULL '+
                                  ' END; ');

  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.CriarCamposInexistentesExpress' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.CriarCamposIntegracaoMovimentosSaida;
begin
  try
    // Criacao dos campos FAT_INTEGRACAOERP do modulo de faturamento unificado com ORS e PDA.
    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_01_01 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_02 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_02_01 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_03'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_03 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_04'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_04 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_05'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_05 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_06'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAOERP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.FAT_00_06 ADD FAT_INTEGRACAOERP VARCHAR(50) NULL '+
                                  ' END; ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.CriarCamposIntegracaoMovimentosSaida' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.CriarCamposParaUnificacaoDEV_00NaOMF_00;
begin
  try
    // Campos que nao existem no EXPRESS e foi necessario criar devido a tabela DEV_00 do ERP e filhas
    // Mesclar com os movimentos da OMF_00 e filhas.
    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''VND_CODIGO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD VND_CODIGO INT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''TRP_CODIGO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD TRP_CODIGO INT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALCOMISSAO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALCOMISSAO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALAPROXIMADOIMPOSTO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALAPROXIMADOIMPOSTO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALDESCTO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_PERCENTUALDESCTO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPT'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_PERCENTUALIBPT DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''USERS_LOGIN'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD USERS_LOGIN VARCHAR(250) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALCOMISSAO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_PERCENTUALCOMISSAO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOCOMISSAO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALBASECALCULOCOMISSAO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALIBPTMUNICIPAL'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALIBPTMUNICIPAL DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALIBPTESTADUAL'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALIBPTESTADUAL DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALIBPTIMPORTADO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALIBPTIMPORTADO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTMUNICIPAL'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_PERCENTUALIBPTMUNICIPAL DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTESTADUAL'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_PERCENTUALIBPTESTADUAL DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTNACIONAL'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_PERCENTUALIBPTNACIONAL DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTIMPORTADO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_PERCENTUALIBPTIMPORTADO DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''CON_CODIGO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD CON_CODIGO INT NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOFCP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALBASECALCULOFCP DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALFCP'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALFCP DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOFCPST'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALBASECALCULOFCPST DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALFCPST'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALFCPST DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOFCPRET'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALBASECALCULOFCPRET DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALFCPRET'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00 ADD OMF_TOTALFCPRET DECIMAL(18, 2) NULL '+
                                  ' END; ');

//    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
//                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00'' '+
//                                  ' AND COLUMNS.COLUMN_NAME = ''DEV_ID_OLD'') '+
//                                  ' BEGIN '+
//                                  ' 	ALTER TABLE dbo.OMF_00 ADD DEV_ID_OLD INT NULL '+
//                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TIPODOCTO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TIPODOCTO VARCHAR(3) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALCOMISSAOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_PERCENTUALCOMISSAOITEM DECIMAL(18, 6) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_VALORBASECALCULOPISCOFINSITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_VALORBASECALCULOPISCOFINSITEM DECIMAL(18, 6) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_VALORBASEDESCTOCOMISSAOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_VALORBASEDESCTOCOMISSAOITEM DECIMAL(18, 4) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_VALORCOMISSAOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_VALORCOMISSAOITEM DECIMAL(18, 4) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALCOMISSAOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALCOMISSAOITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOPISCOFINSITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALBASECALCULOPISCOFINSITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_PERCENTUALIBPTITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTMUNICIPALITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_PERCENTUALIBPTMUNICIPALITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTESTADUALITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_PERCENTUALIBPTESTADUALITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTNACIONALITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_PERCENTUALIBPTNACIONALITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALIBPTIMPORTADOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_PERCENTUALIBPTIMPORTADOITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALIBPTMUNICIPALITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALIBPTMUNICIPALITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALIBPTESTADUALITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALIBPTESTADUALITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALIBPTNACIONALITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALIBPTNACIONALITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALIBPTIMPORTADOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALIBPTIMPORTADOITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALAPROXIMADOIMPOSTOITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALAPROXIMADOIMPOSTOITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_PERCENTUALFCPITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_PERCENTUALFCPITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOFCPITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALBASECALCULOFCPITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALFCPITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALFCPITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOFCPSTITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALBASECALCULOFCPSTITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALFCPSTITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALFCPSTITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALBASECALCULOFCPRETITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALBASECALCULOFCPRETITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''OMF_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''OMF_TOTALFCPRETITEM'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.OMF_00_01 ADD OMF_TOTALFCPRETITEM DECIMAL(18, 2) NULL '+
                                  ' END; ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.CriarCamposParaUnificacaoDEV_00NaOMF_00' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.CriarNovosCamposDeConfiguracaoSetup;
begin
  try
    // Campos das configuracoes que vinheram da FIL_00.
    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CONFIG_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''CFG_EXIBICAOCAMPOSDIGPRODUTO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.CONFIG_00_01         ADD CFG_EXIBICAOCAMPOSDIGPRODUTO VARCHAR(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CONFIG_00_01'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''CFG_PERCENTUALMARGEMLUCRO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.CONFIG_00_01         ADD CFG_PERCENTUALMARGEMLUCRO DECIMAL(18,2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  ' WHERE COLUMNS.TABLE_NAME = ''CONFIG_00_05'' '+
                                  ' AND COLUMNS.COLUMN_NAME = ''CCU_CODIGOPADRAOUNICO'') '+
                                  ' BEGIN '+
                                  ' 	ALTER TABLE dbo.CONFIG_00_05         ADD CCU_CODIGOPADRAOUNICO DECIMAL(18,2) NULL '+
                                  ' END; ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.CriarNovosCamposDeConfiguracaoSetup' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.DataModuleCreate(Sender: TObject);
begin
  ConnectionOrigem  := TGOXDBConnectionEngine.Create(Self,dnMSSQL);
  ConnectionDestino := TGOXDBConnectionEngine.Create(Self,dnMSSQL);
  //
  FDQueryOrigem.Connection  := ConnectionOrigem;
  FDQueryDestino.Connection := ConnectionDestino;
  FIL_00.Connection         := ConnectionOrigem;
  TABLES.Connection         := ConnectionOrigem;
  SQLCorrige.Connection     := ConnectionOrigem;
  SQL_EXE.Connection        := ConnectionOrigem;

  // Criando o Controller para requisição REST no AUTHENTICATOR.
  FControllerAUTHENTICATOR := TGOXManagerObjectSetRest.Create(TRESTConnection.Get.AUTHENTICATOR_RESTClient);
  FControllerAUTHENTICATOR.AddObjectSet<TDtoCOMPANY>;

  FDQuery_VALORCOLUNA := TFDQuery.Create(Self);
  FDQuery_VALORCOLUNA.Connection := ConnectionOrigem;

end;

procedure TDtmMigrationExpress.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FControllerAUTHENTICATOR);
  FreeAndNil(FDQuery_VALORCOLUNA);
  //
  FreeAndNil(ConnectionOrigem);
  FreeAndNil(ConnectionDestino);
end;

procedure TDtmMigrationExpress.DeletandoForeignKeys;
begin
  try
    SQL_EXE.Close;
    SQL_EXE.Connection := ConnectionDestino;
    SQL_EXE.SQL.Text := ' SELECT '+
                        '   #TABLE = fk_tab.NAME '+
                        '  ,#FOREIGN = fk.NAME '+
                        ' FROM sys.foreign_keys fk '+
                        ' INNER JOIN sys.tables fk_tab '+
                        '   ON fk_tab.object_id = fk.parent_object_id';
    SQL_EXE.Open;

    while not (SQL_EXE.Eof) do
    begin
      ConnectionDestino.ExecuteSQL('IF EXISTS (SELECT 1 '+
                                    '           FROM sys.foreign_keys fk '+
                                    '           WHERE fk.NAME = ' + QuotedStr(SQL_EXE.FieldByName('#FOREIGN').AsString) +') '+
                                    'BEGIN '+
                                    '  ALTER TABLE ' + SQL_EXE.FieldByName('#TABLE').AsString + ' '+
                                    '  DROP CONSTRAINT ' + SQL_EXE.FieldByName('#FOREIGN').AsString + ' ' +
                                    'END;');
      SQL_EXE.Next;
    end;
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.DeletandoForeignKeys' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.DeletandoPrimaryKeys;
begin
  try
    SQL_EXE.Close;
    SQL_EXE.Connection := ConnectionDestino;
    SQL_EXE.SQL.Clear;
    SQL_EXE.SQL.Text := ' SELECT '+
                        '    #TABLE = t.[name] '+
                        '   ,#CONSTRAINT = ISNULL(c.[name], i.[name]) '+
                        ' FROM sys.objects t '+
                        ' LEFT OUTER JOIN sys.indexes i ON t.object_id = i.object_id '+
                        ' LEFT OUTER JOIN sys.key_constraints c ON i.object_id = c.parent_object_id AND i.index_id = c.unique_index_id '+
                        ' CROSS APPLY (SELECT col.[name] + '', '' '+
                        '              FROM sys.index_columns ic '+
                        '              INNER JOIN sys.columns col on ic.object_id = col.object_id AND ic.column_id = col.column_id '+
                        '              WHERE ic.object_id = t.object_id AND ic.index_id = i.index_id '+
                        '              ORDER BY col.column_id '+
                        '              FOR XML PATH ('''')) D (column_names) '+
                        ' WHERE i.is_unique = 1 AND t.is_ms_shipped <> 1 ';
    SQL_EXE.Open;
    SQL_EXE.First;
    while not (SQL_EXE.Eof) do
    begin
      ConnectionDestino.ExecuteSQL('IF EXISTS (SELECT '+
                                    '             #CONSTRAINT = ISNULL(c.[name], i.[name]) '+
                                    '           FROM sys.objects t '+
                                    '           LEFT OUTER JOIN sys.indexes i ON t.object_id = i.object_id '+
                                    '           LEFT OUTER JOIN sys.key_constraints c ON i.object_id = c.parent_object_id '+
                                    '             AND i.index_id = c.unique_index_id '+
                                    '           CROSS APPLY (SELECT col.[name] + '', '' '+
                                    '                        FROM sys.index_columns ic '+
                                    '                        INNER JOIN sys.columns col on ic.object_id = col.object_id '+
                                    '                          AND ic.column_id = col.column_id '+
                                    '                        WHERE ic.object_id = t.object_id AND ic.index_id = i.index_id '+
                                    '                        ORDER BY col.column_id '+
                                    '                        FOR XML PATH ('''')) D (column_names) '+
                                    '           WHERE i.is_unique = 1 AND t.is_ms_shipped <> 1 '+
                                    '           AND ISNULL(c.[name], i.[name]) = ' + QuotedStr(SQL_EXE.FieldByName('#CONSTRAINT').AsString) +') '+
                                    'BEGIN '+
                                    '  ALTER TABLE ' + SQL_EXE.FieldByName('#TABLE').AsString + ' '+
                                    '  DROP CONSTRAINT [' + SQL_EXE.FieldByName('#CONSTRAINT').AsString + '] ' +
                                    'END;');
      SQL_EXE.Next;
    end;
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.DeletandoPrimaryKeys' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.DeletarCamposOLDAposConversao;
begin
  try
    SQL_EXE.Connection := ConnectionDestino;
    SQL_EXE.Close;
    SQL_EXE.SQL.Clear;
    SQL_EXE.SQL.Add('SELECT');
    SQL_EXE.SQL.Add('  T.name AS TABELA,');
    SQL_EXE.SQL.Add('  C.name AS COLUNA');
    SQL_EXE.SQL.Add('FROM');
    SQL_EXE.SQL.Add('  sys.sysobjects    AS T (NOLOCK)');
    SQL_EXE.SQL.Add('INNER JOIN sys.all_columns AS C (NOLOCK) ON T.id = C.object_id AND T.XTYPE = ''U''');
    SQL_EXE.SQL.Add('WHERE');
    SQL_EXE.SQL.Add('  C.NAME LIKE ''%_OLD%''');
    SQL_EXE.SQL.Add('ORDER BY');
    SQL_EXE.SQL.Add('T.name ASC');
    SQL_EXE.Open;
    SQL_EXE.FetchAll;
    SQL_EXE.First;
    while not SQL_EXE.Eof do
    begin
      ConnectionDestino.ExecuteSQL('IF EXISTS (SELECT 1 '+
                                    '           FROM INFORMATION_SCHEMA.COLUMNS '+
                                    '           WHERE COLUMNS.TABLE_NAME = ' + QuotedStr(SQL_EXE.FieldByName('TABELA').AsString) + ' '+
                                    '           AND COLUMNS.COLUMN_NAME = ' + QuotedStr(SQL_EXE.FieldByName('COLUNA').AsString) +') '+
                                    'BEGIN '+
                                    '  ALTER TABLE ' + SQL_EXE.FieldByName('TABELA').AsString + ' ' +
                                    '  DROP COLUMN ' + SQL_EXE.FieldByName('COLUNA').AsString + ' ' +
                                    'END');
      SQL_EXE.Next;
    end;
  except on EXC : Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.DeletarCamposOLDAposConversao' + #13#13 + EXC.Message),
                                   'Atenção', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TDtmMigrationExpress.DeletarSequences;
begin
  try
    SQL_EXE.Connection := ConnectionDestino;
    SQL_EXE.Close;
    SQL_EXE.SQL.Clear;
    SQL_EXE.SQL.Add('SELECT NAME FROM SYS.SEQUENCES ORDER BY NAME');
    SQL_EXE.Open;
    while not (SQL_EXE.Eof) do
    begin
      ConnectionDestino.ExecuteSQL('DROP SEQUENCE ' + SQL_EXE.FieldByName('NAME').Text);
      SQL_EXE.Next;
    end;
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.DeletarSequences' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.ExcluirIndicesExpress;
var
  LExcluiIndices : TStringList;
  LCaminho : String;
begin
  try
    try
      LExcluiIndices := TStringList.Create;
      LCaminho := ExtractFilePath(Application.ExeName) + '\ExcluirTodosIndices.sql';
      LExcluiIndices.LoadFromFile(LCaminho);

      ConnectionDestino.ExecuteSQL(LExcluiIndices.Text);
    finally
      FreeAndNil(LExcluiIndices);
    end;
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.ExcluirIndicesExpress' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.ExecutarConversao(AlblHoraInicio, AlblHoraFinal, AlblTempo, AlblTempoProcessamento, AlblTabelaAtual, AlblFuncao : TLabel;
  AGListCopyDataSet : TStringList; AlstTempoTabela : TListBox; AGaugeConversao, AGaugeWhile : TGauge; ATimerProcesamentoTabela : TTimer; AlblRowCopyRecord, AlblTotalRowCopyRecord : TLabel);
var
  LKey: String;
  LModel: TObject;
  FazerCopyDataSet : Boolean;
  iFor : integer;
begin
  try
    var LDto := '';
    for LKey in TCoreRegisterClass.EntityList.Keys do
    begin
      LDto := LKey;
      AlblTabelaAtual.Caption := 'Tabela Atual : ' + LKey;
      AlblTempoProcessamento.Caption := 'Tempo Processado : ';
      LModel := TCoreRegisterClass.EntityList[LKey].Create;
      FazerCopyDataSet := False;
      Application.ProcessMessages;
      //if ((Pos('FAT_00_01', LKey) > 0) and (Length(LKey) = 11)) then  //PARA TESTAR TABELA ESPECIFICA
      //begin
      for iFor := 0 to (AGListCopyDataSet.Count - 1) do
      begin
        if LDto = AGListCopyDataSet[iFor] then
          FazerCopyDataSet := True;
      end;
      try
        LTempo := Time;
        NumeroRegistro := 0;
        if FazerCopyDataSet = False then
        begin
          AlblTempoProcessamento.Caption := 'Tempo Processado : '+ TimeToStr(Time - LTempo);
          Application.ProcessMessages;
          TModelBase(LModel).ExecutarConversao(ConnectionOrigem, ConnectionDestino, AlblFuncao, AlblTempoProcessamento, AGaugeWhile);
          AlblTempo.Caption := 'Tempo Processado : ' + TimeToStr(Time - StrToTime(Copy(AlblHoraInicio.Caption,16,9)));
          AlstTempoTabela.Items.Add(LKey + '   ;   Tempo : ' + TimeToStr(Time - LTempo) + '   ;   Registros : ' + NumeroRegistro.ToString()+ '   ;   ORM');
          Application.ProcessMessages;
        end
        else
        begin
          ATimerProcesamentoTabela.Enabled := True;
          Application.ProcessMessages;
          var LMetodoProcessamentoDados := '';
          LMetodoProcessamentoDados := TModelBase(LModel).ExecutarConversaoCopyDataSet(ConnectionOrigem,ConnectionDestino, AlblFuncao, AlblTempoProcessamento, AGaugeWhile, AlblRowCopyRecord, AlblTotalRowCopyRecord);
          AlblTempo.Caption := 'Tempo Processado : ' + TimeToStr(Time - StrToTime(Copy(AlblHoraInicio.Caption,16,9)));
          AlstTempoTabela.Items.Add(LKey + '   ;   Tempo : ' + TimeToStr(Time - LTempo) + '   ;   Registros : ' + NumeroRegistro.ToString()+ '   ;   ' + LMetodoProcessamentoDados);
          ATimerProcesamentoTabela.Enabled := False;
          Application.ProcessMessages;
        end;
      finally
        FreeAndNil(LModel);
      end;
      //end;
      AGaugeConversao.Progress := AGaugeConversao.Progress + 1;
      AlstTempoTabela.ItemIndex := AGaugeConversao.Progress;
      var LPath : String;
      LPath := ExtractFileDir(Application.ExeName);
      AlstTempoTabela.Items.SaveToFile(LPath + '\TempoConversãoTabelas.txt');
      Application.ProcessMessages;
    end;
    AGaugeConversao.Progress := 0;
    AlblTabelaAtual.Caption := '...';
    Application.MessageBox(PChar('Conversão concluída!' + #13 + AlblTempo.Caption), 'Sucesso', MB_OK + MB_ICONINFORMATION);
    AlblHoraFinal.Caption := 'Hora Final : '+TimeToStr(Time);
    AlblHoraFinal.Visible := true;
  except on E: Exception do
    begin
      Application.ProcessMessages;
      Application.MessageBox(Pchar('TDtmMigrationExpress.ExecutarConversao' + #13#13 + 'Tabela: ' + LKey + #13#13 + E.Message), 'Erro', MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TDtmMigrationExpress.FileSearch(const PathName, FileName: string; const InDir: boolean; pItems: TStrings);
var
  Rec  : TSearchRec;
  Path : string;
begin
  Path := IncludeTrailingBackslash(PathName);
  vCancelarLoop := False;
  if FindFirst(Path + FileName, faAnyFile - faDirectory, Rec) = 0 then
  try
    repeat
      pItems.Add(Path + Rec.Name);
//      pItems.Add(Rec.Name);
    until FindNext(Rec) <> 0;
  finally
    FindClose(Rec);
  end;

  If not InDir then
    Exit;

  if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then
  try
    repeat
     if ((Rec.Attr and faDirectory) <> 0)  and (Rec.Name<>'.') and (Rec.Name<>'..') then
      FileSearch(Path + Rec.Name, FileName, True,pItems);
      Application.ProcessMessages;

      if vCancelarLoop then
        if MessageDlg('Deseja cancelar busca ?',mtConfirmation, [mbYes,mbNo],0) = mrYes then
          Abort;

    until FindNext(Rec) <> 0;
  finally
    FindClose(Rec);
  end;
end;

procedure TDtmMigrationExpress.FIL_00AfterOpen(DataSet: TDataSet);
var
  LCompanyList : TObjectList<TDtoCOMPANY>;

  LCompany : TDtoCOMPANY;
begin
  try
    while not FIL_00.Eof do
    begin
      if (FIL_00.FieldByName('FIL_SELECIONADO').AsString = 'S') then
      begin
        if TRESTConnection.Get.AUTHENTICATOR_TokenBodyAuthenticate(CreateBodyAuthenticate('neski@neski.com.br','89794B621A313BB59EED0D9F0F4E8205',0,0)) then
        begin
          FControllerAUTHENTICATOR.AddPathParam<TDtoCOMPANY>(FIL_00.FieldByName('FIL_CNPJ').AsString);
          LCompanyList := FControllerAUTHENTICATOR.FindFrom<TDtoCOMPANY>('/getcompanycode');
          try
            if (LCompanyList.Count > 0) then
            begin
              LCompany := LCompanyList.First;
              FIL_00.Edit;
              FIL_00.FieldByName('COM_CODIGO').AsInteger := LCompany.COM_CODIGO;
              FIL_00.Post;
            end
            else
            begin
              Application.MessageBox(PChar('Empresa não Encontrada no Cadastro de Clientes da Neski !!. ' + #13#13 +
                                           'Código : ' + FIL_00.FieldByName('FIL_CODIGO').AsString + #13 +
                                           'Razão/Nome : ' + FIL_00.FieldByName('FIL_RAZAO').AsString + #13 +
                                           'CNPJ/CPF : ' + FIL_00.FieldByName('FIL_CNPJ').AsString + #13)
                                           ,'Perigo',MB_OK+MB_ICONINFORMATION);
            end;
          finally
            FreeAndNil(LCompanyList);
          end;
        end;
      end;
      FIL_00.Next;
    end;
  except on EXC : Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.FIL_00AfterOpen' + #13#13 + EXC.Message),'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

function TDtmMigrationExpress.MessageDlgColor(const Msg: string; ATitle : String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; AColor, AColorFont : TColor): Integer;
begin
  Result := MessageDlgPosColor(Msg, ATitle, DlgType, Buttons, 0, -1, -1, '', AColor, AColorFont);
end;

function TDtmMigrationExpress.MessageDlgPosColor(const Msg: string; ATitle : String; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons;
  HelpCtx: Longint; X, Y: Integer; const HelpFileName: string; AColor , AColorFont : TColor): Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons) do
  try
    BorderStyle := bsDialog;
    Caption := ATitle;
    Font.Color := AColorFont;
    Font.Style := [fsBold];
    Color := AColor;
    HelpContext := HelpCtx;
    HelpFile := HelpFileName;
    if X >= 0 then Left := X;
    if Y >= 0 then Top := Y;
    if (Y < 0) and (X < 0) then Position := poScreenCenter;
    Result := ShowModal;
  finally
    Free;
  end;
end;

function TDtmMigrationExpress.RemoveChar(const pTexto: String; pEvento: Integer): String;
var
  I: integer;
  S: string;
begin
  S := '';
  begin
    for I := 1 To Length(pTexto) Do
    begin
      if (pTexto[I] in ['0'..'9']) then
      begin
         S := S + Copy(pTexto, I, 1);
      end;
    end;
  result := S;
  end;
end;

procedure TDtmMigrationExpress.UpdatePedidoCompraZerado;
begin
  try
    ConnectionDestino.ExecuteSQL('UPDATE OMF_00 SET OMF_PEDIDOCOMPRA = 0 WHERE OMF_PEDIDOCOMPRA IS NULL');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.UpdatePedidoCompraZerado' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.UpdatesCaminhosPastasNovasExpress;
begin
  try
    // Ajusta caminhos para a pasta nova do NeskiExpress.
    ConnectionDestino.ExecuteSQL('UPDATE CONFIG_00_01 SET CFG_PATHSETTING = '+ QuotedStr('C:\NeskiApps\NeskiExpress\NeskiExpressClient\Settings'));
    ConnectionDestino.ExecuteSQL('UPDATE CONFIG_00_01 SET CFG_PATHEXPORTACAOCONTABIL = '+ QuotedStr('C:\NeskiApps\NeskiExpress\NeskiExpressClient\Eletronics\Contabil'));
    ConnectionDestino.ExecuteSQL('UPDATE CONFIG_00_01 SET CFG_PATHEXPORTACAOXML = '+ QuotedStr('C:\NeskiApps\NeskiExpress'));
    ConnectionDestino.ExecuteSQL('UPDATE CONFIG_00_01 SET CFG_PATHSINTEGRA = '+ QuotedStr('C:\NeskiApps\NeskiExpress\NeskiExpressClient\Eletronics\Sintegra'));
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.UpdatesCaminhosPastasNovasExpress' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.UpdateValorTodosCampos_ComCodigo(AProgressBar: TGauge; AFilCodigoOrigem, AComCodigoDestino : Integer; ALabelTabela : TLabel);
var
  LSQL:String;
  LTable,LField :String;
begin
  try
    TABLES.SQL.Clear;
    TABLES.SQL.Add('SELECT');
    TABLES.SQL.Add('    T.name AS Tabela,');
    TABLES.SQL.Add('    C.name AS Coluna');
    TABLES.SQL.Add('FROM');
    TABLES.SQL.Add('    sys.sysobjects    AS T (NOLOCK)');
    TABLES.SQL.Add('INNER JOIN sys.all_columns AS C (NOLOCK) ON T.id = C.object_id AND T.XTYPE = ''U''');
    TABLES.SQL.Add('WHERE');
    TABLES.SQL.Add('    C.NAME = ''FIL_CODIGO''');
    TABLES.SQL.Add('ORDER BY');
    TABLES.SQL.Add('T.name ASC');
    TABLES.Open;
    TABLES.FetchAll;
    //
    AProgressBar.MinValue := 0;
    AProgressBar.MaxValue := TABLES.RecordCount;
    Application.ProcessMessages;
    //
    while not (TABLES.Eof) do
    begin
      LField := TABLES.FieldByName('Coluna').AsString;
      LTable := TABLES.FieldByName('Tabela').AsString;

      LSQL := 'UPDATE '+LTable+' SET '+
              LField+' = '+QuotedStr(FormatFloat('000',AComCodigoDestino))+
              ' WHERE '+LField+' = '+QuotedStr(FormatFloat('000',AFilCodigoOrigem));

      ConnectionOrigem.ExecSQL(LSQL);

      ALabelTabela.Caption := UpperCase(LTable);
      AProgressBar.Progress := DtmMigrationExpress.TABLES.RecNo;
      Application.ProcessMessages;
      TABLES.Next;
    end;
  except on EXC : Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.UpdateValorTodosCampos_ComCodigo' + #13#13 + EXC.Message),'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.UpdateXML_00(ALabelQuantidade , ALabelScript : TLabel);
var
  LSQL : String;

  XML_NFE_00_ERP: TFDQuery;

begin
  var lInt := 0;

  // Criando FDQuerys
  XML_NFE_00_ERP := TFDQuery.Create(Self);

  // Conectando os FDQuerys
  XML_NFE_00_ERP.Connection := ConnectionOrigem;

  try
    XML_NFE_00_ERP.Close;
    XML_NFE_00_ERP.FetchOptions.RowsetSize := 100000;
    XML_NFE_00_ERP.SQL.Clear;
    XML_NFE_00_ERP.SQL.Text := 'SELECT '+
                               '  XML_XMLNOTAFISCAL '+
                               '  ,XML_XMLNOTAFISCALCOMAUTORIZACAO '+
                               '  ,XML_XMLINUTILIZACAO '+
                               '  ,XML_XMLDPEC '+
                               '  ,XML_XMLCARTACORRECAO '+
                               '  ,XML_XMLAUTORIZACAOCCE '+
                               '  ,XML_CHAVEACESSO '+
                               'FROM XML_NFE_00 '+
                               'WHERE XML_CHAVEACESSO IS NOT NULL';
    XML_NFE_00_ERP.Open;
    XML_NFE_00_ERP.First;
    while not (XML_NFE_00_ERP.Eof) do
    begin
      LSQL :=  'UPDATE XML_NFE_00 '+
               '  SET XML_NFE_00.XML_XMLNOTAFISCAL = ' + QuotedStr(XML_NFE_00_ERP.FieldByName('XML_XMLNOTAFISCAL').AsString) + ' '+
               '     ,XML_NFE_00.XML_XMLNOTAFISCALCOMAUTORIZACAO = ' + QuotedStr(XML_NFE_00_ERP.FieldByName('XML_XMLNOTAFISCALCOMAUTORIZACAO').AsString) + ' '+
               '     ,XML_NFE_00.XML_XMLINUTILIZACAO = ' + QuotedStr(XML_NFE_00_ERP.FieldByName('XML_XMLINUTILIZACAO').AsString) + ' '+
               '     ,XML_NFE_00.XML_XMLDPEC = ' + QuotedStr(XML_NFE_00_ERP.FieldByName('XML_XMLDPEC').AsString) + ' '+
               '     ,XML_NFE_00.XML_XMLCARTACORRECAO = ' + QuotedStr(XML_NFE_00_ERP.FieldByName('XML_XMLCARTACORRECAO').AsString) + ' '+
               '     ,XML_NFE_00.XML_XMLAUTORIZACAOCCe = ' + QuotedStr(XML_NFE_00_ERP.FieldByName('XML_XMLAUTORIZACAOCCe').AsString) + ' '+
               'WHERE XML_NFE_00.XML_CHAVEACESSO = ' + QuotedStr(XML_NFE_00_ERP.FieldByName('XML_CHAVEACESSO').AsString) + ' ';

      lInt := lInt + 1;
      ALabelQuantidade.Caption := lInt.ToString + ' / ' + XML_NFE_00_ERP.RecordCount.ToString;
      //ALabelScript.Caption := LSQL;
      Application.ProcessMessages;

      ConnectionDestino.ExecuteSQL(LSQL);
      XML_NFE_00_ERP.Next;
    end;
  finally
    FreeAndNil(XML_NFE_00_ERP);
  end;
end;

function TDtmMigrationExpress.ValidaERPAtualizado(AVersionERP : Integer): Boolean;
var
  BUILD_ERP: TFDQuery;
begin
  try
    // Criando FDQuerys
    BUILD_ERP := TFDQuery.Create(Self);

    // Conectando os FDQuerys
    BUILD_ERP.Connection := ConnectionOrigem;
    try
      BUILD_ERP.Close;
      BUILD_ERP.SQL.Clear;
      BUILD_ERP.SQL.Text := 'SELECT BUILD_NUMBER FROM BUILD';
      BUILD_ERP.Open;

      if (BUILD_ERP.FieldByName('BUILD_NUMBER').AsInteger < AVersionERP) then
        Result := False
      else
        Result := True;

    finally
      FreeAndNil(BUILD_ERP);
    end;
  except on EXC : Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.ValidaERPAtualizado' + #13#13 + EXC.Message),'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

function TDtmMigrationExpress.VerificaCamposNOTNULLBanco(Column, Table: string): Boolean;
begin
  try
    Result := False;

    SQL_EXE.SQL.Clear;
    SQL_EXE.Close;
    SQL_EXE.SQL.Add(' SELECT * FROM sys.columns c '+
                    ' LEFT JOIN sys.tables t ON c.object_id = t.object_id '+
                    ' WHERE c.NAME = ' + QuotedStr(Column) + ' '+
                    ' AND t.NAME = ' + QuotedStr(Table) + ' '+
                    ' AND c.IS_NULLABLE = ' + QuotedStr('False') + '; ');
    SQL_EXE.Open;

    if SQL_EXE.RecordCount > 0 then
      Result := True;

  except on EXC : Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.VerificaCamposNOTNULLBanco' + #13#13 + EXC.Message),'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AjustesAntes;
begin
  try
    DeletandoForeignKeys;
    DeletandoPrimaryKeys;
    //ExcluirIndicesExpress;
    AcertosBaseExpress_Destino;
    CriarCamposInexistentesExpress;
    CriarCamposIntegracaoMovimentosSaida;
    CriarCamposParaUnificacaoDEV_00NaOMF_00;
    CriarNovosCamposDeConfiguracaoSetup;
    CriarCampoComComCodigoEmTabelasDeCadastros;
    AcertosBaseERP_Origem;
    Application.ProcessMessages;
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AjustesAntes' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AjustesDepois;
begin
  try
    AcertoID_SubTabelasOMF;
    AcertoID_SubTabelasFAT;
    AcertoID_IntegracoesOMF;
    AcertoID_IntegracoesFAT;
    AcertoCGA01_VinculacaoPDAemFAT;
    AcertoSequenciaNumOrcamentoFAT;
    AcertoHistoricoPadraoReferenteMovOMF;
    AcertoHistoricoPadraoReferenteMovFAT;
    AcertoHistoricoPadraoReferenteMovPDA;
    UpdatePedidoCompraZerado;
    UpdatesCaminhosPastasNovasExpress;
    AcertoCodigosTabelaCOD;
    DeletarSequences;
    DeletarCamposOLDAposConversao;
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AjustesDepois' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AlteracaoComCodigoAutomatico(AProgressBar: TGauge; AOrigem, ADestino: TNumberBox; ALabelTabela : TLabel);
begin
  try
    FIL_00.First;
    while not (FIL_00.Eof) do
    begin
      if (FIL_00.FieldByName('FIL_CODIGO').AsInteger = FIL_00.FieldByName('COM_CODIGO').AsInteger) then
      begin
        if Length(TCoreQuery.FiliaisWhere) > 0 then
          TCoreQuery.FiliaisWhere := TCoreQuery.FiliaisWhere + ' , ';

        TCoreQuery.FiliaisWhere := TCoreQuery.FiliaisWhere + FIL_00.FieldByName('COM_CODIGO').AsString;
      end
      else
      begin
        if (FIL_00.FieldByName('FIL_SELECIONADO').AsString = 'S') then
        begin
          AOrigem.ValueInt  := FIL_00.FieldByName('FIL_CODIGO').AsInteger;
          ADestino.ValueInt := FIL_00.FieldByName('COM_CODIGO').AsInteger;
          Application.ProcessMessages;

//          if Application.MessageBox('Continuar a operação?', 'Atenção', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
//          begin
          DtmMigrationExpress.UpdateValorTodosCampos_ComCodigo(AProgressBar, AOrigem.ValueInt, ADestino.ValueInt, ALabelTabela);
//          end;

          if Length(TCoreQuery.FiliaisWhere) > 0 then
            TCoreQuery.FiliaisWhere := TCoreQuery.FiliaisWhere + ' , ';

          TCoreQuery.FiliaisWhere := TCoreQuery.FiliaisWhere + FIL_00.FieldByName('COM_CODIGO').AsString;
        end;
      end;
      FIL_00.Next;
    end;
    MessageDlgColor('Processo de troca de Código Finalizado.','Processo de troca de código', mtCustom, [mbOK], $002E2E2E, clWhite);

    // Carregando scripts para a migração dos dados.
    TCoreQuery.CarrecarScriptsDTOs;

  except on EXC : Exception do
    begin
      Application.MessageBox(PChar('TFrmDatabaseMaintenance.btnSelecionarFiliaisClick' + #13#13 + EXC.Message),'Perigo',MB_OK+MB_ICONWARNING);
    end;
  end;
end;

function TDtmMigrationExpress.ConectarDestino(AServer, ASenha, ADatabase: String): boolean;
begin
  ConnectionDestino.Connected := False;
  ConnectionDestino.Params.Clear;
  ConnectionDestino.DriverName                      := 'MSSQL';
  ConnectionDestino.Params.DriverID                 := 'MSSQL';
  ConnectionDestino.Params.Values['Server']         := AServer;
  ConnectionDestino.Params.Values['DataBase']       := ADatabase;
  ConnectionDestino.Params.Values['OSAuthent']      := 'No';
  ConnectionDestino.Params.Values['User_Name']      := 'sa';
  ConnectionDestino.Params.Values['Password']       := ASenha;
  ConnectionDestino.Params.Values['MetaDefSchema']  := 'dbo';
  ConnectionDestino.Params.Values['MetaDefCatalog'] := ADatabase;
  ConnectionDestino.Params.Values['DriverID']       := 'MSSQL';
  ConnectionDestino.Params.Values['DriverName']     := 'MSSQL';

  try
    ConnectionDestino.Connected := True;
    Result := ConnectionDestino.Connected;
  except on EXC: Exception do
    begin
      Result := ConnectionDestino.Connected;
      Application.MessageBox(PChar('Falha na Conexão Com o Banco de Dados.' + #13 +
                                   'Instância: ' + AServer + #13 +
                                   'Database: ' + ADatabase + #13#13 +
                                   EXC.Message),'Perigo',MB_OK+MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AbrirBackup;
begin
  var Title := StringOfChar(' ',69) + 'BACKUP';
  MessageDlgColor('FAVOR REALIZAR O BACKUP ANTES DE QUALQUER PROCEDIMENTO DE MIGRAÇÃO.', Title, mtCustom, [mbOK], $002E2E2E, clRed);
  Sleep(100);
  ShellExecute(Application.handle, nil, Pchar('SBF.Application.exe'),PChar(''),PChar(GetEnvironmentVariable('ProgramFiles')+'\SQLBackupAndFTP'), SW_SHOWNORMAL);
end;

procedure TDtmMigrationExpress.AcertoCGA01_VinculacaoPDAemFAT;
//var
//  PDA_00: TFDQuery;
//  FAT_00: TFDQuery;
begin
  // Criando FDQuerys
//  PDA_00 := TFDQuery.Create(Self);
//  FAT_00 := TFDQuery.Create(Self);

  // Conectando os FDQuerys
//  PDA_00.Connection := ConnectionOrigem;
//  FAT_00.Connection := ConnectionDestino;

//  try
//    PDA_00.Close;
//    PDA_00.SQL.Clear;
//    PDA_00.SQL.Text := 'SELECT PDA_ID, CGA_ID,  FROM PDA_00';
//
//    FAT_00.Close;
//    FAT_00.SQL.Clear;
//    FAT_00.SQL.Text := '';
//
//    while not (PDA_00.Eof) do
//    begin
//
//    end;
//  finally
//    FreeAndNil(PDA_00);
//    FreeAndNil(FAT_00);
//  end;
  try
    ConnectionDestino.ExecuteSQL(' UPDATE CGA_00_01 '+
                                  ' SET CGA_00_01.FAT_ID = T2.FAT_ID '+
                                  ' FROM CGA_00_01 '+
                                  ' INNER JOIN FAT_00 T2 ON (CGA_00_01.CGA_ID = T2.CGA_ID) '+
                                  '                     AND (CGA_00_01.PDA_ID = T2.PDA_ID) '+
                                  '                     AND (CGA_00_01.COM_CODIGO = T2.COM_CODIGO)');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoCGA01_VinculacaoPDAemFAT' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoCGA_01_VinculacaoPDAemFAT;
begin

end;

procedure TDtmMigrationExpress.AcertoCodigosTabelaCOD;
begin
  try
    // Acerta código sequencial na tabela COD_00.
    ConnectionDestino.ExecuteSQL('DELETE FROM COD_00 WHERE COD_FIELD = ''PRO_03_ID'' ');
    ConnectionDestino.ExecuteSQL('UPDATE COD_00 SET COD_00.COD_FIELD = ''PRO_03_ID'' WHERE COD_00.COD_FIELD = ''PRO_06_ID'' ');
    ConnectionDestino.ExecuteSQL('DELETE FROM COD_00 WHERE COD_FIELD = ''PRO_05_ID'' ');
    ConnectionDestino.ExecuteSQL('UPDATE COD_00 SET COD_00.COD_FIELD = ''PRO_05_ID'' WHERE COD_00.COD_FIELD = ''PRO_09_ID'' ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoCodigosTabelaCOD' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoHistoricoPadraoReferenteMovFAT;
begin
  try
    // Acerta histórico nos movimentos.
    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_HISTORICO = REPLACE(CRE_HISTORICO, ''Lançamento gerado do faturamento a Vista'', '+
                                  ' ''Lançamento gerado do Movimentos de Saida à Vista'') '+
                                  'WHERE CRE_HISTORICO LIKE ''%Lançamento gerado do faturamento a Vista%'' ');

    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_HISTORICO = REPLACE(CRE_HISTORICO, ''Lançamento gerado do faturamento'', '+
                                  ' ''Lançamento gerado do Movimentos de Saidas'') '+
                                  'WHERE CRE_HISTORICO LIKE ''%Lançamento gerado do faturamento%'' ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoHistoricoPadraoReferenteMovFAT' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoHistoricoPadraoReferenteMovOMF;
begin
  try
    // Acerta histórico nos movimentos.
    ConnectionDestino.ExecuteSQL('UPDATE CPA_00 SET CPA_HISTORICO = REPLACE(CPA_HISTORICO, ''Lançamento gerado da Outras Entradas'', '+
                                  ' ''Lançamento gerado de Outros Movimentos Fiscais'') '+
                                  'WHERE CPA_HISTORICO LIKE ''%Lançamento gerado da Outras Entradas%'' ');

    ConnectionDestino.ExecuteSQL('UPDATE CPA_00 SET CPA_HISTORICO = REPLACE(CPA_HISTORICO, ''Lançamento gerado do Frete CTR da Simples Entrada'', '+
                                  ' ''Lançamento gerado do Frete CTR de Outros Movimentos Fiscais'') '+
                                  'WHERE CPA_HISTORICO LIKE ''%Lançamento gerado do Frete CTR da Simples Entrada%'' ');

    ConnectionDestino.ExecuteSQL('UPDATE CPA_00 SET CPA_HISTORICO = REPLACE(CPA_HISTORICO, ''Lançamento gerado da Simples Entradas'', '+
                                  ' ''Lançamento gerado de Outros Movimentos Fiscais'') '+
                                  'WHERE CPA_HISTORICO LIKE ''%Lançamento gerado da Simples Entradas%'' ');

    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_HISTORICO = REPLACE(CRE_HISTORICO, ''Lançamento Gerado do Simples Saída à Vista'', '+
                                  ' ''Lançamento gerado de Outros Movimentos Fiscais à Vista'') '+
                                  'WHERE CRE_HISTORICO LIKE ''%Lançamento Gerado do Simples Saída à Vista%'' ');

    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_HISTORICO = REPLACE(CRE_HISTORICO, ''Lançamento gerado do Movto. Saída Simples a Vista'', '+
                                  ' ''Lançamento gerado de Outros Movimentos Fiscais à Vista'') '+
                                  'WHERE CRE_HISTORICO LIKE ''%Lançamento gerado do Movto. Saída Simples a Vista%'' ');

    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_HISTORICO = REPLACE(CRE_HISTORICO, ''Lançamento gerado do Movto. Saída Simples'', '+
                                  ' ''Lançamento gerado de Outros Movimentos Fiscais'') '+
                                  'WHERE CRE_HISTORICO LIKE ''%Lançamento gerado do Movto. Saída Simples%'' ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoHistoricoPadraoReferenteMovOMF' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoHistoricoPadraoReferenteMovPDA;
begin
  try
    // Acerta histórico nos movimentos gerados do pedido a atender.
    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_HISTORICO = REPLACE(CRE_HISTORICO, ''Lançamento gerado do Movto. de Pedido a Atender'', '+
                                  ' ''Lançamento gerado do Movimentos de Saidas'') '+
                                  'WHERE CRE_HISTORICO LIKE ''%Lançamento gerado do Movto. de Pedido a Atender%'' ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoHistoricoPadraoReferenteMovPDA' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoID_IntegracoesFAT;
begin
  try
    // Acerta ID e sigla de integração dos movimentos amarrados ao faturamento.
    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_INTEGRACAO = ''FAT'' + CAST((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = CRE_00.CRE_INTEGRACAO '+
                                  'AND FAT_00.COM_CODIGO = CRE_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (CRE_INTEGRACAO LIKE ''FAT%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE BCX_00 SET BCX_INTEGRACAO = ''FAT'' + CAST((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = BCX_00.BCX_INTEGRACAO '+
                                  'AND FAT_00.COM_CODIGO = BCX_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (BCX_INTEGRACAO LIKE ''FAT%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE LFS_00 SET LFS_INTEGRACAO = ''FAT'' + CAST((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = LFS_00.LFS_INTEGRACAO '+
                                  'AND FAT_00.COM_CODIGO = LFS_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (LFS_INTEGRACAO LIKE ''FAT%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE LFE_00 SET LFE_INTEGRACAO = ''FAT'' + CAST((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = LFE_00.LFE_INTEGRACAO '+
                                  'AND FAT_00.COM_CODIGO = LFE_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (LFE_INTEGRACAO LIKE ''FAT%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_INTEGRACAO = ''FAT'' + CAST((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = CRE_00.CRE_INTEGRACAO '+
                                  'AND FAT_00.COM_CODIGO = CRE_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (CRE_INTEGRACAO LIKE ''PDA%'') ');

  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoID_IntegracoesFAT' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoID_IntegracoesOMF;
begin
  try
    // Acerta ID e sigla de integração nos movimentos.
    ConnectionDestino.ExecuteSQL('UPDATE CRE_00 SET CRE_INTEGRACAO = ''OMF'' + CAST((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = CRE_00.CRE_INTEGRACAO '+
                                  'AND OMF_00.COM_CODIGO = CRE_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (CRE_INTEGRACAO LIKE ''SEE%'') OR (CRE_INTEGRACAO LIKE ''SSE%'') OR '+
                                  '(CRE_INTEGRACAO LIKE ''ONE%'') OR (CRE_INTEGRACAO LIKE ''ONS%'') OR (CRE_INTEGRACAO LIKE ''DEV%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE CPA_00 SET CPA_INTEGRACAO = ''OMF'' + CAST((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = CPA_00.CPA_INTEGRACAO '+
                                  'AND OMF_00.COM_CODIGO = CPA_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (CPA_INTEGRACAO LIKE ''SEE%'') OR (CPA_INTEGRACAO LIKE ''SSE%'') OR '+
                                  '(CPA_INTEGRACAO LIKE ''ONE%'') OR (CPA_INTEGRACAO LIKE ''ONS%'') OR (CPA_INTEGRACAO LIKE ''DEV%'')');

    ConnectionDestino.ExecuteSQL('UPDATE BCX_00 SET BCX_INTEGRACAO = ''OMF'' + CAST((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = BCX_00.BCX_INTEGRACAO '+
                                  'AND OMF_00.COM_CODIGO = BCX_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (BCX_INTEGRACAO LIKE ''SEE%'') OR (BCX_INTEGRACAO LIKE ''SSE%'') OR '+
                                  '(BCX_INTEGRACAO LIKE ''ONE%'') OR (BCX_INTEGRACAO LIKE ''ONS%'') OR (BCX_INTEGRACAO LIKE ''DEV%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE LFS_00 SET LFS_INTEGRACAO = ''OMF'' + CAST((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = LFS_00.LFS_INTEGRACAO '+
                                  'AND OMF_00.COM_CODIGO = LFS_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (LFS_INTEGRACAO LIKE ''SEE%'') OR (LFS_INTEGRACAO LIKE ''SSE%'') OR '+
                                  '(LFS_INTEGRACAO LIKE ''ONE%'') OR (LFS_INTEGRACAO LIKE ''ONS%'') OR (LFS_INTEGRACAO LIKE ''DEV%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE LFE_00 SET LFE_INTEGRACAO = ''OMF'' + CAST((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = LFE_00.LFE_INTEGRACAO '+
                                  'AND OMF_00.COM_CODIGO = LFE_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (LFE_INTEGRACAO LIKE ''SEE%'') OR (LFE_INTEGRACAO LIKE ''SSE%'') OR '+
                                  '(LFE_INTEGRACAO LIKE ''ONE%'') OR (LFE_INTEGRACAO LIKE ''ONS%'') OR (LFE_INTEGRACAO LIKE ''DEV%'') ');

    ConnectionDestino.ExecuteSQL('UPDATE LFE_00 SET LFE_INTEGRACAO = ''OMF'' + CAST((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = LFE_00.LFE_INTEGRACAO '+
                                  'AND OMF_00.COM_CODIGO = LFE_00.COM_CODIGO) AS VARCHAR) '+
                                  'WHERE (LFE_INTEGRACAO LIKE ''SEE%'') OR (LFE_INTEGRACAO LIKE ''SSE%'') OR '+
                                  '(LFE_INTEGRACAO LIKE ''ONE%'') OR (LFE_INTEGRACAO LIKE ''ONS%'') OR (LFE_INTEGRACAO LIKE ''DEV%'') ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoID_IntegracoesOMF' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoID_SubTabelasFAT;
begin
  try
    // ID da tabela principal FAT_00 nas subtabelas.
    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_01 SET FAT_ID = COALESCE((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = FAT_00_01.FAT_INTEGRACAOERP '+
                                  'AND FAT_00.COM_CODIGO = FAT_00_01.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_01_01 SET FAT_01_ID = COALESCE((SELECT FAT_01_ID FROM FAT_00_01 '+
                                  'WHERE FAT_00_01.FAT_INTEGRACAOERP = FAT_00_01_01.FAT_INTEGRACAOERP '+
                                  'AND FAT_00_01.COM_CODIGO = FAT_00_01_01.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_01_01 SET FAT_ID = COALESCE((SELECT FAT_ID FROM FAT_00_01 '+
                                  'WHERE FAT_00_01.FAT_INTEGRACAOERP = FAT_00_01_01.FAT_INTEGRACAOERP '+
                                  'AND FAT_00_01.COM_CODIGO = FAT_00_01_01.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_02 SET FAT_ID = COALESCE((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = FAT_00_02.FAT_INTEGRACAOERP '+
                                  'AND FAT_00.COM_CODIGO = FAT_00_02.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_02_01 SET FAT_02_ID = COALESCE((SELECT FAT_02_ID FROM FAT_00_02 '+
                                  'WHERE FAT_00_02.FAT_INTEGRACAOERP = FAT_00_02_01.FAT_INTEGRACAOERP '+
                                  'AND FAT_00_02.COM_CODIGO = FAT_00_02_01.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_03 SET FAT_ID = COALESCE((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = FAT_00_03.FAT_INTEGRACAOERP '+
                                  'AND FAT_00.COM_CODIGO = FAT_00_03.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_04 SET FAT_ID = COALESCE((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = FAT_00_04.FAT_INTEGRACAOERP '+
                                  'AND FAT_00.COM_CODIGO = FAT_00_04.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_05 SET FAT_ID = COALESCE((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = FAT_00_05.FAT_INTEGRACAOERP '+
                                  'AND FAT_00.COM_CODIGO = FAT_00_05.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE FAT_00_06 SET FAT_ID = COALESCE((SELECT FAT_ID FROM FAT_00 '+
                                  'WHERE FAT_00.FAT_INTEGRACAOERP = FAT_00_06.FAT_INTEGRACAOERP '+
                                  'AND FAT_00.COM_CODIGO = FAT_00_06.COM_CODIGO),0) ');

  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoID_SubTabelasFAT' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoID_SubTabelasOMF;
begin
  try
    // ID da tabela principal OMF_00 nas subtabelas.
    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_01 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_01.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_01.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_02 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_02.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_02.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_03 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_03.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_03.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_04 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_04.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_04.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_05 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_05.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_05.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_06 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_06.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_06.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_06_01 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_06_01.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_06_01.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_07 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_07.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_07.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_08 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_08.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_08.COM_CODIGO),0) ');

    ConnectionDestino.ExecuteSQL('UPDATE OMF_00_09 SET OMF_ID = COALESCE((SELECT OMF_ID FROM OMF_00 '+
                                  'WHERE OMF_00.OMF_INTEGRACAO = OMF_00_09.OMF_INTEGRACAOERP '+
                                  'AND OMF_00.COM_CODIGO = OMF_00_09.COM_CODIGO),0) ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertoID_SubTabelasOMF' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertosBaseERP_Origem;
begin
  try
    ConnectionOrigem.ExecuteSQL('UPDATE ORS_00 SET ORS_HORAEMISSAO = NULL ' +
                                 'WHERE ((ORS_HORAEMISSAO IS NULL) OR (LEN(LTRIM(RTRIM(ORS_HORAEMISSAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET TAB_CODIGOPADRAO = 0 ' +
                                 'WHERE ((TAB_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(TAB_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET PRZ_CODIGOPADRAO = 0 ' +
                                 'WHERE ((PRZ_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(PRZ_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET BCO_CODIGOPADRAO = 0 ' +
                                 'WHERE ((BCO_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(BCO_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET FPG_CODIGOPADRAO = 0 ' +
                                 'WHERE ((FPG_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(FPG_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET CTA_CODIGOPADRAO = 0 ' +
                                 'WHERE ((CTA_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(CTA_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET VND_CODIGOPADRAO = 0 ' +
                                 'WHERE ((VND_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(VND_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET CLI_CODIGOPADRAO = 0 ' +
                                 'WHERE ((CLI_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(CLI_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET TDC_CODIGOPADRAO = 0 ' +
                                 'WHERE ((TDC_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(TDC_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET NTO_CODIGOPADRAOCOMPRA = 0 ' +
                                 'WHERE ((NTO_CODIGOPADRAOCOMPRA IS NULL) OR (LEN(LTRIM(RTRIM(NTO_CODIGOPADRAOCOMPRA))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET NTO_CODIGOPADRAOVENDA = 0 ' +
                                 'WHERE ((NTO_CODIGOPADRAOVENDA IS NULL) OR (LEN(LTRIM(RTRIM(NTO_CODIGOPADRAOVENDA))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET NTO_CODIGOPADRAOVENDACPF = 0 ' +
                                 'WHERE ((NTO_CODIGOPADRAOVENDACPF IS NULL) OR (LEN(LTRIM(RTRIM(NTO_CODIGOPADRAOVENDACPF))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET TAB_CODIGOATACADO = 0 ' +
                                 'WHERE ((TAB_CODIGOATACADO IS NULL) OR (LEN(LTRIM(RTRIM(TAB_CODIGOATACADO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET TRP_CODIGOPADRAO = 0 ' +
                                 'WHERE ((TRP_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(TRP_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET POR_CODIGOPADRAO = 0 ' +
                                 'WHERE ((POR_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(POR_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET GRP_CODIGOPADRAO = 0 ' +
                                 'WHERE ((GRP_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(GRP_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET SGP_CODIGOPADRAO = 0 ' +
                                 'WHERE ((SGP_CODIGOPADRAO IS NULL) OR (LEN(LTRIM(RTRIM(SGP_CODIGOPADRAO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE FIL_00_01 SET NTO_CODIGOPADRAOSERVICO = 0 ' +
                                 'WHERE ((NTO_CODIGOPADRAOSERVICO IS NULL) OR (LEN(LTRIM(RTRIM(NTO_CODIGOPADRAOSERVICO))) = 0))');

    ConnectionOrigem.ExecuteSQL('UPDATE ORS_00 SET ORS_HORAFECHAMENTO = NULL ' +
                                 'WHERE ((ORS_HORAFECHAMENTO IS NULL) OR (LEN(LTRIM(RTRIM(ORS_HORAFECHAMENTO))) = 0))');

    ConnectionOrigem.ExecuteSQL(' IF  EXISTS (SELECT * ' +
                                 ' FROM sys.indexes AS si ' +
                                 ' WHERE si.name = ''CTA_00_pk'') ' +
                                 ' ALTER TABLE dbo.CTA_00 ' +
                                 ' DROP CONSTRAINT CTA_00_pk ');

    ConnectionOrigem.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00_02         ADD PDA_02_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00_02         ADD PDA_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SSE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SSE_00_02         ADD OMF_05_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SEE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SEE_00_02         ADD OMF_05_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SSE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SSE_00_02         ADD OMF_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SEE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SEE_00_02         ADD OMF_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SEE_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SEE_00_04         ADD OMF_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ONE_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ONE_00_03         ADD OMF_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SEE_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SEE_00_04         ADD OMF_06_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ONE_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ONE_00_03         ADD OMF_06_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_PES_CODIGO'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00         ADD SCR_PES_CODIGO INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ONE_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ONE_00_03_01         ADD OMF_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SEE_00_04_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SEE_00_04_01         ADD OMF_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ONE_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ONE_00_03_01         ADD OMF_06_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SEE_00_04_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SEE_00_04_01         ADD OMF_06_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SEE_00_04_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_06_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SEE_00_04_01         ADD OMF_06_01_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ONE_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''OMF_06_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ONE_00_03_01         ADD OMF_06_01_ID_OLD INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_PES_CODIGO'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02         ADD CRE_PES_CODIGO INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PES_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PES_USUARIOVINCULADO'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PES_00_02         ADD PES_USUARIOVINCULADO VARCHAR(250) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''AFC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''AFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.AFC_00         ADD AFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''AJU_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''AJU_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.AJU_00         ADD AJU_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00         ADD BCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCP_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_01      ADD BCP_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_01      ADD BCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCP_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_02      ADD BCP_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_02      ADD BCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_02      ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCP_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_03      ADD BCP_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_03      ADD BCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCP_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TLN_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCP_00_03      ADD TLN_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCR_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCR_00         ADD BCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCR_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCR_00_01      ADD BCR_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCR_00_01      ADD BCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCR_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCR_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCR_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCR_00_02      ADD BCR_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCR_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCR_00_02      ADD BCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCR_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCR_00_02      ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCT_00         ADD BCT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCT_00         ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCT_00_01      ADD BCT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCT_00_01      ADD BCT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCX_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00         ADD BCX_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00         ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00         ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCX_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00_01      ADD BCX_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCX_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00_01      ADD BCX_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCX_01_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00_01_01   ADD BCX_01_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCX_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00_01_01   ADD BCX_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCX_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00_01_01   ADD BCX_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BLC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BLC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BLC_00         ADD BLC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CCC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CCC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CCC_00         ADD CCC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CCC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CCC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CCC_00_01      ADD CCC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CCC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CCC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CCC_00_01      ADD CCC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CCC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CCC_00_01      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CDV_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CDV_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CDV_00         ADD CDV_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CDV_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CDV_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CDV_00_01      ADD CDV_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CDV_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CDV_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CDV_00_01      ADD CDV_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CEF_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CEF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CEF_00         ADD CEF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CEF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CEF_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CEF_00_01      ADD CEF_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CEF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CEF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CEF_00_01      ADD CEF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CFR_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CFR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CFR_00         ADD CFR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CGA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CGA_00         ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CGA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CGA_00_01      ADD CGA_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CGA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CGA_00_01      ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CGA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CGA_00_01      ADD PDA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CLT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CLT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CLT_00         ADD CLT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMD_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CMD_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMD_00         ADD CMD_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMD_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CMD_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMD_00_01      ADD CMD_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMD_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CMD_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMD_00_01      ADD CMD_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMD_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ONS_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMD_00_01      ADD ONS_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMD_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ONS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMD_00_01      ADD ONS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMP_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CMP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMP_00         ADD CMP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CMP_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMP_00_01      ADD CMP_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CMP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CMP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CMP_00_01      ADD CMP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00         ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_01      ADD CPA_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_01      ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TLN_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_01      ADD TLN_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_02      ADD CPA_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_02      ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_03      ADD CPA_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_03      ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_03_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_03_01   ADD CPA_03_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_03_01   ADD CPA_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_03_01   ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPF_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPF_00         ADD CPF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPF_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPF_00_01      ADD CPF_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPF_00_01      ADD CPF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPM_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPM_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPM_00         ADD CPM_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPM_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPM_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPM_00_01      ADD CPM_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPM_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPM_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPM_00_01      ADD CPM_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRB_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRB_00         ADD CRB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRB_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRB_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRB_00_01      ADD CRB_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRB_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRB_00_01      ADD CRB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00         ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00         ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_02_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02_01   ADD CRE_02_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02_01   ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_02_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02_02   ADD CRE_02_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02_02   ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_03      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_05      ADD CRE_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_05      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_05_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_05_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_05_01   ADD CRE_05_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_05_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_05_01   ADD CRE_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_05_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_05_01   ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRF_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRF_00         ADD CRF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRF_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRF_00_01      ADD CRF_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRF_00_01      ADD CRF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRF_00_01      ADD FAT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRF_00_01      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00         ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00         ADD LIB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CLT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_01      ADD CLT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_01      ADD CTR_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_01      ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_02      ADD CTR_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_02      ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_03      ADD CTR_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_03      ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_04      ADD CTR_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CTR_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CTR_00_04      ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DCH_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DCH_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DCH_00         ADD DCH_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DCH_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DCH_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DCH_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DCH_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DCH_00_01      ADD DCH_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DCH_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DCH_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DCH_00_01      ADD DCH_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DEV_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DEV_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DEV_00         ADD DEV_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DEV_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DEV_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DEV_00_01      ADD DEV_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DEV_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DEV_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DEV_00_01      ADD DEV_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DEV_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DEV_00_01      ADD FAT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DEV_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DEV_00_01      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DIZ_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DIZ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DIZ_00         ADD DIZ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DRQ_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DRQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DRQ_00         ADD DRQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DRQ_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DRQ_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DRQ_00_01      ADD DRQ_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''DRQ_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''DRQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.DRQ_00_01      ADD DRQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ETQ_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ETQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ETQ_00         ADD ETQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ETQ_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ETQ_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ETQ_00_01      ADD ETQ_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ETQ_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ETQ_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ETQ_00_02      ADD ETQ_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ETQG_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ETQG_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ETQG_00        ADD ETQG_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ETQP_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ETQP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ETQP_00        ADD ETQP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00         ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00         ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00         ADD LIB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00         ADD PDA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_01      ADD FAT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_01      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_01_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_01_01   ADD FAT_01_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_01_01   ADD FAT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_01_01   ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_02      ADD FAT_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_02      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_02_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_02_01   ADD FAT_02_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_02_01   ADD FAT_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_02_01   ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_03      ADD FAT_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_03      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_04      ADD FAT_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_04      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_05      ADD FAT_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_05      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_06      ADD FAT_06_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_06      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00_07'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_07_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00_07      ADD FAT_07_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FCM_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FCM_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FCM_00         ADD FCM_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FLP_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FLP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FLP_00         ADD FLP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FLP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FLP_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FLP_00_01      ADD FLP_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FLP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FLP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FLP_00_01      ADD FLP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''GNRE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.GNRE_00        ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''GNRE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''GNRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.GNRE_00        ADD GNRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''INV_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''INV_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.INV_00         ADD INV_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''INV_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''INV_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.INV_00_01      ADD INV_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''INVP_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''INVP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.INVP_00        ADD INVP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00         ADD LFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00_01      ADD LFE_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00_01      ADD LFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_01_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00_01_01   ADD LFE_01_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00_01_01   ADD LFE_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00_01_01   ADD LFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00_03      ADD LFE_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00_03      ADD LFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00         ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00         ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_01      ADD LFS_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_01      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_01_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_01_01   ADD LFS_01_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_01_01   ADD LFS_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_01_01   ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_01_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_01_02   ADD LFS_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_01_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_01_02   ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_02      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_03      ADD LFS_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_03      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_04      ADD LFS_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_04      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_05      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_06      ADD LFS_06_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_06      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_07'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_07_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_07      ADD LFS_07_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_07'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_07      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_08'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_08_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_08      ADD LFS_08_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00_08'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00_08      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LIB_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LIB_00         ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LIB_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LIB_00         ADD LIB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LIC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LIC_00         ADD LIC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LIC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LIC_00_01      ADD LIC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LIC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LIC_00_01      ADD LIC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LOG_XX'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LOG_VALUE_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LOG_XX         ADD LOG_VALUE_OLD int NULL '+
                                 ' END; ');


    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MEG_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MEG_00         ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MEG_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MEG_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MEG_00_01      ADD MEG_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MEG_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MEG_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MEG_00_01      ADD MEG_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MEG_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MEG_01_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MEG_00_01_01   ADD MEG_01_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MEG_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MEG_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MEG_00_01_01   ADD MEG_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MEG_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MEG_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MEG_00_01_01   ADD MEG_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00         ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_01      ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_01      ADD MFC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_01      ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_02      ADD MFC_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_02      ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_03      ADD MFC_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_03      ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_03_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_03_01   ADD MFC_03_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_03_01   ADD MFC_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_03_01   ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_04      ADD LFS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_04      ADD MFC_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_04      ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_05      ADD MFC_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_05      ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_06      ADD MFC_06_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MFC_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MFC_00_06      ADD MFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MTL_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MTL_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MTL_00         ADD MTL_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MTL_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MTL_00_01      ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MTL_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MTL_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MTL_00_01      ADD MTL_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MTL_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MTL_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MTL_00_01      ADD MTL_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MTL_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MTL_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MTL_00_02      ADD MTL_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MTL_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''MTL_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MTL_00_02      ADD MTL_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''MTL_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TLN_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.MTL_00_02      ADD TLN_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00  ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CMP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_01      ADD CMP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_01      ADD NFE_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_01      ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_02      ADD NFE_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_02      ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_03      ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_04      ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_05      ADD NFE_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_05      ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_06      ADD NFE_06_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_06'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_06      ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_06_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_06_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_06_01   ADD NFE_06_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_06_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_06_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_06_01   ADD NFE_06_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00_06_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00_06_01   ADD NFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_XML'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_XML        ADD NFE_XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00         ADD NFP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_01      ADD NFP_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_01      ADD NFP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_02      ADD NFP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_03      ADD NFP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_04      ADD NFP_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_04      ADD NFP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_05      ADD NFP_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_05      ADD NFP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_05_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_05_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_05_01   ADD NFP_05_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_05_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_05_01   ADD NFP_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFP_00_05_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFP_00_05_01   ADD NFP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00         ADD LIB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00         ADD ORS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_01      ADD ORS_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_01      ADD ORS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_01_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_01_01   ADD ORS_01_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_01_01   ADD ORS_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_01_01   ADD ORS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_02      ADD ORS_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_02      ADD ORS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_02_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_02_01   ADD ORS_02_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_02_01   ADD ORS_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_02_01   ADD ORS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_03      ADD ORS_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_MSC_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_03      ADD ORS_ID_MSC_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_03      ADD ORS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_04      ADD ORS_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00_04      ADD ORS_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PCH_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PCH_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PCH_00         ADD PCH_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PCH_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PCH_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PCH_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PCH_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PCH_00_01      ADD PCH_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PCH_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PCH_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PCH_00_01      ADD PCH_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00         ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00         ADD LIB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00         ADD PDA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00_01      ADD PDA_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00_01      ADD PDA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00_02      ADD PDA_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00_02      ADD PDA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00         ADD PDC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_01      ADD PDC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_01      ADD PDC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_02      ADD PDC_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_02      ADD PDC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_02_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_02_01   ADD PDC_02_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_02_01   ADD PDC_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_02_01   ADD PDC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_03      ADD PDC_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDC_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDC_00_03      ADD PDC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PMC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PMC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PMC_00         ADD PMC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PMC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PMC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PMC_00_01      ADD PMC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PMC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PMC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PMC_00_01      ADD PMC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPC_00         ADD PPC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPC_00_01      ADD PPC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPC_00_01      ADD PPC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00         ADD PPD_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01      ADD PPD_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01      ADD PPD_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_01_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01_01   ADD PPD_01_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01_01   ADD PPD_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01_01   ADD PPD_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_01_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01_02   ADD PPD_01_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01_02   ADD PPD_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PPD_00_01_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PPD_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PPD_00_01_02   ADD PPD_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PRT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PRT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PRT_00         ADD PRT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PRT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PRT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PRT_00_01      ADD PRT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PRT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PRT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PRT_00_01      ADD PRT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PVD_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PVD_00         ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PVD_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PVD_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PVD_00         ADD PVD_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RCC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RCC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RCC_00         ADD RCC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RCC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RCC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RCC_00_01      ADD RCC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RCC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RCC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RCC_00_01      ADD RCC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00         ADD REQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00_01      ADD REQ_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00_01      ADD REQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00_02      ADD REQ_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00_02      ADD REQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_02_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00_02_01   ADD REQ_02_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00_02_01   ADD REQ_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00_02_01   ADD REQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RETQ_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RETQ_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RETQ_00        ADD RETQ_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CGA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00         ADD CGA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00         ADD RFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_01      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_01      ADD RFC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_01      ADD RFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_02      ADD FAT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_02      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_02      ADD RFC_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_02      ADD RFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_03      ADD FAT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_03      ADD RFC_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_03      ADD RFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFC_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFC_00_04      ADD RFC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RFE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RFE_00         ADD RFE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00         ADD RPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00_01      ADD RPA_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00_01      ADD RPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00_02      ADD RPA_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00_02      ADD RPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_02_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00_02_01   ADD RPA_02_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00_02_01   ADD RPA_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''RPA_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''RPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.RPA_00_02_01   ADD RPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00         ADD SCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_01      ADD CPA_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_01      ADD SCP_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_01      ADD SCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_02      ADD SCP_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_02      ADD SCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_03      ADD SCP_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_03      ADD SCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_03_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_03_01   ADD SCP_03_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_03_01   ADD SCP_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCP_00_03_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCP_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCP_00_03_01   ADD SCP_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00         ADD SCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_01      ADD SCR_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_01      ADD SCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_02      ADD SCR_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_02      ADD SCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_03      ADD SCR_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_03      ADD SCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_04      ADD SCR_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_04'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_04      ADD SCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_04_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_04_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_04_01   ADD SCR_04_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_04_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_04_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_04_01   ADD SCR_04_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_04_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_04_01   ADD SCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_05_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_05      ADD SCR_05_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCR_00_05'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCR_00_05      ADD SCR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCT_00         ADD SCT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCT_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CTR_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCT_00_01      ADD CTR_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCT_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCT_00_01      ADD SCT_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCT_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCT_00_01      ADD SCT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCT_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCT_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCT_00_02      ADD SCT_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''SCT_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''SCT_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.SCT_00_02      ADD SCT_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TLN_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TLN_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TLN_00         ADD TLN_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TPO_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TPO_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TPO_00         ADD TPO_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TPO_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TPO_00_01      ADD CRE_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TPO_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TPO_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TPO_00_01      ADD TPO_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TPO_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TPO_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TPO_00_01      ADD TPO_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TRC_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TRC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TRC_00         ADD TRC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TRC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TRC_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TRC_00_01      ADD TRC_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''TRC_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''TRC_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.TRC_00_01      ADD TRC_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LIB_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00         ADD LIB_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''VEF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00         ADD VEF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''VEF_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00_01      ADD VEF_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''VEF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00_01      ADD VEF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''VEF_02_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00_02      ADD VEF_02_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''VEF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00_02      ADD VEF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''VEF_03_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00_03      ADD VEF_03_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''VEF_00_03'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''VEF_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.VEF_00_03      ADD VEF_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_CTE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_CTE_00     ADD XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_CTE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_CTE_00_01  ADD XML_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_CTE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_CTE_00_01  ADD XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_MDFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_MDFE_00    ADD XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_MDFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_MDFE_00_01 ADD XML_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_MDFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_MDFE_00_01 ADD XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_NFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_NFE_00     ADD XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_NFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_01_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_NFE_00_01  ADD XML_01_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_NFE_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_NFE_00_01  ADD XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_NFSE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_ID_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_NFSE_00    ADD XML_ID_OLD int NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''BCX_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''BCX_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.BCX_00         ADD BCX_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00         ADD CPA_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CPA_00_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CPA_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CPA_00_01      ADD CPA_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRB_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRB_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRB_00         ADD CRB_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00         ADD CRE_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02_01'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02_01   ADD CRE_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''CRE_00_02_02'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''CRE_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.CRE_00_02_02   ADD CRE_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FAT_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FAT_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FAT_00         ADD FAT_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''FCM_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''FCM_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FCM_00         ADD FCM_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''GNRE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''GNRE_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.GNRE_00        ADD GNRE_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFE_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFE_00         ADD LFE_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''LFS_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''LFS_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.LFS_00         ADD LFS_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_00         ADD NFE_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''NFE_XML'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''NFE_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.NFE_XML        ADD NFE_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''ORS_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''ORS_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.ORS_00         ADD ORS_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''PDA_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''PDA_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.PDA_00         ADD PDA_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''REQ_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''REQ_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.REQ_00         ADD REQ_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_CTE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_CTE_00     ADD XML_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_MDFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_MDFE_00    ADD XML_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_NFE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_NFE_00     ADD XML_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL('  IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ''XML_NFSE_00'' '+
                                 ' AND COLUMNS.COLUMN_NAME = ''XML_INTEGRACAO_OLD'') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.XML_NFSE_00    ADD XML_INTEGRACAO_OLD VARCHAR(50) NULL '+
                                 ' END; ');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertosBaseERP_Origem' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertosBaseExpress_Destino;
begin
  try
    // Criando tabelas criadas no ERP.
    ConnectionDestino.ExecuteSQL('IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '               WHERE COLUMNS.TABLE_NAME = ''FAT_01_LOGS'') '+
                                  '  BEGIN '+
                                  '    CREATE TABLE FAT_01_LOGS ( '+
                                  '      FAT_ID_LOG INT IDENTITY '+
                                  '      ,COM_CODIGO VARCHAR(3) NOT NULL '+
                                  '      ,FAT_DATALOG DATE NULL '+
                                  '      ,FAT_HORALOG VARCHAR(8) NULL '+
                                  '      ,FAT_LOG INT NULL '+
                                  '      ,FAT_ID INT NULL '+
                                  '      ,FAT_NUMEROOS INT NULL '+
                                  '      ,PRO_CODIGO VARCHAR(6) NULL '+
                                  '      ,FAT_QTDPEDIDA DECIMAL(18, 3) NULL '+
                                  '      ,USERS_LOGIN VARCHAR(20) NULL '+
                                  '      ,FAT_TIPOLOG VARCHAR(3) NULL '+
                                  '      ,FAT_TIPODOCUMENTO VARCHAR(5) NULL '+
                                  '      ,FAT_TIPOPRODUTO VARCHAR(3) NULL '+
                                  '      ,CONSTRAINT FAT_01_LOG_pk PRIMARY KEY CLUSTERED (FAT_ID_LOG) WITH (FILLFACTOR = 80) '+
                                  '    ) ON [PRIMARY] '+
                                  '  END ');

    ConnectionDestino.ExecuteSQL('IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '               WHERE COLUMNS.TABLE_NAME = ''CLT_XML'') '+
                                  '  BEGIN '+
                                  '    CREATE TABLE dbo.CLT_XML ( '+
                                  '      CLT_XML_ID int NOT NULL '+
                                  '      ,CLT_NSU int NOT NULL '+
                                  '      ,CLT_NOTAFISCAL varchar(9) NULL '+
                                  '      ,CLT_SERIE varchar(3) NULL '+
                                  '      ,CLT_CHAVEACESSO varchar(44) NULL '+
                                  '      ,CLT_CNPJEMITENTE varchar(14) NULL '+
                                  '      ,CLT_RAZAOEMITENTE varchar(50) NULL '+
                                  '      ,CLT_IEEMITENTE varchar(16) NULL '+
                                  '      ,CLT_DATAEMISSAO date NULL '+
                                  '      ,CLT_TIPOOPERACAO varchar(1) NULL '+
                                  '      ,CLT_TOTALNOTAFISCAL decimal(18, 2) NULL '+
                                  '      ,CLT_STATUSNFE varchar(1) NULL '+
                                  '      ,CLT_STATUSMANIFESTACAO varchar(1) NULL '+
                                  '      ,CLT_BAIXADA varchar(1) NULL '+
                                  '      ,CLT_IMPORTADA varchar(1) NULL '+
                                  '      ,CLT_DATAINCLUSAO date NULL '+
                                  '      ,CLT_HORAINCLUSAO varchar(8) NULL '+
                                  '      ,CLT_INTEGRACAO varchar(20) NULL '+
                                  '      CONSTRAINT CLT_XML_pk PRIMARY KEY CLUSTERED (CLT_XML_ID) '+
                                  '    WITH ( '+
                                  '      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, '+
                                  '      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) '+
                                  '    ) ON [PRIMARY] '+
                                  '  END ');

  ConnectionDestino.ExecuteSQL('IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                '               WHERE COLUMNS.TABLE_NAME = ''EXP_00'') '+
                                '  BEGIN '+
                                '    CREATE TABLE dbo.EXP_00 ( '+
                                '      EXP_ID INT NOT NULL '+
                                '      ,COM_CODIGO int NOT NULL '+
                                '      ,EXP_DATAEXPEDICAO DATE NULL '+
                                '      ,MOV_ID INT NULL '+
                                '      ,MOV_TIPO VARCHAR(3) NULL '+
                                '      ,EXP_CANCELADA VARCHAR(1) NULL '+
                                '      CONSTRAINT EXP_00_pk PRIMARY KEY CLUSTERED (EXP_ID) '+
                                '    WITH ( '+
                                '      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, '+
                                '      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) '+
                                '    ) ON [PRIMARY] '+
                                '  END ');

    ConnectionDestino.ExecuteSQL('IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '               WHERE COLUMNS.TABLE_NAME = ''EXP_00_01'') '+
                                  '  BEGIN '+
                                  '    CREATE TABLE dbo.EXP_00_01 ( '+
                                  '      EXP_01_ID int NOT NULL '+
                                  '      ,COM_CODIGO int NOT NULL '+
                                  '      ,EXP_ID int NULL '+
                                  '      ,MOV_01_ID int NULL '+
                                  '      ,PRO_CODIGO int NULL '+
                                  '      ,EXP_QTDPEDIDO decimal(18, 4) NULL '+
                                  '      ,EXP_QTDEXPEDIDA decimal(18, 4) NULL '+
                                  '      ,MOV_TIPO varchar(3) NULL '+
                                  '      ,MOV_PRODUTOSEMEXPEDICAO varchar(1) NULL '+
                                  '      CONSTRAINT EXP_00_01_pk PRIMARY KEY CLUSTERED (EXP_01_ID) '+
                                  '    WITH ( '+
                                  '      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, '+
                                  '      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) '+
                                  '    ) ON [PRIMARY] '+
                                  '  END ');

    ConnectionDestino.ExecuteSQL('IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '               WHERE COLUMNS.TABLE_NAME = ''SPEDF_AJUSTE'') '+
                                  '  BEGIN '+
                                  '    CREATE TABLE dbo.SPEDF_AJUSTE ( '+
                                  '       COD_AJ varchar(10) NOT NULL'+
                                  '      ,DESC_AJ varchar(300) NULL '+
                                  '      CONSTRAINT COD_AJ_pk PRIMARY KEY CLUSTERED (COD_AJ) '+
                                  '    WITH ( '+
                                  '      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, '+
                                  '      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) '+
                                  '    ) ON [PRIMARY] '+
                                  '  END ');

    // Criando novas colunas que foram criadas no ERP.
    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CLT_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CLT_INTEGRACAO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CLT_00 ADD CLT_INTEGRACAO varchar(20) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CPF_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CPF_ORDEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CPF_00_01 ADD CPF_ORDEM int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CRE_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CRE_VALORTARIFABANCARIA') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CRE_00_01 ADD CRE_VALORTARIFABANCARIA decimal(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CTA_00_05') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CTA_TIPODIASPROTESTO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CTA_00_05 ADD CTA_TIPODIASPROTESTO varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FAT_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('FAT_PERCENTUALICMSCOMPETE') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.FAT_00_01 ADD FAT_PERCENTUALICMSCOMPETE decimal(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CONFIG_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CFG_SIGLA') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CONFIG_00 ADD CFG_SIGLA varchar(6) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CONFIG_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CFG_NOMESOCIOPRIETARIO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CONFIG_00 ADD CFG_NOMESOCIOPRIETARIO varchar(50) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CONFIG_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CFG_EMAILCONTABILXML') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CONFIG_00_01 ADD CFG_EMAILCONTABILXML varchar(300) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('CONFIG_00_02') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CTR_ULTIMONSUCOLETA') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.CONFIG_00_02 ADD CTR_ULTIMONSUCOLETA int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FPG_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('FPG_BLOQUEARDESCONTO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.FPG_00 ADD FPG_BLOQUEARDESCONTO varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FPG_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('TAB_CODIGO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.FPG_00 ADD TAB_CODIGO int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LEE_00_03') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LEE_PERCENTUALICMSCOMPETE') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LEE_00_03 ADD LEE_PERCENTUALICMSCOMPETE decimal(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFE_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFE_TOTALICMSDESONERADO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFE_00 ADD LFE_TOTALICMSDESONERADO decimal(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFE_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFE_PORTEFORNECEDOR') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFE_00 ADD LFE_PORTEFORNECEDOR varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFE_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFE_VALORICMSDESONERADOITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFE_00_01_01 ADD LFE_VALORICMSDESONERADOITEM decimal(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFE_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFE_PROCEDENCIA') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFE_00_01_01 ADD LFE_PROCEDENCIA varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFE_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFE_TOTALSERVICOITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFE_00_01_01 ADD LFE_TOTALSERVICOITEM decimal(18, 2) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFE_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFE_TOTALBCICMSFRETENFITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFE_00_01_01 ADD LFE_TOTALBCICMSFRETENFITEM decimal(18, 2) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFE_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFE_TOTALICMSFRETENFITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFE_00_01_01 ADD LFE_TOTALICMSFRETENFITEM decimal(18, 2) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFS_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFS_TOTALICMSDESONERADOITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFS_00_01_01 ADD LFS_TOTALICMSDESONERADOITEM decimal(18, 2) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFS_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFS_TOTALSERVICOITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFS_00_01_01 ADD LFS_TOTALSERVICOITEM decimal(18, 2) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFS_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFS_TOTALBCICMSFRETENFITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFS_00_01_01 ADD LFS_TOTALBCICMSFRETENFITEM decimal(18, 2) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('LFS_00_01_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('LFS_TOTALICMSFRETENFITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.LFS_00_01_01 ADD LFS_TOTALICMSFRETENFITEM decimal(18, 2) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('NFE_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('NFE_TOTALICMSDESONERADO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.NFE_00 ADD NFE_TOTALICMSDESONERADO decimal(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('NFE_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('NFE_PORTEFORNECEDOR') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.NFE_00 ADD NFE_PORTEFORNECEDOR varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('NFE_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('COD_AJ') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.NFE_00 ADD COD_AJ varchar(10) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('NFE_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('NFE_VALORICMSDESONERADOITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.NFE_00_01 ADD NFE_VALORICMSDESONERADOITEM decimal(18, 2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('NFE_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('NFE_PROCEDENCIA') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.NFE_00_01 ADD NFE_PROCEDENCIA varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('NTO_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('NTO_EMITIRNFSE') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.NTO_00 ADD NTO_EMITIRNFSE varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FAT_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('FAT_VALORDESCTOCDCITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.FAT_00_01 ADD FAT_VALORDESCTOCDCITEM decimal(18, 6) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FAT_00_01') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('FAT_TOTALCOFINSITEM') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.FAT_00_01 ADD FAT_TOTALCOFINSITEM decimal(18, 6) DEFAULT 0 NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('PES_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('PLC_CODIGO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.PES_00 ADD PLC_CODIGO int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('PES_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('CCU_CODIGO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.PES_00 ADD CCU_CODIGO int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('PRZ_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('TAB_CODIGO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.PRZ_00 ADD TAB_CODIGO int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('OMF_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('OMF_TIPOLIGACAO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.OMF_00 ADD OMF_TIPOLIGACAO varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('OMF_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('OMF_GRUPOTENSAO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.OMF_00 ADD OMF_GRUPOTENSAO varchar(2) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('TRC_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('FUN_CODIGO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.TRC_00 ADD FUN_CODIGO int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('TRC_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('VND_CODIGO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.TRC_00 ADD VND_CODIGO int NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('TRC_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('TRC_DEBITARESTOQUE') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.TRC_00 ADD TRC_DEBITARESTOQUE varchar(1) NULL '+
                                  ' END; ');

    ConnectionDestino.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '                WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FAT_00') + ' '+
                                  '                AND COLUMNS.COLUMN_NAME = ' + QuotedStr('FAT_NUMEROLICITACAO') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE dbo.FAT_00 ADD FAT_NUMEROLICITACAO varchar(20) NULL '+
                                  ' END; ');

    //Alterando os tipos dos campos
    ConnectionDestino.ExecuteSQL(' ALTER TABLE MFC_00 '+
                                  ' ALTER COLUMN MFC_NUMEROCIOT VARCHAR(16)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE ORS_00 '+
                                  ' ALTER COLUMN ORS_HORAEMISSAO VARCHAR(10)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE ORS_00 '+
                                  ' ALTER COLUMN ORS_HORAFECHAMENTO VARCHAR(10)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_MDFE_00_01 '+
                                  ' ALTER COLUMN XML_XMLEVENTO NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_NFE_00_01 '+
                                  ' ALTER COLUMN XML_XMLEVENTO NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_NFE_00 '+
                                  ' ALTER COLUMN XML_XMLNOTAFISCAL NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_NFE_00 '+
                                  ' ALTER COLUMN XML_XMLNOTAFISCALCOMAUTORIZACAO NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_NFE_00 '+
                                  ' ALTER COLUMN XML_XMLINUTILIZACAO NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_NFE_00 '+
                                  ' ALTER COLUMN XML_XMLDPEC NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_NFE_00 '+
                                  ' ALTER COLUMN XML_XMLCARTACORRECAO NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE XML_NFE_00 '+
                                  ' ALTER COLUMN XML_XMLAUTORIZACAOCCE NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE OMF_00 '+
                                  ' ALTER COLUMN OMF_CHAVEREFERENCIANFE NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE CONFIG_00 '+
                                  ' ALTER COLUMN CFG_LICENSEKEY NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE CONFIG_00 '+
                                  ' ALTER COLUMN CFG_LICENSEKEYACTIVATION NVARCHAR(MAX)');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE FAT_00 '+
                                  ' ALTER COLUMN FAT_TOTALPESOBRUTO DECIMAL(18, 4) NULL');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE FAT_00 '+
                                  ' ALTER COLUMN FAT_TOTALPESOLIQUIDO DECIMAL(18, 4) NOT NULL');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE CMP_00_01 '+
                                  ' ALTER COLUMN CMP_VALORITEM decimal(18, 10) NOT NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE CMP_00_01 '+
                                  ' ALTER COLUMN CMP_VALORFORNECEDOR decimal(18, 10) NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE CTA_00_05 '+
                                  ' ALTER COLUMN CTA_AGENCIA varchar(10) NOT NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE CTA_00_05 '+
                                  ' ALTER COLUMN CTA_DIGITOAGENCIA varchar(5) NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE LEE_00 '+
                                  ' ALTER COLUMN LEE_TIPOCLIENTE varchar(10) NOT NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE LFS_00_01_01 '+
                                  ' ALTER COLUMN LFS_TOTALBASECALCULOFCPITEM decimal(18, 2) NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE NFE_00_01 '+
                                  ' ALTER COLUMN NFE_VALORITEM decimal(18, 10) NOT NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE NFE_00_01 '+
                                  ' ALTER COLUMN NFE_VALORIPIITEM decimal(18, 10) NOT NULL ');

    ConnectionDestino.ExecuteSQL(' ALTER TABLE MDO_00 '+
                                  ' ALTER COLUMN MDO_DESCRICAO varchar(300) NOT NULL ');

    // Deleteando Constraints
    ConnectionDestino.ExecuteSQL(' IF EXISTS (SELECT '+
                                  '              con.[name] '+
                                  '            FROM sys.default_constraints con '+
                                  '            LEFT OUTER JOIN sys.objects t '+
                                  '              ON con.parent_object_id = t.object_id '+
                                  '            LEFT OUTER JOIN sys.all_columns col '+
                                  '              ON con.parent_column_id = col.column_id '+
                                  '              AND con.parent_object_id = col.object_id '+
                                  '            WHERE con.[name] = ' + QuotedStr('DF__CONFIG_00__CFG_L__09D52582') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CONFIG_00 '+
                                  '   DROP CONSTRAINT DF__CONFIG_00__CFG_L__09D52582'+
                                  ' END;');

    ConnectionDestino.ExecuteSQL(' IF EXISTS (SELECT '+
                                  '              con.[name] '+
                                  '            FROM sys.default_constraints con '+
                                  '            LEFT OUTER JOIN sys.objects t '+
                                  '              ON con.parent_object_id = t.object_id '+
                                  '            LEFT OUTER JOIN sys.all_columns col '+
                                  '              ON con.parent_column_id = col.column_id '+
                                  '              AND con.parent_object_id = col.object_id '+
                                  '            WHERE con.[name] = ' + QuotedStr('DF__CONFIG_00__CFG_L__0AC949BB') + ') '+
                                  ' BEGIN '+
                                  '   ALTER TABLE CONFIG_00 '+
                                  '   DROP CONSTRAINT DF__CONFIG_00__CFG_L__0AC949BB'+
                                  ' END;');

    // Renomear Field
    ConnectionDestino.ExecuteSQL('IF EXISTS (SELECT 1 '+
                                  '           FROM INFORMATION_SCHEMA.COLUMNS '+
                                  '           WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FAT_00_02_01') +' '+
                                  '           AND COLUMNS.COLUMN_NAME = ' + QuotedStr('PRO_CODIGO') + ') '+
                                  'BEGIN '+
                                  '  EXEC sp_rename N' + QuotedStr('dbo.FAT_00_02_01.PRO_CODIGO') + ', N' + QuotedStr('MDO_CODIGO') + ', '+ QuotedStr('COLUMN') + '; '+
                                  'END;');
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AcertosBaseExpress_Destino' + #13#13 + EXC.Message), 'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TDtmMigrationExpress.AcertoSequenciaNumOrcamentoFAT;
begin
  if FIL_00.RecordCount > 0 then
  begin
    FIL_00.First;
    while not (FIL_00.Eof) do
    begin
      if (FIL_00.FieldByName('COM_CODIGO').AsString.Length > 0) then
      begin
        try
          ConnectionDestino.ExecuteSQL(' WITH CTE AS ( '+
                                        '   SELECT ROW_NUMBER() OVER(ORDER BY FAT_ID) AS ''NUMEROOC'', *  '+
                                        '   FROM FAT_00  '+
                                        '   WHERE COM_CODIGO = ' + FIL_00.FieldByName('COM_CODIGO').AsString +
                                        ' ) '+
                                        ' UPDATE CTE SET FAT_NUMEROOC = NUMEROOC ');

          ConnectionDestino.ExecuteSQL(' UPDATE COD_00 SET COD_00.COD_SEQUENCIA = (SELECT MAX(f.FAT_NUMEROOC) FROM FAT_00 f) '+
                                        ' WHERE COD_00.COD_FIELD = ''FAT_NUMEROOC'' '+
                                        ' AND COM_CODIGO = ' + FIL_00.FieldByName('COM_CODIGO').AsString + ' ');
        except on EXC : Exception do
          begin
            Application.MessageBox(PChar('TDtmMigrationExpress.AddComCodigoFilSelecionado_FIL00' + #13#13 + EXC.Message),'Perigo', MB_OK + MB_ICONWARNING);
          end;
        end;
      end;
      FIL_00.Next;
    end;
  end;
end;

procedure TDtmMigrationExpress.AddComCodigoFilSelecionado_FIL00;
begin
  try
    ConnectionOrigem.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FIL_00') + ' '+
                                 ' AND COLUMNS.COLUMN_NAME = ' + QuotedStr('COM_CODIGO') + ') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FIL_00 ADD COM_CODIGO INT NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL(' IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS '+
                                 ' WHERE COLUMNS.TABLE_NAME = ' + QuotedStr('FIL_00') + ' '+
                                 ' AND COLUMNS.COLUMN_NAME = ' + QuotedStr('FIL_SELECIONADO')+ ') '+
                                 ' BEGIN '+
                                 ' 	ALTER TABLE dbo.FIL_00 ADD FIL_SELECIONADO VARCHAR(1) DEFAULT ' + QuotedStr('S') + ' NULL '+
                                 ' END; ');

    ConnectionOrigem.ExecuteSQL(' UPDATE FIL_00 SET FIL_00.FIL_SELECIONADO = ' + QuotedStr('S') + ' ');
  except on EXC : Exception do
    begin
      Application.MessageBox(PChar('TDtmMigrationExpress.AddComCodigoFilSelecionado_FIL00' + #13#13 + EXC.Message),'Perigo', MB_OK + MB_ICONWARNING);
    end;
  end;
end;

end.
