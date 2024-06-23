unit express.dbo.REL_V01_CEF;

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
  [Table('REL_V01_CEF', '')]
  TDtoREL_V01_CEF = class
  private
    { Private declarations } 
    FCEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FCEF_NUMERODOCTO: String;
    FCEF_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOMECLIENTE: String;
    FPES_TIPOPESSOA: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_CELULAR_1: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FCEF_PROCESSADO: String;
    FPES_OBSERVACAO: String;
    FCEF_NUMERODOCTOFAT: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CEF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_ID', ftInteger)]
    [Dictionary('CEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CEF_ID: Integer read FCEF_ID write FCEF_ID;
    const CEF_ID_Name = 'CEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CEF_NUMERODOCTO', ftString, 15)]
    [Dictionary('CEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_NUMERODOCTO: String read FCEF_NUMERODOCTO write FCEF_NUMERODOCTO;
    const CEF_NUMERODOCTO_Name = 'CEF_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CEF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CEF_DATALANCAMENTO: TDateTime read FCEF_DATALANCAMENTO write FCEF_DATALANCAMENTO;
    const CEF_DATALANCAMENTO_Name = 'CEF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTE: String read FPES_NOMECLIENTE write FPES_NOMECLIENTE;
    const PES_NOMECLIENTE_Name = 'PES_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO: String read FPES_FANTASIA_OU_APELIDO write FPES_FANTASIA_OU_APELIDO;
    const PES_FANTASIA_OU_APELIDO_Name = 'PES_FANTASIA_OU_APELIDO';

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
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA: String read FPES_PONTOREFERENCIA write FPES_PONTOREFERENCIA;
    const PES_PONTOREFERENCIA_Name = 'PES_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

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
    [Column('CEF_PROCESSADO', ftString, 1)]
    [Dictionary('CEF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_PROCESSADO: String read FCEF_PROCESSADO write FCEF_PROCESSADO;
    const CEF_PROCESSADO_Name = 'CEF_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PES_OBSERVACAO', ftString, 300)]
    [Dictionary('PES_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_OBSERVACAO: String read FPES_OBSERVACAO write FPES_OBSERVACAO;
    const PES_OBSERVACAO_Name = 'PES_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CEF_NUMERODOCTOFAT', ftString, 100)]
    [Dictionary('CEF_NUMERODOCTOFAT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEF_NUMERODOCTOFAT: String read FCEF_NUMERODOCTOFAT write FCEF_NUMERODOCTOFAT;
    const CEF_NUMERODOCTOFAT_Name = 'CEF_NUMERODOCTOFAT';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_CEF)

end.
