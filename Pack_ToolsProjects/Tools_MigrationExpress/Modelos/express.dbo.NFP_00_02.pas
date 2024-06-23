unit express.dbo.NFP_00_02;

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
  [Table('NFP_00_02', '')]
  [PrimaryKey('NFP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFP_ID')]
  TDtoNFP_00_02 = class
  private
    { Private declarations } 
    FNFP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FNFP_NUMERODOCTO: String;
    FNFP_NUMEROROMANEIO: String;
    FNFP_TOTALQTDCAIXAS: Double;
    FNFP_PERCENTUALPRORURAL: Double;
    FNFP_TOTALPRORURAL: Double;
    FNFP_TOTALLIQUIDO: Double;
    FNFP_OBSERVACAO: String;
    FNFP_DATAVENCIMENTO: TDateTime;
    FNFP_DATAALTERACAO: TDateTime;
    FNFP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'NFP_00_02';
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

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_NUMERODOCTO', ftString, 15)]
    [Dictionary('NFP_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMERODOCTO: String read FNFP_NUMERODOCTO write FNFP_NUMERODOCTO;
    const NFP_NUMERODOCTO_Name = 'NFP_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_NUMEROROMANEIO', ftString, 10)]
    [Dictionary('NFP_NUMEROROMANEIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMEROROMANEIO: String read FNFP_NUMEROROMANEIO write FNFP_NUMEROROMANEIO;
    const NFP_NUMEROROMANEIO_Name = 'NFP_NUMEROROMANEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALQTDCAIXAS', ftBCD)]
    [Dictionary('NFP_TOTALQTDCAIXAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALQTDCAIXAS: Double read FNFP_TOTALQTDCAIXAS write FNFP_TOTALQTDCAIXAS;
    const NFP_TOTALQTDCAIXAS_Name = 'NFP_TOTALQTDCAIXAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_PERCENTUALPRORURAL', ftBCD)]
    [Dictionary('NFP_PERCENTUALPRORURAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_PERCENTUALPRORURAL: Double read FNFP_PERCENTUALPRORURAL write FNFP_PERCENTUALPRORURAL;
    const NFP_PERCENTUALPRORURAL_Name = 'NFP_PERCENTUALPRORURAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALPRORURAL', ftBCD)]
    [Dictionary('NFP_TOTALPRORURAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALPRORURAL: Double read FNFP_TOTALPRORURAL write FNFP_TOTALPRORURAL;
    const NFP_TOTALPRORURAL_Name = 'NFP_TOTALPRORURAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_TOTALLIQUIDO', ftBCD)]
    [Dictionary('NFP_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_TOTALLIQUIDO: Double read FNFP_TOTALLIQUIDO write FNFP_TOTALLIQUIDO;
    const NFP_TOTALLIQUIDO_Name = 'NFP_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('NFP_OBSERVACAO', ftString, 300)]
    [Dictionary('NFP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_OBSERVACAO: String read FNFP_OBSERVACAO write FNFP_OBSERVACAO;
    const NFP_OBSERVACAO_Name = 'NFP_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('NFP_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('NFP_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFP_DATAVENCIMENTO: TDateTime read FNFP_DATAVENCIMENTO write FNFP_DATAVENCIMENTO;
    const NFP_DATAVENCIMENTO_Name = 'NFP_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAALTERACAO: TDateTime read FNFP_DATAALTERACAO write FNFP_DATAALTERACAO;
    const NFP_DATAALTERACAO_Name = 'NFP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFP_ID_OLD', ftInteger)]
    [Dictionary('NFP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID_OLD: Integer read FNFP_ID_OLD write FNFP_ID_OLD;
    const NFP_ID_OLD_Name = 'NFP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_00_02)

end.
