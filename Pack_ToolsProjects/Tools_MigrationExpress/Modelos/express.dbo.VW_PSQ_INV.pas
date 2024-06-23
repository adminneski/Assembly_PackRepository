unit express.dbo.VW_PSQ_INV;

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
  [Table('VW_PSQ_INV', '')]
  TDtoVW_PSQ_INV = class
  private
    { Private declarations } 
    FINV_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FINV_DESATIVADO: String;
    FINV_DATAFECHAMENTO: TDateTime;
    FPRO_DESCRICAO: String;
    FINV_SALDOFECHAMENTO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_INV';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ID', ftInteger)]
    [Dictionary('INV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ID: Integer read FINV_ID write FINV_ID;
    const INV_ID_Name = 'INV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_DESATIVADO', ftString, 1)]
    [Dictionary('INV_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_DESATIVADO: String read FINV_DESATIVADO write FINV_DESATIVADO;
    const INV_DESATIVADO_Name = 'INV_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('INV_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property INV_DATAFECHAMENTO: TDateTime read FINV_DATAFECHAMENTO write FINV_DATAFECHAMENTO;
    const INV_DATAFECHAMENTO_Name = 'INV_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SALDOFECHAMENTO', ftBCD, 18, 4)]
    [Dictionary('INV_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_SALDOFECHAMENTO: Double read FINV_SALDOFECHAMENTO write FINV_SALDOFECHAMENTO;
    const INV_SALDOFECHAMENTO_Name = 'INV_SALDOFECHAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_INV)

end.
