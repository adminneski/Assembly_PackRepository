unit express.dbo.VW_NSK_EDICAOSQLSERVER;

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
  [Table('VW_NSK_EdicaoSQLServer', '')]
  TDtoVW_NSK_EdicaoSQLServer = class
  private
    { Private declarations } 
    FEDICAO: TBlob;
    FSP: TBlob;
    FVERSAO: TBlob;
  public 
    { Public declarations } 
     const Table      = 'VW_NSK_EdicaoSQLServer';

    [Restrictions([NoValidate])]
    [Column('EDICAO', ftBlob)]
    [Dictionary('EDICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EDICAO: TBlob read FEDICAO write FEDICAO;
    const EDICAO_Name = 'EDICAO';

    [Restrictions([NoValidate])]
    [Column('SP', ftBlob)]
    [Dictionary('SP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SP: TBlob read FSP write FSP;
    const SP_Name = 'SP';

    [Restrictions([NoValidate])]
    [Column('VERSAO', ftBlob)]
    [Dictionary('VERSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VERSAO: TBlob read FVERSAO write FVERSAO;
    const VERSAO_Name = 'VERSAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_NSK_EdicaoSQLServer)

end.
