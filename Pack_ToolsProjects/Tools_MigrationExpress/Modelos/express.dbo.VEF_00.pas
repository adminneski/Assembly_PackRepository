unit express.dbo.VEF_00;

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
  [Table('VEF_00', '')]
  [PrimaryKey('VEF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_VEF_ID')]
  TDtoVEF_00 = class
  private
    { Private declarations } 
    FVEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCON_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FVEF_NUMERODOCTO: String;
    FLIB_NUMEROLIBERACAO: String;
    FVEF_DATALANCAMENTO: TDateTime;
    FVEF_TOTALQTDPEDIDA: Double;
    FVEF_TOTALPRODUTOS: Double;
    FVEF_TOTALLIQUIDO: Double;
    FVEF_TOTALDESCTOITEM: Double;
    FVEF_TOTALDESCTOPRAZO: Double;
    FVEF_TOTALDESCTOAVULSO: Double;
    FVEF_TOTALACRESCIMOITEM: Double;
    FVEF_TOTALFINANCEIROPRAZO: Double;
    FVEF_TOTALACRESCIMOAVULSO: Double;
    FVEF_TOTALCOMISSAO: Double;
    FVEF_TOTALBASEDESCONTOCOMISSAO: Double;
    FVEF_PERCENTUALDESCTOAVULSO: Double;
    FVEF_PERCENTUALFINANCEIROPRAZO: Double;
    FVEF_PERCENTUALDESCONTOPRAZO: Double;
    FVEF_PERCENTUALACRESCIMOAVULSO: Double;
    FVEF_PERCENTUALCOMISSAO: Double;
    FVEF_COMISSAONEGOCIADA: String;
    FVEF_IDFATURAMENTOPRODUTOS: Integer;
    FVEF_DATACANCELAMENTO: TDateTime;
    FVEF_OBSERVACAOCANCELAMENTO: String;
    FVEF_AMBIENTE: String;
    FVEF_PRAZOENTREGA: String;
    FVEF_VALIDADE: Integer;
    FVEF_RESPONSAVELRECEBIMENTO: String;
    FVEF_OBSERVACAO: String;
    FVEF_CANCELADA: String;
    FVEF_PROCESSADO: String;
    FVEF_FINANCEIRO: String;
    FVEF_DATAALTERACAO: TDateTime;
    FLIB_ID: Integer;
    FVEF_ID_OLD: Integer;
    FLIB_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'VEF_00';
     const PrimaryKey = 'VEF_ID';
     const Sequence   = 'SEQ_VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CON_CODIGO: Integer read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_NUMERODOCTO', ftString, 10)]
    [Dictionary('VEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_NUMERODOCTO: String read FVEF_NUMERODOCTO write FVEF_NUMERODOCTO;
    const VEF_NUMERODOCTO_Name = 'VEF_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('VEF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATALANCAMENTO: TDateTime read FVEF_DATALANCAMENTO write FVEF_DATALANCAMENTO;
    const VEF_DATALANCAMENTO_Name = 'VEF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALQTDPEDIDA', ftBCD, 1599096398, 3)]
    [Dictionary('VEF_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALQTDPEDIDA: Double read FVEF_TOTALQTDPEDIDA write FVEF_TOTALQTDPEDIDA;
    const VEF_TOTALQTDPEDIDA_Name = 'VEF_TOTALQTDPEDIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALPRODUTOS', ftBCD, 1415532614, 2)]
    [Dictionary('VEF_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRODUTOS: Double read FVEF_TOTALPRODUTOS write FVEF_TOTALPRODUTOS;
    const VEF_TOTALPRODUTOS_Name = 'VEF_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALLIQUIDO', ftBCD, 539780974, 2)]
    [Dictionary('VEF_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALLIQUIDO: Double read FVEF_TOTALLIQUIDO write FVEF_TOTALLIQUIDO;
    const VEF_TOTALLIQUIDO_Name = 'VEF_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALDESCTOITEM', ftBCD, 1981834596, 2)]
    [Dictionary('VEF_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALDESCTOITEM: Double read FVEF_TOTALDESCTOITEM write FVEF_TOTALDESCTOITEM;
    const VEF_TOTALDESCTOITEM_Name = 'VEF_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALDESCTOPRAZO', ftBCD, 1146045279, 2)]
    [Dictionary('VEF_TOTALDESCTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALDESCTOPRAZO: Double read FVEF_TOTALDESCTOPRAZO write FVEF_TOTALDESCTOPRAZO;
    const VEF_TOTALDESCTOPRAZO_Name = 'VEF_TOTALDESCTOPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALDESCTOAVULSO', ftBCD, 656419879, 2)]
    [Dictionary('VEF_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALDESCTOAVULSO: Double read FVEF_TOTALDESCTOAVULSO write FVEF_TOTALDESCTOAVULSO;
    const VEF_TOTALDESCTOAVULSO_Name = 'VEF_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALACRESCIMOITEM', ftBCD, 6881394, 2)]
    [Dictionary('VEF_TOTALACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALACRESCIMOITEM: Double read FVEF_TOTALACRESCIMOITEM write FVEF_TOTALACRESCIMOITEM;
    const VEF_TOTALACRESCIMOITEM_Name = 'VEF_TOTALACRESCIMOITEM';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALFINANCEIROPRAZO', ftBCD, 1411398223, 2)]
    [Dictionary('VEF_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALFINANCEIROPRAZO: Double read FVEF_TOTALFINANCEIROPRAZO write FVEF_TOTALFINANCEIROPRAZO;
    const VEF_TOTALFINANCEIROPRAZO_Name = 'VEF_TOTALFINANCEIROPRAZO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALACRESCIMOAVULSO', ftBCD, 1145132617, 2)]
    [Dictionary('VEF_TOTALACRESCIMOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALACRESCIMOAVULSO: Double read FVEF_TOTALACRESCIMOAVULSO write FVEF_TOTALACRESCIMOAVULSO;
    const VEF_TOTALACRESCIMOAVULSO_Name = 'VEF_TOTALACRESCIMOAVULSO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALCOMISSAO', ftBCD, 1835362145, 2)]
    [Dictionary('VEF_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALCOMISSAO: Double read FVEF_TOTALCOMISSAO write FVEF_TOTALCOMISSAO;
    const VEF_TOTALCOMISSAO_Name = 'VEF_TOTALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALBASEDESCONTOCOMISSAO', ftBCD, 5177428, 2)]
    [Dictionary('VEF_TOTALBASEDESCONTOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALBASEDESCONTOCOMISSAO: Double read FVEF_TOTALBASEDESCONTOCOMISSAO write FVEF_TOTALBASEDESCONTOCOMISSAO;
    const VEF_TOTALBASEDESCONTOCOMISSAO_Name = 'VEF_TOTALBASEDESCONTOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PERCENTUALDESCTOAVULSO', ftBCD, 1769238085, 6)]
    [Dictionary('VEF_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALDESCTOAVULSO: Double read FVEF_PERCENTUALDESCTOAVULSO write FVEF_PERCENTUALDESCTOAVULSO;
    const VEF_PERCENTUALDESCTOAVULSO_Name = 'VEF_PERCENTUALDESCTOAVULSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PERCENTUALFINANCEIROPRAZO', ftBCD, 1195983951, 2)]
    [Dictionary('VEF_PERCENTUALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALFINANCEIROPRAZO: Double read FVEF_PERCENTUALFINANCEIROPRAZO write FVEF_PERCENTUALFINANCEIROPRAZO;
    const VEF_PERCENTUALFINANCEIROPRAZO_Name = 'VEF_PERCENTUALFINANCEIROPRAZO';

    [Restrictions([NoValidate])]
    [Column('VEF_PERCENTUALDESCONTOPRAZO', ftBCD, 5374017, 2)]
    [Dictionary('VEF_PERCENTUALDESCONTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALDESCONTOPRAZO: Double read FVEF_PERCENTUALDESCONTOPRAZO write FVEF_PERCENTUALDESCONTOPRAZO;
    const VEF_PERCENTUALDESCONTOPRAZO_Name = 'VEF_PERCENTUALDESCONTOPRAZO';

    [Restrictions([NoValidate])]
    [Column('VEF_PERCENTUALACRESCIMOAVULSO', ftBCD, 7274723, 2)]
    [Dictionary('VEF_PERCENTUALACRESCIMOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALACRESCIMOAVULSO: Double read FVEF_PERCENTUALACRESCIMOAVULSO write FVEF_PERCENTUALACRESCIMOAVULSO;
    const VEF_PERCENTUALACRESCIMOAVULSO_Name = 'VEF_PERCENTUALACRESCIMOAVULSO';

    [Restrictions([NoValidate])]
    [Column('VEF_PERCENTUALCOMISSAO', ftBCD, 1280335696, 2)]
    [Dictionary('VEF_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALCOMISSAO: Double read FVEF_PERCENTUALCOMISSAO write FVEF_PERCENTUALCOMISSAO;
    const VEF_PERCENTUALCOMISSAO_Name = 'VEF_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('VEF_COMISSAONEGOCIADA', ftString, 1)]
    [Dictionary('VEF_COMISSAONEGOCIADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_COMISSAONEGOCIADA: String read FVEF_COMISSAONEGOCIADA write FVEF_COMISSAONEGOCIADA;
    const VEF_COMISSAONEGOCIADA_Name = 'VEF_COMISSAONEGOCIADA';

    [Restrictions([NoValidate])]
    [Column('VEF_IDFATURAMENTOPRODUTOS', ftInteger)]
    [Dictionary('VEF_IDFATURAMENTOPRODUTOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_IDFATURAMENTOPRODUTOS: Integer read FVEF_IDFATURAMENTOPRODUTOS write FVEF_IDFATURAMENTOPRODUTOS;
    const VEF_IDFATURAMENTOPRODUTOS_Name = 'VEF_IDFATURAMENTOPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('VEF_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('VEF_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property VEF_DATACANCELAMENTO: TDateTime read FVEF_DATACANCELAMENTO write FVEF_DATACANCELAMENTO;
    const VEF_DATACANCELAMENTO_Name = 'VEF_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('VEF_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('VEF_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_OBSERVACAOCANCELAMENTO: String read FVEF_OBSERVACAOCANCELAMENTO write FVEF_OBSERVACAOCANCELAMENTO;
    const VEF_OBSERVACAOCANCELAMENTO_Name = 'VEF_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_AMBIENTE', ftString, 100)]
    [Dictionary('VEF_AMBIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_AMBIENTE: String read FVEF_AMBIENTE write FVEF_AMBIENTE;
    const VEF_AMBIENTE_Name = 'VEF_AMBIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRAZOENTREGA', ftString, 100)]
    [Dictionary('VEF_PRAZOENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_PRAZOENTREGA: String read FVEF_PRAZOENTREGA write FVEF_PRAZOENTREGA;
    const VEF_PRAZOENTREGA_Name = 'VEF_PRAZOENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_VALIDADE', ftInteger)]
    [Dictionary('VEF_VALIDADE', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_VALIDADE: Integer read FVEF_VALIDADE write FVEF_VALIDADE;
    const VEF_VALIDADE_Name = 'VEF_VALIDADE';

    [Restrictions([NoValidate])]
    [Column('VEF_RESPONSAVELRECEBIMENTO', ftString, 100)]
    [Dictionary('VEF_RESPONSAVELRECEBIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_RESPONSAVELRECEBIMENTO: String read FVEF_RESPONSAVELRECEBIMENTO write FVEF_RESPONSAVELRECEBIMENTO;
    const VEF_RESPONSAVELRECEBIMENTO_Name = 'VEF_RESPONSAVELRECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('VEF_OBSERVACAO', ftString, 5000)]
    [Dictionary('VEF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_OBSERVACAO: String read FVEF_OBSERVACAO write FVEF_OBSERVACAO;
    const VEF_OBSERVACAO_Name = 'VEF_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('VEF_CANCELADA', ftString, 1)]
    [Dictionary('VEF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_CANCELADA: String read FVEF_CANCELADA write FVEF_CANCELADA;
    const VEF_CANCELADA_Name = 'VEF_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('VEF_PROCESSADO', ftString, 1)]
    [Dictionary('VEF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_PROCESSADO: String read FVEF_PROCESSADO write FVEF_PROCESSADO;
    const VEF_PROCESSADO_Name = 'VEF_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('VEF_FINANCEIRO', ftString, 1)]
    [Dictionary('VEF_FINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_FINANCEIRO: String read FVEF_FINANCEIRO write FVEF_FINANCEIRO;
    const VEF_FINANCEIRO_Name = 'VEF_FINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('VEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATAALTERACAO: TDateTime read FVEF_DATAALTERACAO write FVEF_DATAALTERACAO;
    const VEF_DATAALTERACAO_Name = 'VEF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LIB_ID', ftInteger)]
    [Dictionary('LIB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID: Integer read FLIB_ID write FLIB_ID;
    const LIB_ID_Name = 'LIB_ID';

    [Restrictions([NoValidate])]
    [Column('VEF_ID_OLD', ftInteger)]
    [Dictionary('VEF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID_OLD: Integer read FVEF_ID_OLD write FVEF_ID_OLD;
    const VEF_ID_OLD_Name = 'VEF_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LIB_ID_OLD', ftInteger)]
    [Dictionary('LIB_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID_OLD: Integer read FLIB_ID_OLD write FLIB_ID_OLD;
    const LIB_ID_OLD_Name = 'LIB_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVEF_00)

end.
