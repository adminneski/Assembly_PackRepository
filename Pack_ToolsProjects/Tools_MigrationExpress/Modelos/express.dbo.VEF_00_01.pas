unit express.dbo.VEF_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.vef_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('VEF_00_01', '')]
  [PrimaryKey('VEF_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_VEF_01_ID')]
  TDtoVEF_00_01 = class
  private
    { Private declarations } 
    FVEF_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FVEF_ID: Integer;
    FTAB_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FVEF_STATUS: String;
    FVEF_QTDPEDIDA: Double;
    FVEF_QTDFATURADA: Double;
    FVEF_PRECOTABELA: Double;
    FVEF_PRECOCUSTO: Double;
    FVEF_PRECOVENDA: Double;
    FVEF_PRECOLIQUIDO: Double;
    FVEF_PRECODIGITADO: Double;
    FVEF_PRECOBASEDESCTO: Double;
    FVEF_VALORDESCTOITEM: Double;
    FVEF_VALORACRESCIMOITEM: Double;
    FVEF_VALORDESCTOPRAZOITEM: Double;
    FVEF_VALORDESCTOAVULSOITEM: Double;
    FVEF_VALORFINANCEIROPRAZOITEM: Double;
    FVEF_VALORACRESCIMOAVULSOITEM: Double;
    FVEF_PERCENTUALDESCTOITEM: Double;
    FVEF_PERCENTUALACRESCIMOITEM: Double;
    FVEF_TOTALACRESCIMOITEM: Double;
    FVEF_TOTALACRESCIMOAVULSOITEM: Double;
    FVEF_TOTALDESCTOITEM: Double;
    FVEF_TOTALDESCTOPRAZOITEM: Double;
    FVEF_TOTALDESCTOAVULSOITEM: Double;
    FVEF_TOTALFINANCEIROPRAZOITEM: Double;
    FVEF_TOTALPRECOTABELA: Double;
    FVEF_TOTALPRECOVENDA: Double;
    FVEF_TOTALPRECOCUSTO: Double;
    FVEF_TOTALPRECOLIQUIDO: Double;
    FVEF_TOTALPRECODIGITADO: Double;
    FVEF_TOTALPRECOBASEDESCTO: Double;
    FVEF_PERCENTUALCOMISSAOITEM: Double;
    FVEF_VALORCOMISSAOITEM: Double;
    FVEF_TOTALCOMISSAOITEM: Double;
    FVEF_DATAALTERACAOSTATUS: TDateTime;
    FVEF_OBSERVACAOALTERACAOSTATUS: String;
    FVEF_QTDDESISTENCIA: Double;
    FVEF_DATADESISTENCIA: TDateTime;
    FVEF_MOTIVODESISTENCIA: String;
    FVEF_DATAALTERACAO: TDateTime;
    FVEF_01_ID_OLD: Integer;
    FVEF_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'VEF_00_01';
    const PrimaryKey = 'VEF_01_ID';
    const Sequence   = 'SEQ_VEF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_01_ID', ftInteger)]
    [Dictionary('VEF_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_01_ID: Integer read FVEF_01_ID write FVEF_01_ID;
    const VEF_01_ID_Name = 'VEF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [ForeignKey('VEF_00_01_fk', 'VEF_ID', 'VEF_00', 'VEF_ID', SetNull, SetNull)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

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
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEF_STATUS', ftString, 1)]
    [Dictionary('VEF_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_STATUS: String read FVEF_STATUS write FVEF_STATUS;
    const VEF_STATUS_Name = 'VEF_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('VEF_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDPEDIDA: Double read FVEF_QTDPEDIDA write FVEF_QTDPEDIDA;
    const VEF_QTDPEDIDA_Name = 'VEF_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('VEF_QTDFATURADA', ftBCD, 2036754804, 3)]
    [Dictionary('VEF_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDFATURADA: Double read FVEF_QTDFATURADA write FVEF_QTDFATURADA;
    const VEF_QTDFATURADA_Name = 'VEF_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('VEF_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PRECOTABELA: Double read FVEF_PRECOTABELA write FVEF_PRECOTABELA;
    const VEF_PRECOTABELA_Name = 'VEF_PRECOTABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('VEF_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PRECOCUSTO: Double read FVEF_PRECOCUSTO write FVEF_PRECOCUSTO;
    const VEF_PRECOCUSTO_Name = 'VEF_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRECOVENDA', ftBCD, 18, 4)]
    [Dictionary('VEF_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PRECOVENDA: Double read FVEF_PRECOVENDA write FVEF_PRECOVENDA;
    const VEF_PRECOVENDA_Name = 'VEF_PRECOVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRECOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('VEF_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PRECOLIQUIDO: Double read FVEF_PRECOLIQUIDO write FVEF_PRECOLIQUIDO;
    const VEF_PRECOLIQUIDO_Name = 'VEF_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRECODIGITADO', ftBCD, 18, 4)]
    [Dictionary('VEF_PRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PRECODIGITADO: Double read FVEF_PRECODIGITADO write FVEF_PRECODIGITADO;
    const VEF_PRECODIGITADO_Name = 'VEF_PRECODIGITADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRECOBASEDESCTO', ftBCD, 18, 4)]
    [Dictionary('VEF_PRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PRECOBASEDESCTO: Double read FVEF_PRECOBASEDESCTO write FVEF_PRECOBASEDESCTO;
    const VEF_PRECOBASEDESCTO_Name = 'VEF_PRECOBASEDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_VALORDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_VALORDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORDESCTOITEM: Double read FVEF_VALORDESCTOITEM write FVEF_VALORDESCTOITEM;
    const VEF_VALORDESCTOITEM_Name = 'VEF_VALORDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_VALORACRESCIMOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_VALORACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORACRESCIMOITEM: Double read FVEF_VALORACRESCIMOITEM write FVEF_VALORACRESCIMOITEM;
    const VEF_VALORACRESCIMOITEM_Name = 'VEF_VALORACRESCIMOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_VALORDESCTOPRAZOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_VALORDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORDESCTOPRAZOITEM: Double read FVEF_VALORDESCTOPRAZOITEM write FVEF_VALORDESCTOPRAZOITEM;
    const VEF_VALORDESCTOPRAZOITEM_Name = 'VEF_VALORDESCTOPRAZOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_VALORDESCTOAVULSOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_VALORDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORDESCTOAVULSOITEM: Double read FVEF_VALORDESCTOAVULSOITEM write FVEF_VALORDESCTOAVULSOITEM;
    const VEF_VALORDESCTOAVULSOITEM_Name = 'VEF_VALORDESCTOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_VALORFINANCEIROPRAZOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_VALORFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORFINANCEIROPRAZOITEM: Double read FVEF_VALORFINANCEIROPRAZOITEM write FVEF_VALORFINANCEIROPRAZOITEM;
    const VEF_VALORFINANCEIROPRAZOITEM_Name = 'VEF_VALORFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_VALORACRESCIMOAVULSOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_VALORACRESCIMOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORACRESCIMOAVULSOITEM: Double read FVEF_VALORACRESCIMOAVULSOITEM write FVEF_VALORACRESCIMOAVULSOITEM;
    const VEF_VALORACRESCIMOAVULSOITEM_Name = 'VEF_VALORACRESCIMOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PERCENTUALDESCTOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_PERCENTUALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALDESCTOITEM: Double read FVEF_PERCENTUALDESCTOITEM write FVEF_PERCENTUALDESCTOITEM;
    const VEF_PERCENTUALDESCTOITEM_Name = 'VEF_PERCENTUALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_PERCENTUALACRESCIMOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_PERCENTUALACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALACRESCIMOITEM: Double read FVEF_PERCENTUALACRESCIMOITEM write FVEF_PERCENTUALACRESCIMOITEM;
    const VEF_PERCENTUALACRESCIMOITEM_Name = 'VEF_PERCENTUALACRESCIMOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALACRESCIMOITEM', ftBCD, 1162891087, 2)]
    [Dictionary('VEF_TOTALACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALACRESCIMOITEM: Double read FVEF_TOTALACRESCIMOITEM write FVEF_TOTALACRESCIMOITEM;
    const VEF_TOTALACRESCIMOITEM_Name = 'VEF_TOTALACRESCIMOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALACRESCIMOAVULSOITEM', ftBCD, 543449445, 2)]
    [Dictionary('VEF_TOTALACRESCIMOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALACRESCIMOAVULSOITEM: Double read FVEF_TOTALACRESCIMOAVULSOITEM write FVEF_TOTALACRESCIMOAVULSOITEM;
    const VEF_TOTALACRESCIMOAVULSOITEM_Name = 'VEF_TOTALACRESCIMOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALDESCTOITEM', ftBCD, 1229213507, 2)]
    [Dictionary('VEF_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALDESCTOITEM: Double read FVEF_TOTALDESCTOITEM write FVEF_TOTALDESCTOITEM;
    const VEF_TOTALDESCTOITEM_Name = 'VEF_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALDESCTOPRAZOITEM', ftBCD, 1329815375, 2)]
    [Dictionary('VEF_TOTALDESCTOPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALDESCTOPRAZOITEM: Double read FVEF_TOTALDESCTOPRAZOITEM write FVEF_TOTALDESCTOPRAZOITEM;
    const VEF_TOTALDESCTOPRAZOITEM_Name = 'VEF_TOTALDESCTOPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALDESCTOAVULSOITEM', ftBCD, 659308878, 2)]
    [Dictionary('VEF_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALDESCTOAVULSOITEM: Double read FVEF_TOTALDESCTOAVULSOITEM write FVEF_TOTALDESCTOAVULSOITEM;
    const VEF_TOTALDESCTOAVULSOITEM_Name = 'VEF_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALFINANCEIROPRAZOITEM', ftBCD, 1919250543, 2)]
    [Dictionary('VEF_TOTALFINANCEIROPRAZOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALFINANCEIROPRAZOITEM: Double read FVEF_TOTALFINANCEIROPRAZOITEM write FVEF_TOTALFINANCEIROPRAZOITEM;
    const VEF_TOTALFINANCEIROPRAZOITEM_Name = 'VEF_TOTALFINANCEIROPRAZOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECOTABELA', ftBCD, 1598243924, 2)]
    [Dictionary('VEF_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECOTABELA: Double read FVEF_TOTALPRECOTABELA write FVEF_TOTALPRECOTABELA;
    const VEF_TOTALPRECOTABELA_Name = 'VEF_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECOVENDA', ftBCD, 1998605377, 2)]
    [Dictionary('VEF_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECOVENDA: Double read FVEF_TOTALPRECOVENDA write FVEF_TOTALPRECOVENDA;
    const VEF_TOTALPRECOVENDA_Name = 'VEF_TOTALPRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECOCUSTO', ftBCD, 1414407968, 2)]
    [Dictionary('VEF_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECOCUSTO: Double read FVEF_TOTALPRECOCUSTO write FVEF_TOTALPRECOCUSTO;
    const VEF_TOTALPRECOCUSTO_Name = 'VEF_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECOLIQUIDO', ftBCD, 537529610, 2)]
    [Dictionary('VEF_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECOLIQUIDO: Double read FVEF_TOTALPRECOLIQUIDO write FVEF_TOTALPRECOLIQUIDO;
    const VEF_TOTALPRECOLIQUIDO_Name = 'VEF_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECODIGITADO', ftBCD, 539780974, 2)]
    [Dictionary('VEF_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECODIGITADO: Double read FVEF_TOTALPRECODIGITADO write FVEF_TOTALPRECODIGITADO;
    const VEF_TOTALPRECODIGITADO_Name = 'VEF_TOTALPRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECOBASEDESCTO', ftBCD)]
    [Dictionary('VEF_TOTALPRECOBASEDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECOBASEDESCTO: Double read FVEF_TOTALPRECOBASEDESCTO write FVEF_TOTALPRECOBASEDESCTO;
    const VEF_TOTALPRECOBASEDESCTO_Name = 'VEF_TOTALPRECOBASEDESCTO';

    [Restrictions([NoValidate])]
    [Column('VEF_PERCENTUALCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_PERCENTUALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALCOMISSAOITEM: Double read FVEF_PERCENTUALCOMISSAOITEM write FVEF_PERCENTUALCOMISSAOITEM;
    const VEF_PERCENTUALCOMISSAOITEM_Name = 'VEF_PERCENTUALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_VALORCOMISSAOITEM', ftBCD, 18, 4)]
    [Dictionary('VEF_VALORCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_VALORCOMISSAOITEM: Double read FVEF_VALORCOMISSAOITEM write FVEF_VALORCOMISSAOITEM;
    const VEF_VALORCOMISSAOITEM_Name = 'VEF_VALORCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALCOMISSAOITEM', ftBCD)]
    [Dictionary('VEF_TOTALCOMISSAOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALCOMISSAOITEM: Double read FVEF_TOTALCOMISSAOITEM write FVEF_TOTALCOMISSAOITEM;
    const VEF_TOTALCOMISSAOITEM_Name = 'VEF_TOTALCOMISSAOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_DATAALTERACAOSTATUS', ftDateTime)]
    [Dictionary('VEF_DATAALTERACAOSTATUS', 'Mensagem de validação', '', '', '', taCenter)]
    property VEF_DATAALTERACAOSTATUS: TDateTime read FVEF_DATAALTERACAOSTATUS write FVEF_DATAALTERACAOSTATUS;
    const VEF_DATAALTERACAOSTATUS_Name = 'VEF_DATAALTERACAOSTATUS';

    [Restrictions([NoValidate])]
    [Column('VEF_OBSERVACAOALTERACAOSTATUS', ftString, 5000)]
    [Dictionary('VEF_OBSERVACAOALTERACAOSTATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_OBSERVACAOALTERACAOSTATUS: String read FVEF_OBSERVACAOALTERACAOSTATUS write FVEF_OBSERVACAOALTERACAOSTATUS;
    const VEF_OBSERVACAOALTERACAOSTATUS_Name = 'VEF_OBSERVACAOALTERACAOSTATUS';

    [Restrictions([NoValidate])]
    [Column('VEF_QTDDESISTENCIA', ftBCD, 740770885, 3)]
    [Dictionary('VEF_QTDDESISTENCIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDDESISTENCIA: Double read FVEF_QTDDESISTENCIA write FVEF_QTDDESISTENCIA;
    const VEF_QTDDESISTENCIA_Name = 'VEF_QTDDESISTENCIA';

    [Restrictions([NoValidate])]
    [Column('VEF_DATADESISTENCIA', ftDateTime)]
    [Dictionary('VEF_DATADESISTENCIA', 'Mensagem de validação', '', '', '', taCenter)]
    property VEF_DATADESISTENCIA: TDateTime read FVEF_DATADESISTENCIA write FVEF_DATADESISTENCIA;
    const VEF_DATADESISTENCIA_Name = 'VEF_DATADESISTENCIA';

    [Restrictions([NoValidate])]
    [Column('VEF_MOTIVODESISTENCIA', ftString, 5000)]
    [Dictionary('VEF_MOTIVODESISTENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_MOTIVODESISTENCIA: String read FVEF_MOTIVODESISTENCIA write FVEF_MOTIVODESISTENCIA;
    const VEF_MOTIVODESISTENCIA_Name = 'VEF_MOTIVODESISTENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('VEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATAALTERACAO: TDateTime read FVEF_DATAALTERACAO write FVEF_DATAALTERACAO;
    const VEF_DATAALTERACAO_Name = 'VEF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('VEF_01_ID_OLD', ftInteger)]
    [Dictionary('VEF_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_01_ID_OLD: Integer read FVEF_01_ID_OLD write FVEF_01_ID_OLD;
    const VEF_01_ID_OLD_Name = 'VEF_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('VEF_ID_OLD', ftInteger)]
    [Dictionary('VEF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID_OLD: Integer read FVEF_ID_OLD write FVEF_ID_OLD;
    const VEF_ID_OLD_Name = 'VEF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVEF_00_01)

end.
