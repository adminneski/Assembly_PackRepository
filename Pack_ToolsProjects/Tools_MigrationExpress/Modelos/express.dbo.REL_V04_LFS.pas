unit express.dbo.REL_V04_LFS;

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
  [Table('REL_V04_LFS', '')]
  TDtoREL_V04_LFS = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FLFS_NUMEROCUPOM: String;
    FLFS_SERIEECF: String;
    FLFS_NOTAFISCAL: String;
    FLFS_DATAEMISSAO: TDateTime;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FMNF_CODIGO: String;
    FLFS_PERCENTUALICMSITEM: Double;
    FLFS_QTDSAIDA: Double;
    FLFS_VALORITEM: Double;
    FLFS_VALORBASEISENTOICMSITEM: Double;
    FLFS_VALORBASECALCULOICMSITEM: Double;
    FLFS_VALORICMSITEM: Double;
    FLFS_VALORIPIITEM: Double;
    FLFS_VALORBASEOUTROSITEM: Double;
    FPES_UF: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V04_LFS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_NUMEROCUPOM', ftString, 1)]
    [Dictionary('LFS_NUMEROCUPOM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROCUPOM: String read FLFS_NUMEROCUPOM write FLFS_NUMEROCUPOM;
    const LFS_NUMEROCUPOM_Name = 'LFS_NUMEROCUPOM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_SERIEECF', ftString, 1)]
    [Dictionary('LFS_SERIEECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIEECF: String read FLFS_SERIEECF write FLFS_SERIEECF;
    const LFS_SERIEECF_Name = 'LFS_SERIEECF';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_PERCENTUALICMSITEM', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMSITEM: Double read FLFS_PERCENTUALICMSITEM write FLFS_PERCENTUALICMSITEM;
    const LFS_PERCENTUALICMSITEM_Name = 'LFS_PERCENTUALICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('LFS_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_QTDSAIDA: Double read FLFS_QTDSAIDA write FLFS_QTDSAIDA;
    const LFS_QTDSAIDA_Name = 'LFS_QTDSAIDA';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORITEM', ftBCD)]
    [Dictionary('LFS_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORITEM: Double read FLFS_VALORITEM write FLFS_VALORITEM;
    const LFS_VALORITEM_Name = 'LFS_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASEISENTOICMSITEM', ftBCD, 10, 2)]
    [Dictionary('LFS_VALORBASEISENTOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEISENTOICMSITEM: Double read FLFS_VALORBASEISENTOICMSITEM write FLFS_VALORBASEISENTOICMSITEM;
    const LFS_VALORBASEISENTOICMSITEM_Name = 'LFS_VALORBASEISENTOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMSITEM: Double read FLFS_VALORBASECALCULOICMSITEM write FLFS_VALORBASECALCULOICMSITEM;
    const LFS_VALORBASECALCULOICMSITEM_Name = 'LFS_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMSITEM', ftBCD)]
    [Dictionary('LFS_VALORICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMSITEM: Double read FLFS_VALORICMSITEM write FLFS_VALORICMSITEM;
    const LFS_VALORICMSITEM_Name = 'LFS_VALORICMSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORIPIITEM', ftBCD, 48, 2)]
    [Dictionary('LFS_VALORIPIITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORIPIITEM: Double read FLFS_VALORIPIITEM write FLFS_VALORIPIITEM;
    const LFS_VALORIPIITEM_Name = 'LFS_VALORIPIITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASEOUTROSITEM', ftBCD)]
    [Dictionary('LFS_VALORBASEOUTROSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASEOUTROSITEM: Double read FLFS_VALORBASEOUTROSITEM write FLFS_VALORBASEOUTROSITEM;
    const LFS_VALORBASEOUTROSITEM_Name = 'LFS_VALORBASEOUTROSITEM';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V04_LFS)

end.
