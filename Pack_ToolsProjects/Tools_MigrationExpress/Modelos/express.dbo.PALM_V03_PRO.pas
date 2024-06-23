unit express.dbo.PALM_V03_PRO;

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
  [Table('PALM_V03_PRO', '')]
  TDtoPALM_V03_PRO = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FTAB_CODIGO: Integer;
    FPRO_PRECOANTERIOR: Double;
    FPRO_PRECOFATURAMENTO: Double;
    FPRO_PRECOPEDIDO: Double;
    FPRO_PRECOTABELA: Double;
    FPRO_QTDMINIMA: Double;
    FPRO_ULTIMOPRECO: Double;
    FPRO_VENDALUCROMAXIMO: Double;
    FPRO_VENDALUCROMINIMO: Double;
    FPRO_VENDALUCROZERO: Double;
    FPRO_VENDASUGESTAO: Double;
    FPRO_PRODUTONATABELA: String;
    FTAB_DESCRICAO: String;
    FPRO_DESCRICAO: String;
    FTAB_PERCENTUALACRESCIMO: Double;
    FTAB_PERCENTUALDESCONTO: Double;
    FDATA_INICIO: TDateTime;
    FDATA_FIM: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'PALM_V03_PRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOANTERIOR', ftBCD)]
    [Dictionary('PRO_PRECOANTERIOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOANTERIOR: Double read FPRO_PRECOANTERIOR write FPRO_PRECOANTERIOR;
    const PRO_PRECOANTERIOR_Name = 'PRO_PRECOANTERIOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOFATURAMENTO', ftBCD)]
    [Dictionary('PRO_PRECOFATURAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOFATURAMENTO: Double read FPRO_PRECOFATURAMENTO write FPRO_PRECOFATURAMENTO;
    const PRO_PRECOFATURAMENTO_Name = 'PRO_PRECOFATURAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOPEDIDO', ftBCD, 48, 2)]
    [Dictionary('PRO_PRECOPEDIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOPEDIDO: Double read FPRO_PRECOPEDIDO write FPRO_PRECOPEDIDO;
    const PRO_PRECOPEDIDO_Name = 'PRO_PRECOPEDIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOTABELA', ftBCD)]
    [Dictionary('PRO_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOTABELA: Double read FPRO_PRECOTABELA write FPRO_PRECOTABELA;
    const PRO_PRECOTABELA_Name = 'PRO_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_QTDMINIMA', ftBCD)]
    [Dictionary('PRO_QTDMINIMA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDMINIMA: Double read FPRO_QTDMINIMA write FPRO_QTDMINIMA;
    const PRO_QTDMINIMA_Name = 'PRO_QTDMINIMA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_ULTIMOPRECO', ftBCD)]
    [Dictionary('PRO_ULTIMOPRECO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ULTIMOPRECO: Double read FPRO_ULTIMOPRECO write FPRO_ULTIMOPRECO;
    const PRO_ULTIMOPRECO_Name = 'PRO_ULTIMOPRECO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDALUCROMAXIMO', ftBCD)]
    [Dictionary('PRO_VENDALUCROMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDALUCROMAXIMO: Double read FPRO_VENDALUCROMAXIMO write FPRO_VENDALUCROMAXIMO;
    const PRO_VENDALUCROMAXIMO_Name = 'PRO_VENDALUCROMAXIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDALUCROMINIMO', ftBCD)]
    [Dictionary('PRO_VENDALUCROMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDALUCROMINIMO: Double read FPRO_VENDALUCROMINIMO write FPRO_VENDALUCROMINIMO;
    const PRO_VENDALUCROMINIMO_Name = 'PRO_VENDALUCROMINIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDALUCROZERO', ftBCD)]
    [Dictionary('PRO_VENDALUCROZERO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDALUCROZERO: Double read FPRO_VENDALUCROZERO write FPRO_VENDALUCROZERO;
    const PRO_VENDALUCROZERO_Name = 'PRO_VENDALUCROZERO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDASUGESTAO', ftBCD)]
    [Dictionary('PRO_VENDASUGESTAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDASUGESTAO: Double read FPRO_VENDASUGESTAO write FPRO_VENDASUGESTAO;
    const PRO_VENDASUGESTAO_Name = 'PRO_VENDASUGESTAO';

    [Restrictions([NoValidate])]
    [Column('PRO_PRODUTONATABELA', ftString, 1)]
    [Dictionary('PRO_PRODUTONATABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTONATABELA: String read FPRO_PRODUTONATABELA write FPRO_PRODUTONATABELA;
    const PRO_PRODUTONATABELA_Name = 'PRO_PRODUTONATABELA';

    [Restrictions([NoValidate])]
    [Column('TAB_DESCRICAO', ftString, 30)]
    [Dictionary('TAB_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TAB_DESCRICAO: String read FTAB_DESCRICAO write FTAB_DESCRICAO;
    const TAB_DESCRICAO_Name = 'TAB_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('TAB_PERCENTUALACRESCIMO', ftBCD)]
    [Dictionary('TAB_PERCENTUALACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TAB_PERCENTUALACRESCIMO: Double read FTAB_PERCENTUALACRESCIMO write FTAB_PERCENTUALACRESCIMO;
    const TAB_PERCENTUALACRESCIMO_Name = 'TAB_PERCENTUALACRESCIMO';

    [Restrictions([NoValidate])]
    [Column('TAB_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('TAB_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TAB_PERCENTUALDESCONTO: Double read FTAB_PERCENTUALDESCONTO write FTAB_PERCENTUALDESCONTO;
    const TAB_PERCENTUALDESCONTO_Name = 'TAB_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('DATA_INICIO', ftDateTime)]
    [Dictionary('DATA_INICIO', 'Mensagem de validação', '', '', '', taCenter)]
    property DATA_INICIO: TDateTime read FDATA_INICIO write FDATA_INICIO;
    const DATA_INICIO_Name = 'DATA_INICIO';

    [Restrictions([NoValidate])]
    [Column('DATA_FIM', ftDateTime)]
    [Dictionary('DATA_FIM', 'Mensagem de validação', '', '', '', taCenter)]
    property DATA_FIM: TDateTime read FDATA_FIM write FDATA_FIM;
    const DATA_FIM_Name = 'DATA_FIM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V03_PRO)

end.
