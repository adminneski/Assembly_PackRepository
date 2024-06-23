unit express.dbo.CCU_CPA_CRE_BCX;

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
  [Table('CCU_CPA_CRE_BCX', '')]
  TDtoCCU_CPA_CRE_BCX = class
  private
    { Private declarations } 
    FTIPO: String;
    FTABELA: String;
    FXXX_XX_XX_ID: Integer;
    FCOM_CODIGO: Integer;
    FXXX_ID: Integer;
    FXXX_XX_ID: Integer;
    FPLC_CODIGO: Integer;
    FPLC_PLANOCONTA: String;
    FCCU_CODIGO: Integer;
    FXXX_VALORRATEIO: Double;
    FXXX_PERCENTUALRATEIO: Double;
    FXXX_NUMERODOCUMENTO: String;
    FXXX_DATAEMISSAO: TDateTime;
    FXXX_DATAVENCTO: TDateTime;
    FXXX_DATALANCAMENTO: TDateTime;
    FXXX_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'CCU_CPA_CRE_BCX';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO', ftString, 3)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO: String read FTIPO write FTIPO;
    const TIPO_Name = 'TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TABELA', ftString, 12)]
    [Dictionary('TABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TABELA: String read FTABELA write FTABELA;
    const TABELA_Name = 'TABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('XXX_XX_XX_ID', ftInteger)]
    [Dictionary('XXX_XX_XX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property XXX_XX_XX_ID: Integer read FXXX_XX_XX_ID write FXXX_XX_XX_ID;
    const XXX_XX_XX_ID_Name = 'XXX_XX_XX_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('XXX_ID', ftInteger)]
    [Dictionary('XXX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property XXX_ID: Integer read FXXX_ID write FXXX_ID;
    const XXX_ID_Name = 'XXX_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('XXX_XX_ID', ftInteger)]
    [Dictionary('XXX_XX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property XXX_XX_ID: Integer read FXXX_XX_ID write FXXX_XX_ID;
    const XXX_XX_ID_Name = 'XXX_XX_ID';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_PLANOCONTA', ftString, 10)]
    [Dictionary('PLC_PLANOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_PLANOCONTA: String read FPLC_PLANOCONTA write FPLC_PLANOCONTA;
    const PLC_PLANOCONTA_Name = 'PLC_PLANOCONTA';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('XXX_VALORRATEIO', ftBCD, 1280335696, 6)]
    [Dictionary('XXX_VALORRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property XXX_VALORRATEIO: Double read FXXX_VALORRATEIO write FXXX_VALORRATEIO;
    const XXX_VALORRATEIO_Name = 'XXX_VALORRATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('XXX_PERCENTUALRATEIO', ftBCD, 7274723, 6)]
    [Dictionary('XXX_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property XXX_PERCENTUALRATEIO: Double read FXXX_PERCENTUALRATEIO write FXXX_PERCENTUALRATEIO;
    const XXX_PERCENTUALRATEIO_Name = 'XXX_PERCENTUALRATEIO';

    [Restrictions([NoValidate])]
    [Column('XXX_NUMERODOCUMENTO', ftString, 20)]
    [Dictionary('XXX_NUMERODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property XXX_NUMERODOCUMENTO: String read FXXX_NUMERODOCUMENTO write FXXX_NUMERODOCUMENTO;
    const XXX_NUMERODOCUMENTO_Name = 'XXX_NUMERODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('XXX_DATAEMISSAO', ftDateTime)]
    [Dictionary('XXX_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property XXX_DATAEMISSAO: TDateTime read FXXX_DATAEMISSAO write FXXX_DATAEMISSAO;
    const XXX_DATAEMISSAO_Name = 'XXX_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('XXX_DATAVENCTO', ftDateTime)]
    [Dictionary('XXX_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property XXX_DATAVENCTO: TDateTime read FXXX_DATAVENCTO write FXXX_DATAVENCTO;
    const XXX_DATAVENCTO_Name = 'XXX_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('XXX_DATALANCAMENTO', ftDateTime)]
    [Dictionary('XXX_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property XXX_DATALANCAMENTO: TDateTime read FXXX_DATALANCAMENTO write FXXX_DATALANCAMENTO;
    const XXX_DATALANCAMENTO_Name = 'XXX_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('XXX_DATAALTERACAO', ftDateTime)]
    [Dictionary('XXX_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property XXX_DATAALTERACAO: TDateTime read FXXX_DATAALTERACAO write FXXX_DATAALTERACAO;
    const XXX_DATAALTERACAO_Name = 'XXX_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCCU_CPA_CRE_BCX)

end.
