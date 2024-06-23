unit express.dbo.REL_V06_LFS;

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
  [Table('REL_V06_LFS', '')]
  TDtoREL_V06_LFS = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_DATAEMISSAO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_UF: String;
    FMNF_CODIGO: String;
    FCSTP_CODIGO: String;
    FCFOP_CODIGO: String;
    FLFS_VALORITEM: Double;
    FLFS_VALORPIS: Double;
    FLFS_VALORCOFINS: Double;
    FLFS_VALORBCALCULOPISCOFINS: Double;
    FLFS_VALORBASEISENTOPISCOFINS: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V06_LFS';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTP_CODIGO', ftString, 2)]
    [Dictionary('CSTP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTP_CODIGO: String read FCSTP_CODIGO write FCSTP_CODIGO;
    const CSTP_CODIGO_Name = 'CSTP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORITEM', ftBCD)]
    [Dictionary('LFS_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEM: Double read FLFS_VALORITEM write FLFS_VALORITEM;
    const LFS_VALORITEM_Name = 'LFS_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPIS', ftBCD)]
    [Dictionary('LFS_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPIS: Double read FLFS_VALORPIS write FLFS_VALORPIS;
    const LFS_VALORPIS_Name = 'LFS_VALORPIS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORCOFINS', ftBCD, 48, 2)]
    [Dictionary('LFS_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORCOFINS: Double read FLFS_VALORCOFINS write FLFS_VALORCOFINS;
    const LFS_VALORCOFINS_Name = 'LFS_VALORCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBCALCULOPISCOFINS', ftBCD)]
    [Dictionary('LFS_VALORBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBCALCULOPISCOFINS: Double read FLFS_VALORBCALCULOPISCOFINS write FLFS_VALORBCALCULOPISCOFINS;
    const LFS_VALORBCALCULOPISCOFINS_Name = 'LFS_VALORBCALCULOPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORBASEISENTOPISCOFINS', ftBCD)]
    [Dictionary('LFS_VALORBASEISENTOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEISENTOPISCOFINS: Double read FLFS_VALORBASEISENTOPISCOFINS write FLFS_VALORBASEISENTOPISCOFINS;
    const LFS_VALORBASEISENTOPISCOFINS_Name = 'LFS_VALORBASEISENTOPISCOFINS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V06_LFS)

end.
