unit express.dbo.SPEDPC_R_0140;

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
  [Table('SPEDPC_R_0140', '')]
  TDtoSPEDPC_R_0140 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FCOM_RAZAO: String;
    FCOM_FANTASIA_OU_APELIDO: String;
    FCOM_ENDERECO: String;
    FCOM_NUMEROENDERECO: String;
    FCOM_BAIRRO: String;
    FCOM_CIDADE: String;
    FCID_IBGE: Integer;
    FCOM_UF: String;
    FCOM_CODIGOPAIS: String;
    FCOM_PAIS: String;
    FCEP_CODIGO: String;
    FCOM_IE_RG: String;
    FCOM_CNPJ_CPF: String;
    FCOM_DDD_TELEFONE_1: String;
    FCOM_TIPOEMPRESA: String;
    FCOM_PORTEFEDERAL: String;
    FCOM_PORTEESTADUAL: String;
    FCOM_IE_MUNICIPAL: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0140';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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
    [Column('COM_CIDADE', ftString, 100)]
    [Dictionary('COM_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CIDADE: String read FCOM_CIDADE write FCOM_CIDADE;
    const COM_CIDADE_Name = 'COM_CIDADE';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftInteger)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGE: Integer read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('COM_UF', ftString, 2)]
    [Dictionary('COM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;
    const COM_UF_Name = 'COM_UF';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGOPAIS', ftString, 4)]
    [Dictionary('COM_CODIGOPAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGOPAIS: String read FCOM_CODIGOPAIS write FCOM_CODIGOPAIS;
    const COM_CODIGOPAIS_Name = 'COM_CODIGOPAIS';

    [Restrictions([NoValidate])]
    [Column('COM_PAIS', ftString, 100)]
    [Dictionary('COM_PAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_PAIS: String read FCOM_PAIS write FCOM_PAIS;
    const COM_PAIS_Name = 'COM_PAIS';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_IE_RG', ftString, 16)]
    [Dictionary('COM_IE_RG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE_RG: String read FCOM_IE_RG write FCOM_IE_RG;
    const COM_IE_RG_Name = 'COM_IE_RG';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('COM_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_1: String read FCOM_DDD_TELEFONE_1 write FCOM_DDD_TELEFONE_1;
    const COM_DDD_TELEFONE_1_Name = 'COM_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('COM_TIPOEMPRESA', ftString, 1)]
    [Dictionary('COM_TIPOEMPRESA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_TIPOEMPRESA: String read FCOM_TIPOEMPRESA write FCOM_TIPOEMPRESA;
    const COM_TIPOEMPRESA_Name = 'COM_TIPOEMPRESA';

    [Restrictions([NoValidate])]
    [Column('COM_PORTEFEDERAL', ftString, 1)]
    [Dictionary('COM_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_PORTEFEDERAL: String read FCOM_PORTEFEDERAL write FCOM_PORTEFEDERAL;
    const COM_PORTEFEDERAL_Name = 'COM_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('COM_PORTEESTADUAL', ftString, 1)]
    [Dictionary('COM_PORTEESTADUAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_PORTEESTADUAL: String read FCOM_PORTEESTADUAL write FCOM_PORTEESTADUAL;
    const COM_PORTEESTADUAL_Name = 'COM_PORTEESTADUAL';

    [Restrictions([NoValidate])]
    [Column('COM_IE_MUNICIPAL', ftString, 30)]
    [Dictionary('COM_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE_MUNICIPAL: String read FCOM_IE_MUNICIPAL write FCOM_IE_MUNICIPAL;
    const COM_IE_MUNICIPAL_Name = 'COM_IE_MUNICIPAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0140)

end.
