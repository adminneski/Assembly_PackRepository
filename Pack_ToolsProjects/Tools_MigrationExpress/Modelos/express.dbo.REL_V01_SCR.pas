unit express.dbo.REL_V01_SCR;

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
  [Table('REL_V01_SCR', '')]
  TDtoREL_V01_SCR = class
  private
    { Private declarations } 
    FSCR_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FSCR_HISTORICO: String;
    FSCR_OBSERVACAO: String;
    FSCR_PROCESSADO: String;
    FSCR_DATALANCAMENTO: TDateTime;
    FSCR_TIPODOCUMENTO: String;
    FCRE_TOTALVALORLOTE: Double;
    FCRE_TOTALJUROSLOTE: Double;
    FCRE_TOTALMULTALOTE: Double;
    FCRE_TOTALDESCTOLOTE: Double;
    FCRE_TOTALCARTORIOLOTE: Double;
    FCRE_TOTALOUTRASDESPESASLOTE: Double;
    FSCR_TOTALVALORSUBSTITUIDO: Double;
    FSCR_TOTALVALORSUBSTITUTO: Double;
    FSCR_TOTALCHEQUESUBSTITUTO: Double;
    FSCR_02_ID: Integer;
    FBCO_CODIGO: Integer;
    FSCR_DATAVENCTO: TDateTime;
    FSCR_TOTALVALOR: Double;
    FSCR_DATAEMISSAO: TDateTime;
    FSCR_NUMERODOCTO: String;
    FSCR_NOSSONUMERO: String;
    FSCR_DATADESCTO: TDateTime;
    FSCR_VALORDESCTO: Double;
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
  public 
    { Public declarations } 
     const Table      = 'REL_V01_SCR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

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
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SCR_HISTORICO', ftString, 300)]
    [Dictionary('SCR_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_HISTORICO: String read FSCR_HISTORICO write FSCR_HISTORICO;
    const SCR_HISTORICO_Name = 'SCR_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('SCR_OBSERVACAO', ftString, 300)]
    [Dictionary('SCR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_OBSERVACAO: String read FSCR_OBSERVACAO write FSCR_OBSERVACAO;
    const SCR_OBSERVACAO_Name = 'SCR_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_PROCESSADO', ftString, 1)]
    [Dictionary('SCR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_PROCESSADO: String read FSCR_PROCESSADO write FSCR_PROCESSADO;
    const SCR_PROCESSADO_Name = 'SCR_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCR_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATALANCAMENTO: TDateTime read FSCR_DATALANCAMENTO write FSCR_DATALANCAMENTO;
    const SCR_DATALANCAMENTO_Name = 'SCR_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('SCR_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_TIPODOCUMENTO: String read FSCR_TIPODOCUMENTO write FSCR_TIPODOCUMENTO;
    const SCR_TIPODOCUMENTO_Name = 'SCR_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORLOTE', ftBCD)]
    [Dictionary('CRE_TOTALVALORLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORLOTE: Double read FCRE_TOTALVALORLOTE write FCRE_TOTALVALORLOTE;
    const CRE_TOTALVALORLOTE_Name = 'CRE_TOTALVALORLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROSLOTE', ftBCD)]
    [Dictionary('CRE_TOTALJUROSLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROSLOTE: Double read FCRE_TOTALJUROSLOTE write FCRE_TOTALJUROSLOTE;
    const CRE_TOTALJUROSLOTE_Name = 'CRE_TOTALJUROSLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTALOTE', ftBCD)]
    [Dictionary('CRE_TOTALMULTALOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTALOTE: Double read FCRE_TOTALMULTALOTE write FCRE_TOTALMULTALOTE;
    const CRE_TOTALMULTALOTE_Name = 'CRE_TOTALMULTALOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTOLOTE', ftBCD, 66260064, 2)]
    [Dictionary('CRE_TOTALDESCTOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTOLOTE: Double read FCRE_TOTALDESCTOLOTE write FCRE_TOTALDESCTOLOTE;
    const CRE_TOTALDESCTOLOTE_Name = 'CRE_TOTALDESCTOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIOLOTE', ftBCD)]
    [Dictionary('CRE_TOTALCARTORIOLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIOLOTE: Double read FCRE_TOTALCARTORIOLOTE write FCRE_TOTALCARTORIOLOTE;
    const CRE_TOTALCARTORIOLOTE_Name = 'CRE_TOTALCARTORIOLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESASLOTE', ftBCD, 48, 2)]
    [Dictionary('CRE_TOTALOUTRASDESPESASLOTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESASLOTE: Double read FCRE_TOTALOUTRASDESPESASLOTE write FCRE_TOTALOUTRASDESPESASLOTE;
    const CRE_TOTALOUTRASDESPESASLOTE_Name = 'CRE_TOTALOUTRASDESPESASLOTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALORSUBSTITUIDO', ftBCD)]
    [Dictionary('SCR_TOTALVALORSUBSTITUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALORSUBSTITUIDO: Double read FSCR_TOTALVALORSUBSTITUIDO write FSCR_TOTALVALORSUBSTITUIDO;
    const SCR_TOTALVALORSUBSTITUIDO_Name = 'SCR_TOTALVALORSUBSTITUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALORSUBSTITUTO', ftBCD)]
    [Dictionary('SCR_TOTALVALORSUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALORSUBSTITUTO: Double read FSCR_TOTALVALORSUBSTITUTO write FSCR_TOTALVALORSUBSTITUTO;
    const SCR_TOTALVALORSUBSTITUTO_Name = 'SCR_TOTALVALORSUBSTITUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALCHEQUESUBSTITUTO', ftBCD)]
    [Dictionary('SCR_TOTALCHEQUESUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALCHEQUESUBSTITUTO: Double read FSCR_TOTALCHEQUESUBSTITUTO write FSCR_TOTALCHEQUESUBSTITUTO;
    const SCR_TOTALCHEQUESUBSTITUTO_Name = 'SCR_TOTALCHEQUESUBSTITUTO';

    [Restrictions([NoValidate])]
    [Column('SCR_02_ID', ftInteger)]
    [Dictionary('SCR_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_02_ID: Integer read FSCR_02_ID write FSCR_02_ID;
    const SCR_02_ID_Name = 'SCR_02_ID';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SCR_DATAVENCTO', ftDateTime)]
    [Dictionary('SCR_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCR_DATAVENCTO: TDateTime read FSCR_DATAVENCTO write FSCR_DATAVENCTO;
    const SCR_DATAVENCTO_Name = 'SCR_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('SCR_TOTALVALOR', ftBCD)]
    [Dictionary('SCR_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALOR: Double read FSCR_TOTALVALOR write FSCR_TOTALVALOR;
    const SCR_TOTALVALOR_Name = 'SCR_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('SCR_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCR_DATAEMISSAO: TDateTime read FSCR_DATAEMISSAO write FSCR_DATAEMISSAO;
    const SCR_DATAEMISSAO_Name = 'SCR_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('SCR_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMERODOCTO: String read FSCR_NUMERODOCTO write FSCR_NUMERODOCTO;
    const SCR_NUMERODOCTO_Name = 'SCR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCR_NOSSONUMERO', ftString, 20)]
    [Dictionary('SCR_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NOSSONUMERO: String read FSCR_NOSSONUMERO write FSCR_NOSSONUMERO;
    const SCR_NOSSONUMERO_Name = 'SCR_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('SCR_DATADESCTO', ftDateTime)]
    [Dictionary('SCR_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCR_DATADESCTO: TDateTime read FSCR_DATADESCTO write FSCR_DATADESCTO;
    const SCR_DATADESCTO_Name = 'SCR_DATADESCTO';

    [Restrictions([NoValidate])]
    [Column('SCR_VALORDESCTO', ftBCD)]
    [Dictionary('SCR_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_VALORDESCTO: Double read FSCR_VALORDESCTO write FSCR_VALORDESCTO;
    const SCR_VALORDESCTO_Name = 'SCR_VALORDESCTO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_SCR)

end.
