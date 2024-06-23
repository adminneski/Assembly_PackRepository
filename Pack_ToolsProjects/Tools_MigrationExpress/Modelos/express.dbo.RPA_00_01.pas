unit express.dbo.RPA_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.rpa_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('RPA_00_01', '')]
  [PrimaryKey('RPA_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RPA_01_ID')]
  TDtoRPA_00_01 = class
  private
    { Private declarations } 
    FRPA_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FRPA_ID: Integer;
    FRPA_DIA: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FRPA_DATAVENCTO: TDateTime;
    FRPA_NUMERODOCTO: String;
    FRPA_VALORPARCELA: Double;
    FFPG_TIPOPAGAMENTO: Integer;
    FRPA_NUMEROPARCELA: Integer;
    FRPA_DATAALTERACAO: TDateTime;
    FRPA_01_ID_OLD: Integer;
    FRPA_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'RPA_00_01';
    const PrimaryKey = 'RPA_01_ID';
    const Sequence   = 'SEQ_RPA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_01_ID', ftInteger)]
    [Dictionary('RPA_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_01_ID: Integer read FRPA_01_ID write FRPA_01_ID;
    const RPA_01_ID_Name = 'RPA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_ID', ftInteger)]
    [ForeignKey('RPA_00_01_fk', 'RPA_ID', 'RPA_00', 'RPA_ID', SetNull, SetNull)]
    [Dictionary('RPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID: Integer read FRPA_ID write FRPA_ID;
    const RPA_ID_Name = 'RPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DIA', ftInteger)]
    [Dictionary('RPA_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_DIA: Integer read FRPA_DIA write FRPA_DIA;
    const RPA_DIA_Name = 'RPA_DIA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RPA_DATAVENCTO', ftDateTime)]
    [Dictionary('RPA_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RPA_DATAVENCTO: TDateTime read FRPA_DATAVENCTO write FRPA_DATAVENCTO;
    const RPA_DATAVENCTO_Name = 'RPA_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('RPA_NUMERODOCTO', ftString, 15)]
    [Dictionary('RPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_NUMERODOCTO: String read FRPA_NUMERODOCTO write FRPA_NUMERODOCTO;
    const RPA_NUMERODOCTO_Name = 'RPA_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_VALORPARCELA', ftBCD, 544040295, 2)]
    [Dictionary('RPA_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_VALORPARCELA: Double read FRPA_VALORPARCELA write FRPA_VALORPARCELA;
    const RPA_VALORPARCELA_Name = 'RPA_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_NUMEROPARCELA', ftInteger)]
    [Dictionary('RPA_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_NUMEROPARCELA: Integer read FRPA_NUMEROPARCELA write FRPA_NUMEROPARCELA;
    const RPA_NUMEROPARCELA_Name = 'RPA_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('RPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RPA_DATAALTERACAO: TDateTime read FRPA_DATAALTERACAO write FRPA_DATAALTERACAO;
    const RPA_DATAALTERACAO_Name = 'RPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('RPA_01_ID_OLD', ftInteger)]
    [Dictionary('RPA_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_01_ID_OLD: Integer read FRPA_01_ID_OLD write FRPA_01_ID_OLD;
    const RPA_01_ID_OLD_Name = 'RPA_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('RPA_ID_OLD', ftInteger)]
    [Dictionary('RPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID_OLD: Integer read FRPA_ID_OLD write FRPA_ID_OLD;
    const RPA_ID_OLD_Name = 'RPA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRPA_00_01)

end.
