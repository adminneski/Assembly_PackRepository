unit express.dbo.REL_V03_LFS;

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
  [Table('REL_V03_LFS', '')]
  TDtoREL_V03_LFS = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLFS_TIPO: Integer;
    FLFS_TIPOMOVTO: String;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_NOTAFISCAL: String;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_BCPISCOFINS_N: Double;
    FLFS_BCPISCOFINS_A: Double;
    FLFS_BCPISCOFINS_I: Double;
    FLFS_TOTALPISCOFINS: Double;
    FLFS_TOTALBASEPISCOFINSSERVICO: Double;
    FLFS_TOTALPISCOFINSSERVICO: Double;
    FLFE_TOTALNOTAFISCAL: Double;
    FLFE_TOTALPISCOFINS: Double;
    FLFE_TOTALBASEPISCOFINS: Double;
    FLFS_TOTALDEVOLUCAO: Integer;
  public 
    { Public declarations } 
     const Table      = 'REL_V03_LFS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TIPO', ftInteger)]
    [Dictionary('LFS_TIPO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_TIPO: Integer read FLFS_TIPO write FLFS_TIPO;
    const LFS_TIPO_Name = 'LFS_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TIPOMOVTO', ftString, 3)]
    [Dictionary('LFS_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOMOVTO: String read FLFS_TIPOMOVTO write FLFS_TIPOMOVTO;
    const LFS_TIPOMOVTO_Name = 'LFS_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 6)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_BCPISCOFINS_N', ftBCD)]
    [Dictionary('LFS_BCPISCOFINS_N', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_BCPISCOFINS_N: Double read FLFS_BCPISCOFINS_N write FLFS_BCPISCOFINS_N;
    const LFS_BCPISCOFINS_N_Name = 'LFS_BCPISCOFINS_N';

    [Restrictions([NoValidate])]
    [Column('LFS_BCPISCOFINS_A', ftBCD)]
    [Dictionary('LFS_BCPISCOFINS_A', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_BCPISCOFINS_A: Double read FLFS_BCPISCOFINS_A write FLFS_BCPISCOFINS_A;
    const LFS_BCPISCOFINS_A_Name = 'LFS_BCPISCOFINS_A';

    [Restrictions([NoValidate])]
    [Column('LFS_BCPISCOFINS_I', ftBCD)]
    [Dictionary('LFS_BCPISCOFINS_I', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_BCPISCOFINS_I: Double read FLFS_BCPISCOFINS_I write FLFS_BCPISCOFINS_I;
    const LFS_BCPISCOFINS_I_Name = 'LFS_BCPISCOFINS_I';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPISCOFINS', ftBCD)]
    [Dictionary('LFS_TOTALPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPISCOFINS: Double read FLFS_TOTALPISCOFINS write FLFS_TOTALPISCOFINS;
    const LFS_TOTALPISCOFINS_Name = 'LFS_TOTALPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASEPISCOFINSSERVICO', ftBCD)]
    [Dictionary('LFS_TOTALBASEPISCOFINSSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASEPISCOFINSSERVICO: Double read FLFS_TOTALBASEPISCOFINSSERVICO write FLFS_TOTALBASEPISCOFINSSERVICO;
    const LFS_TOTALBASEPISCOFINSSERVICO_Name = 'LFS_TOTALBASEPISCOFINSSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALPISCOFINSSERVICO', ftBCD, 48, 2)]
    [Dictionary('LFS_TOTALPISCOFINSSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPISCOFINSSERVICO: Double read FLFS_TOTALPISCOFINSSERVICO write FLFS_TOTALPISCOFINSSERVICO;
    const LFS_TOTALPISCOFINSSERVICO_Name = 'LFS_TOTALPISCOFINSSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALNOTAFISCAL: Double read FLFE_TOTALNOTAFISCAL write FLFE_TOTALNOTAFISCAL;
    const LFE_TOTALNOTAFISCAL_Name = 'LFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALPISCOFINS', ftBCD)]
    [Dictionary('LFE_TOTALPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALPISCOFINS: Double read FLFE_TOTALPISCOFINS write FLFE_TOTALPISCOFINS;
    const LFE_TOTALPISCOFINS_Name = 'LFE_TOTALPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFE_TOTALBASEPISCOFINS', ftBCD, 10, 2)]
    [Dictionary('LFE_TOTALBASEPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_TOTALBASEPISCOFINS: Double read FLFE_TOTALBASEPISCOFINS write FLFE_TOTALBASEPISCOFINS;
    const LFE_TOTALBASEPISCOFINS_Name = 'LFE_TOTALBASEPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALDEVOLUCAO', ftInteger)]
    [Dictionary('LFS_TOTALDEVOLUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_TOTALDEVOLUCAO: Integer read FLFS_TOTALDEVOLUCAO write FLFS_TOTALDEVOLUCAO;
    const LFS_TOTALDEVOLUCAO_Name = 'LFS_TOTALDEVOLUCAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V03_LFS)

end.
