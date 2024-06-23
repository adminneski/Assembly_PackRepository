unit express.dbo.STG_REGISTRO10_11;

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
  [Table('STG_REGISTRO10_11', '')]
  TDtoSTG_REGISTRO10_11 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FCOM_RAZAO: String;
    FCOM_CNPJ_CPF: String;
    FCOM_IE_RG: String;
    FCOM_ENDERECO: String;
    FCOM_PONTOREFERENCIA: String;
    FCOM_BAIRRO: String;
    FCOM_NUMEROENDERECO: String;
    FCID_IBGE: Integer;
    FCEP_CODIGO: String;
    FCOM_DDD_TELEFONE_1: String;
    FCOM_DDD_FAX: String;
    FCOM_TIPOEMPRESA: String;
    FCOM_CONFIGURACOES: String;
    FCOM_CIDADE: String;
    FCOM_UF: String;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO10_11';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('COM_IE_RG', ftString, 16)]
    [Dictionary('COM_IE_RG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE_RG: String read FCOM_IE_RG write FCOM_IE_RG;
    const COM_IE_RG_Name = 'COM_IE_RG';

    [Restrictions([NoValidate])]
    [Column('COM_ENDERECO', ftString, 100)]
    [Dictionary('COM_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_ENDERECO: String read FCOM_ENDERECO write FCOM_ENDERECO;
    const COM_ENDERECO_Name = 'COM_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('COM_PONTOREFERENCIA', ftString, 100)]
    [Dictionary('COM_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_PONTOREFERENCIA: String read FCOM_PONTOREFERENCIA write FCOM_PONTOREFERENCIA;
    const COM_PONTOREFERENCIA_Name = 'COM_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('COM_BAIRRO', ftString, 50)]
    [Dictionary('COM_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_BAIRRO: String read FCOM_BAIRRO write FCOM_BAIRRO;
    const COM_BAIRRO_Name = 'COM_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('COM_NUMEROENDERECO', ftString, 5)]
    [Dictionary('COM_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_NUMEROENDERECO: String read FCOM_NUMEROENDERECO write FCOM_NUMEROENDERECO;
    const COM_NUMEROENDERECO_Name = 'COM_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftInteger)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGE: Integer read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('COM_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_TELEFONE_1: String read FCOM_DDD_TELEFONE_1 write FCOM_DDD_TELEFONE_1;
    const COM_DDD_TELEFONE_1_Name = 'COM_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('COM_DDD_FAX', ftString, 11)]
    [Dictionary('COM_DDD_FAX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_DDD_FAX: String read FCOM_DDD_FAX write FCOM_DDD_FAX;
    const COM_DDD_FAX_Name = 'COM_DDD_FAX';

    [Restrictions([NoValidate])]
    [Column('COM_TIPOEMPRESA', ftString, 1)]
    [Dictionary('COM_TIPOEMPRESA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_TIPOEMPRESA: String read FCOM_TIPOEMPRESA write FCOM_TIPOEMPRESA;
    const COM_TIPOEMPRESA_Name = 'COM_TIPOEMPRESA';

    [Restrictions([NoValidate])]
    [Column('COM_CONFIGURACOES', ftString, 100)]
    [Dictionary('COM_CONFIGURACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CONFIGURACOES: String read FCOM_CONFIGURACOES write FCOM_CONFIGURACOES;
    const COM_CONFIGURACOES_Name = 'COM_CONFIGURACOES';

    [Restrictions([NoValidate])]
    [Column('COM_CIDADE', ftString, 100)]
    [Dictionary('COM_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CIDADE: String read FCOM_CIDADE write FCOM_CIDADE;
    const COM_CIDADE_Name = 'COM_CIDADE';

    [Restrictions([NoValidate])]
    [Column('COM_UF', ftString, 2)]
    [Dictionary('COM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;
    const COM_UF_Name = 'COM_UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO10_11)

end.
