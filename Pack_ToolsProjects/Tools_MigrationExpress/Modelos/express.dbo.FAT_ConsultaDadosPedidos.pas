unit express.dbo.FAT_CONSULTADADOSPEDIDOS;

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
  [Table('FAT_ConsultaDadosPedidos', '')]
  TDtoFAT_ConsultaDadosPedidos = class
  private
    { Private declarations } 
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_NUMEROOC: Integer;
    FFAT_NUMERODOCTOREPRESENTANTE: String;
    FPES_NOME: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_TOTALLIQUIDO: Double;
    FFAT_TIPOMOVTO: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_BAIRRO: String;
  public 
    { Public declarations } 
     const Table      = 'FAT_ConsultaDadosPedidos';

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
    [Column('FAT_NUMEROOC', ftInteger)]
    [Dictionary('FAT_NUMEROOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROOC: Integer read FFAT_NUMEROOC write FFAT_NUMEROOC;
    const FAT_NUMEROOC_Name = 'FAT_NUMEROOC';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTOREPRESENTANTE: String read FFAT_NUMERODOCTOREPRESENTANTE write FFAT_NUMERODOCTOREPRESENTANTE;
    const FAT_NUMERODOCTOREPRESENTANTE_Name = 'FAT_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALLIQUIDO', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOMOVTO', ftString, 3)]
    [Dictionary('FAT_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOMOVTO: String read FFAT_TIPOMOVTO write FFAT_TIPOMOVTO;
    const FAT_TIPOMOVTO_Name = 'FAT_TIPOMOVTO';

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
  TRegisterClass.RegisterEntity(TDtoFAT_ConsultaDadosPedidos)

end.
