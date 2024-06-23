unit express.dbo.VW_PSQ_LFE;

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
  [Table('VW_PSQ_LFE', '')]
  TDtoVW_PSQ_LFE = class
  private
    { Private declarations } 
    FLFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_DATAENTRADA: TDateTime;
    FLFE_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FLFE_TOTALPRODUTOS: Double;
    FLFE_TOTALNOTAFISCAL: Double;
    FLFE_CANCELADO: String;
    FLFE_DESATIVADO: String;
    FCFOP_CODIGO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_LFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAENTRADA', ftDateTime)]
    [Dictionary('LFE_DATAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAENTRADA: TDateTime read FLFE_DATAENTRADA write FLFE_DATAENTRADA;
    const LFE_DATAENTRADA_Name = 'LFE_DATAENTRADA';

    [Restrictions([NoValidate])]
    [Column('LFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NOTAFISCAL: String read FLFE_NOTAFISCAL write FLFE_NOTAFISCAL;
    const LFE_NOTAFISCAL_Name = 'LFE_NOTAFISCAL';

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
    [Column('LFE_TOTALPRODUTOS', ftBCD, 48, 2)]
    [Dictionary('LFE_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPRODUTOS: Double read FLFE_TOTALPRODUTOS write FLFE_TOTALPRODUTOS;
    const LFE_TOTALPRODUTOS_Name = 'LFE_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALNOTAFISCAL', ftBCD, 10, 2)]
    [Dictionary('LFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALNOTAFISCAL: Double read FLFE_TOTALNOTAFISCAL write FLFE_TOTALNOTAFISCAL;
    const LFE_TOTALNOTAFISCAL_Name = 'LFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFE_CANCELADO', ftString, 1)]
    [Dictionary('LFE_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_CANCELADO: String read FLFE_CANCELADO write FLFE_CANCELADO;
    const LFE_CANCELADO_Name = 'LFE_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DESATIVADO', ftString, 1)]
    [Dictionary('LFE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_DESATIVADO: String read FLFE_DESATIVADO write FLFE_DESATIVADO;
    const LFE_DESATIVADO_Name = 'LFE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_LFE)

end.
