unit express.dbo.REQ_00;

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
  [Table('REQ_00', '')]
  [PrimaryKey('REQ_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_REQ_ID')]
  TDtoREQ_00 = class
  private
    { Private declarations } 
    FREQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FNLP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FREQ_NUMERODOCTO: String;
    FREQ_TIPODOCUMENTO: String;
    FREQ_DATALANCAMENTO: TDateTime;
    FREQ_TOTALREQUISICAO: Double;
    FREQ_TOTALQTDREQUISICAO: Double;
    FREQ_PLANOCONTARATEIO: Double;
    FREQ_PROCESSADO: String;
    FREQ_OBSERVACAO: String;
    FREQ_INTEGRACAO: String;
    FREQ_DATAALTERACAO: TDateTime;
    FREQ_ID_OLD: Integer;
    FREQ_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'REQ_00';
     const PrimaryKey = 'REQ_ID';
     const Sequence   = 'SEQ_REQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_ID', ftInteger)]
    [Dictionary('REQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_ID: Integer read FREQ_ID write FREQ_ID;
    const REQ_ID_Name = 'REQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NLP_CODIGO', ftInteger)]
    [Dictionary('NLP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NLP_CODIGO: Integer read FNLP_CODIGO write FNLP_CODIGO;
    const NLP_CODIGO_Name = 'NLP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('REQ_NUMERODOCTO', ftString, 15)]
    [Dictionary('REQ_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_NUMERODOCTO: String read FREQ_NUMERODOCTO write FREQ_NUMERODOCTO;
    const REQ_NUMERODOCTO_Name = 'REQ_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('REQ_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_TIPODOCUMENTO: String read FREQ_TIPODOCUMENTO write FREQ_TIPODOCUMENTO;
    const REQ_TIPODOCUMENTO_Name = 'REQ_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('REQ_DATALANCAMENTO', ftDateTime)]
    [Dictionary('REQ_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property REQ_DATALANCAMENTO: TDateTime read FREQ_DATALANCAMENTO write FREQ_DATALANCAMENTO;
    const REQ_DATALANCAMENTO_Name = 'REQ_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_TOTALREQUISICAO', ftBCD, 5177428, 2)]
    [Dictionary('REQ_TOTALREQUISICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_TOTALREQUISICAO: Double read FREQ_TOTALREQUISICAO write FREQ_TOTALREQUISICAO;
    const REQ_TOTALREQUISICAO_Name = 'REQ_TOTALREQUISICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_TOTALQTDREQUISICAO', ftBCD, 4456531, 2)]
    [Dictionary('REQ_TOTALQTDREQUISICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_TOTALQTDREQUISICAO: Double read FREQ_TOTALQTDREQUISICAO write FREQ_TOTALQTDREQUISICAO;
    const REQ_TOTALQTDREQUISICAO_Name = 'REQ_TOTALQTDREQUISICAO';

    [Restrictions([NoValidate])]
    [Column('REQ_PLANOCONTARATEIO', ftBCD, 1981834596, 2)]
    [Dictionary('REQ_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_PLANOCONTARATEIO: Double read FREQ_PLANOCONTARATEIO write FREQ_PLANOCONTARATEIO;
    const REQ_PLANOCONTARATEIO_Name = 'REQ_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('REQ_PROCESSADO', ftString, 1)]
    [Dictionary('REQ_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_PROCESSADO: String read FREQ_PROCESSADO write FREQ_PROCESSADO;
    const REQ_PROCESSADO_Name = 'REQ_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('REQ_OBSERVACAO', ftString, 300)]
    [Dictionary('REQ_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_OBSERVACAO: String read FREQ_OBSERVACAO write FREQ_OBSERVACAO;
    const REQ_OBSERVACAO_Name = 'REQ_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('REQ_INTEGRACAO', ftString, 20)]
    [Dictionary('REQ_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_INTEGRACAO: String read FREQ_INTEGRACAO write FREQ_INTEGRACAO;
    const REQ_INTEGRACAO_Name = 'REQ_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('REQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('REQ_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property REQ_DATAALTERACAO: TDateTime read FREQ_DATAALTERACAO write FREQ_DATAALTERACAO;
    const REQ_DATAALTERACAO_Name = 'REQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('REQ_ID_OLD', ftInteger)]
    [Dictionary('REQ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property REQ_ID_OLD: Integer read FREQ_ID_OLD write FREQ_ID_OLD;
    const REQ_ID_OLD_Name = 'REQ_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('REQ_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('REQ_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_INTEGRACAO_OLD: String read FREQ_INTEGRACAO_OLD write FREQ_INTEGRACAO_OLD;
    const REQ_INTEGRACAO_OLD_Name = 'REQ_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREQ_00)

end.
