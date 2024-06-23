unit express.dbo.CTA_00_04;

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
  [Table('CTA_00_04', '')]
  [PrimaryKey('CTA_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTA_04_ID')]
  TDtoCTA_00_04 = class
  private
    { Private declarations } 
    FCTA_04_ID: Integer;
    FCTA_CODIGO: Integer;
    FUSERS_LOGIN: String;
    FCTA_LIBERALANCAMENTO: String;
    FCTA_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CTA_00_04';
     const PrimaryKey = 'CTA_04_ID';
     const Sequence   = 'SEQ_CTA_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_04_ID', ftInteger)]
    [Dictionary('CTA_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_04_ID: Integer read FCTA_04_ID write FCTA_04_ID;
    const CTA_04_ID_Name = 'CTA_04_ID';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('CTA_LIBERALANCAMENTO', ftString, 1)]
    [Dictionary('CTA_LIBERALANCAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_LIBERALANCAMENTO: String read FCTA_LIBERALANCAMENTO write FCTA_LIBERALANCAMENTO;
    const CTA_LIBERALANCAMENTO_Name = 'CTA_LIBERALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTA_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
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
  TRegisterClass.RegisterEntity(TDtoCTA_00_04)

end.
