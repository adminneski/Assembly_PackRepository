unit express.dbo.TPO_00;

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
  [Table('TPO_00', '')]
  [PrimaryKey('TPO_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TPO_ID')]
  TDtoTPO_00 = class
  private
    { Private declarations } 
    FTPO_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FTPO_PROCESSADO: String;
    FTPO_OBSERVACAO: String;
    FTPO_TOTALVALOR: Double;
    FTPO_DATALANCAMENTO: TDateTime;
    FTPO_DATAALTERACAO: TDateTime;
    FTPO_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'TPO_00';
     const PrimaryKey = 'TPO_ID';
     const Sequence   = 'SEQ_TPO_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_ID', ftInteger)]
    [Dictionary('TPO_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TPO_ID: Integer read FTPO_ID write FTPO_ID;
    const TPO_ID_Name = 'TPO_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_PROCESSADO', ftString, 1)]
    [Dictionary('TPO_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TPO_PROCESSADO: String read FTPO_PROCESSADO write FTPO_PROCESSADO;
    const TPO_PROCESSADO_Name = 'TPO_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('TPO_OBSERVACAO', ftString, 300)]
    [Dictionary('TPO_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TPO_OBSERVACAO: String read FTPO_OBSERVACAO write FTPO_OBSERVACAO;
    const TPO_OBSERVACAO_Name = 'TPO_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_TOTALVALOR', ftBCD, 4522064, 2)]
    [Dictionary('TPO_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TPO_TOTALVALOR: Double read FTPO_TOTALVALOR write FTPO_TOTALVALOR;
    const TPO_TOTALVALOR_Name = 'TPO_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_DATALANCAMENTO', ftDateTime)]
    [Dictionary('TPO_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TPO_DATALANCAMENTO: TDateTime read FTPO_DATALANCAMENTO write FTPO_DATALANCAMENTO;
    const TPO_DATALANCAMENTO_Name = 'TPO_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('TPO_DATAALTERACAO', ftDateTime)]
    [Dictionary('TPO_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property TPO_DATAALTERACAO: TDateTime read FTPO_DATAALTERACAO write FTPO_DATAALTERACAO;
    const TPO_DATAALTERACAO_Name = 'TPO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('TPO_ID_OLD', ftInteger)]
    [Dictionary('TPO_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TPO_ID_OLD: Integer read FTPO_ID_OLD write FTPO_ID_OLD;
    const TPO_ID_OLD_Name = 'TPO_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTPO_00)

end.
