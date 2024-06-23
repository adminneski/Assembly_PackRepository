unit express.dbo.AFC_00;

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
  [Table('AFC_00', '')]
  [PrimaryKey('AFC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AFC_ID')]
  TDtoAFC_00 = class
  private
    { Private declarations } 
    FAFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FAFC_VALORCREDITO: Double;
    FAFC_OBSERVACAO: String;
    FAFC_GERAMOVTOCAIXA: String;
    FAFC_DATALANCAMENTO: TDateTime;
    FAFC_DATAALTERACAO: TDateTime;
    FAFC_ID_OLD: Integer;
    FAFC_TIPO: String;
  public 
    { Public declarations } 
     const Table      = 'AFC_00';
     const PrimaryKey = 'AFC_ID';
     const Sequence   = 'SEQ_AFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_ID', ftInteger)]
    [Dictionary('AFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property AFC_ID: Integer read FAFC_ID write FAFC_ID;
    const AFC_ID_Name = 'AFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_VALORCREDITO', ftBCD)]
    [Dictionary('AFC_VALORCREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AFC_VALORCREDITO: Double read FAFC_VALORCREDITO write FAFC_VALORCREDITO;
    const AFC_VALORCREDITO_Name = 'AFC_VALORCREDITO';

    [Restrictions([NoValidate])]
    [Column('AFC_OBSERVACAO', ftString, 300)]
    [Dictionary('AFC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AFC_OBSERVACAO: String read FAFC_OBSERVACAO write FAFC_OBSERVACAO;
    const AFC_OBSERVACAO_Name = 'AFC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('AFC_GERAMOVTOCAIXA', ftString, 1)]
    [Dictionary('AFC_GERAMOVTOCAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AFC_GERAMOVTOCAIXA: String read FAFC_GERAMOVTOCAIXA write FAFC_GERAMOVTOCAIXA;
    const AFC_GERAMOVTOCAIXA_Name = 'AFC_GERAMOVTOCAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('AFC_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property AFC_DATALANCAMENTO: TDateTime read FAFC_DATALANCAMENTO write FAFC_DATALANCAMENTO;
    const AFC_DATALANCAMENTO_Name = 'AFC_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('AFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('AFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property AFC_DATAALTERACAO: TDateTime read FAFC_DATAALTERACAO write FAFC_DATAALTERACAO;
    const AFC_DATAALTERACAO_Name = 'AFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('AFC_ID_OLD', ftInteger)]
    [Dictionary('AFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property AFC_ID_OLD: Integer read FAFC_ID_OLD write FAFC_ID_OLD;
    const AFC_ID_OLD_Name = 'AFC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('AFC_TIPO', ftString, 3)]
    [Dictionary('AFC_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AFC_TIPO: String read FAFC_TIPO write FAFC_TIPO;
    const AFC_TIPO_Name = 'AFC_TIPO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAFC_00)

end.
