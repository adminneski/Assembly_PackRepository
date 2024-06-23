unit express.dbo.PDA_00;

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
  [Table('PDA_00', '')]
  [PrimaryKey('PDA_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDA_ID')]
  TDtoPDA_00 = class
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FCOM_CODIGO: Integer;
    FCGA_ID: Integer;
    FFPG_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FPDA_SERIE: String;
    FMNF_CODIGO: String;
    FPDA_NOTAFISCAL: String;
    FLIB_NUMEROLIBERACAO: String;
    FPDA_NUMERODOCTO: String;
    FPDA_DATAENTREGA: TDateTime;
    FPDA_DATALANCAMENTO: TDateTime;
    FPDA_DATACANCELAMENTO: TDateTime;
    FPDA_COMISSAONEGOCIADA: String;
    FPDA_NUMEROORDEMCOMPRA: String;
    FPDA_NUMERODOCTOREPRESENTANTE: String;
    FPDA_CODIGOLIBERACAOVENDA: String;
    FPDA_TOTALQTDPEDIDA: Double;
    FPDA_TOTALPESOLIQUIDO: Double;
    FPDA_TOTALPRODUTOS: Double;
    FPDA_TOTALPRODUTOSLIQUIDO: Double;
    FPDA_TOTALLIQUIDO: Double;
    FPDA_TOTALPESOBRUTO: Double;
    FPDA_TIPOFRETE: String;
    FPDA_TOTALIPI: Double;
    FPDA_TOTALPIS: Double;
    FPDA_TOTALICMS: Double;
    FPDA_TOTALFRETE: Double;
    FPDA_TOTALICMSR: Double;
    FPDA_TOTALCOFINS: Double;
    FPDA_TOTALSEGURO: Double;
    FPDA_TOTALADICIONAL: Double;
    FPDA_TOTALSUBSTRIBUTARIA: Double;
    FPDA_TOTALDESPACESSORIA: Double;
    FPDA_TOTALBASEISENTOICMS: Double;
    FPDA_TOTALBASECALCULOMVA: Double;
    FPDA_TOTALBASECALCULOICMS: Double;
    FPDA_TOTALBCALCULOPISCOFINS: Double;
    FPDA_TOTALFINANCEIROPRAZO: Double;
    FPDA_TOTALCOMPLEMENTONFICMS: Double;
    FPDA_TOTALDESCTOITEM: Double;
    FPDA_TOTALDESCTOPRAZO: Double;
    FPDA_TOTALDESCTOAVULSO: Double;
    FPDA_TOTALCOMISSAO: Double;
    FPDA_PERCENTUALCOMISSAO: Double;
    FPDA_PERCENTUALDESCTOAVULSO: Double;
    FPDA_PERCENTUALDESCONTOPRAZO: Double;
    FPDA_PERCENTUALFINANCEIROPRAZO: Double;
    FPDA_MARCAVOLUMES: String;
    FPDA_ESPECIEVOLUMES: String;
    FPDA_NUMERACAOVOLUMES: String;
    FPDA_TOTALNUMEROVOLUMES: Double;
    FPES_CODIGOENTREGA: Integer;
    FPES_CODIGORETIRADA: Integer;
    FPDA_DATADIGITACAOPALM: TDateTime;
    FPDA_HORADIGITACAOPALM: String;
    FPDA_TOTALAPROXIMADOIMPOSTO: Double;
    FPDA_TOTALIBPTMUNICIPAL: Double;
    FPDA_TOTALIBPTESTADUAL: Double;
    FPDA_TOTALIBPTNACIONAL: Double;
    FPDA_TOTALIBPTIMPORTADO: Double;
    FPDA_PERCENTUALIBPT: Double;
    FPDA_PERCENTUALIBPTMUNICIPAL: Double;
    FPDA_PERCENTUALIBPTESTADUAL: Double;
    FPDA_PERCENTUALIBPTNACIONAL: Double;
    FPDA_PERCENTUALIBPTIMPORTADO: Double;
    FPDA_TOTALBASECALCULOFCP: Double;
    FPDA_TOTALFCP: Double;
    FPDA_TOTALBASECALCULOFCPST: Double;
    FPDA_TOTALFCPST: Double;
    FPDA_TOTALBASECALCULOFCPRET: Double;
    FPDA_TOTALFCPRET: Double;
    FPDA_OBSERVACAO: String;
    FPDA_OBSERVACAOCANCELAMENTO: String;
    FPDA_CANCELADA: String;
    FPDA_BLOQUEADO: String;
    FPDA_DESATIVADO: String;
    FPDA_FATURADO: String;
    FPDA_INTEGRACAO: String;
    FUSERS_LOGIN: String;
    FPDA_DATAALTERACAO: TDateTime;
    FPDA_TIPODOCUMENTO: String;
    FLIB_ID: Integer;
    FCON_CODIGO: Integer;
    FPDA_ID_OLD: Integer;
    FPDA_INTEGRACAO_OLD: String;
    FCGA_ID_OLD: Integer;
    FLIB_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PDA_00';
     const PrimaryKey = 'PDA_ID';
     const Sequence   = 'SEQ_PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

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
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

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
    [Column('PDA_SERIE', ftString, 3)]
    [Dictionary('PDA_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_SERIE: String read FPDA_SERIE write FPDA_SERIE;
    const PDA_SERIE_Name = 'PDA_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PDA_NOTAFISCAL', ftString, 9)]
    [Dictionary('PDA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NOTAFISCAL: String read FPDA_NOTAFISCAL write FPDA_NOTAFISCAL;
    const PDA_NOTAFISCAL_Name = 'PDA_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_NUMERODOCTO', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTO: String read FPDA_NUMERODOCTO write FPDA_NUMERODOCTO;
    const PDA_NUMERODOCTO_Name = 'PDA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PDA_DATAENTREGA', ftDateTime)]
    [Dictionary('PDA_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATAENTREGA: TDateTime read FPDA_DATAENTREGA write FPDA_DATAENTREGA;
    const PDA_DATAENTREGA_Name = 'PDA_DATAENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATALANCAMENTO: TDateTime read FPDA_DATALANCAMENTO write FPDA_DATALANCAMENTO;
    const PDA_DATALANCAMENTO_Name = 'PDA_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PDA_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('PDA_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATACANCELAMENTO: TDateTime read FPDA_DATACANCELAMENTO write FPDA_DATACANCELAMENTO;
    const PDA_DATACANCELAMENTO_Name = 'PDA_DATACANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_COMISSAONEGOCIADA', ftString, 1)]
    [Dictionary('PDA_COMISSAONEGOCIADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_COMISSAONEGOCIADA: String read FPDA_COMISSAONEGOCIADA write FPDA_COMISSAONEGOCIADA;
    const PDA_COMISSAONEGOCIADA_Name = 'PDA_COMISSAONEGOCIADA';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('PDA_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMEROORDEMCOMPRA: String read FPDA_NUMEROORDEMCOMPRA write FPDA_NUMEROORDEMCOMPRA;
    const PDA_NUMEROORDEMCOMPRA_Name = 'PDA_NUMEROORDEMCOMPRA';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTOREPRESENTANTE: String read FPDA_NUMERODOCTOREPRESENTANTE write FPDA_NUMERODOCTOREPRESENTANTE;
    const PDA_NUMERODOCTOREPRESENTANTE_Name = 'PDA_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate])]
    [Column('PDA_CODIGOLIBERACAOVENDA', ftString, 6)]
    [Dictionary('PDA_CODIGOLIBERACAOVENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CODIGOLIBERACAOVENDA: String read FPDA_CODIGOLIBERACAOVENDA write FPDA_CODIGOLIBERACAOVENDA;
    const PDA_CODIGOLIBERACAOVENDA_Name = 'PDA_CODIGOLIBERACAOVENDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALQTDPEDIDA', ftBCD, 16387, 3)]
    [Dictionary('PDA_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALQTDPEDIDA: Double read FPDA_TOTALQTDPEDIDA write FPDA_TOTALQTDPEDIDA;
    const PDA_TOTALQTDPEDIDA_Name = 'PDA_TOTALQTDPEDIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PDA_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPESOLIQUIDO: Double read FPDA_TOTALPESOLIQUIDO write FPDA_TOTALPESOLIQUIDO;
    const PDA_TOTALPESOLIQUIDO_Name = 'PDA_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALPRODUTOS', ftBCD, 300, 2)]
    [Dictionary('PDA_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRODUTOS: Double read FPDA_TOTALPRODUTOS write FPDA_TOTALPRODUTOS;
    const PDA_TOTALPRODUTOS_Name = 'PDA_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPRODUTOSLIQUIDO', ftBCD, 16387, 2)]
    [Dictionary('PDA_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRODUTOSLIQUIDO: Double read FPDA_TOTALPRODUTOSLIQUIDO write FPDA_TOTALPRODUTOSLIQUIDO;
    const PDA_TOTALPRODUTOSLIQUIDO_Name = 'PDA_TOTALPRODUTOSLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALLIQUIDO', ftBCD)]
    [Dictionary('PDA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALLIQUIDO: Double read FPDA_TOTALLIQUIDO write FPDA_TOTALLIQUIDO;
    const PDA_TOTALLIQUIDO_Name = 'PDA_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('PDA_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPESOBRUTO: Double read FPDA_TOTALPESOBRUTO write FPDA_TOTALPESOBRUTO;
    const PDA_TOTALPESOBRUTO_Name = 'PDA_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TIPOFRETE', ftString, 1)]
    [Dictionary('PDA_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPOFRETE: String read FPDA_TIPOFRETE write FPDA_TIPOFRETE;
    const PDA_TIPOFRETE_Name = 'PDA_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALIPI', ftBCD)]
    [Dictionary('PDA_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIPI: Double read FPDA_TOTALIPI write FPDA_TOTALIPI;
    const PDA_TOTALIPI_Name = 'PDA_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALPIS', ftBCD)]
    [Dictionary('PDA_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPIS: Double read FPDA_TOTALPIS write FPDA_TOTALPIS;
    const PDA_TOTALPIS_Name = 'PDA_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALICMS', ftBCD)]
    [Dictionary('PDA_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMS: Double read FPDA_TOTALICMS write FPDA_TOTALICMS;
    const PDA_TOTALICMS_Name = 'PDA_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALFRETE', ftBCD)]
    [Dictionary('PDA_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFRETE: Double read FPDA_TOTALFRETE write FPDA_TOTALFRETE;
    const PDA_TOTALFRETE_Name = 'PDA_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALICMSR', ftBCD)]
    [Dictionary('PDA_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALICMSR: Double read FPDA_TOTALICMSR write FPDA_TOTALICMSR;
    const PDA_TOTALICMSR_Name = 'PDA_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALCOFINS', ftBCD)]
    [Dictionary('PDA_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOFINS: Double read FPDA_TOTALCOFINS write FPDA_TOTALCOFINS;
    const PDA_TOTALCOFINS_Name = 'PDA_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALSEGURO', ftBCD)]
    [Dictionary('PDA_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSEGURO: Double read FPDA_TOTALSEGURO write FPDA_TOTALSEGURO;
    const PDA_TOTALSEGURO_Name = 'PDA_TOTALSEGURO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALADICIONAL', ftBCD, 740770885, 2)]
    [Dictionary('PDA_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALADICIONAL: Double read FPDA_TOTALADICIONAL write FPDA_TOTALADICIONAL;
    const PDA_TOTALADICIONAL_Name = 'PDA_TOTALADICIONAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('PDA_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALSUBSTRIBUTARIA: Double read FPDA_TOTALSUBSTRIBUTARIA write FPDA_TOTALSUBSTRIBUTARIA;
    const PDA_TOTALSUBSTRIBUTARIA_Name = 'PDA_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('PDA_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESPACESSORIA: Double read FPDA_TOTALDESPACESSORIA write FPDA_TOTALDESPACESSORIA;
    const PDA_TOTALDESPACESSORIA_Name = 'PDA_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASEISENTOICMS', ftBCD, 539780974, 2)]
    [Dictionary('PDA_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASEISENTOICMS: Double read FPDA_TOTALBASEISENTOICMS write FPDA_TOTALBASEISENTOICMS;
    const PDA_TOTALBASEISENTOICMS_Name = 'PDA_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOMVA', ftBCD, 537529610, 2)]
    [Dictionary('PDA_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOMVA: Double read FPDA_TOTALBASECALCULOMVA write FPDA_TOTALBASECALCULOMVA;
    const PDA_TOTALBASECALCULOMVA_Name = 'PDA_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALBASECALCULOICMS', ftBCD, 1414407968, 2)]
    [Dictionary('PDA_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOICMS: Double read FPDA_TOTALBASECALCULOICMS write FPDA_TOTALBASECALCULOICMS;
    const PDA_TOTALBASECALCULOICMS_Name = 'PDA_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBCALCULOPISCOFINS', ftBCD, 1998605377, 2)]
    [Dictionary('PDA_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBCALCULOPISCOFINS: Double read FPDA_TOTALBCALCULOPISCOFINS write FPDA_TOTALBCALCULOPISCOFINS;
    const PDA_TOTALBCALCULOPISCOFINS_Name = 'PDA_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALFINANCEIROPRAZO', ftBCD, 1598243924, 2)]
    [Dictionary('PDA_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFINANCEIROPRAZO: Double read FPDA_TOTALFINANCEIROPRAZO write FPDA_TOTALFINANCEIROPRAZO;
    const PDA_TOTALFINANCEIROPRAZO_Name = 'PDA_TOTALFINANCEIROPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALCOMPLEMENTONFICMS', ftBCD, 1919250543, 2)]
    [Dictionary('PDA_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMPLEMENTONFICMS: Double read FPDA_TOTALCOMPLEMENTONFICMS write FPDA_TOTALCOMPLEMENTONFICMS;
    const PDA_TOTALCOMPLEMENTONFICMS_Name = 'PDA_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALDESCTOITEM', ftBCD, 659308878, 2)]
    [Dictionary('PDA_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOITEM: Double read FPDA_TOTALDESCTOITEM write FPDA_TOTALDESCTOITEM;
    const PDA_TOTALDESCTOITEM_Name = 'PDA_TOTALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALDESCTOPRAZO', ftBCD, 1329815375, 2)]
    [Dictionary('PDA_TOTALDESCTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOPRAZO: Double read FPDA_TOTALDESCTOPRAZO write FPDA_TOTALDESCTOPRAZO;
    const PDA_TOTALDESCTOPRAZO_Name = 'PDA_TOTALDESCTOPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALDESCTOAVULSO', ftBCD, 1229213507, 2)]
    [Dictionary('PDA_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOAVULSO: Double read FPDA_TOTALDESCTOAVULSO write FPDA_TOTALDESCTOAVULSO;
    const PDA_TOTALDESCTOAVULSO_Name = 'PDA_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALCOMISSAO', ftBCD, 543449445, 2)]
    [Dictionary('PDA_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALCOMISSAO: Double read FPDA_TOTALCOMISSAO write FPDA_TOTALCOMISSAO;
    const PDA_TOTALCOMISSAO_Name = 'PDA_TOTALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALCOMISSAO', ftBCD, 2036754804, 2)]
    [Dictionary('PDA_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALCOMISSAO: Double read FPDA_PERCENTUALCOMISSAO write FPDA_PERCENTUALCOMISSAO;
    const PDA_PERCENTUALCOMISSAO_Name = 'PDA_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALDESCTOAVULSO', ftBCD, 1396790350, 6)]
    [Dictionary('PDA_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESCTOAVULSO: Double read FPDA_PERCENTUALDESCTOAVULSO write FPDA_PERCENTUALDESCTOAVULSO;
    const PDA_PERCENTUALDESCTOAVULSO_Name = 'PDA_PERCENTUALDESCTOAVULSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALDESCONTOPRAZO', ftBCD, 1329808717, 2)]
    [Dictionary('PDA_PERCENTUALDESCONTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALDESCONTOPRAZO: Double read FPDA_PERCENTUALDESCONTOPRAZO write FPDA_PERCENTUALDESCONTOPRAZO;
    const PDA_PERCENTUALDESCONTOPRAZO_Name = 'PDA_PERCENTUALDESCONTOPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_PERCENTUALFINANCEIROPRAZO', ftBCD, 1936020059, 2)]
    [Dictionary('PDA_PERCENTUALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALFINANCEIROPRAZO: Double read FPDA_PERCENTUALFINANCEIROPRAZO write FPDA_PERCENTUALFINANCEIROPRAZO;
    const PDA_PERCENTUALFINANCEIROPRAZO_Name = 'PDA_PERCENTUALFINANCEIROPRAZO';

    [Restrictions([NoValidate])]
    [Column('PDA_MARCAVOLUMES', ftString, 30)]
    [Dictionary('PDA_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_MARCAVOLUMES: String read FPDA_MARCAVOLUMES write FPDA_MARCAVOLUMES;
    const PDA_MARCAVOLUMES_Name = 'PDA_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('PDA_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('PDA_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_ESPECIEVOLUMES: String read FPDA_ESPECIEVOLUMES write FPDA_ESPECIEVOLUMES;
    const PDA_ESPECIEVOLUMES_Name = 'PDA_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('PDA_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERACAOVOLUMES: String read FPDA_NUMERACAOVOLUMES write FPDA_NUMERACAOVOLUMES;
    const PDA_NUMERACAOVOLUMES_Name = 'PDA_NUMERACAOVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALNUMEROVOLUMES', ftBCD, 1162039111, 2)]
    [Dictionary('PDA_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALNUMEROVOLUMES: Double read FPDA_TOTALNUMEROVOLUMES write FPDA_TOTALNUMEROVOLUMES;
    const PDA_TOTALNUMEROVOLUMES_Name = 'PDA_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOENTREGA', ftInteger)]
    [Dictionary('PES_CODIGOENTREGA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOENTREGA: Integer read FPES_CODIGOENTREGA write FPES_CODIGOENTREGA;
    const PES_CODIGOENTREGA_Name = 'PES_CODIGOENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGORETIRADA', ftInteger)]
    [Dictionary('PES_CODIGORETIRADA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGORETIRADA: Integer read FPES_CODIGORETIRADA write FPES_CODIGORETIRADA;
    const PES_CODIGORETIRADA_Name = 'PES_CODIGORETIRADA';

    [Restrictions([NoValidate])]
    [Column('PDA_DATADIGITACAOPALM', ftDateTime)]
    [Dictionary('PDA_DATADIGITACAOPALM', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATADIGITACAOPALM: TDateTime read FPDA_DATADIGITACAOPALM write FPDA_DATADIGITACAOPALM;
    const PDA_DATADIGITACAOPALM_Name = 'PDA_DATADIGITACAOPALM';

    [Restrictions([NoValidate])]
    [Column('PDA_HORADIGITACAOPALM', ftString, 10)]
    [Dictionary('PDA_HORADIGITACAOPALM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_HORADIGITACAOPALM: String read FPDA_HORADIGITACAOPALM write FPDA_HORADIGITACAOPALM;
    const PDA_HORADIGITACAOPALM_Name = 'PDA_HORADIGITACAOPALM';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALAPROXIMADOIMPOSTO', ftBCD, 218762555, 2)]
    [Dictionary('PDA_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALAPROXIMADOIMPOSTO: Double read FPDA_TOTALAPROXIMADOIMPOSTO write FPDA_TOTALAPROXIMADOIMPOSTO;
    const PDA_TOTALAPROXIMADOIMPOSTO_Name = 'PDA_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTMUNICIPAL', ftBCD, 1397311055, 2)]
    [Dictionary('PDA_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTMUNICIPAL: Double read FPDA_TOTALIBPTMUNICIPAL write FPDA_TOTALIBPTMUNICIPAL;
    const PDA_TOTALIBPTMUNICIPAL_Name = 'PDA_TOTALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTESTADUAL', ftBCD, 1195983951, 2)]
    [Dictionary('PDA_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTESTADUAL: Double read FPDA_TOTALIBPTESTADUAL write FPDA_TOTALIBPTESTADUAL;
    const PDA_TOTALIBPTESTADUAL_Name = 'PDA_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTNACIONAL', ftBCD, 544040295, 2)]
    [Dictionary('PDA_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTNACIONAL: Double read FPDA_TOTALIBPTNACIONAL write FPDA_TOTALIBPTNACIONAL;
    const PDA_TOTALIBPTNACIONAL_Name = 'PDA_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALIBPTIMPORTADO', ftBCD, 1699555104, 2)]
    [Dictionary('PDA_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALIBPTIMPORTADO: Double read FPDA_TOTALIBPTIMPORTADO write FPDA_TOTALIBPTIMPORTADO;
    const PDA_TOTALIBPTIMPORTADO_Name = 'PDA_TOTALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPT', ftBCD, 656419879, 2)]
    [Dictionary('PDA_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPT: Double read FPDA_PERCENTUALIBPT write FPDA_PERCENTUALIBPT;
    const PDA_PERCENTUALIBPT_Name = 'PDA_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTMUNICIPAL', ftBCD, 1769238085, 2)]
    [Dictionary('PDA_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTMUNICIPAL: Double read FPDA_PERCENTUALIBPTMUNICIPAL write FPDA_PERCENTUALIBPTMUNICIPAL;
    const PDA_PERCENTUALIBPTMUNICIPAL_Name = 'PDA_PERCENTUALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTESTADUAL', ftBCD, 1380275039, 2)]
    [Dictionary('PDA_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTESTADUAL: Double read FPDA_PERCENTUALIBPTESTADUAL write FPDA_PERCENTUALIBPTESTADUAL;
    const PDA_PERCENTUALIBPTESTADUAL_Name = 'PDA_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTNACIONAL', ftBCD, 1411398223, 2)]
    [Dictionary('PDA_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTNACIONAL: Double read FPDA_PERCENTUALIBPTNACIONAL write FPDA_PERCENTUALIBPTNACIONAL;
    const PDA_PERCENTUALIBPTNACIONAL_Name = 'PDA_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('PDA_PERCENTUALIBPTIMPORTADO', ftBCD, 1415532614, 2)]
    [Dictionary('PDA_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_PERCENTUALIBPTIMPORTADO: Double read FPDA_PERCENTUALIBPTIMPORTADO write FPDA_PERCENTUALIBPTIMPORTADO;
    const PDA_PERCENTUALIBPTIMPORTADO_Name = 'PDA_PERCENTUALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOFCP', ftBCD, 1142962771, 2)]
    [Dictionary('PDA_TOTALBASECALCULOFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCP: Double read FPDA_TOTALBASECALCULOFCP write FPDA_TOTALBASECALCULOFCP;
    const PDA_TOTALBASECALCULOFCP_Name = 'PDA_TOTALBASECALCULOFCP';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFCP', ftBCD, 1599096398, 2)]
    [Dictionary('PDA_TOTALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCP: Double read FPDA_TOTALFCP write FPDA_TOTALFCP;
    const PDA_TOTALFCP_Name = 'PDA_TOTALFCP';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOFCPST', ftBCD, 1280335696, 2)]
    [Dictionary('PDA_TOTALBASECALCULOFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPST: Double read FPDA_TOTALBASECALCULOFCPST write FPDA_TOTALBASECALCULOFCPST;
    const PDA_TOTALBASECALCULOFCPST_Name = 'PDA_TOTALBASECALCULOFCPST';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFCPST', ftBCD, 996634217, 2)]
    [Dictionary('PDA_TOTALFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPST: Double read FPDA_TOTALFCPST write FPDA_TOTALFCPST;
    const PDA_TOTALFCPST_Name = 'PDA_TOTALFCPST';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALBASECALCULOFCPRET', ftBCD, 1702129225, 2)]
    [Dictionary('PDA_TOTALBASECALCULOFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALBASECALCULOFCPRET: Double read FPDA_TOTALBASECALCULOFCPRET write FPDA_TOTALBASECALCULOFCPRET;
    const PDA_TOTALBASECALCULOFCPRET_Name = 'PDA_TOTALBASECALCULOFCPRET';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALFCPRET', ftBCD, 659507017, 2)]
    [Dictionary('PDA_TOTALFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFCPRET: Double read FPDA_TOTALFCPRET write FPDA_TOTALFCPRET;
    const PDA_TOTALFCPRET_Name = 'PDA_TOTALFCPRET';

    [Restrictions([NoValidate])]
    [Column('PDA_OBSERVACAO', ftString, 5000)]
    [Dictionary('PDA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_OBSERVACAO: String read FPDA_OBSERVACAO write FPDA_OBSERVACAO;
    const PDA_OBSERVACAO_Name = 'PDA_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PDA_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('PDA_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_OBSERVACAOCANCELAMENTO: String read FPDA_OBSERVACAOCANCELAMENTO write FPDA_OBSERVACAOCANCELAMENTO;
    const PDA_OBSERVACAOCANCELAMENTO_Name = 'PDA_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_CANCELADA', ftString, 1)]
    [Dictionary('PDA_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CANCELADA: String read FPDA_CANCELADA write FPDA_CANCELADA;
    const PDA_CANCELADA_Name = 'PDA_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('PDA_BLOQUEADO', ftString, 1)]
    [Dictionary('PDA_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_BLOQUEADO: String read FPDA_BLOQUEADO write FPDA_BLOQUEADO;
    const PDA_BLOQUEADO_Name = 'PDA_BLOQUEADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DESATIVADO', ftString, 1)]
    [Dictionary('PDA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DESATIVADO: String read FPDA_DESATIVADO write FPDA_DESATIVADO;
    const PDA_DESATIVADO_Name = 'PDA_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_FATURADO', ftString, 1)]
    [Dictionary('PDA_FATURADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_FATURADO: String read FPDA_FATURADO write FPDA_FATURADO;
    const PDA_FATURADO_Name = 'PDA_FATURADO';

    [Restrictions([NoValidate])]
    [Column('PDA_INTEGRACAO', ftString, 20)]
    [Dictionary('PDA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_INTEGRACAO: String read FPDA_INTEGRACAO write FPDA_INTEGRACAO;
    const PDA_INTEGRACAO_Name = 'PDA_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATAALTERACAO: TDateTime read FPDA_DATAALTERACAO write FPDA_DATAALTERACAO;
    const PDA_DATAALTERACAO_Name = 'PDA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDA_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('PDA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPODOCUMENTO: String read FPDA_TIPODOCUMENTO write FPDA_TIPODOCUMENTO;
    const PDA_TIPODOCUMENTO_Name = 'PDA_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('LIB_ID', ftInteger)]
    [Dictionary('LIB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID: Integer read FLIB_ID write FLIB_ID;
    const LIB_ID_Name = 'LIB_ID';

    [Restrictions([NoValidate])]
    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CON_CODIGO: Integer read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID_OLD: Integer read FPDA_ID_OLD write FPDA_ID_OLD;
    const PDA_ID_OLD_Name = 'PDA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDA_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('PDA_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_INTEGRACAO_OLD: String read FPDA_INTEGRACAO_OLD write FPDA_INTEGRACAO_OLD;
    const PDA_INTEGRACAO_OLD_Name = 'PDA_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('CGA_ID_OLD', ftInteger)]
    [Dictionary('CGA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID_OLD: Integer read FCGA_ID_OLD write FCGA_ID_OLD;
    const CGA_ID_OLD_Name = 'CGA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LIB_ID_OLD', ftInteger)]
    [Dictionary('LIB_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID_OLD: Integer read FLIB_ID_OLD write FLIB_ID_OLD;
    const LIB_ID_OLD_Name = 'LIB_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPDA_00)

end.
