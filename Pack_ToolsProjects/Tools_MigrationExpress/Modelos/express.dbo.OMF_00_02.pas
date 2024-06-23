unit express.dbo.OMF_00_02;

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
  [Table('OMF_00_02', '')]
  [PrimaryKey('OMF_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_02_ID')]
  TDtoOMF_00_02 = class
  private
    { Private declarations } 
    FOMF_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_ID: Integer;
    FOMF_UF: String;
    FPRO_CODIGO: Integer;
    FPES_TIPOCLIENTE: String;
    FOMF_VALORVENDASUGERIDO: Double;
    FOMF_VALORVENDAADOTADO: Double;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: String;
    FOMF_02_ID_OLD: Integer;
    FOMF_ID_OLD: Integer;

    FOMF_00_0:  TOMF_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'OMF_00_02';
     const PrimaryKey = 'OMF_02_ID';
     const Sequence   = 'SEQ_OMF_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_02_ID', ftInteger)]
    [Dictionary('OMF_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_02_ID: Integer read FOMF_02_ID write FOMF_02_ID;
    const OMF_02_ID_Name = 'OMF_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_02_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate])]
    [Column('OMF_UF', ftString, 2)]
    [Dictionary('OMF_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_UF: String read FOMF_UF write FOMF_UF;
    const OMF_UF_Name = 'OMF_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOCLIENTE', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE: String read FPES_TIPOCLIENTE write FPES_TIPOCLIENTE;
    const PES_TIPOCLIENTE_Name = 'PES_TIPOCLIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORVENDASUGERIDO', ftBCD)]
    [Dictionary('OMF_VALORVENDASUGERIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORVENDASUGERIDO: Double read FOMF_VALORVENDASUGERIDO write FOMF_VALORVENDASUGERIDO;
    const OMF_VALORVENDASUGERIDO_Name = 'OMF_VALORVENDASUGERIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_VALORVENDAADOTADO', ftBCD, 16387, 2)]
    [Dictionary('OMF_VALORVENDAADOTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_VALORVENDAADOTADO: Double read FOMF_VALORVENDAADOTADO write FOMF_VALORVENDAADOTADO;
    const OMF_VALORVENDAADOTADO_Name = 'OMF_VALORVENDAADOTADO';

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
    [Column('OMF_02_ID_OLD', ftInteger)]
    [Dictionary('OMF_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_02_ID_OLD: Integer read FOMF_02_ID_OLD write FOMF_02_ID_OLD;
    const OMF_02_ID_OLD_Name = 'OMF_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';

    [Association(OneToOne,'OMF_ID','OMF_00','OMF_ID')]
    property OMF_00: TOMF_00 read FOMF_00_0 write FOMF_00_0;

  end;

implementation

constructor TOMF_00_02.Create;
begin
  FOMF_00_0 := TOMF_00.Create;
end;

destructor TOMF_00_02.Destroy;
begin
  if Assigned(FOMF_00_0) then
    FOMF_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_02)

end.
