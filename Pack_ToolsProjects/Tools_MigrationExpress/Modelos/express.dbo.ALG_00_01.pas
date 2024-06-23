unit express.dbo.ALG_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.alg_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ALG_00_01', '')]
  [PrimaryKey('ALG_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ALG_01_ID')]
  TDtoALG_00_01 = class
  private
    { Private declarations } 
    FALG_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FALG_ID: Integer;
    FPRO_CODIGO: Integer;
    FTAB_CODIGO: Integer;
    FALG_DESCRICAO: String;
    FALG_QTDPEDIDA: Double;
    FALG_PRECOUNITARIO: Double;
    FALG_TOTALPRECO: Double;
    FALG_TOTALPRECOLIQUIDO: Double;
    FALG_TOTALDESCTOAVULSOITEM: Double;
    FALG_DATAALTERACAO: TDateTime;
    FALG_STATUS: String;
    FALG_DATARETIRADAITEM: TDateTime;
    FALG_DATADEVOLUCAOITEM: TDateTime;
    FALG_OBSERVACAOITEM: String;
    FALG_01_ID_OLD: Integer;
    FALG_ID_OLD: Integer;

    FALG_00_0:  TALG_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'ALG_00_01';
     const PrimaryKey = 'ALG_01_ID';
     const Sequence   = 'SEQ_ALG_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_01_ID', ftInteger)]
    [Dictionary('ALG_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_01_ID: Integer read FALG_01_ID write FALG_01_ID;
    const ALG_01_ID_Name = 'ALG_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_ID', ftInteger)]
    [ForeignKey('ALG_00_01_fk', 'ALG_ID', 'ALG_00', 'ALG_ID', SetNull, SetNull)]
    [Dictionary('ALG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_ID: Integer read FALG_ID write FALG_ID;
    const ALG_ID_Name = 'ALG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ALG_DESCRICAO', ftString, 100)]
    [Dictionary('ALG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_DESCRICAO: String read FALG_DESCRICAO write FALG_DESCRICAO;
    const ALG_DESCRICAO_Name = 'ALG_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('ALG_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_QTDPEDIDA: Double read FALG_QTDPEDIDA write FALG_QTDPEDIDA;
    const ALG_QTDPEDIDA_Name = 'ALG_QTDPEDIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_PRECOUNITARIO', ftBCD)]
    [Dictionary('ALG_PRECOUNITARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_PRECOUNITARIO: Double read FALG_PRECOUNITARIO write FALG_PRECOUNITARIO;
    const ALG_PRECOUNITARIO_Name = 'ALG_PRECOUNITARIO';

    [Restrictions([NoValidate])]
    [Column('ALG_TOTALPRECO', ftBCD)]
    [Dictionary('ALG_TOTALPRECO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALPRECO: Double read FALG_TOTALPRECO write FALG_TOTALPRECO;
    const ALG_TOTALPRECO_Name = 'ALG_TOTALPRECO';

    [Restrictions([NoValidate])]
    [Column('ALG_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('ALG_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALPRECOLIQUIDO: Double read FALG_TOTALPRECOLIQUIDO write FALG_TOTALPRECOLIQUIDO;
    const ALG_TOTALPRECOLIQUIDO_Name = 'ALG_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ALG_TOTALDESCTOAVULSOITEM', ftBCD)]
    [Dictionary('ALG_TOTALDESCTOAVULSOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALDESCTOAVULSOITEM: Double read FALG_TOTALDESCTOAVULSOITEM write FALG_TOTALDESCTOAVULSOITEM;
    const ALG_TOTALDESCTOAVULSOITEM_Name = 'ALG_TOTALDESCTOAVULSOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ALG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAALTERACAO: TDateTime read FALG_DATAALTERACAO write FALG_DATAALTERACAO;
    const ALG_DATAALTERACAO_Name = 'ALG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ALG_STATUS', ftString, 1)]
    [Dictionary('ALG_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_STATUS: String read FALG_STATUS write FALG_STATUS;
    const ALG_STATUS_Name = 'ALG_STATUS';

    [Restrictions([NoValidate])]
    [Column('ALG_DATARETIRADAITEM', ftDateTime)]
    [Dictionary('ALG_DATARETIRADAITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATARETIRADAITEM: TDateTime read FALG_DATARETIRADAITEM write FALG_DATARETIRADAITEM;
    const ALG_DATARETIRADAITEM_Name = 'ALG_DATARETIRADAITEM';

    [Restrictions([NoValidate])]
    [Column('ALG_DATADEVOLUCAOITEM', ftDateTime)]
    [Dictionary('ALG_DATADEVOLUCAOITEM', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATADEVOLUCAOITEM: TDateTime read FALG_DATADEVOLUCAOITEM write FALG_DATADEVOLUCAOITEM;
    const ALG_DATADEVOLUCAOITEM_Name = 'ALG_DATADEVOLUCAOITEM';

    [Restrictions([NoValidate])]
    [Column('ALG_OBSERVACAOITEM', ftString, 5000)]
    [Dictionary('ALG_OBSERVACAOITEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_OBSERVACAOITEM: String read FALG_OBSERVACAOITEM write FALG_OBSERVACAOITEM;
    const ALG_OBSERVACAOITEM_Name = 'ALG_OBSERVACAOITEM';

    [Restrictions([NoValidate])]
    [Column('ALG_01_ID_OLD', ftInteger)]
    [Dictionary('ALG_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_01_ID_OLD: Integer read FALG_01_ID_OLD write FALG_01_ID_OLD;
    const ALG_01_ID_OLD_Name = 'ALG_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ALG_ID_OLD', ftInteger)]
    [Dictionary('ALG_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_ID_OLD: Integer read FALG_ID_OLD write FALG_ID_OLD;
    const ALG_ID_OLD_Name = 'ALG_ID_OLD';

    [Association(OneToOne,'ALG_ID','ALG_00','ALG_ID')]
    property ALG_00: TALG_00 read FALG_00_0 write FALG_00_0;

  end;

implementation

constructor TALG_00_01.Create;
begin
  FALG_00_0 := TALG_00.Create;
end;

destructor TALG_00_01.Destroy;
begin
  if Assigned(FALG_00_0) then
    FALG_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoALG_00_01)

end.
