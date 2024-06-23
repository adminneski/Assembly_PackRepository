unit express.dbo.DRQ_00;

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
  [Table('DRQ_00', '')]
  [PrimaryKey('DRQ_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DRQ_ID')]
  TDtoDRQ_00 = class
  private
    { Private declarations } 
    FDRQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FNLP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FDRQ_NUMERODOCTO: String;
    FDRQ_TIPODOCUMENTO: String;
    FDRQ_DATALANCAMENTO: TDateTime;
    FDRQ_TOTALDEVOLUCAO: Double;
    FDRQ_TOTALQTDDEVOLUCAO: Double;
    FDRQ_OBSERVACAO: String;
    FDRQ_PROCESSADO: String;
    FDRQ_DATAALTERACAO: TDateTime;
    FDRQ_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'DRQ_00';
     const PrimaryKey = 'DRQ_ID';
     const Sequence   = 'SEQ_DRQ_ID';

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
    [Column('DRQ_NUMERODOCTO', ftString, 15)]
    [Dictionary('DRQ_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DRQ_NUMERODOCTO: String read FDRQ_NUMERODOCTO write FDRQ_NUMERODOCTO;
    const DRQ_NUMERODOCTO_Name = 'DRQ_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('DRQ_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('DRQ_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DRQ_TIPODOCUMENTO: String read FDRQ_TIPODOCUMENTO write FDRQ_TIPODOCUMENTO;
    const DRQ_TIPODOCUMENTO_Name = 'DRQ_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('DRQ_DATALANCAMENTO', ftDateTime)]
    [Dictionary('DRQ_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property DRQ_DATALANCAMENTO: TDateTime read FDRQ_DATALANCAMENTO write FDRQ_DATALANCAMENTO;
    const DRQ_DATALANCAMENTO_Name = 'DRQ_DATALANCAMENTO';

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

    [Restrictions([NoValidate])]
    [Column('DRQ_OBSERVACAO', ftString, 300)]
    [Dictionary('DRQ_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DRQ_OBSERVACAO: String read FDRQ_OBSERVACAO write FDRQ_OBSERVACAO;
    const DRQ_OBSERVACAO_Name = 'DRQ_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('DRQ_PROCESSADO', ftString, 1)]
    [Dictionary('DRQ_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DRQ_PROCESSADO: String read FDRQ_PROCESSADO write FDRQ_PROCESSADO;
    const DRQ_PROCESSADO_Name = 'DRQ_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('DRQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('DRQ_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property DRQ_DATAALTERACAO: TDateTime read FDRQ_DATAALTERACAO write FDRQ_DATAALTERACAO;
    const DRQ_DATAALTERACAO_Name = 'DRQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DRQ_ID_OLD', ftInteger)]
    [Dictionary('DRQ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DRQ_ID_OLD: Integer read FDRQ_ID_OLD write FDRQ_ID_OLD;
    const DRQ_ID_OLD_Name = 'DRQ_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDRQ_00)

end.
