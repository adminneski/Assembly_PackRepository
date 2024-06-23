unit express.dbo.VW_PSQ_INVP;

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
  [Table('VW_PSQ_INVP', '')]
  TDtoVW_PSQ_INVP = class
  private
    { Private declarations } 
    FINVP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FINVP_DESATIVADO: String;
    FINVP_DATAFECHAMENTO: TDateTime;
    FPRO_DESCRICAO: String;
    FPES_NOME: String;
    FINVP_SALDOFECHAMENTO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_INVP';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_ID', ftInteger)]
    [Dictionary('INVP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ID: Integer read FINVP_ID write FINVP_ID;
    const INVP_ID_Name = 'INVP_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_DESATIVADO', ftString, 1)]
    [Dictionary('INVP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_DESATIVADO: String read FINVP_DESATIVADO write FINVP_DESATIVADO;
    const INVP_DESATIVADO_Name = 'INVP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('INVP_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property INVP_DATAFECHAMENTO: TDateTime read FINVP_DATAFECHAMENTO write FINVP_DATAFECHAMENTO;
    const INVP_DATAFECHAMENTO_Name = 'INVP_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_SALDOFECHAMENTO', ftBCD, 18, 4)]
    [Dictionary('INVP_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_SALDOFECHAMENTO: Double read FINVP_SALDOFECHAMENTO write FINVP_SALDOFECHAMENTO;
    const INVP_SALDOFECHAMENTO_Name = 'INVP_SALDOFECHAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_INVP)

end.
