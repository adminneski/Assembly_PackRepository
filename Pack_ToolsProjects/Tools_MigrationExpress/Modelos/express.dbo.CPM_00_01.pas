unit express.dbo.CPM_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cpm_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CPM_00_01', '')]
  [PrimaryKey('CPM_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPM_01_ID')]
  TDtoCPM_00_01 = class
  private
    { Private declarations } 
    FCPM_ID: Integer;
    FCPM_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCPM_QTDCOMPOSICAO: Double;
    FCPM_DATAALTERACAO: TDateTime;
    FPRO_DESCRICAO: String;
    FCPM_01_ID_OLD: Integer;
    FCPM_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CPM_00_01';
    const PrimaryKey = 'CPM_01_ID';
    const Sequence   = 'SEQ_CPM_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPM_ID', ftInteger)]
    [ForeignKey('CPM_00_01_fk', 'CPM_ID', 'CPM_00', 'CPM_ID', SetNull, SetNull)]
    [Dictionary('CPM_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_ID: Integer read FCPM_ID write FCPM_ID;
    const CPM_ID_Name = 'CPM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPM_01_ID', ftInteger)]
    [Dictionary('CPM_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_01_ID: Integer read FCPM_01_ID write FCPM_01_ID;
    const CPM_01_ID_Name = 'CPM_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPM_QTDCOMPOSICAO', ftBCD, 18, 4)]
    [Dictionary('CPM_QTDCOMPOSICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPM_QTDCOMPOSICAO: Double read FCPM_QTDCOMPOSICAO write FCPM_QTDCOMPOSICAO;
    const CPM_QTDCOMPOSICAO_Name = 'CPM_QTDCOMPOSICAO';

    [Restrictions([NoValidate])]
    [Column('CPM_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPM_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPM_DATAALTERACAO: TDateTime read FCPM_DATAALTERACAO write FCPM_DATAALTERACAO;
    const CPM_DATAALTERACAO_Name = 'CPM_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CPM_01_ID_OLD', ftInteger)]
    [Dictionary('CPM_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_01_ID_OLD: Integer read FCPM_01_ID_OLD write FCPM_01_ID_OLD;
    const CPM_01_ID_OLD_Name = 'CPM_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPM_ID_OLD', ftInteger)]
    [Dictionary('CPM_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_ID_OLD: Integer read FCPM_ID_OLD write FCPM_ID_OLD;
    const CPM_ID_OLD_Name = 'CPM_ID_OLD';

  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCPM_00_01)

end.
