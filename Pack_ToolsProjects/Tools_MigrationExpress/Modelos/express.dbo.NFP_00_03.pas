unit express.dbo.NFP_00_03;

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
  [Table('NFP_00_03', '')]
  [PrimaryKey('NFP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFP_ID')]
  TDtoNFP_00_03 = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFP_SERIE: String;
    FMNF_CODIGO: String;
    FNFP_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FNFP_DATAVENCIMENTO: TDateTime;
    FNFP_TOTALFRETECTR: Double;
    FNFP_TOTALICMSFRETECTR: Double;
    FNFP_TOTALRBCICMSFRETECTR: Double;
    FNFP_PERCENTUALICMSFRETECTR: Double;
    FNFP_DATAALTERACAO: TDateTime;
    FNFP_PLACAVEICULO: String;
    FNFP_UFVEICULO: String;
    FNFP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'NFP_00_03';
     const PrimaryKey = 'NFP_ID';
     const Sequence   = 'SEQ_NFP_ID';

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

    [Restrictions([NoValidate])]
    [Column('NFP_SERIE', ftString, 3)]
    [Dictionary('NFP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_SERIE: String read FNFP_SERIE write FNFP_SERIE;
    const NFP_SERIE_Name = 'NFP_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NOTAFISCAL: String read FNFP_NOTAFISCAL write FNFP_NOTAFISCAL;
    const NFP_NOTAFISCAL_Name = 'NFP_NOTAFISCAL';

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
    [Column('NFP_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('NFP_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFP_DATAVENCIMENTO: TDateTime read FNFP_DATAVENCIMENTO write FNFP_DATAVENCIMENTO;
    const NFP_DATAVENCIMENTO_Name = 'NFP_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALFRETECTR', ftBCD)]
    [Dictionary('NFP_TOTALFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALFRETECTR: Double read FNFP_TOTALFRETECTR write FNFP_TOTALFRETECTR;
    const NFP_TOTALFRETECTR_Name = 'NFP_TOTALFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALICMSFRETECTR', ftBCD)]
    [Dictionary('NFP_TOTALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALICMSFRETECTR: Double read FNFP_TOTALICMSFRETECTR write FNFP_TOTALICMSFRETECTR;
    const NFP_TOTALICMSFRETECTR_Name = 'NFP_TOTALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALRBCICMSFRETECTR', ftBCD)]
    [Dictionary('NFP_TOTALRBCICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALRBCICMSFRETECTR: Double read FNFP_TOTALRBCICMSFRETECTR write FNFP_TOTALRBCICMSFRETECTR;
    const NFP_TOTALRBCICMSFRETECTR_Name = 'NFP_TOTALRBCICMSFRETECTR';

    [Restrictions([NoValidate])]
    [Column('NFP_PERCENTUALICMSFRETECTR', ftBCD)]
    [Dictionary('NFP_PERCENTUALICMSFRETECTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALICMSFRETECTR: Double read FNFP_PERCENTUALICMSFRETECTR write FNFP_PERCENTUALICMSFRETECTR;
    const NFP_PERCENTUALICMSFRETECTR_Name = 'NFP_PERCENTUALICMSFRETECTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAALTERACAO: TDateTime read FNFP_DATAALTERACAO write FNFP_DATAALTERACAO;
    const NFP_DATAALTERACAO_Name = 'NFP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFP_PLACAVEICULO', ftString, 7)]
    [Dictionary('NFP_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_PLACAVEICULO: String read FNFP_PLACAVEICULO write FNFP_PLACAVEICULO;
    const NFP_PLACAVEICULO_Name = 'NFP_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('NFP_UFVEICULO', ftString, 2)]
    [Dictionary('NFP_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_UFVEICULO: String read FNFP_UFVEICULO write FNFP_UFVEICULO;
    const NFP_UFVEICULO_Name = 'NFP_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('NFP_ID_OLD', ftInteger)]
    [Dictionary('NFP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID_OLD: Integer read FNFP_ID_OLD write FNFP_ID_OLD;
    const NFP_ID_OLD_Name = 'NFP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_00_03)

end.
