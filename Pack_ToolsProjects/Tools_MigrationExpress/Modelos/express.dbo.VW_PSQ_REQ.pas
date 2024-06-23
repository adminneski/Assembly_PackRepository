unit express.dbo.VW_PSQ_REQ;

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
  [Table('VW_PSQ_REQ', '')]
  TDtoVW_PSQ_REQ = class
  private
    { Private declarations } 
    FREQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FREQ_NUMERODOCTO: String;
    FREQ_DATALANCAMENTO: TDateTime;
    FREQ_PROCESSADO: String;
    FPES_NOME: String;
    FNLP_CODIGO: Integer;
    FNLP_NUMEROLOTE: String;
    FREQ_TOTALQTDREQUISICAO: Double;
    FREQ_TOTALREQUISICAO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_REQ';

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
    [Column('REQ_NUMERODOCTO', ftString, 15)]
    [Dictionary('REQ_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_NUMERODOCTO: String read FREQ_NUMERODOCTO write FREQ_NUMERODOCTO;
    const REQ_NUMERODOCTO_Name = 'REQ_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('REQ_DATALANCAMENTO', ftDateTime)]
    [Dictionary('REQ_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property REQ_DATALANCAMENTO: TDateTime read FREQ_DATALANCAMENTO write FREQ_DATALANCAMENTO;
    const REQ_DATALANCAMENTO_Name = 'REQ_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('REQ_PROCESSADO', ftString, 1)]
    [Dictionary('REQ_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REQ_PROCESSADO: String read FREQ_PROCESSADO write FREQ_PROCESSADO;
    const REQ_PROCESSADO_Name = 'REQ_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('NLP_CODIGO', ftInteger)]
    [Dictionary('NLP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NLP_CODIGO: Integer read FNLP_CODIGO write FNLP_CODIGO;
    const NLP_CODIGO_Name = 'NLP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NLP_NUMEROLOTE', ftString, 15)]
    [Dictionary('NLP_NUMEROLOTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NLP_NUMEROLOTE: String read FNLP_NUMEROLOTE write FNLP_NUMEROLOTE;
    const NLP_NUMEROLOTE_Name = 'NLP_NUMEROLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_TOTALQTDREQUISICAO', ftBCD, 10, 2)]
    [Dictionary('REQ_TOTALQTDREQUISICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_TOTALQTDREQUISICAO: Double read FREQ_TOTALQTDREQUISICAO write FREQ_TOTALQTDREQUISICAO;
    const REQ_TOTALQTDREQUISICAO_Name = 'REQ_TOTALQTDREQUISICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REQ_TOTALREQUISICAO', ftBCD)]
    [Dictionary('REQ_TOTALREQUISICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property REQ_TOTALREQUISICAO: Double read FREQ_TOTALREQUISICAO write FREQ_TOTALREQUISICAO;
    const REQ_TOTALREQUISICAO_Name = 'REQ_TOTALREQUISICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_REQ)

end.
