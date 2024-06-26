unit express.dbo.PES_SQL_00;

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
  [Table('PES_SQL_00', '')]
  TDtoPES_SQL_00 = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_CLIENTE: String;
    FPES_CONTATO: String;
    FPES_CONVENIO: String;
    FPES_FABRICANTE: String;
    FPES_FORNECEDOR: String;
    FPES_FUNCIONARIO: String;
    FPES_PORTADOR: String;
    FPES_CONTADOR: String;
    FPES_TRANSPORTADOR: String;
    FPES_VENDEDOR: String;
    FPES_DESATIVADO: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_BLOQUEADO: String;
    FPES_CIDADE: String;
    FPES_TIPOPESSOA: String;
    FPES_CONTROLAESTOQUEPRODUTOR: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_2: String;
    FPES_DDD_CELULAR_1: String;
    FPES_UF: String;
  public 
    { Public declarations } 
     const Table      = 'PES_SQL_00';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO: String read FPES_FANTASIA_OU_APELIDO write FPES_FANTASIA_OU_APELIDO;
    const PES_FANTASIA_OU_APELIDO_Name = 'PES_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CLIENTE', ftString, 1)]
    [Dictionary('PES_CLIENTE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CLIENTE: String read FPES_CLIENTE write FPES_CLIENTE;
    const PES_CLIENTE_Name = 'PES_CLIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CONTATO', ftString, 1)]
    [Dictionary('PES_CONTATO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CONTATO: String read FPES_CONTATO write FPES_CONTATO;
    const PES_CONTATO_Name = 'PES_CONTATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CONVENIO', ftString, 1)]
    [Dictionary('PES_CONVENIO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CONVENIO: String read FPES_CONVENIO write FPES_CONVENIO;
    const PES_CONVENIO_Name = 'PES_CONVENIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FABRICANTE', ftString, 1)]
    [Dictionary('PES_FABRICANTE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FABRICANTE: String read FPES_FABRICANTE write FPES_FABRICANTE;
    const PES_FABRICANTE_Name = 'PES_FABRICANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FORNECEDOR', ftString, 1)]
    [Dictionary('PES_FORNECEDOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FORNECEDOR: String read FPES_FORNECEDOR write FPES_FORNECEDOR;
    const PES_FORNECEDOR_Name = 'PES_FORNECEDOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_FUNCIONARIO', ftString, 1)]
    [Dictionary('PES_FUNCIONARIO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_FUNCIONARIO: String read FPES_FUNCIONARIO write FPES_FUNCIONARIO;
    const PES_FUNCIONARIO_Name = 'PES_FUNCIONARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_PORTADOR', ftString, 1)]
    [Dictionary('PES_PORTADOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_PORTADOR: String read FPES_PORTADOR write FPES_PORTADOR;
    const PES_PORTADOR_Name = 'PES_PORTADOR';

    [Restrictions([NoValidate])]
    [Column('PES_CONTADOR', ftString, 1)]
    [Dictionary('PES_CONTADOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CONTADOR: String read FPES_CONTADOR write FPES_CONTADOR;
    const PES_CONTADOR_Name = 'PES_CONTADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TRANSPORTADOR', ftString, 1)]
    [Dictionary('PES_TRANSPORTADOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_TRANSPORTADOR: String read FPES_TRANSPORTADOR write FPES_TRANSPORTADOR;
    const PES_TRANSPORTADOR_Name = 'PES_TRANSPORTADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_VENDEDOR', ftString, 1)]
    [Dictionary('PES_VENDEDOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_VENDEDOR: String read FPES_VENDEDOR write FPES_VENDEDOR;
    const PES_VENDEDOR_Name = 'PES_VENDEDOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DESATIVADO', ftString, 1)]
    [Dictionary('PES_DESATIVADO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_DESATIVADO: String read FPES_DESATIVADO write FPES_DESATIVADO;
    const PES_DESATIVADO_Name = 'PES_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('PES_BLOQUEADO', ftString, 1)]
    [Dictionary('PES_BLOQUEADO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_BLOQUEADO: String read FPES_BLOQUEADO write FPES_BLOQUEADO;
    const PES_BLOQUEADO_Name = 'PES_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_CONTROLAESTOQUEPRODUTOR', ftString, 1)]
    [Dictionary('PES_CONTROLAESTOQUEPRODUTOR', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_CONTROLAESTOQUEPRODUTOR: String read FPES_CONTROLAESTOQUEPRODUTOR write FPES_CONTROLAESTOQUEPRODUTOR;
    const PES_CONTROLAESTOQUEPRODUTOR_Name = 'PES_CONTROLAESTOQUEPRODUTOR';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_2', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_2', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_2: String read FPES_DDD_CELULAR_2 write FPES_DDD_CELULAR_2;
    const PES_DDD_CELULAR_2_Name = 'PES_DDD_CELULAR_2';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPES_SQL_00)

end.
