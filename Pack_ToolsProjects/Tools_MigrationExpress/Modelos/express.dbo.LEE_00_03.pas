unit express.dbo.LEE_00_03;

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
  [Table('LEE_00_03', '')]
  [PrimaryKey('LEE_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LEE_03_ID')]
  TDtoLEE_00_03 = class
  private
    { Private declarations } 
    FLEE_03_ID: Integer;
    FLEE_CODIGO: Integer;
    FLEE_UF: String;
    FCST_CODIGO: String;
    FMVA_CODIGO: Integer;
    FRBC_CODIGO: Integer;
    FAQT_CODIGO: Integer;
    FCFOP_CODIGO: String;
    FRBC_CODIGO_ST: Integer;
    FLEE_PERCENTUALFCP: Double;
    FLEE_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
    FLEE_ICMSDESONERADO: String;
    FLEE_MOTIVODESONERACAO: String;
    FLEE_CODIGOBENEFICIO: String;
    FLEE_PERCENTUALICMSCOMPETE: Double;
  public 
    { Public declarations } 
     const Table      = 'LEE_00_03';
     const PrimaryKey = 'LEE_03_ID';
     const Sequence   = 'SEQ_LEE_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_03_ID', ftInteger)]
    [Dictionary('LEE_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_03_ID: Integer read FLEE_03_ID write FLEE_03_ID;
    const LEE_03_ID_Name = 'LEE_03_ID';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_UF', ftString, 2)]
    [Dictionary('LEE_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_UF: String read FLEE_UF write FLEE_UF;
    const LEE_UF_Name = 'LEE_UF';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('AQT_CODIGO', ftInteger)]
    [Dictionary('AQT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO: Integer read FAQT_CODIGO write FAQT_CODIGO;
    const AQT_CODIGO_Name = 'AQT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RBC_CODIGO_ST', ftInteger)]
    [Dictionary('RBC_CODIGO_ST', 'Mensagem de validação', '0', '', '', taCenter)]
    property RBC_CODIGO_ST: Integer read FRBC_CODIGO_ST write FRBC_CODIGO_ST;
    const RBC_CODIGO_ST_Name = 'RBC_CODIGO_ST';

    [Restrictions([NoValidate])]
    [Column('LEE_PERCENTUALFCP', ftBCD)]
    [Dictionary('LEE_PERCENTUALFCP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEE_PERCENTUALFCP: Double read FLEE_PERCENTUALFCP write FLEE_PERCENTUALFCP;
    const LEE_PERCENTUALFCP_Name = 'LEE_PERCENTUALFCP';

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

    [Restrictions([NoValidate])]
    [Column('LEE_ICMSDESONERADO', ftString, 1)]
    [Dictionary('LEE_ICMSDESONERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_ICMSDESONERADO: String read FLEE_ICMSDESONERADO write FLEE_ICMSDESONERADO;
    const LEE_ICMSDESONERADO_Name = 'LEE_ICMSDESONERADO';

    [Restrictions([NoValidate])]
    [Column('LEE_MOTIVODESONERACAO', ftString, 2)]
    [Dictionary('LEE_MOTIVODESONERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_MOTIVODESONERACAO: String read FLEE_MOTIVODESONERACAO write FLEE_MOTIVODESONERACAO;
    const LEE_MOTIVODESONERACAO_Name = 'LEE_MOTIVODESONERACAO';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGOBENEFICIO', ftString, 10)]
    [Dictionary('LEE_CODIGOBENEFICIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_CODIGOBENEFICIO: String read FLEE_CODIGOBENEFICIO write FLEE_CODIGOBENEFICIO;
    const LEE_CODIGOBENEFICIO_Name = 'LEE_CODIGOBENEFICIO';

    [Restrictions([NoValidate])]
    [Column('LEE_PERCENTUALICMSCOMPETE', ftBCD)]
    [Dictionary('LEE_PERCENTUALICMSCOMPETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEE_PERCENTUALICMSCOMPETE: Double read FLEE_PERCENTUALICMSCOMPETE write FLEE_PERCENTUALICMSCOMPETE;
    const LEE_PERCENTUALICMSCOMPETE_Name = 'LEE_PERCENTUALICMSCOMPETE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLEE_00_03)

end.
