unit express.dbo.VW_PSQ_TPO;

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
  [Table('VW_PSQ_TPO', '')]
  TDtoVW_PSQ_TPO = class
  private
    { Private declarations } 
    FTPO_ID: Integer;
    FTPO_DATALANCAMENTO: TDateTime;
    FTPO_PROCESSADO: String;
    FTPO_OBSERVACAO: String;
    FPES_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FPES_NOME: String;
    FTPO_TOTALVALOR: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_TPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_ID', ftInteger)]
    [Dictionary('TPO_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TPO_ID: Integer read FTPO_ID write FTPO_ID;
    const TPO_ID_Name = 'TPO_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_DATALANCAMENTO', ftDateTime)]
    [Dictionary('TPO_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TPO_DATALANCAMENTO: TDateTime read FTPO_DATALANCAMENTO write FTPO_DATALANCAMENTO;
    const TPO_DATALANCAMENTO_Name = 'TPO_DATALANCAMENTO';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_TOTALVALOR', ftBCD)]
    [Dictionary('TPO_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TPO_TOTALVALOR: Double read FTPO_TOTALVALOR write FTPO_TOTALVALOR;
    const TPO_TOTALVALOR_Name = 'TPO_TOTALVALOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_TPO)

end.
