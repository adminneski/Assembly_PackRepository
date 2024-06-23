unit express.dbo.EXP_BAYER_ITENS;

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
  [Table('EXP_Bayer_Itens', '')]
  TDtoEXP_Bayer_Itens = class
  private
    { Private declarations } 
    FFAT_TIPOTRANSACAO: String;
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FFAT_CANCELADO: String;
    FFAT_NATUREZAOPERACAO: Integer;
    FNTO_MODELOOPERACAO: String;
    FPES_CODIGO: Integer;
    FPES_CNPJ_CPF_IDENTIFICADOR: String;
    FPES_CNPJ_CPF: String;
    FPES_NOME: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_ENDERECO: String;
    FPES_BAIRRO: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FCEP_CODIGO: String;
    FPES_DATACADASTRO: TDateTime;
    FVND_CODIGO: Integer;
    FVND_CNPJ_CPF: String;
    FVND_NOME: String;
    FFAT_NUMERODOCTO: String;
    FFAT_NOTAFISCAL: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_DATAENTREGA: TDateTime;
    FPRO_CODIGO: Integer;
    FPRO_CODIGOBARRA: String;
    FFAT_QTDFATURADA: Double;
    FFAT_PRECOVENDA: Double;
    FFAT_TOTALPRECOLIQUIDO: Double;
    FPRO_DESCRICAO: String;
    FFOR_CODIGO: Integer;
    FFAB_CODIGO: Integer;
    FFAB_CNPJ_CPF: String;
    FMAR_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'EXP_Bayer_Itens';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPOTRANSACAO', ftString, 2)]
    [Dictionary('FAT_TIPOTRANSACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOTRANSACAO: String read FFAT_TIPOTRANSACAO write FFAT_TIPOTRANSACAO;
    const FAT_TIPOTRANSACAO_Name = 'FAT_TIPOTRANSACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_CANCELADO', ftString, 1)]
    [Dictionary('FAT_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADO: String read FFAT_CANCELADO write FFAT_CANCELADO;
    const FAT_CANCELADO_Name = 'FAT_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('FAT_NATUREZAOPERACAO', ftInteger)]
    [Dictionary('FAT_NATUREZAOPERACAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NATUREZAOPERACAO: Integer read FFAT_NATUREZAOPERACAO write FFAT_NATUREZAOPERACAO;
    const FAT_NATUREZAOPERACAO_Name = 'FAT_NATUREZAOPERACAO';

    [Restrictions([NoValidate])]
    [Column('NTO_MODELOOPERACAO', ftString, 1)]
    [Dictionary('NTO_MODELOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_MODELOOPERACAO: String read FNTO_MODELOOPERACAO write FNTO_MODELOOPERACAO;
    const NTO_MODELOOPERACAO_Name = 'NTO_MODELOOPERACAO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CNPJ_CPF_IDENTIFICADOR', ftString, 1)]
    [Dictionary('PES_CNPJ_CPF_IDENTIFICADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_IDENTIFICADOR: String read FPES_CNPJ_CPF_IDENTIFICADOR write FPES_CNPJ_CPF_IDENTIFICADOR;
    const PES_CNPJ_CPF_IDENTIFICADOR_Name = 'PES_CNPJ_CPF_IDENTIFICADOR';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

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
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

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
    [Column('PES_DATACADASTRO', ftDateTime)]
    [Dictionary('PES_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATACADASTRO: TDateTime read FPES_DATACADASTRO write FPES_DATACADASTRO;
    const PES_DATACADASTRO_Name = 'PES_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CNPJ_CPF', ftString, 14)]
    [Dictionary('VND_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_CNPJ_CPF: String read FVND_CNPJ_CPF write FVND_CNPJ_CPF;
    const VND_CNPJ_CPF_Name = 'VND_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAENTREGA', ftDateTime)]
    [Dictionary('FAT_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAENTREGA: TDateTime read FFAT_DATAENTREGA write FFAT_DATAENTREGA;
    const FAT_DATAENTREGA_Name = 'FAT_DATAENTREGA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA', ftString, 15)]
    [Dictionary('PRO_CODIGOBARRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA: String read FPRO_CODIGOBARRA write FPRO_CODIGOBARRA;
    const PRO_CODIGOBARRA_Name = 'PRO_CODIGOBARRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Double read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOVENDA', ftBCD, 10, 10)]
    [Dictionary('FAT_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOVENDA: Double read FFAT_PRECOVENDA write FFAT_PRECOVENDA;
    const FAT_PRECOVENDA_Name = 'FAT_PRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOLIQUIDO: Double read FFAT_TOTALPRECOLIQUIDO write FFAT_TOTALPRECOLIQUIDO;
    const FAT_TOTALPRECOLIQUIDO_Name = 'FAT_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAB_CODIGO', ftInteger)]
    [Dictionary('FAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAB_CODIGO: Integer read FFAB_CODIGO write FFAB_CODIGO;
    const FAB_CODIGO_Name = 'FAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAB_CNPJ_CPF', ftString, 14)]
    [Dictionary('FAB_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAB_CNPJ_CPF: String read FFAB_CNPJ_CPF write FFAB_CNPJ_CPF;
    const FAB_CNPJ_CPF_Name = 'FAB_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_Bayer_Itens)

end.
