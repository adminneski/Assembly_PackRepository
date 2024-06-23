unit express.dbo.VW_PSQ_ATB;

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
  [Table('VW_PSQ_ATB', '')]
  TDtoVW_PSQ_ATB = class
  private
    { Private declarations } 
    FATB_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FATB_UF: String;
    FATB_DESATIVADO: String;
    FPES_NOME: String;
    FATB_CREDENCIADO_BEBIDA: String;
    FATB_CREDENCIADO_NORMAL: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_ATB';

    [Restrictions([NoValidate, NotNull])]
    [Column('ATB_CODIGO', ftInteger)]
    [Dictionary('ATB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ATB_CODIGO: Integer read FATB_CODIGO write FATB_CODIGO;
    const ATB_CODIGO_Name = 'ATB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ATB_UF', ftString, 2)]
    [Dictionary('ATB_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ATB_UF: String read FATB_UF write FATB_UF;
    const ATB_UF_Name = 'ATB_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('ATB_DESATIVADO', ftString, 1)]
    [Dictionary('ATB_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ATB_DESATIVADO: String read FATB_DESATIVADO write FATB_DESATIVADO;
    const ATB_DESATIVADO_Name = 'ATB_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('ATB_CREDENCIADO_BEBIDA', ftString, 1)]
    [Dictionary('ATB_CREDENCIADO_BEBIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ATB_CREDENCIADO_BEBIDA: String read FATB_CREDENCIADO_BEBIDA write FATB_CREDENCIADO_BEBIDA;
    const ATB_CREDENCIADO_BEBIDA_Name = 'ATB_CREDENCIADO_BEBIDA';

    [Restrictions([NoValidate])]
    [Column('ATB_CREDENCIADO_NORMAL', ftString, 1)]
    [Dictionary('ATB_CREDENCIADO_NORMAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ATB_CREDENCIADO_NORMAL: String read FATB_CREDENCIADO_NORMAL write FATB_CREDENCIADO_NORMAL;
    const ATB_CREDENCIADO_NORMAL_Name = 'ATB_CREDENCIADO_NORMAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_ATB)

end.
