unit express.dbo.VEI_DADOSREBOQUE;

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
  [Table('VEI_DadosReboque', '')]
  TDtoVEI_DadosReboque = class
  private
    { Private declarations } 
    FVEI_TABELA: String;
    FVEI_TIPO: String;
    FVEI_CODIGO: Integer;
    FVEI_DESCRICAO: String;
    FVEI_PLACA: String;
    FVEI_CAPACIDADEKG: Double;
    FVEI_CAPACIDADEM3: Double;
    FVEI_TARAKG: Double;
    FVEI_UF: String;
    FVEI_NUMERORENAVAM: String;
    FVEI_TIPORODADO: String;
    FVEI_TIPOCARROCERIA: String;
    FFOR_CODIGO_PROPRIETARIO: Integer;
    FPES_CNPJ_CPF_PROPRIETARIO_VEI: String;
    FPES_RNTRC_PROPRIETARIO_VEI: String;
    FPES_NOME_PROPRIETARIO_VEI: String;
    FPES_IE_CI_PROPRIETARIO_VEI: String;
    FPES_UF_PROPRIETARIO_VEI: String;
    FPES_TIPOPESSOA_PROPRIETARIO_VEI: String;
  public 
    { Public declarations } 
     const Table      = 'VEI_DadosReboque';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_TABELA', ftString, 6)]
    [Dictionary('VEI_TABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TABELA: String read FVEI_TABELA write FVEI_TABELA;
    const VEI_TABELA_Name = 'VEI_TABELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_TIPO', ftString, 1)]
    [Dictionary('VEI_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPO: String read FVEI_TIPO write FVEI_TIPO;
    const VEI_TIPO_Name = 'VEI_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('VEI_CAPACIDADEKG', ftBCD)]
    [Dictionary('VEI_CAPACIDADEKG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_CAPACIDADEKG: Double read FVEI_CAPACIDADEKG write FVEI_CAPACIDADEKG;
    const VEI_CAPACIDADEKG_Name = 'VEI_CAPACIDADEKG';

    [Restrictions([NoValidate])]
    [Column('VEI_CAPACIDADEM3', ftBCD)]
    [Dictionary('VEI_CAPACIDADEM3', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_CAPACIDADEM3: Double read FVEI_CAPACIDADEM3 write FVEI_CAPACIDADEM3;
    const VEI_CAPACIDADEM3_Name = 'VEI_CAPACIDADEM3';

    [Restrictions([NoValidate])]
    [Column('VEI_TARAKG', ftBCD)]
    [Dictionary('VEI_TARAKG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_TARAKG: Double read FVEI_TARAKG write FVEI_TARAKG;
    const VEI_TARAKG_Name = 'VEI_TARAKG';

    [Restrictions([NoValidate])]
    [Column('VEI_UF', ftString, 2)]
    [Dictionary('VEI_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_UF: String read FVEI_UF write FVEI_UF;
    const VEI_UF_Name = 'VEI_UF';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMERORENAVAM', ftString, 15)]
    [Dictionary('VEI_NUMERORENAVAM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMERORENAVAM: String read FVEI_NUMERORENAVAM write FVEI_NUMERORENAVAM;
    const VEI_NUMERORENAVAM_Name = 'VEI_NUMERORENAVAM';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPORODADO', ftString, 2)]
    [Dictionary('VEI_TIPORODADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPORODADO: String read FVEI_TIPORODADO write FVEI_TIPORODADO;
    const VEI_TIPORODADO_Name = 'VEI_TIPORODADO';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPOCARROCERIA', ftString, 2)]
    [Dictionary('VEI_TIPOCARROCERIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPOCARROCERIA: String read FVEI_TIPOCARROCERIA write FVEI_TIPOCARROCERIA;
    const VEI_TIPOCARROCERIA_Name = 'VEI_TIPOCARROCERIA';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO_PROPRIETARIO', ftInteger)]
    [Dictionary('FOR_CODIGO_PROPRIETARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO_PROPRIETARIO: Integer read FFOR_CODIGO_PROPRIETARIO write FFOR_CODIGO_PROPRIETARIO;
    const FOR_CODIGO_PROPRIETARIO_Name = 'FOR_CODIGO_PROPRIETARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF_PROPRIETARIO_VEI', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF_PROPRIETARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF_PROPRIETARIO_VEI: String read FPES_CNPJ_CPF_PROPRIETARIO_VEI write FPES_CNPJ_CPF_PROPRIETARIO_VEI;
    const PES_CNPJ_CPF_PROPRIETARIO_VEI_Name = 'PES_CNPJ_CPF_PROPRIETARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_RNTRC_PROPRIETARIO_VEI', ftString, 14)]
    [Dictionary('PES_RNTRC_PROPRIETARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_RNTRC_PROPRIETARIO_VEI: String read FPES_RNTRC_PROPRIETARIO_VEI write FPES_RNTRC_PROPRIETARIO_VEI;
    const PES_RNTRC_PROPRIETARIO_VEI_Name = 'PES_RNTRC_PROPRIETARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_NOME_PROPRIETARIO_VEI', ftString, 100)]
    [Dictionary('PES_NOME_PROPRIETARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME_PROPRIETARIO_VEI: String read FPES_NOME_PROPRIETARIO_VEI write FPES_NOME_PROPRIETARIO_VEI;
    const PES_NOME_PROPRIETARIO_VEI_Name = 'PES_NOME_PROPRIETARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI_PROPRIETARIO_VEI', ftString, 16)]
    [Dictionary('PES_IE_CI_PROPRIETARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI_PROPRIETARIO_VEI: String read FPES_IE_CI_PROPRIETARIO_VEI write FPES_IE_CI_PROPRIETARIO_VEI;
    const PES_IE_CI_PROPRIETARIO_VEI_Name = 'PES_IE_CI_PROPRIETARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_UF_PROPRIETARIO_VEI', ftString, 2)]
    [Dictionary('PES_UF_PROPRIETARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_PROPRIETARIO_VEI: String read FPES_UF_PROPRIETARIO_VEI write FPES_UF_PROPRIETARIO_VEI;
    const PES_UF_PROPRIETARIO_VEI_Name = 'PES_UF_PROPRIETARIO_VEI';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA_PROPRIETARIO_VEI', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA_PROPRIETARIO_VEI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA_PROPRIETARIO_VEI: String read FPES_TIPOPESSOA_PROPRIETARIO_VEI write FPES_TIPOPESSOA_PROPRIETARIO_VEI;
    const PES_TIPOPESSOA_PROPRIETARIO_VEI_Name = 'PES_TIPOPESSOA_PROPRIETARIO_VEI';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVEI_DadosReboque)

end.
