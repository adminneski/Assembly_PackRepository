unit express.dbo.omf_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  // ORMbr
  ormbr.types.blob,
  ormbr.types.lazy,
  dbcbr.types.mapping,
  ormbr.types.nullable,
  dbcbr.mapping.classes,
  dbcbr.mapping.register,
  dbcbr.mapping.attributes,
  dbebr.factory.interfaces,
  Core.Register, 
  Model.Base;  

type
  [Entity]
  [Table('OMF_00_04', 'SELECT * FROM OMF_00_04')]
  [PrimaryKey('OMF_ID', NotInc, NoSort, False, 'Chave primária')]
  TOMF_00_04 = class(TModelBase)
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: String;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Nullable<Integer>;
    FCCU_CODIGO: Nullable<Integer>;
    FOMF_DOCTODUA: String;
    FOMF_TOTALICMSRDUA: Double;
    FOMF_DATAVENCIMENTO: Nullable<TDateTime>;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: Nullable<String>;
    FOMF_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;

    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PLC_CODIGO: Nullable<Integer> read FPLC_CODIGO write FPLC_CODIGO;

    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCU_CODIGO: Nullable<Integer> read FCCU_CODIGO write FCCU_CODIGO;

    [Restrictions([NotNull])]
    [Column('OMF_DOCTODUA', ftString, 15)]
    [Dictionary('OMF_DOCTODUA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_DOCTODUA: String read FOMF_DOCTODUA write FOMF_DOCTODUA;

    [Restrictions([NotNull])]
    [Column('OMF_TOTALICMSRDUA', ftBCD, 18, 4)]
    [Dictionary('OMF_TOTALICMSRDUA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALICMSRDUA: Double read FOMF_TOTALICMSRDUA write FOMF_TOTALICMSRDUA;

    [Column('OMF_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('OMF_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAVENCIMENTO: Nullable<TDateTime> read FOMF_DATAVENCIMENTO write FOMF_DATAVENCIMENTO;

    [Restrictions([NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;

    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: Nullable<String> read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;

    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_ID_OLD: Nullable<Integer> read FOMF_ID_OLD write FOMF_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TOMF_00_04 } 

procedure TOMF_00_04.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TOMF_00_04>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TOMF_00_04>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TOMF_00_04(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TOMF_00_04);
  TCoreRegisterClass.RegisterEntity(TOMF_00_04);

end.
