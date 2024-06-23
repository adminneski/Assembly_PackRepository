unit express.dbo.VW_PSQ_NFP;

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
  [Table('VW_PSQ_NFP', '')]
  TDtoVW_PSQ_NFP = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFP_NUMERODOCTO: String;
    FNFP_NOTAFISCAL: String;
    FNFP_DATALANCAMENTO: TDateTime;
    FNFP_TOTALPRODUTOS: Double;
    FNFP_TOTALNOTAFISCAL: Double;
    FNFP_DESATIVADO: String;
    FNFP_CANCELADA: String;
    FNFP_LIVROFISCAL: String;
    FNFP_PROCESSADO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_NFP';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_NUMERODOCTO', ftString, 10)]
    [Dictionary('NFP_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMERODOCTO: String read FNFP_NUMERODOCTO write FNFP_NUMERODOCTO;
    const NFP_NUMERODOCTO_Name = 'NFP_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('NFP_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NOTAFISCAL: String read FNFP_NOTAFISCAL write FNFP_NOTAFISCAL;
    const NFP_NOTAFISCAL_Name = 'NFP_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATALANCAMENTO: TDateTime read FNFP_DATALANCAMENTO write FNFP_DATALANCAMENTO;
    const NFP_DATALANCAMENTO_Name = 'NFP_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPRODUTOS', ftBCD, 10, 2)]
    [Dictionary('NFP_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPRODUTOS: Double read FNFP_TOTALPRODUTOS write FNFP_TOTALPRODUTOS;
    const NFP_TOTALPRODUTOS_Name = 'NFP_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NFP_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALNOTAFISCAL: Double read FNFP_TOTALNOTAFISCAL write FNFP_TOTALNOTAFISCAL;
    const NFP_TOTALNOTAFISCAL_Name = 'NFP_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DESATIVADO', ftString, 1)]
    [Dictionary('NFP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_DESATIVADO: String read FNFP_DESATIVADO write FNFP_DESATIVADO;
    const NFP_DESATIVADO_Name = 'NFP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_CANCELADA', ftString, 1)]
    [Dictionary('NFP_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_CANCELADA: String read FNFP_CANCELADA write FNFP_CANCELADA;
    const NFP_CANCELADA_Name = 'NFP_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_LIVROFISCAL', ftString, 1)]
    [Dictionary('NFP_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_LIVROFISCAL: String read FNFP_LIVROFISCAL write FNFP_LIVROFISCAL;
    const NFP_LIVROFISCAL_Name = 'NFP_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFP_PROCESSADO', ftString, 1)]
    [Dictionary('NFP_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_PROCESSADO: String read FNFP_PROCESSADO write FNFP_PROCESSADO;
    const NFP_PROCESSADO_Name = 'NFP_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_NFP)

end.
