unit express.dbo.PES_00_04;

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
  [Table('PES_00_04', '')]
  [PrimaryKey('PES_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PES_04_ID')]
  TDtoPES_00_04 = class
  private
    { Private declarations } 
    FPES_04_ID: Integer;
    FPES_CODIGO: Integer;
    FCNV_CODIGO: Integer;
    FCNV_DEFAULT: String;
    FCNV_MATRICULA: String;
    FPES_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PES_00_04';
     const PrimaryKey = 'PES_04_ID';
     const Sequence   = 'SEQ_PES_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_04_ID', ftInteger)]
    [Dictionary('PES_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_04_ID: Integer read FPES_04_ID write FPES_04_ID;
    const PES_04_ID_Name = 'PES_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CNV_CODIGO', ftInteger)]
    [Dictionary('CNV_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CNV_CODIGO: Integer read FCNV_CODIGO write FCNV_CODIGO;
    const CNV_CODIGO_Name = 'CNV_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CNV_DEFAULT', ftString, 1)]
    [Dictionary('CNV_DEFAULT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNV_DEFAULT: String read FCNV_DEFAULT write FCNV_DEFAULT;
    const CNV_DEFAULT_Name = 'CNV_DEFAULT';

    [Restrictions([NoValidate])]
    [Column('CNV_MATRICULA', ftString, 15)]
    [Dictionary('CNV_MATRICULA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNV_MATRICULA: String read FCNV_MATRICULA write FCNV_MATRICULA;
    const CNV_MATRICULA_Name = 'CNV_MATRICULA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATAALTERACAO', ftDateTime)]
    [Dictionary('PES_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATAALTERACAO: TDateTime read FPES_DATAALTERACAO write FPES_DATAALTERACAO;
    const PES_DATAALTERACAO_Name = 'PES_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPES_00_04)

end.
