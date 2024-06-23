unit express.dbo.FLP_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.flp_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('FLP_00_01', '')]
  [PrimaryKey('FLP_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FLP_01_ID')]
  TDtoFLP_00_01 = class
  private
    { Private declarations } 
    FFLP_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FFLP_ID: Integer;
    FFLP_DATALANCAMENTO: TDateTime;
    FFLP_DC: String;
    FFLP_VALORDOCTO: Double;
    FHSP_CODIGO: Integer;
    FFLP_HISTORICO: String;
    FFLP_DATAALTERACAO: TDateTime;
    FFLP_01_ID_OLD: Integer;
    FFLP_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'FLP_00_01';
    const PrimaryKey = 'FLP_01_ID';
    const Sequence   = 'SEQ_FLP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FLP_01_ID', ftInteger)]
    [Dictionary('FLP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FLP_01_ID: Integer read FFLP_01_ID write FFLP_01_ID;
    const FLP_01_ID_Name = 'FLP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FLP_ID', ftInteger)]
    [ForeignKey('FLP_00_01_fk', 'FLP_ID', 'FLP_00', 'FLP_ID', SetNull, SetNull)]
    [Dictionary('FLP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FLP_ID: Integer read FFLP_ID write FFLP_ID;
    const FLP_ID_Name = 'FLP_ID';

    [Restrictions([NoValidate])]
    [Column('FLP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FLP_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FLP_DATALANCAMENTO: TDateTime read FFLP_DATALANCAMENTO write FFLP_DATALANCAMENTO;
    const FLP_DATALANCAMENTO_Name = 'FLP_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('FLP_DC', ftString, 1)]
    [Dictionary('FLP_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FLP_DC: String read FFLP_DC write FFLP_DC;
    const FLP_DC_Name = 'FLP_DC';

    [Restrictions([NoValidate])]
    [Column('FLP_VALORDOCTO', ftBCD)]
    [Dictionary('FLP_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FLP_VALORDOCTO: Double read FFLP_VALORDOCTO write FFLP_VALORDOCTO;
    const FLP_VALORDOCTO_Name = 'FLP_VALORDOCTO';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FLP_HISTORICO', ftString, 5000)]
    [Dictionary('FLP_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FLP_HISTORICO: String read FFLP_HISTORICO write FFLP_HISTORICO;
    const FLP_HISTORICO_Name = 'FLP_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('FLP_DATAALTERACAO', ftDateTime)]
    [Dictionary('FLP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FLP_DATAALTERACAO: TDateTime read FFLP_DATAALTERACAO write FFLP_DATAALTERACAO;
    const FLP_DATAALTERACAO_Name = 'FLP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FLP_01_ID_OLD', ftInteger)]
    [Dictionary('FLP_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FLP_01_ID_OLD: Integer read FFLP_01_ID_OLD write FFLP_01_ID_OLD;
    const FLP_01_ID_OLD_Name = 'FLP_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FLP_ID_OLD', ftInteger)]
    [Dictionary('FLP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FLP_ID_OLD: Integer read FFLP_ID_OLD write FFLP_ID_OLD;
    const FLP_ID_OLD_Name = 'FLP_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoFLP_00_01)

end.
