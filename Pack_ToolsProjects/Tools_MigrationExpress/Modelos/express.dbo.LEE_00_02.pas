unit express.dbo.LEE_00_02;

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
  [Table('LEE_00_02', '')]
  [PrimaryKey('LEE_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LEE_02_ID')]
  TDtoLEE_00_02 = class
  private
    { Private declarations } 
    FLEE_02_ID: Integer;
    FLEE_CODIGO: Integer;
    FLEE_UF: String;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FMVA_CODIGO: Integer;
    FRBC_CODIGO: Integer;
    FAQT_CODIGO: Integer;
    FLEE_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'LEE_00_02';
     const PrimaryKey = 'LEE_02_ID';
     const Sequence   = 'SEQ_LEE_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_02_ID', ftInteger)]
    [Dictionary('LEE_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_02_ID: Integer read FLEE_02_ID write FLEE_02_ID;
    const LEE_02_ID_Name = 'LEE_02_ID';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_UF', ftString, 2)]
    [Dictionary('LEE_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_UF: String read FLEE_UF write FLEE_UF;
    const LEE_UF_Name = 'LEE_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MVA_CODIGO', ftInteger)]
    [Dictionary('MVA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MVA_CODIGO: Integer read FMVA_CODIGO write FMVA_CODIGO;
    const MVA_CODIGO_Name = 'MVA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RBC_CODIGO', ftInteger)]
    [Dictionary('RBC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property RBC_CODIGO: Integer read FRBC_CODIGO write FRBC_CODIGO;
    const RBC_CODIGO_Name = 'RBC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO', ftInteger)]
    [Dictionary('AQT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO: Integer read FAQT_CODIGO write FAQT_CODIGO;
    const AQT_CODIGO_Name = 'AQT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LEE_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LEE_DATAALTERACAO: TDateTime read FLEE_DATAALTERACAO write FLEE_DATAALTERACAO;
    const LEE_DATAALTERACAO_Name = 'LEE_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLEE_00_02)

end.
