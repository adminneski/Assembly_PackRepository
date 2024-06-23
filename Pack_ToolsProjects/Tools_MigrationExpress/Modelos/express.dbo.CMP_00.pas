unit express.dbo.CMP_00;

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
  [Table('CMP_00', '')]
  [PrimaryKey('CMP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CMP_ID')]
  TDtoCMP_00 = class
  private
    { Private declarations } 
    FCMP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCMP_PEDIDOCOMPRA: Integer;
    FCMP_DATAENTREGA: TDateTime;
    FCMP_DATALANCAMENTO: TDateTime;
    FCMP_TOTALIPI: Double;
    FCMP_TOTALPIS: Double;
    FCMP_TOTALICMS: Double;
    FCMP_TOTALICMSR: Double;
    FCMP_TOTALFRETE: Double;
    FCMP_TOTALCOFINS: Double;
    FCMP_TOTALDESCTO: Double;
    FCMP_TOTALSEGURO: Double;
    FCMP_TOTALSERVICO: Double;
    FCMP_TOTALADICIONAL: Double;
    FCMP_TOTALPRODUTOS: Double;
    FCMP_TOTALPEDIDOCOMPRA: Double;
    FCMP_TOTALDESPACESSORIA: Double;
    FCMP_TOTALSUBSTRIBUTARIA: Double;
    FCMP_TOTALBASECALCULOICMS: Double;
    FCMP_TOTALCOMPLEMENTONFICMS: Double;
    FCMP_BAIXADO: String;
    FCMP_DATABAIXA: TDateTime;
    FCMP_OBSERVACAO: String;
    FCMP_DESATIVADO: String;
    FCMP_DATAALTERACAO: TDateTime;
    FCMP_FECHADO: String;
    FCMP_DATAFECHAMENTO: TDateTime;
    FCMP_OBSERVACAOFECHAMENTO: String;
    FCMP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CMP_00';
     const PrimaryKey = 'CMP_ID';
     const Sequence   = 'SEQ_CMP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_ID', ftInteger)]
    [Dictionary('CMP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_ID: Integer read FCMP_ID write FCMP_ID;
    const CMP_ID_Name = 'CMP_ID';

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

    [Restrictions([NoValidate])]
    [Column('CMP_PEDIDOCOMPRA', ftInteger)]
    [Dictionary('CMP_PEDIDOCOMPRA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_PEDIDOCOMPRA: Integer read FCMP_PEDIDOCOMPRA write FCMP_PEDIDOCOMPRA;
    const CMP_PEDIDOCOMPRA_Name = 'CMP_PEDIDOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('CMP_DATAENTREGA', ftDateTime)]
    [Dictionary('CMP_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property CMP_DATAENTREGA: TDateTime read FCMP_DATAENTREGA write FCMP_DATAENTREGA;
    const CMP_DATAENTREGA_Name = 'CMP_DATAENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CMP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMP_DATALANCAMENTO: TDateTime read FCMP_DATALANCAMENTO write FCMP_DATALANCAMENTO;
    const CMP_DATALANCAMENTO_Name = 'CMP_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALIPI', ftBCD)]
    [Dictionary('CMP_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALIPI: Double read FCMP_TOTALIPI write FCMP_TOTALIPI;
    const CMP_TOTALIPI_Name = 'CMP_TOTALIPI';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALPIS', ftBCD)]
    [Dictionary('CMP_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALPIS: Double read FCMP_TOTALPIS write FCMP_TOTALPIS;
    const CMP_TOTALPIS_Name = 'CMP_TOTALPIS';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALICMS', ftBCD)]
    [Dictionary('CMP_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALICMS: Double read FCMP_TOTALICMS write FCMP_TOTALICMS;
    const CMP_TOTALICMS_Name = 'CMP_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALICMSR', ftBCD)]
    [Dictionary('CMP_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALICMSR: Double read FCMP_TOTALICMSR write FCMP_TOTALICMSR;
    const CMP_TOTALICMSR_Name = 'CMP_TOTALICMSR';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALFRETE', ftBCD)]
    [Dictionary('CMP_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALFRETE: Double read FCMP_TOTALFRETE write FCMP_TOTALFRETE;
    const CMP_TOTALFRETE_Name = 'CMP_TOTALFRETE';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALCOFINS', ftBCD)]
    [Dictionary('CMP_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALCOFINS: Double read FCMP_TOTALCOFINS write FCMP_TOTALCOFINS;
    const CMP_TOTALCOFINS_Name = 'CMP_TOTALCOFINS';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALDESCTO', ftBCD)]
    [Dictionary('CMP_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALDESCTO: Double read FCMP_TOTALDESCTO write FCMP_TOTALDESCTO;
    const CMP_TOTALDESCTO_Name = 'CMP_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALSEGURO', ftBCD)]
    [Dictionary('CMP_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALSEGURO: Double read FCMP_TOTALSEGURO write FCMP_TOTALSEGURO;
    const CMP_TOTALSEGURO_Name = 'CMP_TOTALSEGURO';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALSERVICO', ftBCD, 10, 2)]
    [Dictionary('CMP_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALSERVICO: Double read FCMP_TOTALSERVICO write FCMP_TOTALSERVICO;
    const CMP_TOTALSERVICO_Name = 'CMP_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALADICIONAL', ftBCD)]
    [Dictionary('CMP_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALADICIONAL: Double read FCMP_TOTALADICIONAL write FCMP_TOTALADICIONAL;
    const CMP_TOTALADICIONAL_Name = 'CMP_TOTALADICIONAL';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALPRODUTOS', ftBCD)]
    [Dictionary('CMP_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALPRODUTOS: Double read FCMP_TOTALPRODUTOS write FCMP_TOTALPRODUTOS;
    const CMP_TOTALPRODUTOS_Name = 'CMP_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALPEDIDOCOMPRA', ftBCD)]
    [Dictionary('CMP_TOTALPEDIDOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALPEDIDOCOMPRA: Double read FCMP_TOTALPEDIDOCOMPRA write FCMP_TOTALPEDIDOCOMPRA;
    const CMP_TOTALPEDIDOCOMPRA_Name = 'CMP_TOTALPEDIDOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('CMP_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALDESPACESSORIA: Double read FCMP_TOTALDESPACESSORIA write FCMP_TOTALDESPACESSORIA;
    const CMP_TOTALDESPACESSORIA_Name = 'CMP_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('CMP_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALSUBSTRIBUTARIA: Double read FCMP_TOTALSUBSTRIBUTARIA write FCMP_TOTALSUBSTRIBUTARIA;
    const CMP_TOTALSUBSTRIBUTARIA_Name = 'CMP_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('CMP_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALBASECALCULOICMS: Double read FCMP_TOTALBASECALCULOICMS write FCMP_TOTALBASECALCULOICMS;
    const CMP_TOTALBASECALCULOICMS_Name = 'CMP_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('CMP_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('CMP_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_TOTALCOMPLEMENTONFICMS: Double read FCMP_TOTALCOMPLEMENTONFICMS write FCMP_TOTALCOMPLEMENTONFICMS;
    const CMP_TOTALCOMPLEMENTONFICMS_Name = 'CMP_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_BAIXADO', ftString, 1)]
    [Dictionary('CMP_BAIXADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_BAIXADO: String read FCMP_BAIXADO write FCMP_BAIXADO;
    const CMP_BAIXADO_Name = 'CMP_BAIXADO';

    [Restrictions([NoValidate])]
    [Column('CMP_DATABAIXA', ftDateTime)]
    [Dictionary('CMP_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CMP_DATABAIXA: TDateTime read FCMP_DATABAIXA write FCMP_DATABAIXA;
    const CMP_DATABAIXA_Name = 'CMP_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CMP_OBSERVACAO', ftString, 300)]
    [Dictionary('CMP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_OBSERVACAO: String read FCMP_OBSERVACAO write FCMP_OBSERVACAO;
    const CMP_OBSERVACAO_Name = 'CMP_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_DESATIVADO', ftString, 1)]
    [Dictionary('CMP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_DESATIVADO: String read FCMP_DESATIVADO write FCMP_DESATIVADO;
    const CMP_DESATIVADO_Name = 'CMP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CMP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CMP_DATAALTERACAO: TDateTime read FCMP_DATAALTERACAO write FCMP_DATAALTERACAO;
    const CMP_DATAALTERACAO_Name = 'CMP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CMP_FECHADO', ftString, 1)]
    [Dictionary('CMP_FECHADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_FECHADO: String read FCMP_FECHADO write FCMP_FECHADO;
    const CMP_FECHADO_Name = 'CMP_FECHADO';

    [Restrictions([NoValidate])]
    [Column('CMP_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('CMP_DATAFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CMP_DATAFECHAMENTO: TDateTime read FCMP_DATAFECHAMENTO write FCMP_DATAFECHAMENTO;
    const CMP_DATAFECHAMENTO_Name = 'CMP_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('CMP_OBSERVACAOFECHAMENTO', ftString, 300)]
    [Dictionary('CMP_OBSERVACAOFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CMP_OBSERVACAOFECHAMENTO: String read FCMP_OBSERVACAOFECHAMENTO write FCMP_OBSERVACAOFECHAMENTO;
    const CMP_OBSERVACAOFECHAMENTO_Name = 'CMP_OBSERVACAOFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('CMP_ID_OLD', ftInteger)]
    [Dictionary('CMP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_ID_OLD: Integer read FCMP_ID_OLD write FCMP_ID_OLD;
    const CMP_ID_OLD_Name = 'CMP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCMP_00)

end.
