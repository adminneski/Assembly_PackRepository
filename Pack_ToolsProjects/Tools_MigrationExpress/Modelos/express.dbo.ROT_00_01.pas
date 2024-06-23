unit express.dbo.ROT_00_01;

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
  [Table('ROT_00_01', '')]
  [PrimaryKey('ROT_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ROT_01_ID')]
  TDtoROT_00_01 = class
  private
    { Private declarations } 
    FROT_01_ID: Integer;
    FROT_CODIGO: Integer;
    FCID_IBGE: String;
    FROT_CIDADE: String;
    FROT_UF: String;
    FROT_BAIRRO: String;
    FROT_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'ROT_00_01';
     const PrimaryKey = 'ROT_01_ID';
     const Sequence   = 'SEQ_ROT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ROT_01_ID', ftInteger)]
    [Dictionary('ROT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_01_ID: Integer read FROT_01_ID write FROT_01_ID;
    const ROT_01_ID_Name = 'ROT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('ROT_CIDADE', ftString, 100)]
    [Dictionary('ROT_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_CIDADE: String read FROT_CIDADE write FROT_CIDADE;
    const ROT_CIDADE_Name = 'ROT_CIDADE';

    [Restrictions([NoValidate])]
    [Column('ROT_UF', ftString, 2)]
    [Dictionary('ROT_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_UF: String read FROT_UF write FROT_UF;
    const ROT_UF_Name = 'ROT_UF';

    [Restrictions([NoValidate])]
    [Column('ROT_BAIRRO', ftString, 72)]
    [Dictionary('ROT_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_BAIRRO: String read FROT_BAIRRO write FROT_BAIRRO;
    const ROT_BAIRRO_Name = 'ROT_BAIRRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ROT_DATAALTERACAO', ftDateTime)]
    [Dictionary('ROT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ROT_DATAALTERACAO: TDateTime read FROT_DATAALTERACAO write FROT_DATAALTERACAO;
    const ROT_DATAALTERACAO_Name = 'ROT_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoROT_00_01)

end.
