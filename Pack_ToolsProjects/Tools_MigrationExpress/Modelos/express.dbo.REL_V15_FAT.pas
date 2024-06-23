unit express.dbo.REL_V15_FAT;

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
  [Table('REL_V15_FAT', '')]
  TDtoREL_V15_FAT = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V15_FAT';

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
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V15_FAT)

end.
