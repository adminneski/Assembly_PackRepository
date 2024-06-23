unit express.dbo.MFC_CONSULTANOTAFISCAL;

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
  [Table('MFC_ConsultaNotaFiscal', '')]
  TDtoMFC_ConsultaNotaFiscal = class
  private
    { Private declarations } 
    FLFS_TIPO: String;
    FLFS_ID: Integer;
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_TIPOFRETE: String;
    FLFS_NOTAFISCAL: String;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_TOTALFRETENF: Double;
    FLFS_TOTALPESOBRUTO: Double;
    FLFS_CHAVEACESSO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FMNF_CODIGO: String;
    FLFS_CANCELADO: String;
    FTRP_CODIGO: Integer;
    FTRP_NOME: String;
    FLFS_UFORIGEM: String;
    FLFS_UFDESTINO: String;
    FCID_IBGEORIGEM: Integer;
    FCID_IBGEDESTINO: Integer;
    FLFS_CIDADEORIGEM: String;
    FLFS_CIDADEDESTINO: String;
    FMFC_ID: Integer;
  public 
    { Public declarations } 
     const Table      = 'MFC_ConsultaNotaFiscal';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TIPO', ftString, 1)]
    [Dictionary('LFS_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPO: String read FLFS_TIPO write FLFS_TIPO;
    const LFS_TIPO_Name = 'LFS_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

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
    [Column('LFS_TIPOFRETE', ftString, 1)]
    [Dictionary('LFS_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOFRETE: String read FLFS_TIPOFRETE write FLFS_TIPOFRETE;
    const LFS_TIPOFRETE_Name = 'LFS_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALFRETENF', ftBCD)]
    [Dictionary('LFS_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFRETENF: Double read FLFS_TOTALFRETENF write FLFS_TOTALFRETENF;
    const LFS_TOTALFRETENF_Name = 'LFS_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('LFS_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPESOBRUTO: Double read FLFS_TOTALPESOBRUTO write FLFS_TOTALPESOBRUTO;
    const LFS_TOTALPESOBRUTO_Name = 'LFS_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSO: String read FLFS_CHAVEACESSO write FLFS_CHAVEACESSO;
    const LFS_CHAVEACESSO_Name = 'LFS_CHAVEACESSO';

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
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_CANCELADO', ftString, 1)]
    [Dictionary('LFS_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CANCELADO: String read FLFS_CANCELADO write FLFS_CANCELADO;
    const LFS_CANCELADO_Name = 'LFS_CANCELADO';

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

    [Restrictions([NoValidate])]
    [Column('LFS_UFORIGEM', ftString, 2)]
    [Dictionary('LFS_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UFORIGEM: String read FLFS_UFORIGEM write FLFS_UFORIGEM;
    const LFS_UFORIGEM_Name = 'LFS_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('LFS_UFDESTINO', ftString, 2)]
    [Dictionary('LFS_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UFDESTINO: String read FLFS_UFDESTINO write FLFS_UFDESTINO;
    const LFS_UFDESTINO_Name = 'LFS_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftInteger)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEORIGEM: Integer read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftInteger)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEDESTINO: Integer read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('LFS_CIDADEORIGEM', ftString, 100)]
    [Dictionary('LFS_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CIDADEORIGEM: String read FLFS_CIDADEORIGEM write FLFS_CIDADEORIGEM;
    const LFS_CIDADEORIGEM_Name = 'LFS_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('LFS_CIDADEDESTINO', ftString, 100)]
    [Dictionary('LFS_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CIDADEDESTINO: String read FLFS_CIDADEDESTINO write FLFS_CIDADEDESTINO;
    const LFS_CIDADEDESTINO_Name = 'LFS_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('MFC_ID', ftInteger)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_ConsultaNotaFiscal)

end.
