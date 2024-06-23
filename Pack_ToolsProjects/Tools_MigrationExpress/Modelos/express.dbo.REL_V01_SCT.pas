unit express.dbo.REL_V01_SCT;

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
  [Table('REL_V01_SCT', '')]
  TDtoREL_V01_SCT = class
  private
    { Private declarations } 
    FSCT_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCT_OBSERVACAO: String;
    FSCT_PROCESSADO: String;
    FSCT_CONDICAOESPECIAL: String;
    FSCT_DATALANCAMENTO: TDateTime;
    FCRE_TOTALVALORLOTE: Double;
    FCRE_TOTALICMSLOTE: Double;
    FCRE_TOTALFRETELOTE: Double;
    FCRE_TOTALSEGUROLOTE: Double;
    FCRE_TOTALJUROSLOTE: Double;
    FCRE_TOTALMULTALOTE: Double;
    FCRE_TOTALDESCTOLOTE: Double;
    FCRE_TOTALCARTORIOLOTE: Double;
    FCRE_TOTALOUTRASDESPESASLOTE: Double;
    FSCT_TOTALVALORSUBSTITUIDO: Double;
    FSCT_TOTALVALORSUBSTITUTO: Double;
    FSCT_02_ID: Integer;
    FBCO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FSCT_DATAVENCTO: TDateTime;
    FSCT_TOTALVALOR: Double;
    FSCT_DATAEMISSAO: TDateTime;
    FSCT_NUMERODOCTO: String;
    FSCT_NOSSONUMERO: String;
    FSCT_DATADESCTO: TDateTime;
    FSCT_VALORDESCTO: Double;
    FSCT_PERCENTUALMORADIARIA: Double;
    FSCT_REFERENCIATRANSPORTE: String;
    FPES_NOME: String;
    FPES_DDD_TELEFONE_1: String;
    FCID_IBGE: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FBCO_NOME: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_TIPOPESSOA: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FCEP_CODIGO: String;
    FPES_BAIRRO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_SCT';

    [Restrictions([NoValidate])]
    [Column('SCT_ID', ftInteger)]
    [Dictionary('SCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID: Integer read FSCT_ID write FSCT_ID;
    const SCT_ID_Name = 'SCT_ID';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SCT_OBSERVACAO', ftString, 300)]
    [Dictionary('SCT_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_OBSERVACAO: String read FSCT_OBSERVACAO write FSCT_OBSERVACAO;
    const SCT_OBSERVACAO_Name = 'SCT_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('SCT_PROCESSADO', ftString, 1)]
    [Dictionary('SCT_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_PROCESSADO: String read FSCT_PROCESSADO write FSCT_PROCESSADO;
    const SCT_PROCESSADO_Name = 'SCT_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('SCT_CONDICAOESPECIAL', ftString, 5000)]
    [Dictionary('SCT_CONDICAOESPECIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_CONDICAOESPECIAL: String read FSCT_CONDICAOESPECIAL write FSCT_CONDICAOESPECIAL;
    const SCT_CONDICAOESPECIAL_Name = 'SCT_CONDICAOESPECIAL';

    [Restrictions([NoValidate])]
    [Column('SCT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCT_DATALANCAMENTO: TDateTime read FSCT_DATALANCAMENTO write FSCT_DATALANCAMENTO;
    const SCT_DATALANCAMENTO_Name = 'SCT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALVALORLOTE', ftBCD, 48, 2)]
    [Dictionary('CRE_TOTALVALORLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORLOTE: Double read FCRE_TOTALVALORLOTE write FCRE_TOTALVALORLOTE;
    const CRE_TOTALVALORLOTE_Name = 'CRE_TOTALVALORLOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALICMSLOTE', ftBCD)]
    [Dictionary('CRE_TOTALICMSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALICMSLOTE: Double read FCRE_TOTALICMSLOTE write FCRE_TOTALICMSLOTE;
    const CRE_TOTALICMSLOTE_Name = 'CRE_TOTALICMSLOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALFRETELOTE', ftBCD)]
    [Dictionary('CRE_TOTALFRETELOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALFRETELOTE: Double read FCRE_TOTALFRETELOTE write FCRE_TOTALFRETELOTE;
    const CRE_TOTALFRETELOTE_Name = 'CRE_TOTALFRETELOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALSEGUROLOTE', ftBCD)]
    [Dictionary('CRE_TOTALSEGUROLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALSEGUROLOTE: Double read FCRE_TOTALSEGUROLOTE write FCRE_TOTALSEGUROLOTE;
    const CRE_TOTALSEGUROLOTE_Name = 'CRE_TOTALSEGUROLOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALJUROSLOTE', ftBCD)]
    [Dictionary('CRE_TOTALJUROSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROSLOTE: Double read FCRE_TOTALJUROSLOTE write FCRE_TOTALJUROSLOTE;
    const CRE_TOTALJUROSLOTE_Name = 'CRE_TOTALJUROSLOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALMULTALOTE', ftBCD)]
    [Dictionary('CRE_TOTALMULTALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTALOTE: Double read FCRE_TOTALMULTALOTE write FCRE_TOTALMULTALOTE;
    const CRE_TOTALMULTALOTE_Name = 'CRE_TOTALMULTALOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALDESCTOLOTE', ftBCD)]
    [Dictionary('CRE_TOTALDESCTOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTOLOTE: Double read FCRE_TOTALDESCTOLOTE write FCRE_TOTALDESCTOLOTE;
    const CRE_TOTALDESCTOLOTE_Name = 'CRE_TOTALDESCTOLOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALCARTORIOLOTE', ftBCD)]
    [Dictionary('CRE_TOTALCARTORIOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIOLOTE: Double read FCRE_TOTALCARTORIOLOTE write FCRE_TOTALCARTORIOLOTE;
    const CRE_TOTALCARTORIOLOTE_Name = 'CRE_TOTALCARTORIOLOTE';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALOUTRASDESPESASLOTE', ftBCD)]
    [Dictionary('CRE_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESASLOTE: Double read FCRE_TOTALOUTRASDESPESASLOTE write FCRE_TOTALOUTRASDESPESASLOTE;
    const CRE_TOTALOUTRASDESPESASLOTE_Name = 'CRE_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate])]
    [Column('SCT_TOTALVALORSUBSTITUIDO', ftBCD)]
    [Dictionary('SCT_TOTALVALORSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALORSUBSTITUIDO: Double read FSCT_TOTALVALORSUBSTITUIDO write FSCT_TOTALVALORSUBSTITUIDO;
    const SCT_TOTALVALORSUBSTITUIDO_Name = 'SCT_TOTALVALORSUBSTITUIDO';

    [Restrictions([NoValidate])]
    [Column('SCT_TOTALVALORSUBSTITUTO', ftBCD, 48, 2)]
    [Dictionary('SCT_TOTALVALORSUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALORSUBSTITUTO: Double read FSCT_TOTALVALORSUBSTITUTO write FSCT_TOTALVALORSUBSTITUTO;
    const SCT_TOTALVALORSUBSTITUTO_Name = 'SCT_TOTALVALORSUBSTITUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_02_ID', ftInteger)]
    [Dictionary('SCT_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_02_ID: Integer read FSCT_02_ID write FSCT_02_ID;
    const SCT_02_ID_Name = 'SCT_02_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAVENCTO', ftDateTime)]
    [Dictionary('SCT_DATAVENCTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAVENCTO: TDateTime read FSCT_DATAVENCTO write FSCT_DATAVENCTO;
    const SCT_DATAVENCTO_Name = 'SCT_DATAVENCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_TOTALVALOR', ftBCD)]
    [Dictionary('SCT_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALOR: Double read FSCT_TOTALVALOR write FSCT_TOTALVALOR;
    const SCT_TOTALVALOR_Name = 'SCT_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCT_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAEMISSAO: TDateTime read FSCT_DATAEMISSAO write FSCT_DATAEMISSAO;
    const SCT_DATAEMISSAO_Name = 'SCT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('SCT_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_NUMERODOCTO: String read FSCT_NUMERODOCTO write FSCT_NUMERODOCTO;
    const SCT_NUMERODOCTO_Name = 'SCT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCT_NOSSONUMERO', ftString, 20)]
    [Dictionary('SCT_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_NOSSONUMERO: String read FSCT_NOSSONUMERO write FSCT_NOSSONUMERO;
    const SCT_NOSSONUMERO_Name = 'SCT_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('SCT_DATADESCTO', ftDateTime)]
    [Dictionary('SCT_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCT_DATADESCTO: TDateTime read FSCT_DATADESCTO write FSCT_DATADESCTO;
    const SCT_DATADESCTO_Name = 'SCT_DATADESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_VALORDESCTO', ftBCD)]
    [Dictionary('SCT_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_VALORDESCTO: Double read FSCT_VALORDESCTO write FSCT_VALORDESCTO;
    const SCT_VALORDESCTO_Name = 'SCT_VALORDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_PERCENTUALMORADIARIA', ftBCD)]
    [Dictionary('SCT_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_PERCENTUALMORADIARIA: Double read FSCT_PERCENTUALMORADIARIA write FSCT_PERCENTUALMORADIARIA;
    const SCT_PERCENTUALMORADIARIA_Name = 'SCT_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('SCT_REFERENCIATRANSPORTE', ftString, 100)]
    [Dictionary('SCT_REFERENCIATRANSPORTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_REFERENCIATRANSPORTE: String read FSCT_REFERENCIATRANSPORTE write FSCT_REFERENCIATRANSPORTE;
    const SCT_REFERENCIATRANSPORTE_Name = 'SCT_REFERENCIATRANSPORTE';

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

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_DESCRICAO', ftString, 30)]
    [Dictionary('ROT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_DESCRICAO: String read FROT_DESCRICAO write FROT_DESCRICAO;
    const ROT_DESCRICAO_Name = 'ROT_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

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

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO', ftString, 100)]
    [Dictionary('PES_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO: String read FPES_ENDERECO write FPES_ENDERECO;
    const PES_ENDERECO_Name = 'PES_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO: String read FPES_NUMEROENDERECO write FPES_NUMEROENDERECO;
    const PES_NUMEROENDERECO_Name = 'PES_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_SCT)

end.
