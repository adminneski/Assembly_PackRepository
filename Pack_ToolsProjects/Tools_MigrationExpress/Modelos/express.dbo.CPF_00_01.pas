unit express.dbo.CPF_00_01;

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
  [Table('CPF_00_01', '')]
  [PrimaryKey('CPF_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPF_01_ID')]
  TDtoCPF_00_01 = class
  private
    { Private declarations } 
    FCPF_ID: Integer;
    FCPF_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCPF_QTDCOMPOSICAO: Double;
    FCPF_DATAALTERACAO: TDateTime;
    FPRO_DESCRICAO: String;
    FCPF_INFORMATIVO: String;
    FCPF_01_ID_OLD: Integer;
    FCPF_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CPF_00_01';
     const PrimaryKey = 'CPF_01_ID';
     const Sequence   = 'SEQ_CPF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPF_ID', ftInteger)]
    [Dictionary('CPF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPF_ID: Integer read FCPF_ID write FCPF_ID;
    const CPF_ID_Name = 'CPF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPF_01_ID', ftInteger)]
    [Dictionary('CPF_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPF_01_ID: Integer read FCPF_01_ID write FCPF_01_ID;
    const CPF_01_ID_Name = 'CPF_01_ID';

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
    [Column('CPF_QTDCOMPOSICAO', ftBCD, 18, 4)]
    [Dictionary('CPF_QTDCOMPOSICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPF_QTDCOMPOSICAO: Double read FCPF_QTDCOMPOSICAO write FCPF_QTDCOMPOSICAO;
    const CPF_QTDCOMPOSICAO_Name = 'CPF_QTDCOMPOSICAO';

    [Restrictions([NoValidate])]
    [Column('CPF_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPF_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPF_DATAALTERACAO: TDateTime read FCPF_DATAALTERACAO write FCPF_DATAALTERACAO;
    const CPF_DATAALTERACAO_Name = 'CPF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CPF_INFORMATIVO', ftString, 1)]
    [Dictionary('CPF_INFORMATIVO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPF_INFORMATIVO: String read FCPF_INFORMATIVO write FCPF_INFORMATIVO;
    const CPF_INFORMATIVO_Name = 'CPF_INFORMATIVO';

    [Restrictions([NoValidate])]
    [Column('CPF_01_ID_OLD', ftInteger)]
    [Dictionary('CPF_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPF_01_ID_OLD: Integer read FCPF_01_ID_OLD write FCPF_01_ID_OLD;
    const CPF_01_ID_OLD_Name = 'CPF_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPF_ID_OLD', ftInteger)]
    [Dictionary('CPF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPF_ID_OLD: Integer read FCPF_ID_OLD write FCPF_ID_OLD;
    const CPF_ID_OLD_Name = 'CPF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPF_00_01)

end.
