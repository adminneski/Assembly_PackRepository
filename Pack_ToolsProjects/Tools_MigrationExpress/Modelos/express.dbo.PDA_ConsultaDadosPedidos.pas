unit express.dbo.PDA_CONSULTADADOSPEDIDOS;

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
  [Table('PDA_ConsultaDadosPedidos', '')]
  TDtoPDA_ConsultaDadosPedidos = class
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDA_NUMERODOCTO: String;
    FPDA_NUMERODOCTOREPRESENTANTE: String;
    FPES_NOME: String;
    FPDA_DATALANCAMENTO: TDateTime;
    FPDA_TOTALLIQUIDO: Double;
    FPDA_TIPODOCUMENTO: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_BAIRRO: String;
  public 
    { Public declarations } 
     const Table      = 'PDA_ConsultaDadosPedidos';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_NUMERODOCTO', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTO: String read FPDA_NUMERODOCTO write FPDA_NUMERODOCTO;
    const PDA_NUMERODOCTO_Name = 'PDA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTOREPRESENTANTE: String read FPDA_NUMERODOCTOREPRESENTANTE write FPDA_NUMERODOCTOREPRESENTANTE;
    const PDA_NUMERODOCTOREPRESENTANTE_Name = 'PDA_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATALANCAMENTO: TDateTime read FPDA_DATALANCAMENTO write FPDA_DATALANCAMENTO;
    const PDA_DATALANCAMENTO_Name = 'PDA_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALLIQUIDO', ftBCD)]
    [Dictionary('PDA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALLIQUIDO: Double read FPDA_TOTALLIQUIDO write FPDA_TOTALLIQUIDO;
    const PDA_TOTALLIQUIDO_Name = 'PDA_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PDA_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('PDA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPODOCUMENTO: String read FPDA_TIPODOCUMENTO write FPDA_TIPODOCUMENTO;
    const PDA_TIPODOCUMENTO_Name = 'PDA_TIPODOCUMENTO';

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
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPDA_ConsultaDadosPedidos)

end.
