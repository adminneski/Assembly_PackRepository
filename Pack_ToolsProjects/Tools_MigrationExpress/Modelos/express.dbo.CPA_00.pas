unit express.dbo.CPA_00;

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
  [Table('CPA_00', '')]
  [PrimaryKey('CPA_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPA_ID')]
  TDtoCPA_00 = class
  private
    { Private declarations } 
    FCPA_ID: Integer;
    FCOM_CODIGO: Integer;
    FCPA_DC: String;
    FCPA_STATUS: String;
    FBCO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FCPA_CARTAFRETE: String;
    FCPA_COMPETENCIA: String;
    FCPA_NUMERODOCTO: String;
    FCPA_TIPODOCUMENTO: String;
    FCPA_DATALANCAMENTO: TDateTime;
    FCPA_DATAEMISSAO: TDateTime;
    FCPA_DATAVENCTO: TDateTime;
    FCPA_TOTALNOTAFISCAL: Double;
    FCPA_TOTALVALOR: Double;
    FCPA_NOTAFISCAL: String;
    FCPA_ORDEMPARCIAL: Integer;
    FBCO_CODIGOBAIXA: Integer;
    FCTA_CODIGOBAIXA: Integer;
    FCPA_DATABAIXA: TDateTime;
    FCPA_TIPOBAIXA: String;
    FCPA_TOTALVALORBAIXA: Double;
    FCPA_DATAULTIMOPAGTO: TDateTime;
    FCPA_DATAEMISSAOORIGINAL: TDateTime;
    FCPA_DATAVENCTOORIGINAL: TDateTime;
    FCPA_TOTALVALORORIGINAL: Double;
    FCPA_TOTALJUROS: Double;
    FCPA_TOTALDESCTO: Double;
    FCPA_TOTALMULTA: Double;
    FCPA_TOTALOUTRASDESPESAS: Double;
    FCPA_VALORMULTA: Double;
    FCPA_VALORDESCTO: Double;
    FCPA_VALORMORADIARIA: Double;
    FCPA_PERCENTUALDESCTO: Double;
    FCPA_PERCENTUALMULTA: Double;
    FCPA_PERCENTUALMORADIARIA: Double;
    FCPA_DATADESCTO: TDateTime;
    FCPA_DATAMULTA: TDateTime;
    FCPA_PLANOCONTARATEIO: Double;
    FCPA_CHEQUEVINCULADO: String;
    FCPA_TIPOCHEQUEVINCULADO: String;
    FCPA_TOTALCHEQUEVINCULADO: Double;
    FCPA_OBSERVACAO: String;
    FCPA_HISTORICO: String;
    FCPA_DESATIVADO: String;
    FCPA_INTEGRACAO: String;
    FCPA_DATAALTERACAO: TDateTime;
    FCPA_ID_OLD: Integer;
    FCPA_INTEGRACAO_OLD: String;
    FCPA_IDCREDITO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CPA_00';
     const PrimaryKey = 'CPA_ID';
     const Sequence   = 'SEQ_CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPA_DC', ftString, 1)]
    [Dictionary('CPA_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DC: String read FCPA_DC write FCPA_DC;
    const CPA_DC_Name = 'CPA_DC';

    [Restrictions([NoValidate])]
    [Column('CPA_STATUS', ftString, 1)]
    [Dictionary('CPA_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_STATUS: String read FCPA_STATUS write FCPA_STATUS;
    const CPA_STATUS_Name = 'CPA_STATUS';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPA_CARTAFRETE', ftString, 6)]
    [Dictionary('CPA_CARTAFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_CARTAFRETE: String read FCPA_CARTAFRETE write FCPA_CARTAFRETE;
    const CPA_CARTAFRETE_Name = 'CPA_CARTAFRETE';

    [Restrictions([NoValidate])]
    [Column('CPA_COMPETENCIA', ftString, 6)]
    [Dictionary('CPA_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_COMPETENCIA: String read FCPA_COMPETENCIA write FCPA_COMPETENCIA;
    const CPA_COMPETENCIA_Name = 'CPA_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('CPA_NUMERODOCTO', ftString, 20)]
    [Dictionary('CPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NUMERODOCTO: String read FCPA_NUMERODOCTO write FCPA_NUMERODOCTO;
    const CPA_NUMERODOCTO_Name = 'CPA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPODOCUMENTO', ftString, 1)]
    [Dictionary('CPA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPODOCUMENTO: String read FCPA_TIPODOCUMENTO write FCPA_TIPODOCUMENTO;
    const CPA_TIPODOCUMENTO_Name = 'CPA_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CPA_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATALANCAMENTO: TDateTime read FCPA_DATALANCAMENTO write FCPA_DATALANCAMENTO;
    const CPA_DATALANCAMENTO_Name = 'CPA_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAEMISSAO', ftDateTime)]
    [Dictionary('CPA_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAEMISSAO: TDateTime read FCPA_DATAEMISSAO write FCPA_DATAEMISSAO;
    const CPA_DATAEMISSAO_Name = 'CPA_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAVENCTO', ftDateTime)]
    [Dictionary('CPA_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAVENCTO: TDateTime read FCPA_DATAVENCTO write FCPA_DATAVENCTO;
    const CPA_DATAVENCTO_Name = 'CPA_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CPA_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALNOTAFISCAL: Double read FCPA_TOTALNOTAFISCAL write FCPA_TOTALNOTAFISCAL;
    const CPA_TOTALNOTAFISCAL_Name = 'CPA_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALOR', ftBCD)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('CPA_NOTAFISCAL', ftString, 9)]
    [Dictionary('CPA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NOTAFISCAL: String read FCPA_NOTAFISCAL write FCPA_NOTAFISCAL;
    const CPA_NOTAFISCAL_Name = 'CPA_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPA_ORDEMPARCIAL', ftInteger)]
    [Dictionary('CPA_ORDEMPARCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ORDEMPARCIAL: Integer read FCPA_ORDEMPARCIAL write FCPA_ORDEMPARCIAL;
    const CPA_ORDEMPARCIAL_Name = 'CPA_ORDEMPARCIAL';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGOBAIXA', ftInteger)]
    [Dictionary('BCO_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGOBAIXA: Integer read FBCO_CODIGOBAIXA write FBCO_CODIGOBAIXA;
    const BCO_CODIGOBAIXA_Name = 'BCO_CODIGOBAIXA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_DATABAIXA', ftDateTime)]
    [Dictionary('CPA_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATABAIXA: TDateTime read FCPA_DATABAIXA write FCPA_DATABAIXA;
    const CPA_DATABAIXA_Name = 'CPA_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPOBAIXA', ftString, 1)]
    [Dictionary('CPA_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPOBAIXA: String read FCPA_TIPOBAIXA write FCPA_TIPOBAIXA;
    const CPA_TIPOBAIXA_Name = 'CPA_TIPOBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CPA_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORBAIXA: Double read FCPA_TOTALVALORBAIXA write FCPA_TOTALVALORBAIXA;
    const CPA_TOTALVALORBAIXA_Name = 'CPA_TOTALVALORBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAULTIMOPAGTO', ftDateTime)]
    [Dictionary('CPA_DATAULTIMOPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAULTIMOPAGTO: TDateTime read FCPA_DATAULTIMOPAGTO write FCPA_DATAULTIMOPAGTO;
    const CPA_DATAULTIMOPAGTO_Name = 'CPA_DATAULTIMOPAGTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAEMISSAOORIGINAL', ftDateTime)]
    [Dictionary('CPA_DATAEMISSAOORIGINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAEMISSAOORIGINAL: TDateTime read FCPA_DATAEMISSAOORIGINAL write FCPA_DATAEMISSAOORIGINAL;
    const CPA_DATAEMISSAOORIGINAL_Name = 'CPA_DATAEMISSAOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAVENCTOORIGINAL', ftDateTime)]
    [Dictionary('CPA_DATAVENCTOORIGINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAVENCTOORIGINAL: TDateTime read FCPA_DATAVENCTOORIGINAL write FCPA_DATAVENCTOORIGINAL;
    const CPA_DATAVENCTOORIGINAL_Name = 'CPA_DATAVENCTOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALORORIGINAL', ftBCD)]
    [Dictionary('CPA_TOTALVALORORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORORIGINAL: Double read FCPA_TOTALVALORORIGINAL write FCPA_TOTALVALORORIGINAL;
    const CPA_TOTALVALORORIGINAL_Name = 'CPA_TOTALVALORORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALJUROS', ftBCD)]
    [Dictionary('CPA_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROS: Double read FCPA_TOTALJUROS write FCPA_TOTALJUROS;
    const CPA_TOTALJUROS_Name = 'CPA_TOTALJUROS';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALDESCTO', ftBCD)]
    [Dictionary('CPA_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTO: Double read FCPA_TOTALDESCTO write FCPA_TOTALDESCTO;
    const CPA_TOTALDESCTO_Name = 'CPA_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALMULTA', ftBCD)]
    [Dictionary('CPA_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALMULTA: Double read FCPA_TOTALMULTA write FCPA_TOTALMULTA;
    const CPA_TOTALMULTA_Name = 'CPA_TOTALMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CPA_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESAS: Double read FCPA_TOTALOUTRASDESPESAS write FCPA_TOTALOUTRASDESPESAS;
    const CPA_TOTALOUTRASDESPESAS_Name = 'CPA_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORMULTA', ftBCD)]
    [Dictionary('CPA_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORMULTA: Double read FCPA_VALORMULTA write FCPA_VALORMULTA;
    const CPA_VALORMULTA_Name = 'CPA_VALORMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORDESCTO', ftBCD)]
    [Dictionary('CPA_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORDESCTO: Double read FCPA_VALORDESCTO write FCPA_VALORDESCTO;
    const CPA_VALORDESCTO_Name = 'CPA_VALORDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORMORADIARIA', ftBCD)]
    [Dictionary('CPA_VALORMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORMORADIARIA: Double read FCPA_VALORMORADIARIA write FCPA_VALORMORADIARIA;
    const CPA_VALORMORADIARIA_Name = 'CPA_VALORMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CPA_PERCENTUALDESCTO', ftBCD)]
    [Dictionary('CPA_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALDESCTO: Double read FCPA_PERCENTUALDESCTO write FCPA_PERCENTUALDESCTO;
    const CPA_PERCENTUALDESCTO_Name = 'CPA_PERCENTUALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_PERCENTUALMULTA', ftBCD)]
    [Dictionary('CPA_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALMULTA: Double read FCPA_PERCENTUALMULTA write FCPA_PERCENTUALMULTA;
    const CPA_PERCENTUALMULTA_Name = 'CPA_PERCENTUALMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_PERCENTUALMORADIARIA', ftBCD)]
    [Dictionary('CPA_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALMORADIARIA: Double read FCPA_PERCENTUALMORADIARIA write FCPA_PERCENTUALMORADIARIA;
    const CPA_PERCENTUALMORADIARIA_Name = 'CPA_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CPA_DATADESCTO', ftDateTime)]
    [Dictionary('CPA_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATADESCTO: TDateTime read FCPA_DATADESCTO write FCPA_DATADESCTO;
    const CPA_DATADESCTO_Name = 'CPA_DATADESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAMULTA', ftDateTime)]
    [Dictionary('CPA_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAMULTA: TDateTime read FCPA_DATAMULTA write FCPA_DATAMULTA;
    const CPA_DATAMULTA_Name = 'CPA_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('CPA_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PLANOCONTARATEIO: Double read FCPA_PLANOCONTARATEIO write FCPA_PLANOCONTARATEIO;
    const CPA_PLANOCONTARATEIO_Name = 'CPA_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CPA_CHEQUEVINCULADO', ftString, 1)]
    [Dictionary('CPA_CHEQUEVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_CHEQUEVINCULADO: String read FCPA_CHEQUEVINCULADO write FCPA_CHEQUEVINCULADO;
    const CPA_CHEQUEVINCULADO_Name = 'CPA_CHEQUEVINCULADO';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPOCHEQUEVINCULADO', ftString, 3)]
    [Dictionary('CPA_TIPOCHEQUEVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPOCHEQUEVINCULADO: String read FCPA_TIPOCHEQUEVINCULADO write FCPA_TIPOCHEQUEVINCULADO;
    const CPA_TIPOCHEQUEVINCULADO_Name = 'CPA_TIPOCHEQUEVINCULADO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALCHEQUEVINCULADO', ftBCD)]
    [Dictionary('CPA_TOTALCHEQUEVINCULADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALCHEQUEVINCULADO: Double read FCPA_TOTALCHEQUEVINCULADO write FCPA_TOTALCHEQUEVINCULADO;
    const CPA_TOTALCHEQUEVINCULADO_Name = 'CPA_TOTALCHEQUEVINCULADO';

    [Restrictions([NoValidate])]
    [Column('CPA_OBSERVACAO', ftString, 300)]
    [Dictionary('CPA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_OBSERVACAO: String read FCPA_OBSERVACAO write FCPA_OBSERVACAO;
    const CPA_OBSERVACAO_Name = 'CPA_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_HISTORICO', ftString, 300)]
    [Dictionary('CPA_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_HISTORICO: String read FCPA_HISTORICO write FCPA_HISTORICO;
    const CPA_HISTORICO_Name = 'CPA_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CPA_DESATIVADO', ftString, 1)]
    [Dictionary('CPA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DESATIVADO: String read FCPA_DESATIVADO write FCPA_DESATIVADO;
    const CPA_DESATIVADO_Name = 'CPA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CPA_INTEGRACAO', ftString, 20)]
    [Dictionary('CPA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_INTEGRACAO: String read FCPA_INTEGRACAO write FCPA_INTEGRACAO;
    const CPA_INTEGRACAO_Name = 'CPA_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPA_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAALTERACAO: TDateTime read FCPA_DATAALTERACAO write FCPA_DATAALTERACAO;
    const CPA_DATAALTERACAO_Name = 'CPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_ID_OLD', ftInteger)]
    [Dictionary('CPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID_OLD: Integer read FCPA_ID_OLD write FCPA_ID_OLD;
    const CPA_ID_OLD_Name = 'CPA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('CPA_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_INTEGRACAO_OLD: String read FCPA_INTEGRACAO_OLD write FCPA_INTEGRACAO_OLD;
    const CPA_INTEGRACAO_OLD_Name = 'CPA_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_IDCREDITO', ftInteger)]
    [Dictionary('CPA_IDCREDITO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_IDCREDITO: Integer read FCPA_IDCREDITO write FCPA_IDCREDITO;
    const CPA_IDCREDITO_Name = 'CPA_IDCREDITO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPA_00)

end.
