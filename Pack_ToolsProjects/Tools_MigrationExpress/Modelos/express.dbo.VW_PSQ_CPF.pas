unit express.dbo.VW_PSQ_CPF;

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
  [Table('VW_PSQ_CPF', '')]
  TDtoVW_PSQ_CPF = class
  private
    { Private declarations } 
    FCPF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FCPF_DATALANCAMENTO: TDateTime;
    FCPF_OBSERVACAO: String;
    FCPF_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CPF';

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
    [Column('CPF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CPF_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPF_DATALANCAMENTO: TDateTime read FCPF_DATALANCAMENTO write FCPF_DATALANCAMENTO;
    const CPF_DATALANCAMENTO_Name = 'CPF_DATALANCAMENTO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CPF)

end.
