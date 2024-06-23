unit express.dbo.PALM_V01_CRE;

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
  [Table('PALM_V01_CRE', '')]
  TDtoPALM_V01_CRE = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCRE_DC: String;
    FPES_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FPOR_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FCRE_DATABAIXA: TDateTime;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_DATALANCAMENTO: TDateTime;
    FCRE_DATAVENCTOORIGINAL: TDateTime;
    FCRE_DESATIVADO: String;
    FCRE_HISTORICO: String;
    FCRE_INTEGRACAO: String;
    FCRE_NUMERODOCTO: String;
    FCRE_PERCENTUALCOMISSAO: Double;
    FCRE_PRORROGACOES: Integer;
    FCRE_STATUS: String;
    FCRE_TIPODOCUMENTO: String;
    FCRE_TOTALFRETE: Double;
    FCRE_TOTALIPI: Double;
    FCRE_TOTALVALOR: Double;
    FCRE_TOTALVALORBAIXA: Double;
    FCRE_ORDEMPARCIAL: Integer;
    FCRE_DATAEMISSAOORIGINAL: TDateTime;
    FCRE_TOTALVALORORIGINAL: Double;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_TOTALMULTA: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_PERCENTUALDESCTO: Double;
    FCRE_DATADESCTO: TDateTime;
    FCRE_VALORDESCTO: Double;
    FCRE_PERCENTUALMULTA: Double;
    FCRE_DATAMULTA: TDateTime;
    FCRE_VALORMULTA: Double;
    FCRE_PERCENTUALMORADIARIA: Double;
    FCRE_VALORMORADIARIA: Double;
    FCRE_TIPOBAIXA: String;
    FCRE_NOSSONUMERO: String;
    FCRE_LIGARNOVENCTO: String;
    FCRE_PROTESTAR: String;
    FPES_NOME: String;
    FCRE_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_CRE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DC', ftString, 1)]
    [Dictionary('CRE_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DC: String read FCRE_DC write FCRE_DC;
    const CRE_DC_Name = 'CRE_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('POR_CODIGO', ftInteger)]
    [Dictionary('POR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property POR_CODIGO: Integer read FPOR_CODIGO write FPOR_CODIGO;
    const POR_CODIGO_Name = 'POR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATABAIXA', ftDateTime)]
    [Dictionary('CRE_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATABAIXA: TDateTime read FCRE_DATABAIXA write FCRE_DATABAIXA;
    const CRE_DATABAIXA_Name = 'CRE_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAVENCTO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAVENCTO: TDateTime read FCRE_DATAVENCTO write FCRE_DATAVENCTO;
    const CRE_DATAVENCTO_Name = 'CRE_DATAVENCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRE_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAEMISSAO: TDateTime read FCRE_DATAEMISSAO write FCRE_DATAEMISSAO;
    const CRE_DATAEMISSAO_Name = 'CRE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CRE_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATALANCAMENTO: TDateTime read FCRE_DATALANCAMENTO write FCRE_DATALANCAMENTO;
    const CRE_DATALANCAMENTO_Name = 'CRE_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAVENCTOORIGINAL', ftDateTime)]
    [Dictionary('CRE_DATAVENCTOORIGINAL', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAVENCTOORIGINAL: TDateTime read FCRE_DATAVENCTOORIGINAL write FCRE_DATAVENCTOORIGINAL;
    const CRE_DATAVENCTOORIGINAL_Name = 'CRE_DATAVENCTOORIGINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DESATIVADO', ftString, 1)]
    [Dictionary('CRE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESATIVADO: String read FCRE_DESATIVADO write FCRE_DESATIVADO;
    const CRE_DESATIVADO_Name = 'CRE_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CRE_HISTORICO', ftString, 5000)]
    [Dictionary('CRE_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_HISTORICO: String read FCRE_HISTORICO write FCRE_HISTORICO;
    const CRE_HISTORICO_Name = 'CRE_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO', ftString, 50)]
    [Dictionary('CRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO: String read FCRE_INTEGRACAO write FCRE_INTEGRACAO;
    const CRE_INTEGRACAO_Name = 'CRE_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('CRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMERODOCTO: String read FCRE_NUMERODOCTO write FCRE_NUMERODOCTO;
    const CRE_NUMERODOCTO_Name = 'CRE_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALCOMISSAO', ftBCD, 10, 2)]
    [Dictionary('CRE_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALCOMISSAO: Double read FCRE_PERCENTUALCOMISSAO write FCRE_PERCENTUALCOMISSAO;
    const CRE_PERCENTUALCOMISSAO_Name = 'CRE_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PRORROGACOES', ftInteger)]
    [Dictionary('CRE_PRORROGACOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PRORROGACOES: Integer read FCRE_PRORROGACOES write FCRE_PRORROGACOES;
    const CRE_PRORROGACOES_Name = 'CRE_PRORROGACOES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_STATUS', ftString, 1)]
    [Dictionary('CRE_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_STATUS: String read FCRE_STATUS write FCRE_STATUS;
    const CRE_STATUS_Name = 'CRE_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALFRETE', ftBCD)]
    [Dictionary('CRE_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFRETE: Double read FCRE_TOTALFRETE write FCRE_TOTALFRETE;
    const CRE_TOTALFRETE_Name = 'CRE_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALIPI', ftBCD, 48, 2)]
    [Dictionary('CRE_TOTALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALIPI: Double read FCRE_TOTALIPI write FCRE_TOTALIPI;
    const CRE_TOTALIPI_Name = 'CRE_TOTALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CRE_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORBAIXA: Double read FCRE_TOTALVALORBAIXA write FCRE_TOTALVALORBAIXA;
    const CRE_TOTALVALORBAIXA_Name = 'CRE_TOTALVALORBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ORDEMPARCIAL', ftInteger)]
    [Dictionary('CRE_ORDEMPARCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ORDEMPARCIAL: Integer read FCRE_ORDEMPARCIAL write FCRE_ORDEMPARCIAL;
    const CRE_ORDEMPARCIAL_Name = 'CRE_ORDEMPARCIAL';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAEMISSAOORIGINAL', ftDateTime)]
    [Dictionary('CRE_DATAEMISSAOORIGINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAEMISSAOORIGINAL: TDateTime read FCRE_DATAEMISSAOORIGINAL write FCRE_DATAEMISSAOORIGINAL;
    const CRE_DATAEMISSAOORIGINAL_Name = 'CRE_DATAEMISSAOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALVALORORIGINAL', ftBCD)]
    [Dictionary('CRE_TOTALVALORORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORORIGINAL: Double read FCRE_TOTALVALORORIGINAL write FCRE_TOTALVALORORIGINAL;
    const CRE_TOTALVALORORIGINAL_Name = 'CRE_TOTALVALORORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALJUROS', ftBCD)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CRE_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESAS: Double read FCRE_TOTALOUTRASDESPESAS write FCRE_TOTALOUTRASDESPESAS;
    const CRE_TOTALOUTRASDESPESAS_Name = 'CRE_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALDESCTO', ftBCD)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALMULTA', ftBCD)]
    [Dictionary('CRE_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTA: Double read FCRE_TOTALMULTA write FCRE_TOTALMULTA;
    const CRE_TOTALMULTA_Name = 'CRE_TOTALMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALCARTORIO', ftBCD)]
    [Dictionary('CRE_TOTALCARTORIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIO: Double read FCRE_TOTALCARTORIO write FCRE_TOTALCARTORIO;
    const CRE_TOTALCARTORIO_Name = 'CRE_TOTALCARTORIO';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALDESCTO', ftBCD)]
    [Dictionary('CRE_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALDESCTO: Double read FCRE_PERCENTUALDESCTO write FCRE_PERCENTUALDESCTO;
    const CRE_PERCENTUALDESCTO_Name = 'CRE_PERCENTUALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATADESCTO', ftDateTime)]
    [Dictionary('CRE_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATADESCTO: TDateTime read FCRE_DATADESCTO write FCRE_DATADESCTO;
    const CRE_DATADESCTO_Name = 'CRE_DATADESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORDESCTO', ftBCD)]
    [Dictionary('CRE_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORDESCTO: Double read FCRE_VALORDESCTO write FCRE_VALORDESCTO;
    const CRE_VALORDESCTO_Name = 'CRE_VALORDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALMULTA', ftBCD)]
    [Dictionary('CRE_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALMULTA: Double read FCRE_PERCENTUALMULTA write FCRE_PERCENTUALMULTA;
    const CRE_PERCENTUALMULTA_Name = 'CRE_PERCENTUALMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAMULTA', ftDateTime)]
    [Dictionary('CRE_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAMULTA: TDateTime read FCRE_DATAMULTA write FCRE_DATAMULTA;
    const CRE_DATAMULTA_Name = 'CRE_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORMULTA', ftBCD)]
    [Dictionary('CRE_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORMULTA: Double read FCRE_VALORMULTA write FCRE_VALORMULTA;
    const CRE_VALORMULTA_Name = 'CRE_VALORMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_PERCENTUALMORADIARIA', ftBCD)]
    [Dictionary('CRE_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALMORADIARIA: Double read FCRE_PERCENTUALMORADIARIA write FCRE_PERCENTUALMORADIARIA;
    const CRE_PERCENTUALMORADIARIA_Name = 'CRE_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CRE_VALORMORADIARIA', ftBCD)]
    [Dictionary('CRE_VALORMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORMORADIARIA: Double read FCRE_VALORMORADIARIA write FCRE_VALORMORADIARIA;
    const CRE_VALORMORADIARIA_Name = 'CRE_VALORMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CRE_TIPOBAIXA', ftString, 1)]
    [Dictionary('CRE_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPOBAIXA: String read FCRE_TIPOBAIXA write FCRE_TIPOBAIXA;
    const CRE_TIPOBAIXA_Name = 'CRE_TIPOBAIXA';

    [Restrictions([NoValidate])]
    [Column('CRE_NOSSONUMERO', ftString, 20)]
    [Dictionary('CRE_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOSSONUMERO: String read FCRE_NOSSONUMERO write FCRE_NOSSONUMERO;
    const CRE_NOSSONUMERO_Name = 'CRE_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('CRE_LIGARNOVENCTO', ftString, 1)]
    [Dictionary('CRE_LIGARNOVENCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_LIGARNOVENCTO: String read FCRE_LIGARNOVENCTO write FCRE_LIGARNOVENCTO;
    const CRE_LIGARNOVENCTO_Name = 'CRE_LIGARNOVENCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_PROTESTAR', ftString, 1)]
    [Dictionary('CRE_PROTESTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_PROTESTAR: String read FCRE_PROTESTAR write FCRE_PROTESTAR;
    const CRE_PROTESTAR_Name = 'CRE_PROTESTAR';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CRE_OBSERVACAO', ftString, 5000)]
    [Dictionary('CRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSERVACAO: String read FCRE_OBSERVACAO write FCRE_OBSERVACAO;
    const CRE_OBSERVACAO_Name = 'CRE_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_CRE)

end.
