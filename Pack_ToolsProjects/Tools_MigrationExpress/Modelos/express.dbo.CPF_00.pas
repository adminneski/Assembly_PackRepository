unit express.dbo.CPF_00;

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
  [Table('CPF_00', '')]
  [PrimaryKey('CPF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPF_ID')]
  TDtoCPF_00 = class
  private
    { Private declarations } 
    FCPF_ID: Integer;
    FCOM_CODIGO: Integer;
    FCPF_DATALANCAMENTO: TDateTime;
    FPRO_CODIGO: Integer;
    FCPF_OBSERVACAO: String;
    FCPF_DESATIVADO: String;
    FCPF_DATAALTERACAO: TDateTime;
    FCPF_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CPF_00';
     const PrimaryKey = 'CPF_ID';
     const Sequence   = 'SEQ_CPF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPF_ID', ftInteger)]
    [Dictionary('CPF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPF_ID: Integer read FCPF_ID write FCPF_ID;
    const CPF_ID_Name = 'CPF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CPF_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPF_DATALANCAMENTO: TDateTime read FCPF_DATALANCAMENTO write FCPF_DATALANCAMENTO;
    const CPF_DATALANCAMENTO_Name = 'CPF_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPF_OBSERVACAO', ftString, 300)]
    [Dictionary('CPF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPF_OBSERVACAO: String read FCPF_OBSERVACAO write FCPF_OBSERVACAO;
    const CPF_OBSERVACAO_Name = 'CPF_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CPF_DESATIVADO', ftString, 1)]
    [Dictionary('CPF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPF_DESATIVADO: String read FCPF_DESATIVADO write FCPF_DESATIVADO;
    const CPF_DESATIVADO_Name = 'CPF_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CPF_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPF_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPF_DATAALTERACAO: TDateTime read FCPF_DATAALTERACAO write FCPF_DATAALTERACAO;
    const CPF_DATAALTERACAO_Name = 'CPF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPF_ID_OLD', ftInteger)]
    [Dictionary('CPF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPF_ID_OLD: Integer read FCPF_ID_OLD write FCPF_ID_OLD;
    const CPF_ID_OLD_Name = 'CPF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPF_00)

end.
