unit express.dbo.MEG_00;

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
  [Table('MEG_00', '')]
  [PrimaryKey('MEG_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MEG_ID')]
  TDtoMEG_00 = class
  private
    { Private declarations } 
    FMEG_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_ID: Integer;
    FNFE_SIGLA: String;
    FNFE_NOTAFISCAL: String;
    FMEG_DATALANCAMENTO: TDateTime;
    FMEG_TOTALQTDENTRADA: Double;
    FMEG_OBSERVACAO: String;
    FMEG_PROCESSADO: String;
    FMEG_DATAALTERACAO: TDateTime;
    FMEG_ID_OLD: Integer;
    FNFE_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'MEG_00';
     const PrimaryKey = 'MEG_ID';
     const Sequence   = 'SEQ_MEG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_ID', ftInteger)]
    [Dictionary('MEG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_ID: Integer read FMEG_ID write FMEG_ID;
    const MEG_ID_Name = 'MEG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate])]
    [Column('NFE_SIGLA', ftString, 3)]
    [Dictionary('NFE_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SIGLA: String read FNFE_SIGLA write FNFE_SIGLA;
    const NFE_SIGLA_Name = 'NFE_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_DATALANCAMENTO', ftDateTime)]
    [Dictionary('MEG_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MEG_DATALANCAMENTO: TDateTime read FMEG_DATALANCAMENTO write FMEG_DATALANCAMENTO;
    const MEG_DATALANCAMENTO_Name = 'MEG_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_TOTALQTDENTRADA', ftBCD)]
    [Dictionary('MEG_TOTALQTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MEG_TOTALQTDENTRADA: Double read FMEG_TOTALQTDENTRADA write FMEG_TOTALQTDENTRADA;
    const MEG_TOTALQTDENTRADA_Name = 'MEG_TOTALQTDENTRADA';

    [Restrictions([NoValidate])]
    [Column('MEG_OBSERVACAO', ftString, 300)]
    [Dictionary('MEG_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEG_OBSERVACAO: String read FMEG_OBSERVACAO write FMEG_OBSERVACAO;
    const MEG_OBSERVACAO_Name = 'MEG_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_PROCESSADO', ftString, 1)]
    [Dictionary('MEG_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEG_PROCESSADO: String read FMEG_PROCESSADO write FMEG_PROCESSADO;
    const MEG_PROCESSADO_Name = 'MEG_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_DATAALTERACAO', ftDateTime)]
    [Dictionary('MEG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MEG_DATAALTERACAO: TDateTime read FMEG_DATAALTERACAO write FMEG_DATAALTERACAO;
    const MEG_DATAALTERACAO_Name = 'MEG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MEG_ID_OLD', ftInteger)]
    [Dictionary('MEG_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_ID_OLD: Integer read FMEG_ID_OLD write FMEG_ID_OLD;
    const MEG_ID_OLD_Name = 'MEG_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_ID_OLD', ftInteger)]
    [Dictionary('NFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID_OLD: Integer read FNFE_ID_OLD write FNFE_ID_OLD;
    const NFE_ID_OLD_Name = 'NFE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMEG_00)

end.
