unit express.dbo.SPEDPC_R_A010;

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
  [Table('SPEDPC_R_A010', '')]
  TDtoSPEDPC_R_A010 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FCEP_CODIGO: String;
    FCID_IBGE: Integer;
    FCOM_CNPJ: String;
    FCOM_IE: String;
    FCOM_UF: String;
    FCOM_RAZAO: String;
    FCOM_FANTASIA_OU_APELIDO: String;
    FCOM_ENDERECO: String;
    FCOM_NUMEROENDERECO: String;
    FCOM_BAIRRO: String;
    FCOM_PONTOREFERENCIA: String;
    FCOM_DDD_TELEFONE_1: String;
    FCOM_DDD_TELEFONE_2: String;
    FCOM_DDD_CELULAR_1: String;
    FCOM_DDD_CELULAR_2: String;
    FCOM_EMAIL: String;
    FCOM_HTTP: String;
    FCOM_CAIXAPOSTAL: String;
    FCOM_OBSERVACAO: String;
    FCOM_IE_MUNICIPAL: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_A010';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftInteger)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGE: Integer read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ', ftString, 14)]
    [Dictionary('COM_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ: String read FCOM_CNPJ write FCOM_CNPJ;
    const COM_CNPJ_Name = 'COM_CNPJ';

    [Restrictions([NoValidate])]
    [Column('COM_IE', ftString, 16)]
    [Dictionary('COM_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE: String read FCOM_IE write FCOM_IE;
    const COM_IE_Name = 'COM_IE';

    [Restrictions([NoValidate])]
    [Column('COM_UF', ftString, 2)]
    [Dictionary('COM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;
    const COM_UF_Name = 'COM_UF';

    [Restrictions([NoValidate])]
    [Column('COM_RAZAO', ftString, 100)]
    [Dictionary('COM_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;
    const COM_RAZAO_Name = 'COM_RAZAO';

    [Restrictions([NoValidate])]
    [Column('COM_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('COM_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_FANTASIA_OU_APELIDO: String read FCOM_FANTASIA_OU_APELIDO write FCOM_FANTASIA_OU_APELIDO;
    const COM_FANTASIA_OU_APELIDO_Name = 'COM_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate])]
    [Column('COM_ENDERECO', ftString, 100)]
    [Dictionary('COM_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_ENDERECO: String read FCOM_ENDERECO write FCOM_ENDERECO;
    const COM_ENDERECO_Name = 'COM_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('COM_NUMEROENDERECO', ftString, 5)]
    [Dictionary('COM_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_NUMEROENDERECO: String read FCOM_NUMEROENDERECO write FCOM_NUMEROENDERECO;
    const COM_NUMEROENDERECO_Name = 'COM_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('COM_BAIRRO', ftString, 50)]
    [Dictionary('COM_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_BAIRRO: String read FCOM_BAIRRO write FCOM_BAIRRO;
    const COM_BAIRRO_Name = 'COM_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('COM_PONTOREFERENCIA', ftString, 100)]
    [Dictionary('COM_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_PONTOREFERENCIA: String read FCOM_PONTOREFERENCIA write FCOM_PONTOREFERENCIA;
    const COM_PONTOREFERENCIA_Name = 'COM_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('COM_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_1: String read FCOM_DDD_TELEFONE_1 write FCOM_DDD_TELEFONE_1;
    const COM_DDD_TELEFONE_1_Name = 'COM_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('COM_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_2: String read FCOM_DDD_TELEFONE_2 write FCOM_DDD_TELEFONE_2;
    const COM_DDD_TELEFONE_2_Name = 'COM_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('COM_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_CELULAR_1: String read FCOM_DDD_CELULAR_1 write FCOM_DDD_CELULAR_1;
    const COM_DDD_CELULAR_1_Name = 'COM_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_CELULAR_2', ftString, 11)]
    [Dictionary('COM_DDD_CELULAR_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_CELULAR_2: String read FCOM_DDD_CELULAR_2 write FCOM_DDD_CELULAR_2;
    const COM_DDD_CELULAR_2_Name = 'COM_DDD_CELULAR_2';

    [Restrictions([NoValidate])]
    [Column('COM_EMAIL', ftString, 50)]
    [Dictionary('COM_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_EMAIL: String read FCOM_EMAIL write FCOM_EMAIL;
    const COM_EMAIL_Name = 'COM_EMAIL';

    [Restrictions([NoValidate])]
    [Column('COM_HTTP', ftString, 50)]
    [Dictionary('COM_HTTP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_HTTP: String read FCOM_HTTP write FCOM_HTTP;
    const COM_HTTP_Name = 'COM_HTTP';

    [Restrictions([NoValidate])]
    [Column('COM_CAIXAPOSTAL', ftString, 30)]
    [Dictionary('COM_CAIXAPOSTAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CAIXAPOSTAL: String read FCOM_CAIXAPOSTAL write FCOM_CAIXAPOSTAL;
    const COM_CAIXAPOSTAL_Name = 'COM_CAIXAPOSTAL';

    [Restrictions([NoValidate])]
    [Column('COM_OBSERVACAO', ftString, 500)]
    [Dictionary('COM_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_OBSERVACAO: String read FCOM_OBSERVACAO write FCOM_OBSERVACAO;
    const COM_OBSERVACAO_Name = 'COM_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('COM_IE_MUNICIPAL', ftString, 30)]
    [Dictionary('COM_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE_MUNICIPAL: String read FCOM_IE_MUNICIPAL write FCOM_IE_MUNICIPAL;
    const COM_IE_MUNICIPAL_Name = 'COM_IE_MUNICIPAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_A010)

end.
