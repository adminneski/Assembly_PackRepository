unit express.dbo.VW_PSQ_CMP;

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
  [Table('VW_PSQ_CMP', '')]
  TDtoVW_PSQ_CMP = class
  private
    { Private declarations } 
    FCMP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCMP_BAIXADO: String;
    FCMP_DESATIVADO: String;
    FCMP_DATALANCAMENTO: TDateTime;
    FCMP_DATAENTREGA: TDateTime;
    FCMP_PEDIDOCOMPRA: Integer;
    FPES_NOME: String;
    FCMP_OBSERVACAO: String;
    FCMP_TOTALPEDIDOCOMPRA: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CMP';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_ID', ftInteger)]
    [Dictionary('CMP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_ID: Integer read FCMP_ID write FCMP_ID;
    const CMP_ID_Name = 'CMP_ID';

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
    [Column('CMP_BAIXADO', ftString, 1)]
    [Dictionary('CMP_BAIXADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_BAIXADO: String read FCMP_BAIXADO write FCMP_BAIXADO;
    const CMP_BAIXADO_Name = 'CMP_BAIXADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_DESATIVADO', ftString, 1)]
    [Dictionary('CMP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_DESATIVADO: String read FCMP_DESATIVADO write FCMP_DESATIVADO;
    const CMP_DESATIVADO_Name = 'CMP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CMP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMP_DATALANCAMENTO: TDateTime read FCMP_DATALANCAMENTO write FCMP_DATALANCAMENTO;
    const CMP_DATALANCAMENTO_Name = 'CMP_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CMP_DATAENTREGA', ftDateTime)]
    [Dictionary('CMP_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property CMP_DATAENTREGA: TDateTime read FCMP_DATAENTREGA write FCMP_DATAENTREGA;
    const CMP_DATAENTREGA_Name = 'CMP_DATAENTREGA';

    [Restrictions([NoValidate])]
    [Column('CMP_PEDIDOCOMPRA', ftInteger)]
    [Dictionary('CMP_PEDIDOCOMPRA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_PEDIDOCOMPRA: Integer read FCMP_PEDIDOCOMPRA write FCMP_PEDIDOCOMPRA;
    const CMP_PEDIDOCOMPRA_Name = 'CMP_PEDIDOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CMP_OBSERVACAO', ftString, 300)]
    [Dictionary('CMP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_OBSERVACAO: String read FCMP_OBSERVACAO write FCMP_OBSERVACAO;
    const CMP_OBSERVACAO_Name = 'CMP_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALPEDIDOCOMPRA', ftBCD)]
    [Dictionary('CMP_TOTALPEDIDOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALPEDIDOCOMPRA: Double read FCMP_TOTALPEDIDOCOMPRA write FCMP_TOTALPEDIDOCOMPRA;
    const CMP_TOTALPEDIDOCOMPRA_Name = 'CMP_TOTALPEDIDOCOMPRA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CMP)

end.
