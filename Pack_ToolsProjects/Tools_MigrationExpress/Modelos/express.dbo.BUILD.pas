unit express.dbo.BUILD;

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
  [Table('BUILD', '')]
  [PrimaryKey('BUILD_NUMBER', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BUILD_NUMBER')]
  TDtoBUILD = class
  private
    { Private declarations } 
    FBUILD_NUMBER: Integer;
    FBUILD_DATAATUALIZACAO: TDateTime;
    FBUILD_HORAATUALIZACAO: String;
    FBUILD_NESKI_EXPRESS_DB: String;
  public 
    { Public declarations } 
     const Table      = 'BUILD';
     const PrimaryKey = 'BUILD_NUMBER';
     const Sequence   = 'SEQ_BUILD_NUMBER';

    [Restrictions([NoValidate, NotNull])]
    [Column('BUILD_NUMBER', ftInteger)]
    [Dictionary('BUILD_NUMBER', 'Mensagem de validação', '0', '', '', taCenter)]
    property BUILD_NUMBER: Integer read FBUILD_NUMBER write FBUILD_NUMBER;
    const BUILD_NUMBER_Name = 'BUILD_NUMBER';

    [Restrictions([NoValidate])]
    [Column('BUILD_DATAATUALIZACAO', ftDateTime)]
    [Dictionary('BUILD_DATAATUALIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property BUILD_DATAATUALIZACAO: TDateTime read FBUILD_DATAATUALIZACAO write FBUILD_DATAATUALIZACAO;
    const BUILD_DATAATUALIZACAO_Name = 'BUILD_DATAATUALIZACAO';

    [Restrictions([NoValidate])]
    [Column('BUILD_HORAATUALIZACAO', ftString, 8)]
    [Dictionary('BUILD_HORAATUALIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BUILD_HORAATUALIZACAO: String read FBUILD_HORAATUALIZACAO write FBUILD_HORAATUALIZACAO;
    const BUILD_HORAATUALIZACAO_Name = 'BUILD_HORAATUALIZACAO';

    [Restrictions([NoValidate])]
    [Column('BUILD_NESKI_EXPRESS_DB', ftString, 1)]
    [Dictionary('BUILD_NESKI_EXPRESS_DB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BUILD_NESKI_EXPRESS_DB: String read FBUILD_NESKI_EXPRESS_DB write FBUILD_NESKI_EXPRESS_DB;
    const BUILD_NESKI_EXPRESS_DB_Name = 'BUILD_NESKI_EXPRESS_DB';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBUILD)

end.
