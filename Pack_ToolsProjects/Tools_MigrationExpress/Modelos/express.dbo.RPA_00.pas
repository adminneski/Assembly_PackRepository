unit express.dbo.RPA_00;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('RPA_00', '')]
  [PrimaryKey('RPA_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RPA_ID')]
  TDtoRPA_00 = class
  private
    { Private declarations } 
    FRPA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FRPA_NOTAFISCAL: String;
    FRPA_COMPETENCIA: String;
    FRPA_TIPODOCUMENTO: String;
    FRPA_NUMERODOCTO: String;
    FRPA_TIPOSERVICO: String;
    FRPA_TOTALIRF: Double;
    FRPA_TOTALSEST_SENAT: Double;
    FRPA_TOTALINSSSEGURO: Double;
    FRPA_TOTALINSS: Double;
    FRPA_PERCENTUALINSS: Double;
    FRPA_TOTALBCSERVICOPRESTADO: Double;
    FRPA_TOTALBASECALCULOINSS: Double;
    FRPA_TOTALPENSAOALIMENTICIA: Double;
    FRPA_TOTALSERVICOPRESTADO: Double;
    FRPA_CAMPOLIVRE_1: String;
    FRPA_TOTALCAMPOLIVRE_1: Double;
    FRPA_CAMPOLIVRE_2: String;
    FRPA_TOTALCAMPOLIVRE_2: Double;
    FRPA_CAMPOLIVRE_3: String;
    FRPA_TOTALCAMPOLIVRE_3: Double;
    FRPA_TOTALLIQUIDO: Double;
    FRPA_PROCESSADO: String;
    FRPA_CANCELADO: String;
    FRPA_DATACANCELAMENTO: TDateTime;
    FRPA_OBSERVACAOCANCELAMENTO: String;
    FRPA_PLANOCONTARATEIO: Double;
    FRPA_DATALANCAMENTO: TDateTime;
    FRPA_DATAALTERACAO: TDateTime;
    FLEF_CODIGO: Integer;
    FNTO_CODIGO: Integer;
    FRPA_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'RPA_00';
     const PrimaryKey = 'RPA_ID';
     const Sequence   = 'SEQ_RPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_ID', ftInteger)]
    [Dictionary('RPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID: Integer read FRPA_ID write FRPA_ID;
    const RPA_ID_Name = 'RPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RPA_NOTAFISCAL', ftString, 100)]
    [Dictionary('RPA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_NOTAFISCAL: String read FRPA_NOTAFISCAL write FRPA_NOTAFISCAL;
    const RPA_NOTAFISCAL_Name = 'RPA_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('RPA_COMPETENCIA', ftString, 6)]
    [Dictionary('RPA_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_COMPETENCIA: String read FRPA_COMPETENCIA write FRPA_COMPETENCIA;
    const RPA_COMPETENCIA_Name = 'RPA_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('RPA_TIPODOCUMENTO', ftString, 1)]
    [Dictionary('RPA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_TIPODOCUMENTO: String read FRPA_TIPODOCUMENTO write FRPA_TIPODOCUMENTO;
    const RPA_TIPODOCUMENTO_Name = 'RPA_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('RPA_NUMERODOCTO', ftString, 6)]
    [Dictionary('RPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_NUMERODOCTO: String read FRPA_NUMERODOCTO write FRPA_NUMERODOCTO;
    const RPA_NUMERODOCTO_Name = 'RPA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('RPA_TIPOSERVICO', ftString, 100)]
    [Dictionary('RPA_TIPOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_TIPOSERVICO: String read FRPA_TIPOSERVICO write FRPA_TIPOSERVICO;
    const RPA_TIPOSERVICO_Name = 'RPA_TIPOSERVICO';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALIRF', ftBCD, 656419879, 2)]
    [Dictionary('RPA_TOTALIRF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALIRF: Double read FRPA_TOTALIRF write FRPA_TOTALIRF;
    const RPA_TOTALIRF_Name = 'RPA_TOTALIRF';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALSEST_SENAT', ftBCD, 6881394, 2)]
    [Dictionary('RPA_TOTALSEST_SENAT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALSEST_SENAT: Double read FRPA_TOTALSEST_SENAT write FRPA_TOTALSEST_SENAT;
    const RPA_TOTALSEST_SENAT_Name = 'RPA_TOTALSEST_SENAT';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALINSSSEGURO', ftBCD, 1699555104, 2)]
    [Dictionary('RPA_TOTALINSSSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALINSSSEGURO: Double read FRPA_TOTALINSSSEGURO write FRPA_TOTALINSSSEGURO;
    const RPA_TOTALINSSSEGURO_Name = 'RPA_TOTALINSSSEGURO';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALINSS', ftBCD, 544040295, 2)]
    [Dictionary('RPA_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALINSS: Double read FRPA_TOTALINSS write FRPA_TOTALINSS;
    const RPA_TOTALINSS_Name = 'RPA_TOTALINSS';

    [Restrictions([NoValidate])]
    [Column('RPA_PERCENTUALINSS', ftBCD, 1981834596, 2)]
    [Dictionary('RPA_PERCENTUALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_PERCENTUALINSS: Double read FRPA_PERCENTUALINSS write FRPA_PERCENTUALINSS;
    const RPA_PERCENTUALINSS_Name = 'RPA_PERCENTUALINSS';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALBCSERVICOPRESTADO', ftBCD, 1142962771, 2)]
    [Dictionary('RPA_TOTALBCSERVICOPRESTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALBCSERVICOPRESTADO: Double read FRPA_TOTALBCSERVICOPRESTADO write FRPA_TOTALBCSERVICOPRESTADO;
    const RPA_TOTALBCSERVICOPRESTADO_Name = 'RPA_TOTALBCSERVICOPRESTADO';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALBASECALCULOINSS', ftBCD, 1411398223, 2)]
    [Dictionary('RPA_TOTALBASECALCULOINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALBASECALCULOINSS: Double read FRPA_TOTALBASECALCULOINSS write FRPA_TOTALBASECALCULOINSS;
    const RPA_TOTALBASECALCULOINSS_Name = 'RPA_TOTALBASECALCULOINSS';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALPENSAOALIMENTICIA', ftBCD, 539780974, 2)]
    [Dictionary('RPA_TOTALPENSAOALIMENTICIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALPENSAOALIMENTICIA: Double read FRPA_TOTALPENSAOALIMENTICIA write FRPA_TOTALPENSAOALIMENTICIA;
    const RPA_TOTALPENSAOALIMENTICIA_Name = 'RPA_TOTALPENSAOALIMENTICIA';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALSERVICOPRESTADO', ftBCD, 5177428, 2)]
    [Dictionary('RPA_TOTALSERVICOPRESTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALSERVICOPRESTADO: Double read FRPA_TOTALSERVICOPRESTADO write FRPA_TOTALSERVICOPRESTADO;
    const RPA_TOTALSERVICOPRESTADO_Name = 'RPA_TOTALSERVICOPRESTADO';

    [Restrictions([NoValidate])]
    [Column('RPA_CAMPOLIVRE_1', ftString, 50)]
    [Dictionary('RPA_CAMPOLIVRE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CAMPOLIVRE_1: String read FRPA_CAMPOLIVRE_1 write FRPA_CAMPOLIVRE_1;
    const RPA_CAMPOLIVRE_1_Name = 'RPA_CAMPOLIVRE_1';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALCAMPOLIVRE_1', ftBCD, 2097273, 2)]
    [Dictionary('RPA_TOTALCAMPOLIVRE_1', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALCAMPOLIVRE_1: Double read FRPA_TOTALCAMPOLIVRE_1 write FRPA_TOTALCAMPOLIVRE_1;
    const RPA_TOTALCAMPOLIVRE_1_Name = 'RPA_TOTALCAMPOLIVRE_1';

    [Restrictions([NoValidate])]
    [Column('RPA_CAMPOLIVRE_2', ftString, 50)]
    [Dictionary('RPA_CAMPOLIVRE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CAMPOLIVRE_2: String read FRPA_CAMPOLIVRE_2 write FRPA_CAMPOLIVRE_2;
    const RPA_CAMPOLIVRE_2_Name = 'RPA_CAMPOLIVRE_2';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALCAMPOLIVRE_2', ftBCD, 4456531, 2)]
    [Dictionary('RPA_TOTALCAMPOLIVRE_2', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALCAMPOLIVRE_2: Double read FRPA_TOTALCAMPOLIVRE_2 write FRPA_TOTALCAMPOLIVRE_2;
    const RPA_TOTALCAMPOLIVRE_2_Name = 'RPA_TOTALCAMPOLIVRE_2';

    [Restrictions([NoValidate])]
    [Column('RPA_CAMPOLIVRE_3', ftString, 50)]
    [Dictionary('RPA_CAMPOLIVRE_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CAMPOLIVRE_3: String read FRPA_CAMPOLIVRE_3 write FRPA_CAMPOLIVRE_3;
    const RPA_CAMPOLIVRE_3_Name = 'RPA_CAMPOLIVRE_3';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALCAMPOLIVRE_3', ftBCD, 1195983951, 2)]
    [Dictionary('RPA_TOTALCAMPOLIVRE_3', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALCAMPOLIVRE_3: Double read FRPA_TOTALCAMPOLIVRE_3 write FRPA_TOTALCAMPOLIVRE_3;
    const RPA_TOTALCAMPOLIVRE_3_Name = 'RPA_TOTALCAMPOLIVRE_3';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALLIQUIDO', ftBCD, 1397311055, 2)]
    [Dictionary('RPA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALLIQUIDO: Double read FRPA_TOTALLIQUIDO write FRPA_TOTALLIQUIDO;
    const RPA_TOTALLIQUIDO_Name = 'RPA_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_PROCESSADO', ftString, 1)]
    [Dictionary('RPA_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_PROCESSADO: String read FRPA_PROCESSADO write FRPA_PROCESSADO;
    const RPA_PROCESSADO_Name = 'RPA_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_CANCELADO', ftString, 1)]
    [Dictionary('RPA_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CANCELADO: String read FRPA_CANCELADO write FRPA_CANCELADO;
    const RPA_CANCELADO_Name = 'RPA_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('RPA_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('RPA_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RPA_DATACANCELAMENTO: TDateTime read FRPA_DATACANCELAMENTO write FRPA_DATACANCELAMENTO;
    const RPA_DATACANCELAMENTO_Name = 'RPA_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('RPA_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('RPA_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_OBSERVACAOCANCELAMENTO: String read FRPA_OBSERVACAOCANCELAMENTO write FRPA_OBSERVACAOCANCELAMENTO;
    const RPA_OBSERVACAOCANCELAMENTO_Name = 'RPA_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('RPA_PLANOCONTARATEIO', ftBCD, 218762555, 2)]
    [Dictionary('RPA_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_PLANOCONTARATEIO: Double read FRPA_PLANOCONTARATEIO write FRPA_PLANOCONTARATEIO;
    const RPA_PLANOCONTARATEIO_Name = 'RPA_PLANOCONTARATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('RPA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RPA_DATALANCAMENTO: TDateTime read FRPA_DATALANCAMENTO write FRPA_DATALANCAMENTO;
    const RPA_DATALANCAMENTO_Name = 'RPA_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('RPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RPA_DATAALTERACAO: TDateTime read FRPA_DATAALTERACAO write FRPA_DATAALTERACAO;
    const RPA_DATAALTERACAO_Name = 'RPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RPA_ID_OLD', ftInteger)]
    [Dictionary('RPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID_OLD: Integer read FRPA_ID_OLD write FRPA_ID_OLD;
    const RPA_ID_OLD_Name = 'RPA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRPA_00)

end.
