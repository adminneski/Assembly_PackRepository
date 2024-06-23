unit express.dbo.MFC_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.mfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MFC_00_04', '')]
  [PrimaryKey('MFC_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MFC_04_ID')]
  TDtoMFC_00_04 = class
  private
    { Private declarations } 
    FMFC_04_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_ID: Integer;
    FLFS_ID: Integer;
    FLFS_TIPO: String;
    FMNF_CODIGO: String;
    FLFS_NOTAFISCAL: String;
    FCID_IBGEORIGEM: String;
    FMFC_CIDADEORIGEM: String;
    FMFC_UFORIGEM: String;
    FCID_IBGEDESTINO: String;
    FMFC_CIDADEDESTINO: String;
    FMFC_UFDESTINO: String;
    FMFC_ORDEMITEM: Integer;
    FMFC_TIPOFRETE: String;
    FMFC_PESOBRUTO: Double;
    FMFC_VALORFRETE: Double;
    FMFC_VALORNOTAFISCAL: Double;
    FMFC_CODIGORASTREAMENTO: String;
    FLFS_CHAVEACESSO: String;
    FMFC_DATAALTERACAO: TDateTime;
    FMFC_04_ID_OLD: Integer;
    FMFC_ID_OLD: Integer;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'MFC_00_04';
    const PrimaryKey = 'MFC_04_ID';
    const Sequence   = 'SEQ_MFC_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_04_ID', ftInteger)]
    [Dictionary('MFC_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_04_ID: Integer read FMFC_04_ID write FMFC_04_ID;
    const MFC_04_ID_Name = 'MFC_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [ForeignKey('MFC_00_04_fk', 'MFC_ID', 'MFC_00', 'MFC_ID', SetNull, SetNull)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPO', ftString, 1)]
    [Dictionary('LFS_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPO: String read FLFS_TIPO write FLFS_TIPO;
    const LFS_TIPO_Name = 'LFS_TIPO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftString, 7)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEORIGEM: String read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('MFC_CIDADEORIGEM', ftString, 100)]
    [Dictionary('MFC_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CIDADEORIGEM: String read FMFC_CIDADEORIGEM write FMFC_CIDADEORIGEM;
    const MFC_CIDADEORIGEM_Name = 'MFC_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('MFC_UFORIGEM', ftString, 2)]
    [Dictionary('MFC_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_UFORIGEM: String read FMFC_UFORIGEM write FMFC_UFORIGEM;
    const MFC_UFORIGEM_Name = 'MFC_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftString, 7)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEDESTINO: String read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('MFC_CIDADEDESTINO', ftString, 100)]
    [Dictionary('MFC_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CIDADEDESTINO: String read FMFC_CIDADEDESTINO write FMFC_CIDADEDESTINO;
    const MFC_CIDADEDESTINO_Name = 'MFC_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('MFC_UFDESTINO', ftString, 2)]
    [Dictionary('MFC_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_UFDESTINO: String read FMFC_UFDESTINO write FMFC_UFDESTINO;
    const MFC_UFDESTINO_Name = 'MFC_UFDESTINO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ORDEMITEM', ftInteger)]
    [Dictionary('MFC_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ORDEMITEM: Integer read FMFC_ORDEMITEM write FMFC_ORDEMITEM;
    const MFC_ORDEMITEM_Name = 'MFC_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOFRETE', ftString, 1)]
    [Dictionary('MFC_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOFRETE: String read FMFC_TIPOFRETE write FMFC_TIPOFRETE;
    const MFC_TIPOFRETE_Name = 'MFC_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('MFC_PESOBRUTO', ftBCD)]
    [Dictionary('MFC_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_PESOBRUTO: Double read FMFC_PESOBRUTO write FMFC_PESOBRUTO;
    const MFC_PESOBRUTO_Name = 'MFC_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_VALORFRETE', ftBCD)]
    [Dictionary('MFC_VALORFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORFRETE: Double read FMFC_VALORFRETE write FMFC_VALORFRETE;
    const MFC_VALORFRETE_Name = 'MFC_VALORFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('MFC_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORNOTAFISCAL: Double read FMFC_VALORNOTAFISCAL write FMFC_VALORNOTAFISCAL;
    const MFC_VALORNOTAFISCAL_Name = 'MFC_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MFC_CODIGORASTREAMENTO', ftString, 20)]
    [Dictionary('MFC_CODIGORASTREAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CODIGORASTREAMENTO: String read FMFC_CODIGORASTREAMENTO write FMFC_CODIGORASTREAMENTO;
    const MFC_CODIGORASTREAMENTO_Name = 'MFC_CODIGORASTREAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSO: String read FLFS_CHAVEACESSO write FLFS_CHAVEACESSO;
    const LFS_CHAVEACESSO_Name = 'LFS_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('MFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATAALTERACAO: TDateTime read FMFC_DATAALTERACAO write FMFC_DATAALTERACAO;
    const MFC_DATAALTERACAO_Name = 'MFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_04_ID_OLD', ftInteger)]
    [Dictionary('MFC_04_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_04_ID_OLD: Integer read FMFC_04_ID_OLD write FMFC_04_ID_OLD;
    const MFC_04_ID_OLD_Name = 'MFC_04_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_ID_OLD', ftInteger)]
    [Dictionary('MFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID_OLD: Integer read FMFC_ID_OLD write FMFC_ID_OLD;
    const MFC_ID_OLD_Name = 'MFC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_00_04)

end.
