unit express.dbo.CTA_00_03;

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
  [Table('CTA_00_03', '')]
  [PrimaryKey('CTA_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTA_03_ID')]
  TDtoCTA_00_03 = class
  private
    { Private declarations } 
    FCTA_03_ID: Integer;
    FCTA_CODIGO: Integer;
    FCTA_DATAFECHAMENTO: TDateTime;
    FCTA_SALDOFECHAMENTO: Double;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CTA_00_03';
     const PrimaryKey = 'CTA_03_ID';
     const Sequence   = 'SEQ_CTA_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_03_ID', ftInteger)]
    [Dictionary('CTA_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_03_ID: Integer read FCTA_03_ID write FCTA_03_ID;
    const CTA_03_ID_Name = 'CTA_03_ID';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('CTA_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTA_DATAFECHAMENTO: TDateTime read FCTA_DATAFECHAMENTO write FCTA_DATAFECHAMENTO;
    const CTA_DATAFECHAMENTO_Name = 'CTA_DATAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_SALDOFECHAMENTO', ftBCD)]
    [Dictionary('CTA_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_SALDOFECHAMENTO: Double read FCTA_SALDOFECHAMENTO write FCTA_SALDOFECHAMENTO;
    const CTA_SALDOFECHAMENTO_Name = 'CTA_SALDOFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTA_00_03)

end.
