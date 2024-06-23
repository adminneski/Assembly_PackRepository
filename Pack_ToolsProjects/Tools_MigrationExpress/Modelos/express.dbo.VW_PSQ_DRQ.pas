unit express.dbo.VW_PSQ_DRQ;

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
  [Table('VW_PSQ_DRQ', '')]
  TDtoVW_PSQ_DRQ = class
  private
    { Private declarations } 
    FDRQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FDRQ_NUMERODOCTO: String;
    FDRQ_DATALANCAMENTO: TDateTime;
    FDRQ_PROCESSADO: String;
    FPES_NOME: String;
    FNLP_CODIGO: Integer;
    FNLP_NUMEROLOTE: String;
    FDRQ_TOTALDEVOLUCAO: Double;
    FDRQ_TOTALQTDDEVOLUCAO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_DRQ';

    [Restrictions([NoValidate, NotNull])]
    [Column('DRQ_ID', ftInteger)]
    [Dictionary('DRQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DRQ_ID: Integer read FDRQ_ID write FDRQ_ID;
    const DRQ_ID_Name = 'DRQ_ID';

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
    [Column('DRQ_NUMERODOCTO', ftString, 15)]
    [Dictionary('DRQ_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DRQ_NUMERODOCTO: String read FDRQ_NUMERODOCTO write FDRQ_NUMERODOCTO;
    const DRQ_NUMERODOCTO_Name = 'DRQ_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('DRQ_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DRQ_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property DRQ_DATALANCAMENTO: TDateTime read FDRQ_DATALANCAMENTO write FDRQ_DATALANCAMENTO;
    const DRQ_DATALANCAMENTO_Name = 'DRQ_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('DRQ_PROCESSADO', ftString, 1)]
    [Dictionary('DRQ_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DRQ_PROCESSADO: String read FDRQ_PROCESSADO write FDRQ_PROCESSADO;
    const DRQ_PROCESSADO_Name = 'DRQ_PROCESSADO';

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
    [Column('DRQ_TOTALDEVOLUCAO', ftBCD)]
    [Dictionary('DRQ_TOTALDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_TOTALDEVOLUCAO: Double read FDRQ_TOTALDEVOLUCAO write FDRQ_TOTALDEVOLUCAO;
    const DRQ_TOTALDEVOLUCAO_Name = 'DRQ_TOTALDEVOLUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DRQ_TOTALQTDDEVOLUCAO', ftBCD)]
    [Dictionary('DRQ_TOTALQTDDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DRQ_TOTALQTDDEVOLUCAO: Double read FDRQ_TOTALQTDDEVOLUCAO write FDRQ_TOTALQTDDEVOLUCAO;
    const DRQ_TOTALQTDDEVOLUCAO_Name = 'DRQ_TOTALQTDDEVOLUCAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_DRQ)

end.
