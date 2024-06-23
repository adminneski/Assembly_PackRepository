unit express.dbo.PRO_00_05;

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
  [Table('PRO_00_05', '')]
  [PrimaryKey('PRO_05_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_05_ID')]
  TDtoPRO_00_05 = class
  private
    { Private declarations } 
    FPRO_05_ID: Integer;
    FPRO_CODIGO: Integer;
    FTAB_CODIGO: Integer;
    FPRO_QTDMINIMA: Double;
    FPRO_ULTIMOPRECO: Double;
    FPRO_PRECOPEDIDO: Double;
    FPRO_PRECOTABELA: Double;
    FPRO_PRECOANTERIOR: Double;
    FPRO_PRECOFATURAMENTO: Double;
    FPRO_VENDASUGESTAO: Double;
    FPRO_VENDALUCROZERO: Double;
    FPRO_VENDALUCROMINIMO: Double;
    FPRO_VENDALUCROMAXIMO: Double;
    FPRO_PERCENTUALACRESCIMO: Double;
    FPRO_PRODUTONATABELA: String;
    FPRO_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRO_00_05';
     const PrimaryKey = 'PRO_05_ID';
     const Sequence   = 'SEQ_PRO_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_05_ID', ftInteger)]
    [Dictionary('PRO_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_05_ID: Integer read FPRO_05_ID write FPRO_05_ID;
    const PRO_05_ID_Name = 'PRO_05_ID';

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
    [Column('PRO_QTDMINIMA', ftBCD, 1981834596, 3)]
    [Dictionary('PRO_QTDMINIMA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_QTDMINIMA: Double read FPRO_QTDMINIMA write FPRO_QTDMINIMA;
    const PRO_QTDMINIMA_Name = 'PRO_QTDMINIMA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_ULTIMOPRECO', ftBCD, 4456531, 2)]
    [Dictionary('PRO_ULTIMOPRECO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ULTIMOPRECO: Double read FPRO_ULTIMOPRECO write FPRO_ULTIMOPRECO;
    const PRO_ULTIMOPRECO_Name = 'PRO_ULTIMOPRECO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOPEDIDO', ftBCD, 5177428, 2)]
    [Dictionary('PRO_PRECOPEDIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOPEDIDO: Double read FPRO_PRECOPEDIDO write FPRO_PRECOPEDIDO;
    const PRO_PRECOPEDIDO_Name = 'PRO_PRECOPEDIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOTABELA', ftBCD, 1702129225, 2)]
    [Dictionary('PRO_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOTABELA: Double read FPRO_PRECOTABELA write FPRO_PRECOTABELA;
    const PRO_PRECOTABELA_Name = 'PRO_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOANTERIOR', ftBCD, 1146045279, 2)]
    [Dictionary('PRO_PRECOANTERIOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOANTERIOR: Double read FPRO_PRECOANTERIOR write FPRO_PRECOANTERIOR;
    const PRO_PRECOANTERIOR_Name = 'PRO_PRECOANTERIOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_PRECOFATURAMENTO', ftBCD, 1952867660, 2)]
    [Dictionary('PRO_PRECOFATURAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOFATURAMENTO: Double read FPRO_PRECOFATURAMENTO write FPRO_PRECOFATURAMENTO;
    const PRO_PRECOFATURAMENTO_Name = 'PRO_PRECOFATURAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDASUGESTAO', ftBCD, 539780974, 2)]
    [Dictionary('PRO_VENDASUGESTAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDASUGESTAO: Double read FPRO_VENDASUGESTAO write FPRO_VENDASUGESTAO;
    const PRO_VENDASUGESTAO_Name = 'PRO_VENDASUGESTAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDALUCROZERO', ftBCD, 1529377646, 2)]
    [Dictionary('PRO_VENDALUCROZERO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDALUCROZERO: Double read FPRO_VENDALUCROZERO write FPRO_VENDALUCROZERO;
    const PRO_VENDALUCROZERO_Name = 'PRO_VENDALUCROZERO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDALUCROMINIMO', ftBCD, 1952531540, 2)]
    [Dictionary('PRO_VENDALUCROMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDALUCROMINIMO: Double read FPRO_VENDALUCROMINIMO write FPRO_VENDALUCROMINIMO;
    const PRO_VENDALUCROMINIMO_Name = 'PRO_VENDALUCROMINIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_VENDALUCROMAXIMO', ftBCD, 1411398223, 2)]
    [Dictionary('PRO_VENDALUCROMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VENDALUCROMAXIMO: Double read FPRO_VENDALUCROMAXIMO write FPRO_VENDALUCROMAXIMO;
    const PRO_VENDALUCROMAXIMO_Name = 'PRO_VENDALUCROMAXIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALACRESCIMO', ftBCD, 1415532614, 2)]
    [Dictionary('PRO_PERCENTUALACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALACRESCIMO: Double read FPRO_PERCENTUALACRESCIMO write FPRO_PERCENTUALACRESCIMO;
    const PRO_PERCENTUALACRESCIMO_Name = 'PRO_PERCENTUALACRESCIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_PRODUTONATABELA', ftString, 1)]
    [Dictionary('PRO_PRODUTONATABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_PRODUTONATABELA: String read FPRO_PRODUTONATABELA write FPRO_PRODUTONATABELA;
    const PRO_PRODUTONATABELA_Name = 'PRO_PRODUTONATABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_00_05)

end.
