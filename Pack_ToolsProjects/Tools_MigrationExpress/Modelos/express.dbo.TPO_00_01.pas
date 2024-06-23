unit express.dbo.TPO_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.tpo_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('TPO_00_01', '')]
  [PrimaryKey('TPO_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TPO_01_ID')]
  TDtoTPO_00_01 = class
  private
    { Private declarations } 
    FTPO_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FTPO_ID: Integer;
    FCRE_ID: Integer;
    FCRE_TOTALVALOR: Double;
    FTPO_DATAALTERACAO: TDateTime;
    FTPO_01_ID_OLD: Integer;
    FTPO_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'TPO_00_01';
    const PrimaryKey = 'TPO_01_ID';
    const Sequence   = 'SEQ_TPO_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_01_ID', ftInteger)]
    [Dictionary('TPO_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TPO_01_ID: Integer read FTPO_01_ID write FTPO_01_ID;
    const TPO_01_ID_Name = 'TPO_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TPO_ID', ftInteger)]
    [ForeignKey('TPO_00_01_fk', 'TPO_ID', 'TPO_00', 'TPO_ID', SetNull, SetNull)]
    [Dictionary('TPO_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TPO_ID: Integer read FTPO_ID write FTPO_ID;
    const TPO_ID_Name = 'TPO_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD, 1162891087, 2)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('TPO_DATAALTERACAO', ftDateTime)]
    [Dictionary('TPO_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property TPO_DATAALTERACAO: TDateTime read FTPO_DATAALTERACAO write FTPO_DATAALTERACAO;
    const TPO_DATAALTERACAO_Name = 'TPO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('TPO_01_ID_OLD', ftInteger)]
    [Dictionary('TPO_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TPO_01_ID_OLD: Integer read FTPO_01_ID_OLD write FTPO_01_ID_OLD;
    const TPO_01_ID_OLD_Name = 'TPO_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('TPO_ID_OLD', ftInteger)]
    [Dictionary('TPO_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TPO_ID_OLD: Integer read FTPO_ID_OLD write FTPO_ID_OLD;
    const TPO_ID_OLD_Name = 'TPO_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoTPO_00_01)

end.
