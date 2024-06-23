unit express.dbo.ORS_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ors_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ORS_00_01', '')]
  [PrimaryKey('ORS_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_01_ID')]
  TDtoORS_00_01 = class
  private
    { Private declarations } 
    FORS_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_ID: Integer;
    FTAB_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FORS_QTDPEDIDA: Double;
    FGRD_CODIGO: String;
    FORS_PRECOVENDA: Double;
    FORS_PRECOCUSTO: Double;
    FORS_PRECOTABELA: Double;
    FORS_PRECOLIQUIDO: Double;
    FORS_PRECODIGITADO: Double;
    FORS_PRECOBASEDESCTO: Double;
    FORS_VALORDESCTOITEM: Double;
    FORS_VALORACRESCIMOITEM: Double;
    FORS_VALORCOMISSAOITEM: Double;
    FORS_VALORDESCTOAVULSOITEM: Double;
    FORS_VALORACRESCIMOAVULSOITEM: Double;
    FORS_TOTALPRECOVENDA: Double;
    FORS_TOTALPRECOCUSTO: Double;
    FORS_TOTALPRECOTABELA: Double;
    FORS_TOTALPRECOLIQUIDO: Double;
    FORS_TOTALPRECODIGITADO: Double;
    FORS_TOTALPRECOBASEDESCTO: Double;
    FORS_TOTALDESCTOITEM: Double;
    FORS_TOTALDESCTOAVULSOITEM: Double;
    FORS_TOTALCOMISSAOITEM: Double;
    FORS_TOTALACRESCIMOITEM: Double;
    FORS_TOTALACRESCIMOAVULSOITEM: Double;
    FORS_PERCENTUALDESCTOITEM: Double;
    FORS_PERCENTUALACRESCIMOITEM: Double;
    FORS_PERCENTUALCOMISSAOITEM: Double;
    FORS_DATAALTERACAO: TDateTime;
    FORS_HASHKEY: String;
    FORS_COD_TOT_PARC: String;
    FORS_VALORITEM: Double;
    FORS_VALORLIQUIDOITEM: Double;
    FORS_01_ID_OLD: Integer;
    FORS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'ORS_00_01';
    const PrimaryKey = 'ORS_01_ID';
    const Sequence   = 'SEQ_ORS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_01_ID', ftInteger)]
    [Dictionary('ORS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_01_ID: Integer read FORS_01_ID write FORS_01_ID;
    const ORS_01_ID_Name = 'ORS_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID', ftInteger)]
    [ForeignKey('ORS_00_01_fk', 'ORS_ID', 'ORS_00', 'ORS_ID', SetNull, SetNull)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('ORS_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_QTDPEDIDA: Double read FORS_QTDPEDIDA write FORS_QTDPEDIDA;
    const ORS_QTDPEDIDA_Name = 'ORS_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_PRECOVENDA', ftBCD, 538970637, 2)]
    [Dictionary('ORS_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PRECOVENDA: Double read FORS_PRECOVENDA write FORS_PRECOVENDA;
    const ORS_PRECOVENDA_Name = 'ORS_PRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('ORS_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('ORS_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PRECOCUSTO: Double read FORS_PRECOCUSTO write FORS_PRECOCUSTO;
    const ORS_PRECOCUSTO_Name = 'ORS_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('ORS_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('ORS_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PRECOTABELA: Double read FORS_PRECOTABELA write FORS_PRECOTABELA;
    const ORS_PRECOTABELA_Name = 'ORS_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('ORS_PRECOLIQUIDO', ftBCD, 1179206738, 2)]
    [Dictionary('ORS_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PRECOLIQUIDO: Double read FORS_PRECOLIQUIDO write FORS_PRECOLIQUIDO;
    const ORS_PRECOLIQUIDO_Name = 'ORS_PRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ORS_PRECODIGITADO', ftBCD, 221996910, 2)]
    [Dictionary('ORS_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PRECODIGITADO: Double read FORS_PRECODIGITADO write FORS_PRECODIGITADO;
    const ORS_PRECODIGITADO_Name = 'ORS_PRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('ORS_PRECOBASEDESCTO', ftBCD, 1818453348, 2)]
    [Dictionary('ORS_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PRECOBASEDESCTO: Double read FORS_PRECOBASEDESCTO write FORS_PRECOBASEDESCTO;
    const ORS_PRECOBASEDESCTO_Name = 'ORS_PRECOBASEDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_VALORDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORDESCTOITEM: Double read FORS_VALORDESCTOITEM write FORS_VALORDESCTOITEM;
    const ORS_VALORDESCTOITEM_Name = 'ORS_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORACRESCIMOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORACRESCIMOITEM: Double read FORS_VALORACRESCIMOITEM write FORS_VALORACRESCIMOITEM;
    const ORS_VALORACRESCIMOITEM_Name = 'ORS_VALORACRESCIMOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORCOMISSAOITEM: Double read FORS_VALORCOMISSAOITEM write FORS_VALORCOMISSAOITEM;
    const ORS_VALORCOMISSAOITEM_Name = 'ORS_VALORCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORDESCTOAVULSOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORDESCTOAVULSOITEM: Double read FORS_VALORDESCTOAVULSOITEM write FORS_VALORDESCTOAVULSOITEM;
    const ORS_VALORDESCTOAVULSOITEM_Name = 'ORS_VALORDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_VALORACRESCIMOAVULSOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORACRESCIMOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORACRESCIMOAVULSOITEM: Double read FORS_VALORACRESCIMOAVULSOITEM write FORS_VALORACRESCIMOAVULSOITEM;
    const ORS_VALORACRESCIMOAVULSOITEM_Name = 'ORS_VALORACRESCIMOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRECOVENDA', ftBCD, 1953391939, 2)]
    [Dictionary('ORS_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRECOVENDA: Double read FORS_TOTALPRECOVENDA write FORS_TOTALPRECOVENDA;
    const ORS_TOTALPRECOVENDA_Name = 'ORS_TOTALPRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRECOCUSTO', ftBCD, 538970637, 2)]
    [Dictionary('ORS_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRECOCUSTO: Double read FORS_TOTALPRECOCUSTO write FORS_TOTALPRECOCUSTO;
    const ORS_TOTALPRECOCUSTO_Name = 'ORS_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRECOTABELA', ftBCD, 1281455136, 2)]
    [Dictionary('ORS_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRECOTABELA: Double read FORS_TOTALPRECOTABELA write FORS_TOTALPRECOTABELA;
    const ORS_TOTALPRECOTABELA_Name = 'ORS_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRECOLIQUIDO', ftBCD, 1981834596, 2)]
    [Dictionary('ORS_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRECOLIQUIDO: Double read FORS_TOTALPRECOLIQUIDO write FORS_TOTALPRECOLIQUIDO;
    const ORS_TOTALPRECOLIQUIDO_Name = 'ORS_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRECODIGITADO', ftBCD, 539780974, 2)]
    [Dictionary('ORS_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRECODIGITADO: Double read FORS_TOTALPRECODIGITADO write FORS_TOTALPRECODIGITADO;
    const ORS_TOTALPRECODIGITADO_Name = 'ORS_TOTALPRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRECOBASEDESCTO', ftBCD, 1162891087, 2)]
    [Dictionary('ORS_TOTALPRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRECOBASEDESCTO: Double read FORS_TOTALPRECOBASEDESCTO write FORS_TOTALPRECOBASEDESCTO;
    const ORS_TOTALPRECOBASEDESCTO_Name = 'ORS_TOTALPRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALDESCTOITEM', ftBCD, 1529377646, 2)]
    [Dictionary('ORS_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOITEM: Double read FORS_TOTALDESCTOITEM write FORS_TOTALDESCTOITEM;
    const ORS_TOTALDESCTOITEM_Name = 'ORS_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALDESCTOAVULSOITEM', ftBCD, 1146045279, 2)]
    [Dictionary('ORS_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOAVULSOITEM: Double read FORS_TOTALDESCTOAVULSOITEM write FORS_TOTALDESCTOAVULSOITEM;
    const ORS_TOTALDESCTOAVULSOITEM_Name = 'ORS_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALCOMISSAOITEM', ftBCD, 1195983951, 2)]
    [Dictionary('ORS_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALCOMISSAOITEM: Double read FORS_TOTALCOMISSAOITEM write FORS_TOTALCOMISSAOITEM;
    const ORS_TOTALCOMISSAOITEM_Name = 'ORS_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALACRESCIMOITEM', ftBCD, 1145132617, 2)]
    [Dictionary('ORS_TOTALACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALACRESCIMOITEM: Double read FORS_TOTALACRESCIMOITEM write FORS_TOTALACRESCIMOITEM;
    const ORS_TOTALACRESCIMOITEM_Name = 'ORS_TOTALACRESCIMOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALACRESCIMOAVULSOITEM', ftBCD, 1952531540, 2)]
    [Dictionary('ORS_TOTALACRESCIMOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALACRESCIMOAVULSOITEM: Double read FORS_TOTALACRESCIMOAVULSOITEM write FORS_TOTALACRESCIMOAVULSOITEM;
    const ORS_TOTALACRESCIMOAVULSOITEM_Name = 'ORS_TOTALACRESCIMOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALDESCTOITEM: Double read FORS_PERCENTUALDESCTOITEM write FORS_PERCENTUALDESCTOITEM;
    const ORS_PERCENTUALDESCTOITEM_Name = 'ORS_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALACRESCIMOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_PERCENTUALACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALACRESCIMOITEM: Double read FORS_PERCENTUALACRESCIMOITEM write FORS_PERCENTUALACRESCIMOITEM;
    const ORS_PERCENTUALACRESCIMOITEM_Name = 'ORS_PERCENTUALACRESCIMOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALCOMISSAOITEM: Double read FORS_PERCENTUALCOMISSAOITEM write FORS_PERCENTUALCOMISSAOITEM;
    const ORS_PERCENTUALCOMISSAOITEM_Name = 'ORS_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_HASHKEY', ftString, 50)]
    [Dictionary('ORS_HASHKEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_HASHKEY: String read FORS_HASHKEY write FORS_HASHKEY;
    const ORS_HASHKEY_Name = 'ORS_HASHKEY';

    [Restrictions([NoValidate])]
    [Column('ORS_COD_TOT_PARC', ftString, 7)]
    [Dictionary('ORS_COD_TOT_PARC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_COD_TOT_PARC: String read FORS_COD_TOT_PARC write FORS_COD_TOT_PARC;
    const ORS_COD_TOT_PARC_Name = 'ORS_COD_TOT_PARC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_VALORITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORITEM: Double read FORS_VALORITEM write FORS_VALORITEM;
    const ORS_VALORITEM_Name = 'ORS_VALORITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_VALORLIQUIDOITEM', ftBCD, 18, 4)]
    [Dictionary('ORS_VALORLIQUIDOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_VALORLIQUIDOITEM: Double read FORS_VALORLIQUIDOITEM write FORS_VALORLIQUIDOITEM;
    const ORS_VALORLIQUIDOITEM_Name = 'ORS_VALORLIQUIDOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_01_ID_OLD', ftInteger)]
    [Dictionary('ORS_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_01_ID_OLD: Integer read FORS_01_ID_OLD write FORS_01_ID_OLD;
    const ORS_01_ID_OLD_Name = 'ORS_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_00_01)

end.
