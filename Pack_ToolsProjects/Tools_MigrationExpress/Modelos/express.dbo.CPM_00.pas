unit express.dbo.CPM_00;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CPM_00', '')]
  [PrimaryKey('CPM_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPM_ID')]
  TDtoCPM_00 = class
  private
    { Private declarations } 
    FCPM_ID: Integer;
    FCOM_CODIGO: Integer;
    FCPM_DATALANCAMENTO: TDateTime;
    FPRO_CODIGO: Integer;
    FCPM_OBSERVACAO: String;
    FCPM_DESATIVADO: String;
    FCPM_DATAALTERACAO: TDateTime;
    FCPM_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CPM_00';
     const PrimaryKey = 'CPM_ID';
     const Sequence   = 'SEQ_CPM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPM_ID', ftInteger)]
    [Dictionary('CPM_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_ID: Integer read FCPM_ID write FCPM_ID;
    const CPM_ID_Name = 'CPM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPM_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CPM_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPM_DATALANCAMENTO: TDateTime read FCPM_DATALANCAMENTO write FCPM_DATALANCAMENTO;
    const CPM_DATALANCAMENTO_Name = 'CPM_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPM_OBSERVACAO', ftString, 300)]
    [Dictionary('CPM_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPM_OBSERVACAO: String read FCPM_OBSERVACAO write FCPM_OBSERVACAO;
    const CPM_OBSERVACAO_Name = 'CPM_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CPM_DESATIVADO', ftString, 1)]
    [Dictionary('CPM_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPM_DESATIVADO: String read FCPM_DESATIVADO write FCPM_DESATIVADO;
    const CPM_DESATIVADO_Name = 'CPM_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CPM_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPM_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPM_DATAALTERACAO: TDateTime read FCPM_DATAALTERACAO write FCPM_DATAALTERACAO;
    const CPM_DATAALTERACAO_Name = 'CPM_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPM_ID_OLD', ftInteger)]
    [Dictionary('CPM_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPM_ID_OLD: Integer read FCPM_ID_OLD write FCPM_ID_OLD;
    const CPM_ID_OLD_Name = 'CPM_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPM_00)

end.
