unit express.dbo.CTA_00_01;

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
  [Table('CTA_00_01', '')]
  [PrimaryKey('CTA_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTA_01_ID')]
  TDtoCTA_00_01 = class
  private
    { Private declarations } 
    FCTA_01_ID: Integer;
    FCTA_CODIGO: Integer;
    FCTA_NOMECONTATO: String;
    FCTA_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CTA_00_01';
     const PrimaryKey = 'CTA_01_ID';
     const Sequence   = 'SEQ_CTA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_01_ID', ftInteger)]
    [Dictionary('CTA_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_01_ID: Integer read FCTA_01_ID write FCTA_01_ID;
    const CTA_01_ID_Name = 'CTA_01_ID';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_NOMECONTATO', ftString, 30)]
    [Dictionary('CTA_NOMECONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_NOMECONTATO: String read FCTA_NOMECONTATO write FCTA_NOMECONTATO;
    const CTA_NOMECONTATO_Name = 'CTA_NOMECONTATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTA_DATAALTERACAO: TDateTime read FCTA_DATAALTERACAO write FCTA_DATAALTERACAO;
    const CTA_DATAALTERACAO_Name = 'CTA_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTA_00_01)

end.
