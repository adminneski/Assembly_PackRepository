unit express.dbo.PES_00_06;

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
  [Table('PES_00_06', '')]
  [PrimaryKey('PES_06_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PES_06_ID')]
  TDtoPES_00_06 = class
  private
    { Private declarations } 
    FPES_06_ID: Integer;
    FPES_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FHSP_QUANTIDADECULTURA: Double;
    FHSP_ESPECIECULTURA: String;
    FHSP_DEFAULT: String;
    FPES_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PES_00_06';
     const PrimaryKey = 'PES_06_ID';
     const Sequence   = 'SEQ_PES_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_06_ID', ftInteger)]
    [Dictionary('PES_06_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_06_ID: Integer read FPES_06_ID write FPES_06_ID;
    const PES_06_ID_Name = 'PES_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('HSP_QUANTIDADECULTURA', ftBCD, 7077999, 2)]
    [Dictionary('HSP_QUANTIDADECULTURA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property HSP_QUANTIDADECULTURA: Double read FHSP_QUANTIDADECULTURA write FHSP_QUANTIDADECULTURA;
    const HSP_QUANTIDADECULTURA_Name = 'HSP_QUANTIDADECULTURA';

    [Restrictions([NoValidate])]
    [Column('HSP_ESPECIECULTURA', ftString, 20)]
    [Dictionary('HSP_ESPECIECULTURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HSP_ESPECIECULTURA: String read FHSP_ESPECIECULTURA write FHSP_ESPECIECULTURA;
    const HSP_ESPECIECULTURA_Name = 'HSP_ESPECIECULTURA';

    [Restrictions([NoValidate, NotNull])]
    [Column('HSP_DEFAULT', ftString, 1)]
    [Dictionary('HSP_DEFAULT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HSP_DEFAULT: String read FHSP_DEFAULT write FHSP_DEFAULT;
    const HSP_DEFAULT_Name = 'HSP_DEFAULT';

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
  TRegisterClass.RegisterEntity(TDtoPES_00_06)

end.
