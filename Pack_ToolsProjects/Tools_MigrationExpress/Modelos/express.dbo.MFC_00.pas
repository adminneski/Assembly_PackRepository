unit express.dbo.MFC_00;

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
  [Table('MFC_00', '')]
  [PrimaryKey('MFC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MFC_ID')]
  TDtoMFC_00 = class
  private
    { Private declarations } 
    FMFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_DATASAIDA: TDateTime;
    FMFC_SERIE: String;
    FMFC_SUBSERIE: String;
    FMNF_CODIGO: String;
    FMFC_STATUSMDFE: String;
    FMFC_NOTAFISCAL: String;
    FMFC_NUMEROCIOT: String;
    FMFC_DATARETORNO: TDateTime;
    FMFC_NUMERODOCTO: String;
    FVEI_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FMFC_UFORIGEM: String;
    FMFC_UFDESTINO: String;
    FMFC_TOTALQTDNOTAFISCAL: Integer;
    FMFC_TOTALQTDCONHECIMENTO: Integer;
    FMFC_TOTALKM: Double;
    FMFC_TOTALFRETECIF: Double;
    FMFC_TOTALFRETEFOB: Double;
    FMFC_TOTALFRETETRP: Double;
    FMFC_TOTALFRETEOUTROS: Double;
    FMFC_TOTALADIANTAMENTO: Double;
    FMFC_TOTALNFCONHECIMENTO: Double;
    FMFC_TOTALNFLIVROFISCAL: Double;
    FMFC_TOTALNOTAFISCAL: Double;
    FMFC_TOTALPESOBRUTOCTR: Double;
    FMFC_TOTALPESOBRUTONF: Double;
    FMFC_PLANOCONTARATEIO: Double;
    FMFC_RESPONSAVELSEGURO: String;
    FMFC_CNPJCPF_RESPONSAVELSEGURO: String;
    FMFC_CHAVEACESSO: String;
    FMFC_OBSERVACAO: String;
    FMFC_PROCESSADO: String;
    FMFC_CANCELADO: String;
    FMFC_DATACANCELAMENTO: TDateTime;
    FMFC_OBSERVACAOCANCELAMENTO: String;
    FMFC_DATAALTERACAO: TDateTime;
    FMFC_AVERBADO: String;
    FMFC_DATAAVERBACAO: TDateTime;
    FMFC_HORAAVERBACAO: String;
    FMFC_PROTOCOLOAVERBACAO: String;
    FMFC_ID_OLD: Integer;
    FMFC_TIPOPRODUTO: String;
    FMFC_TIPOCARGA: String;
    FMFC_LATITUDECARREGA: Double;
    FMFC_LONGITUDECARREGA: Double;
    FMFC_LATITUDEDESCARREGA: Double;
    FMFC_LONGITUDEDESCARREGA: Double;
    FMFC_TIPOVIAGEM: String;
    FMFC_TIPOEMBALAGEM: String;
    FMFC_TIPOPAGAMENTO: String;
    FBCO_CODIGOPAGTO: String;
    FMFC_AGENCIAPAGTO: String;
    FMFC_CONTAPAGTO: String;
    FMFC_TIPOCONTAPAGTO: String;
    FMFC_DATALIBERACAOPAGTO: TDateTime;
    FMFC_OBSTRANSPORTADOR: String;
    FMFC_OBSCREDENCIADO: String;
    FMFC_PROTOCOLOCIOT: String;
    FMFC_STATUSCIOT: String;
    FPES_FORNECEDORVALEPEDAGIO: String;
    FMFC_NUMEROCOMPRAVALEPEDAGIO: String;
    FMFC_VALORVALEPEDAGIO: Double;
    FMFC_IDPAGAMENTOCIOT: Integer;
    FMFC_CATEGORIAPAGAMENTOCIOT: String;
    FMFC_TIPOEMITENTEMDFE: String;
    FPES_PAGADORVALEPEDAGIO: String;
    FMFC_CATEGORIACOMBVEICULAR: String;
    FPRO_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MFC_00';
     const PrimaryKey = 'MFC_ID';
     const Sequence   = 'SEQ_MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATASAIDA', ftDateTime)]
    [Dictionary('MFC_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATASAIDA: TDateTime read FMFC_DATASAIDA write FMFC_DATASAIDA;
    const MFC_DATASAIDA_Name = 'MFC_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('MFC_SERIE', ftString, 3)]
    [Dictionary('MFC_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SERIE: String read FMFC_SERIE write FMFC_SERIE;
    const MFC_SERIE_Name = 'MFC_SERIE';

    [Restrictions([NoValidate])]
    [Column('MFC_SUBSERIE', ftString, 2)]
    [Dictionary('MFC_SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_SUBSERIE: String read FMFC_SUBSERIE write FMFC_SUBSERIE;
    const MFC_SUBSERIE_Name = 'MFC_SUBSERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MFC_STATUSMDFE', ftString, 1)]
    [Dictionary('MFC_STATUSMDFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_STATUSMDFE: String read FMFC_STATUSMDFE write FMFC_STATUSMDFE;
    const MFC_STATUSMDFE_Name = 'MFC_STATUSMDFE';

    [Restrictions([NoValidate])]
    [Column('MFC_NOTAFISCAL', ftString, 9)]
    [Dictionary('MFC_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NOTAFISCAL: String read FMFC_NOTAFISCAL write FMFC_NOTAFISCAL;
    const MFC_NOTAFISCAL_Name = 'MFC_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMEROCIOT', ftString, 16)]
    [Dictionary('MFC_NUMEROCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMEROCIOT: String read FMFC_NUMEROCIOT write FMFC_NUMEROCIOT;
    const MFC_NUMEROCIOT_Name = 'MFC_NUMEROCIOT';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATARETORNO', ftDateTime)]
    [Dictionary('MFC_DATARETORNO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATARETORNO: TDateTime read FMFC_DATARETORNO write FMFC_DATARETORNO;
    const MFC_DATARETORNO_Name = 'MFC_DATARETORNO';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMERODOCTO', ftString, 6)]
    [Dictionary('MFC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMERODOCTO: String read FMFC_NUMERODOCTO write FMFC_NUMERODOCTO;
    const MFC_NUMERODOCTO_Name = 'MFC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MFC_UFORIGEM', ftString, 2)]
    [Dictionary('MFC_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_UFORIGEM: String read FMFC_UFORIGEM write FMFC_UFORIGEM;
    const MFC_UFORIGEM_Name = 'MFC_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('MFC_UFDESTINO', ftString, 2)]
    [Dictionary('MFC_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_UFDESTINO: String read FMFC_UFDESTINO write FMFC_UFDESTINO;
    const MFC_UFDESTINO_Name = 'MFC_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('MFC_TOTALQTDNOTAFISCAL', ftInteger)]
    [Dictionary('MFC_TOTALQTDNOTAFISCAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_TOTALQTDNOTAFISCAL: Integer read FMFC_TOTALQTDNOTAFISCAL write FMFC_TOTALQTDNOTAFISCAL;
    const MFC_TOTALQTDNOTAFISCAL_Name = 'MFC_TOTALQTDNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MFC_TOTALQTDCONHECIMENTO', ftInteger)]
    [Dictionary('MFC_TOTALQTDCONHECIMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_TOTALQTDCONHECIMENTO: Integer read FMFC_TOTALQTDCONHECIMENTO write FMFC_TOTALQTDCONHECIMENTO;
    const MFC_TOTALQTDCONHECIMENTO_Name = 'MFC_TOTALQTDCONHECIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALKM', ftBCD)]
    [Dictionary('MFC_TOTALKM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALKM: Double read FMFC_TOTALKM write FMFC_TOTALKM;
    const MFC_TOTALKM_Name = 'MFC_TOTALKM';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALFRETECIF', ftBCD)]
    [Dictionary('MFC_TOTALFRETECIF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALFRETECIF: Double read FMFC_TOTALFRETECIF write FMFC_TOTALFRETECIF;
    const MFC_TOTALFRETECIF_Name = 'MFC_TOTALFRETECIF';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALFRETEFOB', ftBCD)]
    [Dictionary('MFC_TOTALFRETEFOB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALFRETEFOB: Double read FMFC_TOTALFRETEFOB write FMFC_TOTALFRETEFOB;
    const MFC_TOTALFRETEFOB_Name = 'MFC_TOTALFRETEFOB';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALFRETETRP', ftBCD)]
    [Dictionary('MFC_TOTALFRETETRP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALFRETETRP: Double read FMFC_TOTALFRETETRP write FMFC_TOTALFRETETRP;
    const MFC_TOTALFRETETRP_Name = 'MFC_TOTALFRETETRP';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALFRETEOUTROS', ftBCD)]
    [Dictionary('MFC_TOTALFRETEOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALFRETEOUTROS: Double read FMFC_TOTALFRETEOUTROS write FMFC_TOTALFRETEOUTROS;
    const MFC_TOTALFRETEOUTROS_Name = 'MFC_TOTALFRETEOUTROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALADIANTAMENTO', ftBCD)]
    [Dictionary('MFC_TOTALADIANTAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALADIANTAMENTO: Double read FMFC_TOTALADIANTAMENTO write FMFC_TOTALADIANTAMENTO;
    const MFC_TOTALADIANTAMENTO_Name = 'MFC_TOTALADIANTAMENTO';

    [Restrictions([NoValidate])]
    [Column('MFC_TOTALNFCONHECIMENTO', ftBCD)]
    [Dictionary('MFC_TOTALNFCONHECIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALNFCONHECIMENTO: Double read FMFC_TOTALNFCONHECIMENTO write FMFC_TOTALNFCONHECIMENTO;
    const MFC_TOTALNFCONHECIMENTO_Name = 'MFC_TOTALNFCONHECIMENTO';

    [Restrictions([NoValidate])]
    [Column('MFC_TOTALNFLIVROFISCAL', ftBCD)]
    [Dictionary('MFC_TOTALNFLIVROFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALNFLIVROFISCAL: Double read FMFC_TOTALNFLIVROFISCAL write FMFC_TOTALNFLIVROFISCAL;
    const MFC_TOTALNFLIVROFISCAL_Name = 'MFC_TOTALNFLIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('MFC_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALNOTAFISCAL: Double read FMFC_TOTALNOTAFISCAL write FMFC_TOTALNOTAFISCAL;
    const MFC_TOTALNOTAFISCAL_Name = 'MFC_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MFC_TOTALPESOBRUTOCTR', ftBCD)]
    [Dictionary('MFC_TOTALPESOBRUTOCTR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALPESOBRUTOCTR: Double read FMFC_TOTALPESOBRUTOCTR write FMFC_TOTALPESOBRUTOCTR;
    const MFC_TOTALPESOBRUTOCTR_Name = 'MFC_TOTALPESOBRUTOCTR';

    [Restrictions([NoValidate])]
    [Column('MFC_TOTALPESOBRUTONF', ftBCD)]
    [Dictionary('MFC_TOTALPESOBRUTONF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALPESOBRUTONF: Double read FMFC_TOTALPESOBRUTONF write FMFC_TOTALPESOBRUTONF;
    const MFC_TOTALPESOBRUTONF_Name = 'MFC_TOTALPESOBRUTONF';

    [Restrictions([NoValidate])]
    [Column('MFC_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('MFC_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_PLANOCONTARATEIO: Double read FMFC_PLANOCONTARATEIO write FMFC_PLANOCONTARATEIO;
    const MFC_PLANOCONTARATEIO_Name = 'MFC_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('MFC_RESPONSAVELSEGURO', ftString, 1)]
    [Dictionary('MFC_RESPONSAVELSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_RESPONSAVELSEGURO: String read FMFC_RESPONSAVELSEGURO write FMFC_RESPONSAVELSEGURO;
    const MFC_RESPONSAVELSEGURO_Name = 'MFC_RESPONSAVELSEGURO';

    [Restrictions([NoValidate])]
    [Column('MFC_CNPJCPF_RESPONSAVELSEGURO', ftString, 14)]
    [Dictionary('MFC_CNPJCPF_RESPONSAVELSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CNPJCPF_RESPONSAVELSEGURO: String read FMFC_CNPJCPF_RESPONSAVELSEGURO write FMFC_CNPJCPF_RESPONSAVELSEGURO;
    const MFC_CNPJCPF_RESPONSAVELSEGURO_Name = 'MFC_CNPJCPF_RESPONSAVELSEGURO';

    [Restrictions([NoValidate])]
    [Column('MFC_CHAVEACESSO', ftString, 44)]
    [Dictionary('MFC_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CHAVEACESSO: String read FMFC_CHAVEACESSO write FMFC_CHAVEACESSO;
    const MFC_CHAVEACESSO_Name = 'MFC_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('MFC_OBSERVACAO', ftString, 300)]
    [Dictionary('MFC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_OBSERVACAO: String read FMFC_OBSERVACAO write FMFC_OBSERVACAO;
    const MFC_OBSERVACAO_Name = 'MFC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROCESSADO', ftString, 1)]
    [Dictionary('MFC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROCESSADO: String read FMFC_PROCESSADO write FMFC_PROCESSADO;
    const MFC_PROCESSADO_Name = 'MFC_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('MFC_CANCELADO', ftString, 1)]
    [Dictionary('MFC_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CANCELADO: String read FMFC_CANCELADO write FMFC_CANCELADO;
    const MFC_CANCELADO_Name = 'MFC_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('MFC_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('MFC_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property MFC_DATACANCELAMENTO: TDateTime read FMFC_DATACANCELAMENTO write FMFC_DATACANCELAMENTO;
    const MFC_DATACANCELAMENTO_Name = 'MFC_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('MFC_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('MFC_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_OBSERVACAOCANCELAMENTO: String read FMFC_OBSERVACAOCANCELAMENTO write FMFC_OBSERVACAOCANCELAMENTO;
    const MFC_OBSERVACAOCANCELAMENTO_Name = 'MFC_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('MFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATAALTERACAO: TDateTime read FMFC_DATAALTERACAO write FMFC_DATAALTERACAO;
    const MFC_DATAALTERACAO_Name = 'MFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_AVERBADO', ftString, 1)]
    [Dictionary('MFC_AVERBADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_AVERBADO: String read FMFC_AVERBADO write FMFC_AVERBADO;
    const MFC_AVERBADO_Name = 'MFC_AVERBADO';

    [Restrictions([NoValidate])]
    [Column('MFC_DATAAVERBACAO', ftDateTime)]
    [Dictionary('MFC_DATAAVERBACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property MFC_DATAAVERBACAO: TDateTime read FMFC_DATAAVERBACAO write FMFC_DATAAVERBACAO;
    const MFC_DATAAVERBACAO_Name = 'MFC_DATAAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_HORAAVERBACAO', ftString, 8)]
    [Dictionary('MFC_HORAAVERBACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_HORAAVERBACAO: String read FMFC_HORAAVERBACAO write FMFC_HORAAVERBACAO;
    const MFC_HORAAVERBACAO_Name = 'MFC_HORAAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROTOCOLOAVERBACAO', ftString, 40)]
    [Dictionary('MFC_PROTOCOLOAVERBACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROTOCOLOAVERBACAO: String read FMFC_PROTOCOLOAVERBACAO write FMFC_PROTOCOLOAVERBACAO;
    const MFC_PROTOCOLOAVERBACAO_Name = 'MFC_PROTOCOLOAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_ID_OLD', ftInteger)]
    [Dictionary('MFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID_OLD: Integer read FMFC_ID_OLD write FMFC_ID_OLD;
    const MFC_ID_OLD_Name = 'MFC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOPRODUTO', ftString, 2)]
    [Dictionary('MFC_TIPOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOPRODUTO: String read FMFC_TIPOPRODUTO write FMFC_TIPOPRODUTO;
    const MFC_TIPOPRODUTO_Name = 'MFC_TIPOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOCARGA', ftString, 1)]
    [Dictionary('MFC_TIPOCARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOCARGA: String read FMFC_TIPOCARGA write FMFC_TIPOCARGA;
    const MFC_TIPOCARGA_Name = 'MFC_TIPOCARGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LATITUDECARREGA', ftBCD)]
    [Dictionary('MFC_LATITUDECARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LATITUDECARREGA: Double read FMFC_LATITUDECARREGA write FMFC_LATITUDECARREGA;
    const MFC_LATITUDECARREGA_Name = 'MFC_LATITUDECARREGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LONGITUDECARREGA', ftBCD)]
    [Dictionary('MFC_LONGITUDECARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LONGITUDECARREGA: Double read FMFC_LONGITUDECARREGA write FMFC_LONGITUDECARREGA;
    const MFC_LONGITUDECARREGA_Name = 'MFC_LONGITUDECARREGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LATITUDEDESCARREGA', ftBCD)]
    [Dictionary('MFC_LATITUDEDESCARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LATITUDEDESCARREGA: Double read FMFC_LATITUDEDESCARREGA write FMFC_LATITUDEDESCARREGA;
    const MFC_LATITUDEDESCARREGA_Name = 'MFC_LATITUDEDESCARREGA';

    [Restrictions([NoValidate])]
    [Column('MFC_LONGITUDEDESCARREGA', ftBCD)]
    [Dictionary('MFC_LONGITUDEDESCARREGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_LONGITUDEDESCARREGA: Double read FMFC_LONGITUDEDESCARREGA write FMFC_LONGITUDEDESCARREGA;
    const MFC_LONGITUDEDESCARREGA_Name = 'MFC_LONGITUDEDESCARREGA';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOVIAGEM', ftString, 1)]
    [Dictionary('MFC_TIPOVIAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOVIAGEM: String read FMFC_TIPOVIAGEM write FMFC_TIPOVIAGEM;
    const MFC_TIPOVIAGEM_Name = 'MFC_TIPOVIAGEM';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOEMBALAGEM', ftString, 1)]
    [Dictionary('MFC_TIPOEMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOEMBALAGEM: String read FMFC_TIPOEMBALAGEM write FMFC_TIPOEMBALAGEM;
    const MFC_TIPOEMBALAGEM_Name = 'MFC_TIPOEMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOPAGAMENTO', ftString, 1)]
    [Dictionary('MFC_TIPOPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOPAGAMENTO: String read FMFC_TIPOPAGAMENTO write FMFC_TIPOPAGAMENTO;
    const MFC_TIPOPAGAMENTO_Name = 'MFC_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGOPAGTO', ftString, 3)]
    [Dictionary('BCO_CODIGOPAGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_CODIGOPAGTO: String read FBCO_CODIGOPAGTO write FBCO_CODIGOPAGTO;
    const BCO_CODIGOPAGTO_Name = 'BCO_CODIGOPAGTO';

    [Restrictions([NoValidate])]
    [Column('MFC_AGENCIAPAGTO', ftString, 10)]
    [Dictionary('MFC_AGENCIAPAGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_AGENCIAPAGTO: String read FMFC_AGENCIAPAGTO write FMFC_AGENCIAPAGTO;
    const MFC_AGENCIAPAGTO_Name = 'MFC_AGENCIAPAGTO';

    [Restrictions([NoValidate])]
    [Column('MFC_CONTAPAGTO', ftString, 15)]
    [Dictionary('MFC_CONTAPAGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CONTAPAGTO: String read FMFC_CONTAPAGTO write FMFC_CONTAPAGTO;
    const MFC_CONTAPAGTO_Name = 'MFC_CONTAPAGTO';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOCONTAPAGTO', ftString, 1)]
    [Dictionary('MFC_TIPOCONTAPAGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOCONTAPAGTO: String read FMFC_TIPOCONTAPAGTO write FMFC_TIPOCONTAPAGTO;
    const MFC_TIPOCONTAPAGTO_Name = 'MFC_TIPOCONTAPAGTO';

    [Restrictions([NoValidate])]
    [Column('MFC_DATALIBERACAOPAGTO', ftDateTime)]
    [Dictionary('MFC_DATALIBERACAOPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property MFC_DATALIBERACAOPAGTO: TDateTime read FMFC_DATALIBERACAOPAGTO write FMFC_DATALIBERACAOPAGTO;
    const MFC_DATALIBERACAOPAGTO_Name = 'MFC_DATALIBERACAOPAGTO';

    [Restrictions([NoValidate])]
    [Column('MFC_OBSTRANSPORTADOR', ftString, 1000)]
    [Dictionary('MFC_OBSTRANSPORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_OBSTRANSPORTADOR: String read FMFC_OBSTRANSPORTADOR write FMFC_OBSTRANSPORTADOR;
    const MFC_OBSTRANSPORTADOR_Name = 'MFC_OBSTRANSPORTADOR';

    [Restrictions([NoValidate])]
    [Column('MFC_OBSCREDENCIADO', ftString, 1000)]
    [Dictionary('MFC_OBSCREDENCIADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_OBSCREDENCIADO: String read FMFC_OBSCREDENCIADO write FMFC_OBSCREDENCIADO;
    const MFC_OBSCREDENCIADO_Name = 'MFC_OBSCREDENCIADO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROTOCOLOCIOT', ftString, 30)]
    [Dictionary('MFC_PROTOCOLOCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROTOCOLOCIOT: String read FMFC_PROTOCOLOCIOT write FMFC_PROTOCOLOCIOT;
    const MFC_PROTOCOLOCIOT_Name = 'MFC_PROTOCOLOCIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_STATUSCIOT', ftString, 1)]
    [Dictionary('MFC_STATUSCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_STATUSCIOT: String read FMFC_STATUSCIOT write FMFC_STATUSCIOT;
    const MFC_STATUSCIOT_Name = 'MFC_STATUSCIOT';

    [Restrictions([NoValidate])]
    [Column('PES_FORNECEDORVALEPEDAGIO', ftString, 6)]
    [Dictionary('PES_FORNECEDORVALEPEDAGIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FORNECEDORVALEPEDAGIO: String read FPES_FORNECEDORVALEPEDAGIO write FPES_FORNECEDORVALEPEDAGIO;
    const PES_FORNECEDORVALEPEDAGIO_Name = 'PES_FORNECEDORVALEPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMEROCOMPRAVALEPEDAGIO', ftString, 20)]
    [Dictionary('MFC_NUMEROCOMPRAVALEPEDAGIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMEROCOMPRAVALEPEDAGIO: String read FMFC_NUMEROCOMPRAVALEPEDAGIO write FMFC_NUMEROCOMPRAVALEPEDAGIO;
    const MFC_NUMEROCOMPRAVALEPEDAGIO_Name = 'MFC_NUMEROCOMPRAVALEPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('MFC_VALORVALEPEDAGIO', ftBCD)]
    [Dictionary('MFC_VALORVALEPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORVALEPEDAGIO: Double read FMFC_VALORVALEPEDAGIO write FMFC_VALORVALEPEDAGIO;
    const MFC_VALORVALEPEDAGIO_Name = 'MFC_VALORVALEPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('MFC_IDPAGAMENTOCIOT', ftInteger)]
    [Dictionary('MFC_IDPAGAMENTOCIOT', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_IDPAGAMENTOCIOT: Integer read FMFC_IDPAGAMENTOCIOT write FMFC_IDPAGAMENTOCIOT;
    const MFC_IDPAGAMENTOCIOT_Name = 'MFC_IDPAGAMENTOCIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_CATEGORIAPAGAMENTOCIOT', ftString, 1)]
    [Dictionary('MFC_CATEGORIAPAGAMENTOCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CATEGORIAPAGAMENTOCIOT: String read FMFC_CATEGORIAPAGAMENTOCIOT write FMFC_CATEGORIAPAGAMENTOCIOT;
    const MFC_CATEGORIAPAGAMENTOCIOT_Name = 'MFC_CATEGORIAPAGAMENTOCIOT';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOEMITENTEMDFE', ftString, 1)]
    [Dictionary('MFC_TIPOEMITENTEMDFE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOEMITENTEMDFE: String read FMFC_TIPOEMITENTEMDFE write FMFC_TIPOEMITENTEMDFE;
    const MFC_TIPOEMITENTEMDFE_Name = 'MFC_TIPOEMITENTEMDFE';

    [Restrictions([NoValidate])]
    [Column('PES_PAGADORVALEPEDAGIO', ftString, 6)]
    [Dictionary('PES_PAGADORVALEPEDAGIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PAGADORVALEPEDAGIO: String read FPES_PAGADORVALEPEDAGIO write FPES_PAGADORVALEPEDAGIO;
    const PES_PAGADORVALEPEDAGIO_Name = 'PES_PAGADORVALEPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('MFC_CATEGORIACOMBVEICULAR', ftString, 2)]
    [Dictionary('MFC_CATEGORIACOMBVEICULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CATEGORIACOMBVEICULAR: String read FMFC_CATEGORIACOMBVEICULAR write FMFC_CATEGORIACOMBVEICULAR;
    const MFC_CATEGORIACOMBVEICULAR_Name = 'MFC_CATEGORIACOMBVEICULAR';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_00)

end.
