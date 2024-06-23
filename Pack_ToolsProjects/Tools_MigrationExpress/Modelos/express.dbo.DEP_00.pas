unit express.dbo.DEP_00;

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
  [Table('DEP_00', '')]
  [PrimaryKey('DEP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DEP_CODIGO')]
  TDtoDEP_00 = class
  private
    { Private declarations } 
    FDEP_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FDEP_DESCRICAO: String;
    FDEP_DATAALTERACAO: TDateTime;
    FDEP_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'DEP_00';
     const PrimaryKey = 'DEP_CODIGO';
     const Sequence   = 'SEQ_DEP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEP_CODIGO', ftInteger)]
    [Dictionary('DEP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEP_CODIGO: Integer read FDEP_CODIGO write FDEP_CODIGO;
    const DEP_CODIGO_Name = 'DEP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEP_DESCRICAO', ftString, 30)]
    [Dictionary('DEP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEP_DESCRICAO: String read FDEP_DESCRICAO write FDEP_DESCRICAO;
    const DEP_DESCRICAO_Name = 'DEP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEP_DATAALTERACAO', ftDateTime)]
    [Dictionary('DEP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DEP_DATAALTERACAO: TDateTime read FDEP_DATAALTERACAO write FDEP_DATAALTERACAO;
    const DEP_DATAALTERACAO_Name = 'DEP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DEP_DESATIVADO', ftString, 1)]
    [Dictionary('DEP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DEP_DESATIVADO: String read FDEP_DESATIVADO write FDEP_DESATIVADO;
    const DEP_DESATIVADO_Name = 'DEP_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDEP_00)

end.
