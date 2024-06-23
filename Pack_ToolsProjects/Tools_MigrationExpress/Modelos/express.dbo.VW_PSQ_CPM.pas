unit express.dbo.VW_PSQ_CPM;

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
  [Table('VW_PSQ_CPM', '')]
  TDtoVW_PSQ_CPM = class
  private
    { Private declarations } 
    FCPM_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FCPM_DATALANCAMENTO: TDateTime;
    FCPM_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CPM';

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
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CPM_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CPM_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPM_DATALANCAMENTO: TDateTime read FCPM_DATALANCAMENTO write FCPM_DATALANCAMENTO;
    const CPM_DATALANCAMENTO_Name = 'CPM_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CPM_OBSERVACAO', ftString, 300)]
    [Dictionary('CPM_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPM_OBSERVACAO: String read FCPM_OBSERVACAO write FCPM_OBSERVACAO;
    const CPM_OBSERVACAO_Name = 'CPM_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CPM)

end.
