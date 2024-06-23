unit express.dbo.REL_V01_CPA;

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
  [Table('REL_V01_CPA', '')]
  TDtoREL_V01_CPA = class
  private
    { Private declarations } 
    FCPA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCPA_NUMERODOCTO: String;
    FCPA_NOTAFISCAL: String;
    FCPA_ORDEMPARCIAL: Integer;
    FCPA_DATAEMISSAO: TDateTime;
    FCPA_STATUS: String;
    FCPA_DATAVENCTO: TDateTime;
    FCPA_TOTALVALOR: Double;
    FCPA_DATADESCTO: TDateTime;
    FCPA_DATAMULTA: TDateTime;
    FCPA_VALORDESCTO: Double;
    FCPA_PERCENTUALMORADIARIA: Double;
    FCPA_VALORMULTA: Double;
    FCPA_VALORMORADIARIA: Double;
    FCPA_DATABAIXA: TDateTime;
    FCPA_TOTALDESCTO: Double;
    FCPA_TOTALJUROS: Double;
    FCPA_TOTALMULTA: Double;
    FCPA_TOTALVALORBAIXA: Double;
    FCPA_TOTALVALORORIGINAL: Double;
    FCPA_DESATIVADO: String;
    FCPA_OBSERVACAO: String;
    FCPA_TIPODOCUMENTO: String;
    FBCO_CODIGO: Integer;
    FCPA_CHEQUEVINCULADO: String;
    FCTA_CODIGOBAIXA: Integer;
    FBCO_NOME: String;
    FPES_NOME: String;
    FPES_DDD_TELEFONE_1: String;
    FCPA_SIGLATIPODOCUMENTO: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_TIPOPESSOA: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CPA';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPA_NUMERODOCTO', ftString, 20)]
    [Dictionary('CPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NUMERODOCTO: String read FCPA_NUMERODOCTO write FCPA_NUMERODOCTO;
    const CPA_NUMERODOCTO_Name = 'CPA_NUMERODOCTO';

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
    [Column('CPA_DATAEMISSAO', ftDateTime)]
    [Dictionary('CPA_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAEMISSAO: TDateTime read FCPA_DATAEMISSAO write FCPA_DATAEMISSAO;
    const CPA_DATAEMISSAO_Name = 'CPA_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CPA_STATUS', ftString, 1)]
    [Dictionary('CPA_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_STATUS: String read FCPA_STATUS write FCPA_STATUS;
    const CPA_STATUS_Name = 'CPA_STATUS';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAVENCTO', ftDateTime)]
    [Dictionary('CPA_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAVENCTO: TDateTime read FCPA_DATAVENCTO write FCPA_DATAVENCTO;
    const CPA_DATAVENCTO_Name = 'CPA_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALOR', ftBCD)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';

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
    [Column('CPA_VALORDESCTO', ftBCD)]
    [Dictionary('CPA_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORDESCTO: Double read FCPA_VALORDESCTO write FCPA_VALORDESCTO;
    const CPA_VALORDESCTO_Name = 'CPA_VALORDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_PERCENTUALMORADIARIA', ftBCD)]
    [Dictionary('CPA_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALMORADIARIA: Double read FCPA_PERCENTUALMORADIARIA write FCPA_PERCENTUALMORADIARIA;
    const CPA_PERCENTUALMORADIARIA_Name = 'CPA_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORMULTA', ftBCD)]
    [Dictionary('CPA_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORMULTA: Double read FCPA_VALORMULTA write FCPA_VALORMULTA;
    const CPA_VALORMULTA_Name = 'CPA_VALORMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORMORADIARIA', ftBCD)]
    [Dictionary('CPA_VALORMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORMORADIARIA: Double read FCPA_VALORMORADIARIA write FCPA_VALORMORADIARIA;
    const CPA_VALORMORADIARIA_Name = 'CPA_VALORMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CPA_DATABAIXA', ftDateTime)]
    [Dictionary('CPA_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATABAIXA: TDateTime read FCPA_DATABAIXA write FCPA_DATABAIXA;
    const CPA_DATABAIXA_Name = 'CPA_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALDESCTO', ftBCD)]
    [Dictionary('CPA_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTO: Double read FCPA_TOTALDESCTO write FCPA_TOTALDESCTO;
    const CPA_TOTALDESCTO_Name = 'CPA_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALJUROS', ftBCD, 48, 2)]
    [Dictionary('CPA_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROS: Double read FCPA_TOTALJUROS write FCPA_TOTALJUROS;
    const CPA_TOTALJUROS_Name = 'CPA_TOTALJUROS';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALMULTA', ftBCD)]
    [Dictionary('CPA_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALMULTA: Double read FCPA_TOTALMULTA write FCPA_TOTALMULTA;
    const CPA_TOTALMULTA_Name = 'CPA_TOTALMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CPA_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORBAIXA: Double read FCPA_TOTALVALORBAIXA write FCPA_TOTALVALORBAIXA;
    const CPA_TOTALVALORBAIXA_Name = 'CPA_TOTALVALORBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALORORIGINAL', ftBCD)]
    [Dictionary('CPA_TOTALVALORORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORORIGINAL: Double read FCPA_TOTALVALORORIGINAL write FCPA_TOTALVALORORIGINAL;
    const CPA_TOTALVALORORIGINAL_Name = 'CPA_TOTALVALORORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CPA_DESATIVADO', ftString, 1)]
    [Dictionary('CPA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DESATIVADO: String read FCPA_DESATIVADO write FCPA_DESATIVADO;
    const CPA_DESATIVADO_Name = 'CPA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CPA_OBSERVACAO', ftString, 300)]
    [Dictionary('CPA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_OBSERVACAO: String read FCPA_OBSERVACAO write FCPA_OBSERVACAO;
    const CPA_OBSERVACAO_Name = 'CPA_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPODOCUMENTO', ftString, 1)]
    [Dictionary('CPA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPODOCUMENTO: String read FCPA_TIPODOCUMENTO write FCPA_TIPODOCUMENTO;
    const CPA_TIPODOCUMENTO_Name = 'CPA_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPA_CHEQUEVINCULADO', ftString, 1)]
    [Dictionary('CPA_CHEQUEVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_CHEQUEVINCULADO: String read FCPA_CHEQUEVINCULADO write FCPA_CHEQUEVINCULADO;
    const CPA_CHEQUEVINCULADO_Name = 'CPA_CHEQUEVINCULADO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_SIGLATIPODOCUMENTO', ftString, 3)]
    [Dictionary('CPA_SIGLATIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_SIGLATIPODOCUMENTO: String read FCPA_SIGLATIPODOCUMENTO write FCPA_SIGLATIPODOCUMENTO;
    const CPA_SIGLATIPODOCUMENTO_Name = 'CPA_SIGLATIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_CPA)

end.
