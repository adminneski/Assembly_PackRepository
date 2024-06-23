unit express.dbo.REL_V03_VEF;

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
  [Table('REL_V03_VEF', '')]
  TDtoREL_V03_VEF = class
  private
    { Private declarations } 
    FVEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVEF_NUMERODOCTO: String;
    FVEF_DATALANCAMENTO: TDateTime;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FPES_CIDADE: String;
    FCEP_CODIGO: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_UF: String;
    FPES_TIPOPESSOA: String;
    FCON_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FCON_NOME: String;
    FVND_NOME: String;
    FVEF_PRAZOENTREGA: String;
    FVEF_VALIDADE: Integer;
    FVEF_OBSERVACAO: String;
    FVEF_AMBIENTE: String;
    FVEF_TOTALLIQUIDO: Double;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FVEF_CANCELADA: String;
    FVEF_TOTALQTDPEDIDA: Double;
    FVEF_PROCESSADO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V03_VEF';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_NUMERODOCTO', ftString, 10)]
    [Dictionary('VEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_NUMERODOCTO: String read FVEF_NUMERODOCTO write FVEF_NUMERODOCTO;
    const VEF_NUMERODOCTO_Name = 'VEF_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('VEF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATALANCAMENTO: TDateTime read FVEF_DATALANCAMENTO write FVEF_DATALANCAMENTO;
    const VEF_DATALANCAMENTO_Name = 'VEF_DATALANCAMENTO';

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
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CON_CODIGO: Integer read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CON_NOME', ftString, 100)]
    [Dictionary('CON_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CON_NOME: String read FCON_NOME write FCON_NOME;
    const CON_NOME_Name = 'CON_NOME';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_PRAZOENTREGA', ftString, 100)]
    [Dictionary('VEF_PRAZOENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_PRAZOENTREGA: String read FVEF_PRAZOENTREGA write FVEF_PRAZOENTREGA;
    const VEF_PRAZOENTREGA_Name = 'VEF_PRAZOENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_VALIDADE', ftInteger)]
    [Dictionary('VEF_VALIDADE', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_VALIDADE: Integer read FVEF_VALIDADE write FVEF_VALIDADE;
    const VEF_VALIDADE_Name = 'VEF_VALIDADE';

    [Restrictions([NoValidate])]
    [Column('VEF_OBSERVACAO', ftString, 5000)]
    [Dictionary('VEF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_OBSERVACAO: String read FVEF_OBSERVACAO write FVEF_OBSERVACAO;
    const VEF_OBSERVACAO_Name = 'VEF_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_AMBIENTE', ftString, 100)]
    [Dictionary('VEF_AMBIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_AMBIENTE: String read FVEF_AMBIENTE write FVEF_AMBIENTE;
    const VEF_AMBIENTE_Name = 'VEF_AMBIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALLIQUIDO', ftBCD)]
    [Dictionary('VEF_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALLIQUIDO: Double read FVEF_TOTALLIQUIDO write FVEF_TOTALLIQUIDO;
    const VEF_TOTALLIQUIDO_Name = 'VEF_TOTALLIQUIDO';

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
    [Column('VEF_CANCELADA', ftString, 1)]
    [Dictionary('VEF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_CANCELADA: String read FVEF_CANCELADA write FVEF_CANCELADA;
    const VEF_CANCELADA_Name = 'VEF_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALQTDPEDIDA', ftBCD)]
    [Dictionary('VEF_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALQTDPEDIDA: Double read FVEF_TOTALQTDPEDIDA write FVEF_TOTALQTDPEDIDA;
    const VEF_TOTALQTDPEDIDA_Name = 'VEF_TOTALQTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('VEF_PROCESSADO', ftString, 1)]
    [Dictionary('VEF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_PROCESSADO: String read FVEF_PROCESSADO write FVEF_PROCESSADO;
    const VEF_PROCESSADO_Name = 'VEF_PROCESSADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V03_VEF)

end.
