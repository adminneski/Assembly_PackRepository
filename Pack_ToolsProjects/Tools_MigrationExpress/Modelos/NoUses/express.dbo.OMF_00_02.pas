unit express.dbo.omf_00_02;

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
  [Table('OMF_00_02', 'SELECT * FROM OMF_00_02')]
  [PrimaryKey('OMF_02_ID', NotInc, NoSort, False, 'Chave primária')]
  TOMF_00_02 = class(TModelBase)
  private
    { Private declarations } 
    FOMF_02_ID: Integer;
    FCOM_CODIGO: String;
    FOMF_ID: Integer;
    FOMF_UF: Nullable<String>;
    FPRO_CODIGO: Integer;
    FPES_TIPOCLIENTE: String;
    FOMF_VALORVENDASUGERIDO: Double;
    FOMF_VALORVENDAADOTADO: Double;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: Nullable<String>;
    FOMF_02_ID_OLD: Nullable<Integer>;
    FOMF_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('OMF_02_ID', ftInteger)]
    [Dictionary('OMF_02_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_02_ID: Integer read FOMF_02_ID write FOMF_02_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;

    [Column('OMF_UF', ftString, 2)]
    [Dictionary('OMF_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_UF: Nullable<String> read FOMF_UF write FOMF_UF;

    [Restrictions([NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;

    [Restrictions([NotNull])]
    [Column('PES_TIPOCLIENTE', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE: String read FPES_TIPOCLIENTE write FPES_TIPOCLIENTE;

    [Restrictions([NotNull])]
    [Column('OMF_VALORVENDASUGERIDO', ftBCD)]
    [Dictionary('OMF_VALORVENDASUGERIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORVENDASUGERIDO: Double read FOMF_VALORVENDASUGERIDO write FOMF_VALORVENDASUGERIDO;

    [Restrictions([NotNull])]
    [Column('OMF_VALORVENDAADOTADO', ftBCD)]
    [Dictionary('OMF_VALORVENDAADOTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORVENDAADOTADO: Double read FOMF_VALORVENDAADOTADO write FOMF_VALORVENDAADOTADO;

    [Restrictions([NotNull])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;

    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: Nullable<String> read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;

    [Column('OMF_02_ID_OLD', ftInteger)]
    [Dictionary('OMF_02_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_02_ID_OLD: Nullable<Integer> read FOMF_02_ID_OLD write FOMF_02_ID_OLD;

    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_ID_OLD: Nullable<Integer> read FOMF_ID_OLD write FOMF_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TOMF_00_02 } 

procedure TOMF_00_02.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TOMF_00_02>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TOMF_00_02>.Create(ATargetConn); 
  try
    TOMF_00_02(AObject).OMF_02_ID := IncCodigo('XXX','OMF_02_ID',ATargetConn);
    LContainerObjectSet.Insert(TOMF_00_02(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TOMF_00_02);
  TCoreRegisterClass.RegisterEntity(TOMF_00_02);

end.
