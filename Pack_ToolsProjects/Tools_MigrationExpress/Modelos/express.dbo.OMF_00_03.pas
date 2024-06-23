unit express.dbo.OMF_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.omf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('OMF_00_03', '')]
  [PrimaryKey('OMF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_ID')]
  TDtoOMF_00_03 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_SERIE: String;
    FMNF_CODIGO: String;
    FOMF_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FFPG_CODIGO: Integer;
    FOMF_DATAVENCIMENTO: TDateTime;
    FOMF_TOTALFRETECTR: Double;
    FOMF_TOTALICMSFRETECTR: Double;
    FOMF_TOTALBCICMSFRETECTR: Double;
    FOMF_PERCENTUALICMSFRETECTR: Double;
    FOMF_CHAVEACESSOCTR: String;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: String;
    FOMF_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'OMF_00_03';
    const PrimaryKey = 'OMF_ID';
    const Sequence   = 'SEQ_OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_03_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_SERIE', ftString, 3)]
    [Dictionary('OMF_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_SERIE: String read FOMF_SERIE write FOMF_SERIE;
    const OMF_SERIE_Name = 'OMF_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_NOTAFISCAL', ftString, 9)]
    [Dictionary('OMF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NOTAFISCAL: String read FOMF_NOTAFISCAL write FOMF_NOTAFISCAL;
    const OMF_NOTAFISCAL_Name = 'OMF_NOTAFISCAL';

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
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('OMF_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAVENCIMENTO: TDateTime read FOMF_DATAVENCIMENTO write FOMF_DATAVENCIMENTO;
    const OMF_DATAVENCIMENTO_Name = 'OMF_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALFRETECTR', ftBCD)]
    [Dictionary('OMF_TOTALFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALFRETECTR: Double read FOMF_TOTALFRETECTR write FOMF_TOTALFRETECTR;
    const OMF_TOTALFRETECTR_Name = 'OMF_TOTALFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMSFRETECTR', ftBCD)]
    [Dictionary('OMF_TOTALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSFRETECTR: Double read FOMF_TOTALICMSFRETECTR write FOMF_TOTALICMSFRETECTR;
    const OMF_TOTALICMSFRETECTR_Name = 'OMF_TOTALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALBCICMSFRETECTR', ftBCD)]
    [Dictionary('OMF_TOTALBCICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALBCICMSFRETECTR: Double read FOMF_TOTALBCICMSFRETECTR write FOMF_TOTALBCICMSFRETECTR;
    const OMF_TOTALBCICMSFRETECTR_Name = 'OMF_TOTALBCICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('OMF_PERCENTUALICMSFRETECTR', ftBCD, 16387, 2)]
    [Dictionary('OMF_PERCENTUALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_PERCENTUALICMSFRETECTR: Double read FOMF_PERCENTUALICMSFRETECTR write FOMF_PERCENTUALICMSFRETECTR;
    const OMF_PERCENTUALICMSFRETECTR_Name = 'OMF_PERCENTUALICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('OMF_CHAVEACESSOCTR', ftString, 44)]
    [Dictionary('OMF_CHAVEACESSOCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CHAVEACESSOCTR: String read FOMF_CHAVEACESSOCTR write FOMF_CHAVEACESSOCTR;
    const OMF_CHAVEACESSOCTR_Name = 'OMF_CHAVEACESSOCTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: String read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;
    const OMF_INTEGRACAOERP_Name = 'OMF_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_03)

end.
