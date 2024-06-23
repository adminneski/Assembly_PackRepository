unit express.dbo.MTA_00_01;

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
  [Table('MTA_00_01', '')]
  [PrimaryKey('MTA_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MTA_01_ID')]
  TDtoMTA_00_01 = class
  private
    { Private declarations } 
    FMTA_01_ID: Integer;
    FMTA_CODIGO: Integer;
    FCID_IBGE: String;
    FMTA_UF: String;
    FMTA_VALORCIDADE: Double;
    FMTA_DATAALTERACAO: TDateTime;
    FMTA_CIDADE: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MTA_00_01';
     const PrimaryKey = 'MTA_01_ID';
     const Sequence   = 'SEQ_MTA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_01_ID', ftInteger)]
    [Dictionary('MTA_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTA_01_ID: Integer read FMTA_01_ID write FMTA_01_ID;
    const MTA_01_ID_Name = 'MTA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_CODIGO', ftInteger)]
    [Dictionary('MTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTA_CODIGO: Integer read FMTA_CODIGO write FMTA_CODIGO;
    const MTA_CODIGO_Name = 'MTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('MTA_UF', ftString, 2)]
    [Dictionary('MTA_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_UF: String read FMTA_UF write FMTA_UF;
    const MTA_UF_Name = 'MTA_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_VALORCIDADE', ftBCD)]
    [Dictionary('MTA_VALORCIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MTA_VALORCIDADE: Double read FMTA_VALORCIDADE write FMTA_VALORCIDADE;
    const MTA_VALORCIDADE_Name = 'MTA_VALORCIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('MTA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTA_DATAALTERACAO: TDateTime read FMTA_DATAALTERACAO write FMTA_DATAALTERACAO;
    const MTA_DATAALTERACAO_Name = 'MTA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MTA_CIDADE', ftString, 100)]
    [Dictionary('MTA_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTA_CIDADE: String read FMTA_CIDADE write FMTA_CIDADE;
    const MTA_CIDADE_Name = 'MTA_CIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMTA_00_01)

end.
