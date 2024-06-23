unit express.dbo.VW_PSQ_LFS;

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
  [Table('VW_PSQ_LFS', '')]
  TDtoVW_PSQ_LFS = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_NOTAFISCAL: String;
    FLFS_SERIE: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FLFS_TOTALPRODUTOS: Double;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_DESATIVADO: String;
    FLFS_CANCELADO: String;
    FCFOP_CODIGO: String;
    FTRP_CODIGO: Integer;
    FTRP_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_LFS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIE', ftString, 3)]
    [Dictionary('LFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIE: String read FLFS_SERIE write FLFS_SERIE;
    const LFS_SERIE_Name = 'LFS_SERIE';

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
    [Column('LFS_TOTALPRODUTOS', ftBCD)]
    [Dictionary('LFS_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPRODUTOS: Double read FLFS_TOTALPRODUTOS write FLFS_TOTALPRODUTOS;
    const LFS_TOTALPRODUTOS_Name = 'LFS_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD, 48, 2)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DESATIVADO', ftString, 1)]
    [Dictionary('LFS_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_DESATIVADO: String read FLFS_DESATIVADO write FLFS_DESATIVADO;
    const LFS_DESATIVADO_Name = 'LFS_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('LFS_CANCELADO', ftString, 1)]
    [Dictionary('LFS_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CANCELADO: String read FLFS_CANCELADO write FLFS_CANCELADO;
    const LFS_CANCELADO_Name = 'LFS_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_NOME', ftString, 100)]
    [Dictionary('TRP_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRP_NOME: String read FTRP_NOME write FTRP_NOME;
    const TRP_NOME_Name = 'TRP_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_LFS)

end.
