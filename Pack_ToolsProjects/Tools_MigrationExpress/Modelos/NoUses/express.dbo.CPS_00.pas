unit express.dbo.cps_00;

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
  [Table('CPS_00', 'SELECT * FROM CPS_00')]
  [PrimaryKey('CPS_ID', NotInc, NoSort, False, 'Chave primária')]
  TCPS_00 = class(TModelBase)
  private
    { Private declarations } 
    FCPS_ID: Integer;
    FCOM_CODIGO: String;
    FPES_CODIGO: Integer;
    FCPS_DATACADASTRO: Nullable<TDateTime>;
    FNTO_CODIGO: Nullable<Integer>;
    FMDO_CODIGO: Nullable<Integer>;
    FVND_CODIGO: Integer;
    FFPG_CODIGO: Nullable<Integer>;
    FCPS_VALORMENSALIDADE: Nullable<Double>;
    FCPS_VALORNOTAFISCAL: Nullable<Double>;
    FCPS_DIAPAGAMENTO: Nullable<String>;
    FCPS_RESPONSAVELFINANCEIRO: Nullable<String>;
    FCPS_PLANO: Nullable<String>;
    FCPS_PARAMETROS: Nullable<String>;
    FCPS_OBSERVACAO: Nullable<String>;
    FCPS_ULTIMOMESANOGERADO: Nullable<String>;
    FCPS_ULTIMANOTAFISCALGERADA: Nullable<Integer>;
    FCPS_DESATIVADO: String;
    FCPS_DATAALTERACAO: TDateTime;
    FCPS_ID_OLD: Nullable<Integer>;
  public 
    { Public declarations } 
    procedure ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); override; 

    [Restrictions([NotNull])]
    [Column('CPS_ID', ftInteger)]
    [Dictionary('CPS_ID', 'Mensagem de validação', '', '', '', taCenter)]
    property CPS_ID: Integer read FCPS_ID write FCPS_ID;

    [Restrictions([NotNull])]
    [Column('COM_CODIGO', ftString, 3)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGO: String read FCOM_CODIGO write FCOM_CODIGO;

    [Restrictions([NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;

    [Column('CPS_DATACADASTRO', ftDateTime)]
    [Dictionary('CPS_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPS_DATACADASTRO: Nullable<TDateTime> read FCPS_DATACADASTRO write FCPS_DATACADASTRO;

    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property NTO_CODIGO: Nullable<Integer> read FNTO_CODIGO write FNTO_CODIGO;

    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property MDO_CODIGO: Nullable<Integer> read FMDO_CODIGO write FMDO_CODIGO;

    [Restrictions([NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;

    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '', '', '', taCenter)]
    property FPG_CODIGO: Nullable<Integer> read FFPG_CODIGO write FFPG_CODIGO;

    [Column('CPS_VALORMENSALIDADE', ftBCD)]
    [Dictionary('CPS_VALORMENSALIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPS_VALORMENSALIDADE: Nullable<Double> read FCPS_VALORMENSALIDADE write FCPS_VALORMENSALIDADE;

    [Column('CPS_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('CPS_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPS_VALORNOTAFISCAL: Nullable<Double> read FCPS_VALORNOTAFISCAL write FCPS_VALORNOTAFISCAL;

    [Column('CPS_DIAPAGAMENTO', ftString, 2)]
    [Dictionary('CPS_DIAPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_DIAPAGAMENTO: Nullable<String> read FCPS_DIAPAGAMENTO write FCPS_DIAPAGAMENTO;

    [Column('CPS_RESPONSAVELFINANCEIRO', ftString, 50)]
    [Dictionary('CPS_RESPONSAVELFINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_RESPONSAVELFINANCEIRO: Nullable<String> read FCPS_RESPONSAVELFINANCEIRO write FCPS_RESPONSAVELFINANCEIRO;

    [Column('CPS_PLANO', ftString, 100)]
    [Dictionary('CPS_PLANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_PLANO: Nullable<String> read FCPS_PLANO write FCPS_PLANO;

    [Column('CPS_PARAMETROS', ftString, 30)]
    [Dictionary('CPS_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_PARAMETROS: Nullable<String> read FCPS_PARAMETROS write FCPS_PARAMETROS;

    [Column('CPS_OBSERVACAO', ftString, 5000)]
    [Dictionary('CPS_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_OBSERVACAO: Nullable<String> read FCPS_OBSERVACAO write FCPS_OBSERVACAO;

    [Column('CPS_ULTIMOMESANOGERADO', ftString, 6)]
    [Dictionary('CPS_ULTIMOMESANOGERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_ULTIMOMESANOGERADO: Nullable<String> read FCPS_ULTIMOMESANOGERADO write FCPS_ULTIMOMESANOGERADO;

    [Column('CPS_ULTIMANOTAFISCALGERADA', ftInteger)]
    [Dictionary('CPS_ULTIMANOTAFISCALGERADA', 'Mensagem de validação', '', '', '', taCenter)]
    property CPS_ULTIMANOTAFISCALGERADA: Nullable<Integer> read FCPS_ULTIMANOTAFISCALGERADA write FCPS_ULTIMANOTAFISCALGERADA;

    [Restrictions([NotNull])]
    [Column('CPS_DESATIVADO', ftString, 1)]
    [Dictionary('CPS_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_DESATIVADO: String read FCPS_DESATIVADO write FCPS_DESATIVADO;

    [Restrictions([NotNull])]
    [Column('CPS_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPS_DATAALTERACAO: TDateTime read FCPS_DATAALTERACAO write FCPS_DATAALTERACAO;

    [Column('CPS_ID_OLD', ftInteger)]
    [Dictionary('CPS_ID_OLD', 'Mensagem de validação', '', '', '', taCenter)]
    property CPS_ID_OLD: Nullable<Integer> read FCPS_ID_OLD write FCPS_ID_OLD;
  end;

implementation

uses ormbr.container.objectset; 

{ TCPS_00 } 

procedure TCPS_00.ObjectSetInsert(AObject: TObject;ASourceConn,ATargetConn:IDBConnection); 
var 
  LContainerObjectSet: TContainerObjectSet<TCPS_00>; 
begin 
  LContainerObjectSet := TContainerObjectSet<TCPS_00>.Create(ATargetConn); 
  try 
    LContainerObjectSet.Insert(TCPS_00(AObject)); 
  finally 
    FreeAndNil(LContainerObjectSet); 
  end; 
end; 

initialization
  TRegisterClass.RegisterEntity(TCPS_00);
  TCoreRegisterClass.RegisterEntity(TCPS_00);

end.
