unit express.dbo.OMF_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.omf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('OMF_00_04', '')]
  [PrimaryKey('OMF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_ID')]
  TDtoOMF_00_04 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FOMF_DOCTODUA: String;
    FOMF_TOTALICMSRDUA: Double;
    FOMF_DATAVENCIMENTO: TDateTime;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: String;
    FOMF_ID_OLD: Integer;

    FOMF_00_0:  TOMF_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'OMF_00_04';
     const PrimaryKey = 'OMF_ID';
     const Sequence   = 'SEQ_OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_04_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DOCTODUA', ftString, 15)]
    [Dictionary('OMF_DOCTODUA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_DOCTODUA: String read FOMF_DOCTODUA write FOMF_DOCTODUA;
    const OMF_DOCTODUA_Name = 'OMF_DOCTODUA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALICMSRDUA', ftBCD, 18, 4)]
    [Dictionary('OMF_TOTALICMSRDUA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSRDUA: Double read FOMF_TOTALICMSRDUA write FOMF_TOTALICMSRDUA;
    const OMF_TOTALICMSRDUA_Name = 'OMF_TOTALICMSRDUA';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('OMF_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAVENCIMENTO: TDateTime read FOMF_DATAVENCIMENTO write FOMF_DATAVENCIMENTO;
    const OMF_DATAVENCIMENTO_Name = 'OMF_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: String read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;
    const OMF_INTEGRACAOERP_Name = 'OMF_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';

    [Association(OneToOne,'OMF_ID','OMF_00','OMF_ID')]
    property OMF_00: TOMF_00 read FOMF_00_0 write FOMF_00_0;

  end;

implementation

constructor TOMF_00_04.Create;
begin
  FOMF_00_0 := TOMF_00.Create;
end;

destructor TOMF_00_04.Destroy;
begin
  if Assigned(FOMF_00_0) then
    FOMF_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_04)

end.
