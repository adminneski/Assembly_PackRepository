unit express.dbo.FAT_00;

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
  [Table('FAT_00', '')]
  [PrimaryKey('FAT_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_ID')]
  TDtoFAT_00 = class
  private
    { Private declarations } 
    FFAT_NSV: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FCGA_ID: Integer;
    FFAT_TIPO: String;
    FFPG_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FFAT_CPFCLIENTE: String;
    FFAT_NOMECLIENTE: String;
    FVND_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FMNF_CODIGO: String;
    FTDC_CODIGO: String;
    FNTO_CODIGO: Integer;
    FCTB_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FCCU_CODIGO: Integer;
    FFAT_SERIE: String;
    FFAT_NOTAFISCAL: String;
    FFAT_NOTAFISCALSERVICO: String;
    FFAT_NUMERODOCTO: String;
    FFAT_DATALACRE: TDateTime;
    FFAT_DATAENTREGA: TDateTime;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_DATACANCELAMENTO: TDateTime;
    FFAT_DATAATUALIZACAOFINANCEIRA: TDateTime;
    FFAT_TIPOFRETE: String;
    FFAT_NUMEROORCAMENTO: String;
    FFAT_COMISSAONEGOCIADA: String;
    FFAT_CODIGOLIBERACAOVENDA: String;
    FFAT_OBSERVACAOCANCELAMENTO: String;
    FFAT_NUMEROORDEMCOMPRA: String;
    FFAT_NUMERODOCTOREPRESENTANTE: String;
    FFAT_TOTALPESOBRUTO: Double;
    FFAT_TOTALPESOLIQUIDO: Double;
    FFAT_TOTALQTDFATURADA: Double;
    FFAT_TOTALNUMEROVOLUMES: Double;
    FFAT_PERCENTUALCOMISSAO: Double;
    FFAT_TOTALBASEDESCONTOCOMISSAO: Double;
    FFAT_PERCENTUALFINANCEIROPRAZO: Double;
    FFAT_PERCENTUALDESCONTOPRAZO: Double;
    FFAT_PERCENTUALDESCTOAVULSO: Double;
    FFAT_PERCENTUALIBPTMUNICIPAL: Double;
    FFAT_PERCENTUALIBPTESTADUAL: Double;
    FFAT_PERCENTUALIBPTNACIONAL: Double;
    FFAT_PERCENTUALIBPTIMPORTADO: Double;
    FFAT_TOTALISS: Double;
    FFAT_TOTALIPI: Double;
    FFAT_TOTALPIS: Double;
    FFAT_TOTALICMS: Double;
    FFAT_TOTALICMSR: Double;
    FFAT_TOTALFRETE: Double;
    FFAT_TOTALCOFINS: Double;
    FFAT_TOTALLIQUIDO: Double;
    FFAT_TOTALSEGURO: Double;
    FFAT_TOTALSERVICO: Double;
    FFAT_TOTALADICIONAL: Double;
    FFAT_TOTALPRODUTOS: Double;
    FFAT_TOTALSUBSTRIBUTARIA: Double;
    FFAT_TOTALDESPACESSORIA: Double;
    FFAT_TOTALBASEISENTOICMS: Double;
    FFAT_TOTALBASECALCULOICMS: Double;
    FFAT_TOTALBASECALCULOMVA: Double;
    FFAT_TOTALFINANCEIROPRAZO: Double;
    FFAT_TOTALDESCTOITEM: Double;
    FFAT_TOTALDESCTOPRAZO: Double;
    FFAT_TOTALDESCTOAVULSO: Double;
    FFAT_TOTALBASECALCULOISS: Double;
    FFAT_TOTALBCALCULOPISCOFINS: Double;
    FFAT_TOTALAPROXIMADOIMPOSTO: Double;
    FFAT_TOTALCOMPLEMENTONFICMS: Double;
    FFAT_TOTALPRODUTOSLIQUIDO: Double;
    FFAT_TOTALCOMISSAO: Double;
    FFAT_TOTALTROCO: Double;
    FFAT_PERCENTUALIBPT: Double;
    FFAT_TOTALIBPTMUNICIPAL: Double;
    FFAT_TOTALIBPTESTADUAL: Double;
    FFAT_TOTALIBPTNACIONAL: Double;
    FFAT_TOTALIBPTIMPORTADO: Double;
    FFAT_TOTALBASECALCULOFCP: Double;
    FFAT_TOTALFCP: Double;
    FFAT_TOTALBASECALCULOFCPST: Double;
    FFAT_TOTALFCPST: Double;
    FFAT_TOTALBASECALCULOFCPRET: Double;
    FFAT_TOTALFCPRET: Double;
    FFAT_UFVEICULO: String;
    FFAT_PLACAVEICULO: String;
    FFAT_MARCAVOLUMES: String;
    FFAT_ESPECIEVOLUMES: String;
    FFAT_NUMERACAOVOLUMES: String;
    FFAT_INFCOMPLEMENTAR: String;
    FPES_CODIGOENTREGA: Integer;
    FPES_CODIGORETIRADA: Integer;
    FLIB_NUMEROLIBERACAO: String;
    FFAT_MESA: Integer;
    FFAT_OBSERVACAO: String;
    FFAT_POSVENDA: String;
    FFAT_DENEGADA: String;
    FFAT_CANCELADA: String;
    FFAT_DESATIVADO: String;
    FFAT_PROCESSADO: String;
    FFAT_LIVROFISCAL: String;
    FFAT_BLOQUEADO: String;
    FFAT_INTEGRACAO: String;
    FUSERS_LOGIN: String;
    FFAT_HORAALTERACAO: String;
    FFAT_DATAALTERACAO: TDateTime;
    FLIB_ID: Integer;
    FFAT_RPS: Integer;
    FFAT_COMPETENCIA: String;
    FCON_CODIGO: Integer;
    FFAT_ID_OLD: Integer;
    FCGA_ID_OLD: Integer;
    FLIB_ID_OLD: Integer;
    FPDA_ID_OLD: Integer;
    FFAT_INTEGRACAO_OLD: String;
    FFAT_RESERVARESTOQUE: String;
    FFAT_TIPOMOVTO: String;
    FFAT_FATURADOPRODUTOS: String;
    FFAT_FATURADOSERVICOS: String;
    FFAT_NUMEROREMESSA: String;
    FFAT_TOTALICMSDESONERADO: Double;
    FFAT_EXPEDIDO: String;
    FFAT_INTEGRACAOERP: String;
    FPDA_ID: Integer;
    FFAT_TOTALINSS: Double;
    FFAT_TOTALIR: Double;
    FFAT_TOTALCSLL: Double;
    FFAT_ISSRETIDO: String;
    FFAT_NUMEROOC: Integer;
    FFAT_STATUS: String;
    FFAT_IDSUNIFICADOS: String;
    FFAT_NUMEROLICITACAO: String;
  public 
    { Public declarations } 
     const Table      = 'FAT_00';
     const PrimaryKey = 'FAT_ID';
     const Sequence   = 'SEQ_FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_NSV', ftInteger)]
    [Dictionary('FAT_NSV', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NSV: Integer read FFAT_NSV write FFAT_NSV;
    const FAT_NSV_Name = 'FAT_NSV';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPO', ftString, 1)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_CPFCLIENTE', ftString, 11)]
    [Dictionary('FAT_CPFCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CPFCLIENTE: String read FFAT_CPFCLIENTE write FFAT_CPFCLIENTE;
    const FAT_CPFCLIENTE_Name = 'FAT_CPFCLIENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_NOMECLIENTE', ftString, 100)]
    [Dictionary('FAT_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOMECLIENTE: String read FFAT_NOMECLIENTE write FFAT_NOMECLIENTE;
    const FAT_NOMECLIENTE_Name = 'FAT_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

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
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_SERIE', ftString, 3)]
    [Dictionary('FAT_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_SERIE: String read FFAT_SERIE write FFAT_SERIE;
    const FAT_SERIE_Name = 'FAT_SERIE';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('FAT_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCALSERVICO: String read FFAT_NOTAFISCALSERVICO write FFAT_NOTAFISCALSERVICO;
    const FAT_NOTAFISCALSERVICO_Name = 'FAT_NOTAFISCALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALACRE', ftDateTime)]
    [Dictionary('FAT_DATALACRE', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALACRE: TDateTime read FFAT_DATALACRE write FFAT_DATALACRE;
    const FAT_DATALACRE_Name = 'FAT_DATALACRE';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAENTREGA', ftDateTime)]
    [Dictionary('FAT_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAENTREGA: TDateTime read FFAT_DATAENTREGA write FFAT_DATAENTREGA;
    const FAT_DATAENTREGA_Name = 'FAT_DATAENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('FAT_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATACANCELAMENTO: TDateTime read FFAT_DATACANCELAMENTO write FFAT_DATACANCELAMENTO;
    const FAT_DATACANCELAMENTO_Name = 'FAT_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAATUALIZACAOFINANCEIRA', ftDateTime)]
    [Dictionary('FAT_DATAATUALIZACAOFINANCEIRA', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAATUALIZACAOFINANCEIRA: TDateTime read FFAT_DATAATUALIZACAOFINANCEIRA write FFAT_DATAATUALIZACAOFINANCEIRA;
    const FAT_DATAATUALIZACAOFINANCEIRA_Name = 'FAT_DATAATUALIZACAOFINANCEIRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPOFRETE', ftString, 1)]
    [Dictionary('FAT_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOFRETE: String read FFAT_TIPOFRETE write FFAT_TIPOFRETE;
    const FAT_TIPOFRETE_Name = 'FAT_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROORCAMENTO', ftString, 6)]
    [Dictionary('FAT_NUMEROORCAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROORCAMENTO: String read FFAT_NUMEROORCAMENTO write FFAT_NUMEROORCAMENTO;
    const FAT_NUMEROORCAMENTO_Name = 'FAT_NUMEROORCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_COMISSAONEGOCIADA', ftString, 1)]
    [Dictionary('FAT_COMISSAONEGOCIADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_COMISSAONEGOCIADA: String read FFAT_COMISSAONEGOCIADA write FFAT_COMISSAONEGOCIADA;
    const FAT_COMISSAONEGOCIADA_Name = 'FAT_COMISSAONEGOCIADA';

    [Restrictions([NoValidate])]
    [Column('FAT_CODIGOLIBERACAOVENDA', ftString, 6)]
    [Dictionary('FAT_CODIGOLIBERACAOVENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CODIGOLIBERACAOVENDA: String read FFAT_CODIGOLIBERACAOVENDA write FFAT_CODIGOLIBERACAOVENDA;
    const FAT_CODIGOLIBERACAOVENDA_Name = 'FAT_CODIGOLIBERACAOVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('FAT_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAOCANCELAMENTO: String read FFAT_OBSERVACAOCANCELAMENTO write FFAT_OBSERVACAOCANCELAMENTO;
    const FAT_OBSERVACAOCANCELAMENTO_Name = 'FAT_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROORDEMCOMPRA', ftString, 20)]
    [Dictionary('FAT_NUMEROORDEMCOMPRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROORDEMCOMPRA: String read FFAT_NUMEROORDEMCOMPRA write FFAT_NUMEROORDEMCOMPRA;
    const FAT_NUMEROORDEMCOMPRA_Name = 'FAT_NUMEROORDEMCOMPRA';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTOREPRESENTANTE: String read FFAT_NUMERODOCTOREPRESENTANTE write FFAT_NUMERODOCTOREPRESENTANTE;
    const FAT_NUMERODOCTOREPRESENTANTE_Name = 'FAT_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('FAT_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPESOBRUTO: Double read FFAT_TOTALPESOBRUTO write FFAT_TOTALPESOBRUTO;
    const FAT_TOTALPESOBRUTO_Name = 'FAT_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('FAT_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPESOLIQUIDO: Double read FFAT_TOTALPESOLIQUIDO write FFAT_TOTALPESOLIQUIDO;
    const FAT_TOTALPESOLIQUIDO_Name = 'FAT_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALQTDFATURADA', ftBCD)]
    [Dictionary('FAT_TOTALQTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALQTDFATURADA: Double read FFAT_TOTALQTDFATURADA write FFAT_TOTALQTDFATURADA;
    const FAT_TOTALQTDFATURADA_Name = 'FAT_TOTALQTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('FAT_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALNUMEROVOLUMES: Double read FFAT_TOTALNUMEROVOLUMES write FFAT_TOTALNUMEROVOLUMES;
    const FAT_TOTALNUMEROVOLUMES_Name = 'FAT_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('FAT_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALCOMISSAO: Double read FFAT_PERCENTUALCOMISSAO write FFAT_PERCENTUALCOMISSAO;
    const FAT_PERCENTUALCOMISSAO_Name = 'FAT_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASEDESCONTOCOMISSAO', ftBCD)]
    [Dictionary('FAT_TOTALBASEDESCONTOCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASEDESCONTOCOMISSAO: Double read FFAT_TOTALBASEDESCONTOCOMISSAO write FFAT_TOTALBASEDESCONTOCOMISSAO;
    const FAT_TOTALBASEDESCONTOCOMISSAO_Name = 'FAT_TOTALBASEDESCONTOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('FAT_PERCENTUALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALFINANCEIROPRAZO: Double read FFAT_PERCENTUALFINANCEIROPRAZO write FFAT_PERCENTUALFINANCEIROPRAZO;
    const FAT_PERCENTUALFINANCEIROPRAZO_Name = 'FAT_PERCENTUALFINANCEIROPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALDESCONTOPRAZO', ftBCD)]
    [Dictionary('FAT_PERCENTUALDESCONTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESCONTOPRAZO: Double read FFAT_PERCENTUALDESCONTOPRAZO write FFAT_PERCENTUALDESCONTOPRAZO;
    const FAT_PERCENTUALDESCONTOPRAZO_Name = 'FAT_PERCENTUALDESCONTOPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PERCENTUALDESCTOAVULSO', ftBCD)]
    [Dictionary('FAT_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESCTOAVULSO: Double read FFAT_PERCENTUALDESCTOAVULSO write FFAT_PERCENTUALDESCTOAVULSO;
    const FAT_PERCENTUALDESCTOAVULSO_Name = 'FAT_PERCENTUALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTMUNICIPAL: Double read FFAT_PERCENTUALIBPTMUNICIPAL write FFAT_PERCENTUALIBPTMUNICIPAL;
    const FAT_PERCENTUALIBPTMUNICIPAL_Name = 'FAT_PERCENTUALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTESTADUAL: Double read FFAT_PERCENTUALIBPTESTADUAL write FFAT_PERCENTUALIBPTESTADUAL;
    const FAT_PERCENTUALIBPTESTADUAL_Name = 'FAT_PERCENTUALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTNACIONAL: Double read FFAT_PERCENTUALIBPTNACIONAL write FFAT_PERCENTUALIBPTNACIONAL;
    const FAT_PERCENTUALIBPTNACIONAL_Name = 'FAT_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPTIMPORTADO', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPTIMPORTADO: Double read FFAT_PERCENTUALIBPTIMPORTADO write FFAT_PERCENTUALIBPTIMPORTADO;
    const FAT_PERCENTUALIBPTIMPORTADO_Name = 'FAT_PERCENTUALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALISS', ftBCD)]
    [Dictionary('FAT_TOTALISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALISS: Double read FFAT_TOTALISS write FFAT_TOTALISS;
    const FAT_TOTALISS_Name = 'FAT_TOTALISS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALIPI', ftBCD)]
    [Dictionary('FAT_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIPI: Double read FFAT_TOTALIPI write FFAT_TOTALIPI;
    const FAT_TOTALIPI_Name = 'FAT_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPIS', ftBCD)]
    [Dictionary('FAT_TOTALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPIS: Double read FFAT_TOTALPIS write FFAT_TOTALPIS;
    const FAT_TOTALPIS_Name = 'FAT_TOTALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALICMS', ftBCD)]
    [Dictionary('FAT_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMS: Double read FFAT_TOTALICMS write FFAT_TOTALICMS;
    const FAT_TOTALICMS_Name = 'FAT_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALICMSR', ftBCD)]
    [Dictionary('FAT_TOTALICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSR: Double read FFAT_TOTALICMSR write FFAT_TOTALICMSR;
    const FAT_TOTALICMSR_Name = 'FAT_TOTALICMSR';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALFRETE', ftBCD)]
    [Dictionary('FAT_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFRETE: Double read FFAT_TOTALFRETE write FFAT_TOTALFRETE;
    const FAT_TOTALFRETE_Name = 'FAT_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALCOFINS', ftBCD)]
    [Dictionary('FAT_TOTALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOFINS: Double read FFAT_TOTALCOFINS write FFAT_TOTALCOFINS;
    const FAT_TOTALCOFINS_Name = 'FAT_TOTALCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALSEGURO', ftBCD)]
    [Dictionary('FAT_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSEGURO: Double read FFAT_TOTALSEGURO write FFAT_TOTALSEGURO;
    const FAT_TOTALSEGURO_Name = 'FAT_TOTALSEGURO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSERVICO', ftBCD)]
    [Dictionary('FAT_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSERVICO: Double read FFAT_TOTALSERVICO write FFAT_TOTALSERVICO;
    const FAT_TOTALSERVICO_Name = 'FAT_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALADICIONAL', ftBCD)]
    [Dictionary('FAT_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALADICIONAL: Double read FFAT_TOTALADICIONAL write FFAT_TOTALADICIONAL;
    const FAT_TOTALADICIONAL_Name = 'FAT_TOTALADICIONAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPRODUTOS', ftBCD)]
    [Dictionary('FAT_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRODUTOS: Double read FFAT_TOTALPRODUTOS write FFAT_TOTALPRODUTOS;
    const FAT_TOTALPRODUTOS_Name = 'FAT_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('FAT_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSUBSTRIBUTARIA: Double read FFAT_TOTALSUBSTRIBUTARIA write FFAT_TOTALSUBSTRIBUTARIA;
    const FAT_TOTALSUBSTRIBUTARIA_Name = 'FAT_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('FAT_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESPACESSORIA: Double read FFAT_TOTALDESPACESSORIA write FFAT_TOTALDESPACESSORIA;
    const FAT_TOTALDESPACESSORIA_Name = 'FAT_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASEISENTOICMS', ftBCD)]
    [Dictionary('FAT_TOTALBASEISENTOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASEISENTOICMS: Double read FFAT_TOTALBASEISENTOICMS write FFAT_TOTALBASEISENTOICMS;
    const FAT_TOTALBASEISENTOICMS_Name = 'FAT_TOTALBASEISENTOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOICMS: Double read FFAT_TOTALBASECALCULOICMS write FFAT_TOTALBASECALCULOICMS;
    const FAT_TOTALBASECALCULOICMS_Name = 'FAT_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOMVA: Double read FFAT_TOTALBASECALCULOMVA write FFAT_TOTALBASECALCULOMVA;
    const FAT_TOTALBASECALCULOMVA_Name = 'FAT_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('FAT_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFINANCEIROPRAZO: Double read FFAT_TOTALFINANCEIROPRAZO write FFAT_TOTALFINANCEIROPRAZO;
    const FAT_TOTALFINANCEIROPRAZO_Name = 'FAT_TOTALFINANCEIROPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOITEM: Double read FFAT_TOTALDESCTOITEM write FFAT_TOTALDESCTOITEM;
    const FAT_TOTALDESCTOITEM_Name = 'FAT_TOTALDESCTOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALDESCTOPRAZO', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOPRAZO: Double read FFAT_TOTALDESCTOPRAZO write FFAT_TOTALDESCTOPRAZO;
    const FAT_TOTALDESCTOPRAZO_Name = 'FAT_TOTALDESCTOPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('FAT_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTOAVULSO: Double read FFAT_TOTALDESCTOAVULSO write FFAT_TOTALDESCTOAVULSO;
    const FAT_TOTALDESCTOAVULSO_Name = 'FAT_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOISS', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOISS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOISS: Double read FFAT_TOTALBASECALCULOISS write FFAT_TOTALBASECALCULOISS;
    const FAT_TOTALBASECALCULOISS_Name = 'FAT_TOTALBASECALCULOISS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBCALCULOPISCOFINS', ftBCD, 10, 2)]
    [Dictionary('FAT_TOTALBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBCALCULOPISCOFINS: Double read FFAT_TOTALBCALCULOPISCOFINS write FFAT_TOTALBCALCULOPISCOFINS;
    const FAT_TOTALBCALCULOPISCOFINS_Name = 'FAT_TOTALBCALCULOPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALAPROXIMADOIMPOSTO', ftBCD)]
    [Dictionary('FAT_TOTALAPROXIMADOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALAPROXIMADOIMPOSTO: Double read FFAT_TOTALAPROXIMADOIMPOSTO write FFAT_TOTALAPROXIMADOIMPOSTO;
    const FAT_TOTALAPROXIMADOIMPOSTO_Name = 'FAT_TOTALAPROXIMADOIMPOSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('FAT_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMPLEMENTONFICMS: Double read FFAT_TOTALCOMPLEMENTONFICMS write FFAT_TOTALCOMPLEMENTONFICMS;
    const FAT_TOTALCOMPLEMENTONFICMS_Name = 'FAT_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRODUTOSLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRODUTOSLIQUIDO: Double read FFAT_TOTALPRODUTOSLIQUIDO write FFAT_TOTALPRODUTOSLIQUIDO;
    const FAT_TOTALPRODUTOSLIQUIDO_Name = 'FAT_TOTALPRODUTOSLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCOMISSAO', ftBCD)]
    [Dictionary('FAT_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCOMISSAO: Double read FFAT_TOTALCOMISSAO write FFAT_TOTALCOMISSAO;
    const FAT_TOTALCOMISSAO_Name = 'FAT_TOTALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALTROCO', ftBCD)]
    [Dictionary('FAT_TOTALTROCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALTROCO: Double read FFAT_TOTALTROCO write FFAT_TOTALTROCO;
    const FAT_TOTALTROCO_Name = 'FAT_TOTALTROCO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALIBPT', ftBCD)]
    [Dictionary('FAT_PERCENTUALIBPT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALIBPT: Double read FFAT_PERCENTUALIBPT write FFAT_PERCENTUALIBPT;
    const FAT_PERCENTUALIBPT_Name = 'FAT_PERCENTUALIBPT';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('FAT_TOTALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTMUNICIPAL: Double read FFAT_TOTALIBPTMUNICIPAL write FFAT_TOTALIBPTMUNICIPAL;
    const FAT_TOTALIBPTMUNICIPAL_Name = 'FAT_TOTALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTESTADUAL', ftBCD)]
    [Dictionary('FAT_TOTALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTESTADUAL: Double read FFAT_TOTALIBPTESTADUAL write FFAT_TOTALIBPTESTADUAL;
    const FAT_TOTALIBPTESTADUAL_Name = 'FAT_TOTALIBPTESTADUAL';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTNACIONAL', ftBCD)]
    [Dictionary('FAT_TOTALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTNACIONAL: Double read FFAT_TOTALIBPTNACIONAL write FFAT_TOTALIBPTNACIONAL;
    const FAT_TOTALIBPTNACIONAL_Name = 'FAT_TOTALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIBPTIMPORTADO', ftBCD)]
    [Dictionary('FAT_TOTALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIBPTIMPORTADO: Double read FFAT_TOTALIBPTIMPORTADO write FFAT_TOTALIBPTIMPORTADO;
    const FAT_TOTALIBPTIMPORTADO_Name = 'FAT_TOTALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCP', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCP: Double read FFAT_TOTALBASECALCULOFCP write FFAT_TOTALBASECALCULOFCP;
    const FAT_TOTALBASECALCULOFCP_Name = 'FAT_TOTALBASECALCULOFCP';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCP', ftBCD)]
    [Dictionary('FAT_TOTALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCP: Double read FFAT_TOTALFCP write FFAT_TOTALFCP;
    const FAT_TOTALFCP_Name = 'FAT_TOTALFCP';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCPST', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCPST: Double read FFAT_TOTALBASECALCULOFCPST write FFAT_TOTALBASECALCULOFCPST;
    const FAT_TOTALBASECALCULOFCPST_Name = 'FAT_TOTALBASECALCULOFCPST';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCPST', ftBCD)]
    [Dictionary('FAT_TOTALFCPST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCPST: Double read FFAT_TOTALFCPST write FFAT_TOTALFCPST;
    const FAT_TOTALFCPST_Name = 'FAT_TOTALFCPST';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALBASECALCULOFCPRET', ftBCD)]
    [Dictionary('FAT_TOTALBASECALCULOFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALBASECALCULOFCPRET: Double read FFAT_TOTALBASECALCULOFCPRET write FFAT_TOTALBASECALCULOFCPRET;
    const FAT_TOTALBASECALCULOFCPRET_Name = 'FAT_TOTALBASECALCULOFCPRET';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALFCPRET', ftBCD)]
    [Dictionary('FAT_TOTALFCPRET', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFCPRET: Double read FFAT_TOTALFCPRET write FFAT_TOTALFCPRET;
    const FAT_TOTALFCPRET_Name = 'FAT_TOTALFCPRET';

    [Restrictions([NoValidate])]
    [Column('FAT_UFVEICULO', ftString, 2)]
    [Dictionary('FAT_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_UFVEICULO: String read FFAT_UFVEICULO write FFAT_UFVEICULO;
    const FAT_UFVEICULO_Name = 'FAT_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_PLACAVEICULO', ftString, 7)]
    [Dictionary('FAT_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_PLACAVEICULO: String read FFAT_PLACAVEICULO write FFAT_PLACAVEICULO;
    const FAT_PLACAVEICULO_Name = 'FAT_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_MARCAVOLUMES', ftString, 30)]
    [Dictionary('FAT_MARCAVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_MARCAVOLUMES: String read FFAT_MARCAVOLUMES write FFAT_MARCAVOLUMES;
    const FAT_MARCAVOLUMES_Name = 'FAT_MARCAVOLUMES';

    [Restrictions([NoValidate])]
    [Column('FAT_ESPECIEVOLUMES', ftString, 30)]
    [Dictionary('FAT_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_ESPECIEVOLUMES: String read FFAT_ESPECIEVOLUMES write FFAT_ESPECIEVOLUMES;
    const FAT_ESPECIEVOLUMES_Name = 'FAT_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERACAOVOLUMES', ftString, 30)]
    [Dictionary('FAT_NUMERACAOVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERACAOVOLUMES: String read FFAT_NUMERACAOVOLUMES write FFAT_NUMERACAOVOLUMES;
    const FAT_NUMERACAOVOLUMES_Name = 'FAT_NUMERACAOVOLUMES';

    [Restrictions([NoValidate])]
    [Column('FAT_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('FAT_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INFCOMPLEMENTAR: String read FFAT_INFCOMPLEMENTAR write FFAT_INFCOMPLEMENTAR;
    const FAT_INFCOMPLEMENTAR_Name = 'FAT_INFCOMPLEMENTAR';

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
    [Column('LIB_NUMEROLIBERACAO', ftString, 6)]
    [Dictionary('LIB_NUMEROLIBERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIB_NUMEROLIBERACAO: String read FLIB_NUMEROLIBERACAO write FLIB_NUMEROLIBERACAO;
    const LIB_NUMEROLIBERACAO_Name = 'LIB_NUMEROLIBERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_MESA', ftInteger)]
    [Dictionary('FAT_MESA', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_MESA: Integer read FFAT_MESA write FFAT_MESA;
    const FAT_MESA_Name = 'FAT_MESA';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAO', ftString, 5000)]
    [Dictionary('FAT_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAO: String read FFAT_OBSERVACAO write FFAT_OBSERVACAO;
    const FAT_OBSERVACAO_Name = 'FAT_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_POSVENDA', ftString, 1)]
    [Dictionary('FAT_POSVENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_POSVENDA: String read FFAT_POSVENDA write FFAT_POSVENDA;
    const FAT_POSVENDA_Name = 'FAT_POSVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_DENEGADA', ftString, 1)]
    [Dictionary('FAT_DENEGADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DENEGADA: String read FFAT_DENEGADA write FFAT_DENEGADA;
    const FAT_DENEGADA_Name = 'FAT_DENEGADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DESATIVADO', ftString, 1)]
    [Dictionary('FAT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESATIVADO: String read FFAT_DESATIVADO write FFAT_DESATIVADO;
    const FAT_DESATIVADO_Name = 'FAT_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PROCESSADO', ftString, 1)]
    [Dictionary('FAT_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_PROCESSADO: String read FFAT_PROCESSADO write FFAT_PROCESSADO;
    const FAT_PROCESSADO_Name = 'FAT_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('FAT_LIVROFISCAL', ftString, 1)]
    [Dictionary('FAT_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_LIVROFISCAL: String read FFAT_LIVROFISCAL write FFAT_LIVROFISCAL;
    const FAT_LIVROFISCAL_Name = 'FAT_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_BLOQUEADO', ftString, 1)]
    [Dictionary('FAT_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_BLOQUEADO: String read FFAT_BLOQUEADO write FFAT_BLOQUEADO;
    const FAT_BLOQUEADO_Name = 'FAT_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO', ftString, 20)]
    [Dictionary('FAT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO: String read FFAT_INTEGRACAO write FFAT_INTEGRACAO;
    const FAT_INTEGRACAO_Name = 'FAT_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('FAT_HORAALTERACAO', ftString, 8)]
    [Dictionary('FAT_HORAALTERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_HORAALTERACAO: String read FFAT_HORAALTERACAO write FFAT_HORAALTERACAO;
    const FAT_HORAALTERACAO_Name = 'FAT_HORAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LIB_ID', ftInteger)]
    [Dictionary('LIB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIB_ID: Integer read FLIB_ID write FLIB_ID;
    const LIB_ID_Name = 'LIB_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_RPS', ftInteger)]
    [Dictionary('FAT_RPS', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_RPS: Integer read FFAT_RPS write FFAT_RPS;
    const FAT_RPS_Name = 'FAT_RPS';

    [Restrictions([NoValidate])]
    [Column('FAT_COMPETENCIA', ftString, 6)]
    [Dictionary('FAT_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_COMPETENCIA: String read FFAT_COMPETENCIA write FFAT_COMPETENCIA;
    const FAT_COMPETENCIA_Name = 'FAT_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CON_CODIGO: Integer read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

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

    [Restrictions([NoValidate])]
    [Column('PDA_ID_OLD', ftInteger)]
    [Dictionary('PDA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID_OLD: Integer read FPDA_ID_OLD write FPDA_ID_OLD;
    const PDA_ID_OLD_Name = 'PDA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('FAT_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO_OLD: String read FFAT_INTEGRACAO_OLD write FFAT_INTEGRACAO_OLD;
    const FAT_INTEGRACAO_OLD_Name = 'FAT_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_RESERVARESTOQUE', ftString, 1)]
    [Dictionary('FAT_RESERVARESTOQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_RESERVARESTOQUE: String read FFAT_RESERVARESTOQUE write FFAT_RESERVARESTOQUE;
    const FAT_RESERVARESTOQUE_Name = 'FAT_RESERVARESTOQUE';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOMOVTO', ftString, 3)]
    [Dictionary('FAT_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOMOVTO: String read FFAT_TIPOMOVTO write FFAT_TIPOMOVTO;
    const FAT_TIPOMOVTO_Name = 'FAT_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('FAT_FATURADOPRODUTOS', ftString, 1)]
    [Dictionary('FAT_FATURADOPRODUTOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_FATURADOPRODUTOS: String read FFAT_FATURADOPRODUTOS write FFAT_FATURADOPRODUTOS;
    const FAT_FATURADOPRODUTOS_Name = 'FAT_FATURADOPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('FAT_FATURADOSERVICOS', ftString, 1)]
    [Dictionary('FAT_FATURADOSERVICOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_FATURADOSERVICOS: String read FFAT_FATURADOSERVICOS write FFAT_FATURADOSERVICOS;
    const FAT_FATURADOSERVICOS_Name = 'FAT_FATURADOSERVICOS';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROREMESSA', ftString, 20)]
    [Dictionary('FAT_NUMEROREMESSA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROREMESSA: String read FFAT_NUMEROREMESSA write FFAT_NUMEROREMESSA;
    const FAT_NUMEROREMESSA_Name = 'FAT_NUMEROREMESSA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALICMSDESONERADO', ftBCD)]
    [Dictionary('FAT_TOTALICMSDESONERADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALICMSDESONERADO: Double read FFAT_TOTALICMSDESONERADO write FFAT_TOTALICMSDESONERADO;
    const FAT_TOTALICMSDESONERADO_Name = 'FAT_TOTALICMSDESONERADO';

    [Restrictions([NoValidate])]
    [Column('FAT_EXPEDIDO', ftString, 1)]
    [Dictionary('FAT_EXPEDIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_EXPEDIDO: String read FFAT_EXPEDIDO write FFAT_EXPEDIDO;
    const FAT_EXPEDIDO_Name = 'FAT_EXPEDIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAOERP', ftString, 50)]
    [Dictionary('FAT_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAOERP: String read FFAT_INTEGRACAOERP write FFAT_INTEGRACAOERP;
    const FAT_INTEGRACAOERP_Name = 'FAT_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALINSS', ftBCD)]
    [Dictionary('FAT_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALINSS: Double read FFAT_TOTALINSS write FFAT_TOTALINSS;
    const FAT_TOTALINSS_Name = 'FAT_TOTALINSS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALIR', ftBCD)]
    [Dictionary('FAT_TOTALIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALIR: Double read FFAT_TOTALIR write FFAT_TOTALIR;
    const FAT_TOTALIR_Name = 'FAT_TOTALIR';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALCSLL', ftBCD)]
    [Dictionary('FAT_TOTALCSLL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALCSLL: Double read FFAT_TOTALCSLL write FFAT_TOTALCSLL;
    const FAT_TOTALCSLL_Name = 'FAT_TOTALCSLL';

    [Restrictions([NoValidate])]
    [Column('FAT_ISSRETIDO', ftString, 1)]
    [Dictionary('FAT_ISSRETIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_ISSRETIDO: String read FFAT_ISSRETIDO write FFAT_ISSRETIDO;
    const FAT_ISSRETIDO_Name = 'FAT_ISSRETIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROOC', ftInteger)]
    [Dictionary('FAT_NUMEROOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROOC: Integer read FFAT_NUMEROOC write FFAT_NUMEROOC;
    const FAT_NUMEROOC_Name = 'FAT_NUMEROOC';

    [Restrictions([NoValidate])]
    [Column('FAT_STATUS', ftString, 1)]
    [Dictionary('FAT_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_STATUS: String read FFAT_STATUS write FFAT_STATUS;
    const FAT_STATUS_Name = 'FAT_STATUS';

    [Restrictions([NoValidate])]
    [Column('FAT_IDSUNIFICADOS', ftString, 1000)]
    [Dictionary('FAT_IDSUNIFICADOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_IDSUNIFICADOS: String read FFAT_IDSUNIFICADOS write FFAT_IDSUNIFICADOS;
    const FAT_IDSUNIFICADOS_Name = 'FAT_IDSUNIFICADOS';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROLICITACAO', ftString, 20)]
    [Dictionary('FAT_NUMEROLICITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROLICITACAO: String read FFAT_NUMEROLICITACAO write FFAT_NUMEROLICITACAO;
    const FAT_NUMEROLICITACAO_Name = 'FAT_NUMEROLICITACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00)

end.
