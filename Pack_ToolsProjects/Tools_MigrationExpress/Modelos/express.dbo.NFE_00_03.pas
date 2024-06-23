unit express.dbo.NFE_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.nfe_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('NFE_00_03', '')]
  [PrimaryKey('NFE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFE_ID')]
  TDtoNFE_00_03 = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_SERIE: String;
    FMNF_CODIGO: String;
    FNFE_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FNFE_DATAVENCIMENTO: TDateTime;
    FNFE_TOTALFRETECTR: Double;
    FNFE_TOTALICMSFRETECTR: Double;
    FNFE_TOTALBCICMSFRETECTR: Double;
    FNFE_PERCENTUALICMSFRETECTR: Double;
    FNFE_DATAALTERACAO: TDateTime;
    FFPG_CODIGO: Integer;
    FNFE_CHAVEACESSOCTR: String;
    FNFE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'NFE_00_03';
    const PrimaryKey = 'NFE_ID';
    const Sequence   = 'SEQ_NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [ForeignKey('NFE_00_03_fk', 'NFE_ID', 'NFE_00', 'NFE_ID', SetNull, SetNull)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_SERIE', ftString, 3)]
    [Dictionary('NFE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIE: String read FNFE_SERIE write FNFE_SERIE;
    const NFE_SERIE_Name = 'NFE_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 3)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('NFE_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAVENCIMENTO: TDateTime read FNFE_DATAVENCIMENTO write FNFE_DATAVENCIMENTO;
    const NFE_DATAVENCIMENTO_Name = 'NFE_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALFRETECTR', ftBCD)]
    [Dictionary('NFE_TOTALFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALFRETECTR: Double read FNFE_TOTALFRETECTR write FNFE_TOTALFRETECTR;
    const NFE_TOTALFRETECTR_Name = 'NFE_TOTALFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALICMSFRETECTR', ftBCD)]
    [Dictionary('NFE_TOTALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSFRETECTR: Double read FNFE_TOTALICMSFRETECTR write FNFE_TOTALICMSFRETECTR;
    const NFE_TOTALICMSFRETECTR_Name = 'NFE_TOTALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALBCICMSFRETECTR', ftBCD)]
    [Dictionary('NFE_TOTALBCICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALBCICMSFRETECTR: Double read FNFE_TOTALBCICMSFRETECTR write FNFE_TOTALBCICMSFRETECTR;
    const NFE_TOTALBCICMSFRETECTR_Name = 'NFE_TOTALBCICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('NFE_PERCENTUALICMSFRETECTR', ftBCD)]
    [Dictionary('NFE_PERCENTUALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_PERCENTUALICMSFRETECTR: Double read FNFE_PERCENTUALICMSFRETECTR write FNFE_PERCENTUALICMSFRETECTR;
    const NFE_PERCENTUALICMSFRETECTR_Name = 'NFE_PERCENTUALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATAALTERACAO: TDateTime read FNFE_DATAALTERACAO write FNFE_DATAALTERACAO;
    const NFE_DATAALTERACAO_Name = 'NFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_CHAVEACESSOCTR', ftString, 44)]
    [Dictionary('NFE_CHAVEACESSOCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CHAVEACESSOCTR: String read FNFE_CHAVEACESSOCTR write FNFE_CHAVEACESSOCTR;
    const NFE_CHAVEACESSOCTR_Name = 'NFE_CHAVEACESSOCTR';

    [Restrictions([NoValidate])]
    [Column('NFE_ID_OLD', ftInteger)]
    [Dictionary('NFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID_OLD: Integer read FNFE_ID_OLD write FNFE_ID_OLD;
    const NFE_ID_OLD_Name = 'NFE_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoNFE_00_03)

end.
