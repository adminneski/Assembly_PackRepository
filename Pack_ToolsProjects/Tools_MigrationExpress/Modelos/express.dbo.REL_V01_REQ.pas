unit express.dbo.REL_V01_REQ;

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
  [Table('REL_V01_REQ', '')]
  TDtoREL_V01_REQ = class
  private
    { Private declarations } 
    FREQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FREQ_NUMERODOCTO: String;
    FREQ_TIPODOCUMENTO: String;
    FREQ_DATALANCAMENTO: TDateTime;
    FREQ_TOTALREQUISICAO: Double;
    FREQ_TOTALQTDREQUISICAO: Double;
    FREQ_PLANOCONTARATEIO: Double;
    FREQ_PROCESSADO: String;
    FREQ_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_REQ';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

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
    [Column('REQ_TOTALREQUISICAO', ftBCD)]
    [Dictionary('REQ_TOTALREQUISICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_TOTALREQUISICAO: Double read FREQ_TOTALREQUISICAO write FREQ_TOTALREQUISICAO;
    const REQ_TOTALREQUISICAO_Name = 'REQ_TOTALREQUISICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_TOTALQTDREQUISICAO', ftBCD)]
    [Dictionary('REQ_TOTALQTDREQUISICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_TOTALQTDREQUISICAO: Double read FREQ_TOTALQTDREQUISICAO write FREQ_TOTALQTDREQUISICAO;
    const REQ_TOTALQTDREQUISICAO_Name = 'REQ_TOTALQTDREQUISICAO';

    [Restrictions([NoValidate])]
    [Column('REQ_PLANOCONTARATEIO', ftBCD)]
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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_REQ)

end.
