unit express.dbo.ORS_00;

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
  [Table('ORS_00', '')]
  [PrimaryKey('ORS_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_ID')]
  TDtoORS_00 = class
  private
    { Private declarations } 
    FORS_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_NUMEROOS: Integer;
    FORS_SEQUENCIAL: Integer;
    FORS_DATAEMISSAO: TDateTime;
    FVEI_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FORS_NUMERODOCTO: String;
    FORS_NOTAFISCAL: String;
    FORS_NOTAFISCALSERVICO: String;
    FORS_TIPODOCUMENTO: String;
    FORS_TOTALQTDPEDIDA: Double;
    FORS_TOTALQTDHORAS: Integer;
    FORS_TOTALLIQUIDO: Double;
    FORS_TOTALSERVICOS: Double;
    FORS_TOTALPRODUTOS: Double;
    FORS_TOTALPRODUTOSLIQUIDO: Double;
    FORS_TOTALDESCTOITEM: Double;
    FORS_TOTALDESCTOAVULSO: Double;
    FORS_TOTALACRESCIMOITEM: Double;
    FORS_TOTALDESCTOSERVICOS: Double;
    FORS_TOTALBASECALCULOISS: Double;
    FORS_TOTALBASEDESCONTOCOMISSAO: Double;
    FORS_TOTALACRESCIMOAVULSO: Double;
    FORS_PERCENTUALDESCTOAVULSO: Double;
    FORS_PERCENTUALACRESCIMOAVULSO: Double;
    FORS_PERCENTUALCOMISSAO: Double;
    FORS_TOTALCOMISSAO: Double;
    FLIB_NUMEROLIBERACAO: String;
    FORS_TOTALKMVEICULO: Integer;
    FORS_DIASRETORNO: Integer;
    FORS_COMISSAONEGOCIADA: String;
    FORS_TOTALISS: Double;
    FORS_IDFATURAMENTOPRODUTOS: Integer;
    FORS_IDFATURAMENTOSERVICOS: Integer;
    FORS_SOLICITACOES: String;
    FORS_OBSERVACAO: String;
    FORS_OBSERVACAOENTRADA: String;
    FORS_OBSERVACAOVEICULO: String;
    FORS_ENTREGUEPOR: String;
    FORS_RETIRADOPOR: String;
    FORS_BLOQUEADO: String;
    FORS_INTEGRACAO: String;
    FORS_IMPRESSO: String;
    FORS_MESCLADO: String;
    FORS_LOG: Integer;
    FORS_HORAEMISSAO: String;
    FORS_FECHADO: String;
    FORS_DATAFECHAMENTO: TDateTime;
    FORS_HORAFECHAMENTO: String;
    FORS_DIASVALIDADEORCAMENTO: Integer;
    FORS_STATUSFECHAMENTO: String;
    FORS_OBSERVACAOFECHAMENTO: String;
    FORS_DATAPREVISAOTERMINO: TDateTime;
    FORS_HORAPREVISAOTERMINO: String;
    FORS_CANCELADA: String;
    FORS_DATACANCELAMENTO: TDateTime;
    FORS_OBSERVACAOCANCELAMENTO: String;
    FORS_DATAALTERACAO: TDateTime;
    FMDV_ID: Integer;
    FLIB_ID: Integer;
    FORS_NUMEROOC: Integer;
    FCON_CODIGO: Integer;
    FBOX_CODIGO: String;
    FORS_ID_OLD: Integer;
    FORS_INTEGRACAO_OLD: String;
    FLIB_ID_OLD: Integer;
    FORS_NOMECLIENTE: String;
    FORS_TIPOFRETE: String;
  public 
    { Public declarations } 
     const Table      = 'ORS_00';
     const PrimaryKey = 'ORS_ID';
     const Sequence   = 'SEQ_ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID', ftInteger)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOS', ftInteger)]
    [Dictionary('ORS_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOS: Integer read FORS_NUMEROOS write FORS_NUMEROOS;
    const ORS_NUMEROOS_Name = 'ORS_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('ORS_SEQUENCIAL', ftInteger)]
    [Dictionary('ORS_SEQUENCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_SEQUENCIAL: Integer read FORS_SEQUENCIAL write FORS_SEQUENCIAL;
    const ORS_SEQUENCIAL_Name = 'ORS_SEQUENCIAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_DATAEMISSAO', ftDateTime)]
    [Dictionary('ORS_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ORS_DATAEMISSAO: TDateTime read FORS_DATAEMISSAO write FORS_DATAEMISSAO;
    const ORS_DATAEMISSAO_Name = 'ORS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_NUMERODOCTO', ftString, 10)]
    [Dictionary('ORS_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NUMERODOCTO: String read FORS_NUMERODOCTO write FORS_NUMERODOCTO;
    const ORS_NUMERODOCTO_Name = 'ORS_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('ORS_NOTAFISCAL', ftString, 9)]
    [Dictionary('ORS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCAL: String read FORS_NOTAFISCAL write FORS_NOTAFISCAL;
    const ORS_NOTAFISCAL_Name = 'ORS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('ORS_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('ORS_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCALSERVICO: String read FORS_NOTAFISCALSERVICO write FORS_NOTAFISCALSERVICO;
    const ORS_NOTAFISCALSERVICO_Name = 'ORS_NOTAFISCALSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('ORS_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPODOCUMENTO: String read FORS_TIPODOCUMENTO write FORS_TIPODOCUMENTO;
    const ORS_TIPODOCUMENTO_Name = 'ORS_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALQTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('ORS_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALQTDPEDIDA: Double read FORS_TOTALQTDPEDIDA write FORS_TOTALQTDPEDIDA;
    const ORS_TOTALQTDPEDIDA_Name = 'ORS_TOTALQTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALQTDHORAS', ftInteger)]
    [Dictionary('ORS_TOTALQTDHORAS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_TOTALQTDHORAS: Integer read FORS_TOTALQTDHORAS write FORS_TOTALQTDHORAS;
    const ORS_TOTALQTDHORAS_Name = 'ORS_TOTALQTDHORAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALLIQUIDO', ftBCD, 2097184, 2)]
    [Dictionary('ORS_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALLIQUIDO: Double read FORS_TOTALLIQUIDO write FORS_TOTALLIQUIDO;
    const ORS_TOTALLIQUIDO_Name = 'ORS_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALSERVICOS', ftBCD, 5177428, 2)]
    [Dictionary('ORS_TOTALSERVICOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALSERVICOS: Double read FORS_TOTALSERVICOS write FORS_TOTALSERVICOS;
    const ORS_TOTALSERVICOS_Name = 'ORS_TOTALSERVICOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALPRODUTOS', ftBCD, 2097196, 2)]
    [Dictionary('ORS_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRODUTOS: Double read FORS_TOTALPRODUTOS write FORS_TOTALPRODUTOS;
    const ORS_TOTALPRODUTOS_Name = 'ORS_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRODUTOSLIQUIDO', ftBCD, 2097273, 2)]
    [Dictionary('ORS_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRODUTOSLIQUIDO: Double read FORS_TOTALPRODUTOSLIQUIDO write FORS_TOTALPRODUTOSLIQUIDO;
    const ORS_TOTALPRODUTOSLIQUIDO_Name = 'ORS_TOTALPRODUTOSLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALDESCTOITEM', ftBCD, 7077999, 2)]
    [Dictionary('ORS_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOITEM: Double read FORS_TOTALDESCTOITEM write FORS_TOTALDESCTOITEM;
    const ORS_TOTALDESCTOITEM_Name = 'ORS_TOTALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALDESCTOAVULSO', ftBCD, 7274610, 2)]
    [Dictionary('ORS_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOAVULSO: Double read FORS_TOTALDESCTOAVULSO write FORS_TOTALDESCTOAVULSO;
    const ORS_TOTALDESCTOAVULSO_Name = 'ORS_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALACRESCIMOITEM', ftBCD, 4784197, 2)]
    [Dictionary('ORS_TOTALACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALACRESCIMOITEM: Double read FORS_TOTALACRESCIMOITEM write FORS_TOTALACRESCIMOITEM;
    const ORS_TOTALACRESCIMOITEM_Name = 'ORS_TOTALACRESCIMOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALDESCTOSERVICOS', ftBCD)]
    [Dictionary('ORS_TOTALDESCTOSERVICOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOSERVICOS: Double read FORS_TOTALDESCTOSERVICOS write FORS_TOTALDESCTOSERVICOS;
    const ORS_TOTALDESCTOSERVICOS_Name = 'ORS_TOTALDESCTOSERVICOS';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALBASECALCULOISS', ftBCD, 1818439271, 2)]
    [Dictionary('ORS_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALBASECALCULOISS: Double read FORS_TOTALBASECALCULOISS write FORS_TOTALBASECALCULOISS;
    const ORS_TOTALBASECALCULOISS_Name = 'ORS_TOTALBASECALCULOISS';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALBASEDESCONTOCOMISSAO', ftBCD, 1936617321, 2)]
    [Dictionary('ORS_TOTALBASEDESCONTOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALBASEDESCONTOCOMISSAO: Double read FORS_TOTALBASEDESCONTOCOMISSAO write FORS_TOTALBASEDESCONTOCOMISSAO;
    const ORS_TOTALBASEDESCONTOCOMISSAO_Name = 'ORS_TOTALBASEDESCONTOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALACRESCIMOAVULSO', ftBCD, 538970637, 2)]
    [Dictionary('ORS_TOTALACRESCIMOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALACRESCIMOAVULSO: Double read FORS_TOTALACRESCIMOAVULSO write FORS_TOTALACRESCIMOAVULSO;
    const ORS_TOTALACRESCIMOAVULSO_Name = 'ORS_TOTALACRESCIMOAVULSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_PERCENTUALDESCTOAVULSO', ftBCD, 1179206738, 6)]
    [Dictionary('ORS_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALDESCTOAVULSO: Double read FORS_PERCENTUALDESCTOAVULSO write FORS_PERCENTUALDESCTOAVULSO;
    const ORS_PERCENTUALDESCTOAVULSO_Name = 'ORS_PERCENTUALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALACRESCIMOAVULSO', ftBCD, 221996910, 2)]
    [Dictionary('ORS_PERCENTUALACRESCIMOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALACRESCIMOAVULSO: Double read FORS_PERCENTUALACRESCIMOAVULSO write FORS_PERCENTUALACRESCIMOAVULSO;
    const ORS_PERCENTUALACRESCIMOAVULSO_Name = 'ORS_PERCENTUALACRESCIMOAVULSO';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALCOMISSAO', ftBCD, 1818453348, 2)]
    [Dictionary('ORS_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALCOMISSAO: Double read FORS_PERCENTUALCOMISSAO write FORS_PERCENTUALCOMISSAO;
    const ORS_PERCENTUALCOMISSAO_Name = 'ORS_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALCOMISSAO', ftBCD, 1953391939, 2)]
    [Dictionary('ORS_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALCOMISSAO: Double read FORS_TOTALCOMISSAO write FORS_TOTALCOMISSAO;
    const ORS_TOTALCOMISSAO_Name = 'ORS_TOTALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALKMVEICULO', ftInteger)]
    [Dictionary('ORS_TOTALKMVEICULO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_TOTALKMVEICULO: Integer read FORS_TOTALKMVEICULO write FORS_TOTALKMVEICULO;
    const ORS_TOTALKMVEICULO_Name = 'ORS_TOTALKMVEICULO';

    [Restrictions([NoValidate])]
    [Column('ORS_DIASRETORNO', ftInteger)]
    [Dictionary('ORS_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_DIASRETORNO: Integer read FORS_DIASRETORNO write FORS_DIASRETORNO;
    const ORS_DIASRETORNO_Name = 'ORS_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('ORS_COMISSAONEGOCIADA', ftString, 1)]
    [Dictionary('ORS_COMISSAONEGOCIADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_COMISSAONEGOCIADA: String read FORS_COMISSAONEGOCIADA write FORS_COMISSAONEGOCIADA;
    const ORS_COMISSAONEGOCIADA_Name = 'ORS_COMISSAONEGOCIADA';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALISS', ftBCD, 1981834596, 2)]
    [Dictionary('ORS_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALISS: Double read FORS_TOTALISS write FORS_TOTALISS;
    const ORS_TOTALISS_Name = 'ORS_TOTALISS';

    [Restrictions([NoValidate])]
    [Column('ORS_IDFATURAMENTOPRODUTOS', ftInteger)]
    [Dictionary('ORS_IDFATURAMENTOPRODUTOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_IDFATURAMENTOPRODUTOS: Integer read FORS_IDFATURAMENTOPRODUTOS write FORS_IDFATURAMENTOPRODUTOS;
    const ORS_IDFATURAMENTOPRODUTOS_Name = 'ORS_IDFATURAMENTOPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('ORS_IDFATURAMENTOSERVICOS', ftInteger)]
    [Dictionary('ORS_IDFATURAMENTOSERVICOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_IDFATURAMENTOSERVICOS: Integer read FORS_IDFATURAMENTOSERVICOS write FORS_IDFATURAMENTOSERVICOS;
    const ORS_IDFATURAMENTOSERVICOS_Name = 'ORS_IDFATURAMENTOSERVICOS';

    [Restrictions([NoValidate])]
    [Column('ORS_SOLICITACOES', ftString, 5000)]
    [Dictionary('ORS_SOLICITACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_SOLICITACOES: String read FORS_SOLICITACOES write FORS_SOLICITACOES;
    const ORS_SOLICITACOES_Name = 'ORS_SOLICITACOES';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAO', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAO: String read FORS_OBSERVACAO write FORS_OBSERVACAO;
    const ORS_OBSERVACAO_Name = 'ORS_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAOENTRADA', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAOENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAOENTRADA: String read FORS_OBSERVACAOENTRADA write FORS_OBSERVACAOENTRADA;
    const ORS_OBSERVACAOENTRADA_Name = 'ORS_OBSERVACAOENTRADA';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAOVEICULO', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAOVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAOVEICULO: String read FORS_OBSERVACAOVEICULO write FORS_OBSERVACAOVEICULO;
    const ORS_OBSERVACAOVEICULO_Name = 'ORS_OBSERVACAOVEICULO';

    [Restrictions([NoValidate])]
    [Column('ORS_ENTREGUEPOR', ftString, 100)]
    [Dictionary('ORS_ENTREGUEPOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_ENTREGUEPOR: String read FORS_ENTREGUEPOR write FORS_ENTREGUEPOR;
    const ORS_ENTREGUEPOR_Name = 'ORS_ENTREGUEPOR';

    [Restrictions([NoValidate])]
    [Column('ORS_RETIRADOPOR', ftString, 100)]
    [Dictionary('ORS_RETIRADOPOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_RETIRADOPOR: String read FORS_RETIRADOPOR write FORS_RETIRADOPOR;
    const ORS_RETIRADOPOR_Name = 'ORS_RETIRADOPOR';

    [Restrictions([NoValidate])]
    [Column('ORS_BLOQUEADO', ftString, 1)]
    [Dictionary('ORS_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_BLOQUEADO: String read FORS_BLOQUEADO write FORS_BLOQUEADO;
    const ORS_BLOQUEADO_Name = 'ORS_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('ORS_INTEGRACAO', ftString, 20)]
    [Dictionary('ORS_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_INTEGRACAO: String read FORS_INTEGRACAO write FORS_INTEGRACAO;
    const ORS_INTEGRACAO_Name = 'ORS_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_IMPRESSO', ftString, 1)]
    [Dictionary('ORS_IMPRESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_IMPRESSO: String read FORS_IMPRESSO write FORS_IMPRESSO;
    const ORS_IMPRESSO_Name = 'ORS_IMPRESSO';

    [Restrictions([NoValidate])]
    [Column('ORS_MESCLADO', ftString, 1)]
    [Dictionary('ORS_MESCLADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_MESCLADO: String read FORS_MESCLADO write FORS_MESCLADO;
    const ORS_MESCLADO_Name = 'ORS_MESCLADO';

    [Restrictions([NoValidate])]
    [Column('ORS_LOG', ftInteger)]
    [Dictionary('ORS_LOG', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_LOG: Integer read FORS_LOG write FORS_LOG;
    const ORS_LOG_Name = 'ORS_LOG';

    [Restrictions([NoValidate])]
    [Column('ORS_HORAEMISSAO', ftString, 10)]
    [Dictionary('ORS_HORAEMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_HORAEMISSAO: String read FORS_HORAEMISSAO write FORS_HORAEMISSAO;
    const ORS_HORAEMISSAO_Name = 'ORS_HORAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('ORS_FECHADO', ftString, 1)]
    [Dictionary('ORS_FECHADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_FECHADO: String read FORS_FECHADO write FORS_FECHADO;
    const ORS_FECHADO_Name = 'ORS_FECHADO';

    [Restrictions([NoValidate])]
    [Column('ORS_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('ORS_DATAFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAFECHAMENTO: TDateTime read FORS_DATAFECHAMENTO write FORS_DATAFECHAMENTO;
    const ORS_DATAFECHAMENTO_Name = 'ORS_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_HORAFECHAMENTO', ftString, 10)]
    [Dictionary('ORS_HORAFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_HORAFECHAMENTO: String read FORS_HORAFECHAMENTO write FORS_HORAFECHAMENTO;
    const ORS_HORAFECHAMENTO_Name = 'ORS_HORAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_DIASVALIDADEORCAMENTO', ftInteger)]
    [Dictionary('ORS_DIASVALIDADEORCAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_DIASVALIDADEORCAMENTO: Integer read FORS_DIASVALIDADEORCAMENTO write FORS_DIASVALIDADEORCAMENTO;
    const ORS_DIASVALIDADEORCAMENTO_Name = 'ORS_DIASVALIDADEORCAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_STATUSFECHAMENTO', ftString, 1)]
    [Dictionary('ORS_STATUSFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_STATUSFECHAMENTO: String read FORS_STATUSFECHAMENTO write FORS_STATUSFECHAMENTO;
    const ORS_STATUSFECHAMENTO_Name = 'ORS_STATUSFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAOFECHAMENTO', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAOFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAOFECHAMENTO: String read FORS_OBSERVACAOFECHAMENTO write FORS_OBSERVACAOFECHAMENTO;
    const ORS_OBSERVACAOFECHAMENTO_Name = 'ORS_OBSERVACAOFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_DATAPREVISAOTERMINO', ftDateTime)]
    [Dictionary('ORS_DATAPREVISAOTERMINO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAPREVISAOTERMINO: TDateTime read FORS_DATAPREVISAOTERMINO write FORS_DATAPREVISAOTERMINO;
    const ORS_DATAPREVISAOTERMINO_Name = 'ORS_DATAPREVISAOTERMINO';

    [Restrictions([NoValidate])]
    [Column('ORS_HORAPREVISAOTERMINO', ftString, 4)]
    [Dictionary('ORS_HORAPREVISAOTERMINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_HORAPREVISAOTERMINO: String read FORS_HORAPREVISAOTERMINO write FORS_HORAPREVISAOTERMINO;
    const ORS_HORAPREVISAOTERMINO_Name = 'ORS_HORAPREVISAOTERMINO';

    [Restrictions([NoValidate])]
    [Column('ORS_CANCELADA', ftString, 1)]
    [Dictionary('ORS_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_CANCELADA: String read FORS_CANCELADA write FORS_CANCELADA;
    const ORS_CANCELADA_Name = 'ORS_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('ORS_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('ORS_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATACANCELAMENTO: TDateTime read FORS_DATACANCELAMENTO write FORS_DATACANCELAMENTO;
    const ORS_DATACANCELAMENTO_Name = 'ORS_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('ORS_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAOCANCELAMENTO: String read FORS_OBSERVACAOCANCELAMENTO write FORS_OBSERVACAOCANCELAMENTO;
    const ORS_OBSERVACAOCANCELAMENTO_Name = 'ORS_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MDV_ID', ftInteger)]
    [Dictionary('MDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDV_ID: Integer read FMDV_ID write FMDV_ID;
    const MDV_ID_Name = 'MDV_ID';

    [Restrictions([NoValidate])]
    [Column('LIB_ID', ftInteger)]
    [Dictionary('LIB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID: Integer read FLIB_ID write FLIB_ID;
    const LIB_ID_Name = 'LIB_ID';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOC', ftInteger)]
    [Dictionary('ORS_NUMEROOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOC: Integer read FORS_NUMEROOC write FORS_NUMEROOC;
    const ORS_NUMEROOC_Name = 'ORS_NUMEROOC';

    [Restrictions([NoValidate])]
    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CON_CODIGO: Integer read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BOX_CODIGO', ftString, 3)]
    [Dictionary('BOX_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BOX_CODIGO: String read FBOX_CODIGO write FBOX_CODIGO;
    const BOX_CODIGO_Name = 'BOX_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('ORS_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_INTEGRACAO_OLD: String read FORS_INTEGRACAO_OLD write FORS_INTEGRACAO_OLD;
    const ORS_INTEGRACAO_OLD_Name = 'ORS_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('LIB_ID_OLD', ftInteger)]
    [Dictionary('LIB_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID_OLD: Integer read FLIB_ID_OLD write FLIB_ID_OLD;
    const LIB_ID_OLD_Name = 'LIB_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_NOMECLIENTE', ftString, 100)]
    [Dictionary('ORS_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOMECLIENTE: String read FORS_NOMECLIENTE write FORS_NOMECLIENTE;
    const ORS_NOMECLIENTE_Name = 'ORS_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPOFRETE', ftString, 1)]
    [Dictionary('ORS_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPOFRETE: String read FORS_TIPOFRETE write FORS_TIPOFRETE;
    const ORS_TIPOFRETE_Name = 'ORS_TIPOFRETE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_00)

end.
