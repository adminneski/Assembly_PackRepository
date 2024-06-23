unit express.dbo.CSTI_00;

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
  [Table('CSTI_00', '')]
  [PrimaryKey('CSTI_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CSTI_CODIGO')]
  TDtoCSTI_00 = class
  private
    { Private declarations } 
    FCSTI_CODIGO: String;
    FCSTI_DESCRICAO: String;
    FCSTI_TRIBUTADO: String;
    FCSTI_DESATIVADO: String;
    FCSTI_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'CSTI_00';
     const PrimaryKey = 'CSTI_CODIGO';
     const Sequence   = 'SEQ_CSTI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CSTI_CODIGO', ftString, 2)]
    [Dictionary('CSTI_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTI_CODIGO: String read FCSTI_CODIGO write FCSTI_CODIGO;
    const CSTI_CODIGO_Name = 'CSTI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTI_DESCRICAO', ftString, 300)]
    [Dictionary('CSTI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTI_DESCRICAO: String read FCSTI_DESCRICAO write FCSTI_DESCRICAO;
    const CSTI_DESCRICAO_Name = 'CSTI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CSTI_TRIBUTADO', ftString, 1)]
    [Dictionary('CSTI_TRIBUTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTI_TRIBUTADO: String read FCSTI_TRIBUTADO write FCSTI_TRIBUTADO;
    const CSTI_TRIBUTADO_Name = 'CSTI_TRIBUTADO';

    [Restrictions([NoValidate])]
    [Column('CSTI_DESATIVADO', ftString, 1)]
    [Dictionary('CSTI_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTI_DESATIVADO: String read FCSTI_DESATIVADO write FCSTI_DESATIVADO;
    const CSTI_DESATIVADO_Name = 'CSTI_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CSTI_DATAALTERACAO', ftDateTime)]
    [Dictionary('CSTI_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CSTI_DATAALTERACAO: TDateTime read FCSTI_DATAALTERACAO write FCSTI_DATAALTERACAO;
    const CSTI_DATAALTERACAO_Name = 'CSTI_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCSTI_00)

end.
