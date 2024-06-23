unit express.dbo.NCM_00;

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
  [Table('NCM_00', '')]
  [PrimaryKey('NCM_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NCM_CODIGO')]
  TDtoNCM_00 = class
  private
    { Private declarations } 
    FNCM_CODIGO: Integer;
    FNCM_DESCRICAO: String;
    FNCM_CODIGONCM: String;
    FLEF_CODIGO: Integer;
    FCST_CODIGO: String;
    FNCM_DESATIVADO: String;
    FNCM_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'NCM_00';
     const PrimaryKey = 'NCM_CODIGO';
     const Sequence   = 'SEQ_NCM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_DESCRICAO', ftString, 60)]
    [Dictionary('NCM_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NCM_DESCRICAO: String read FNCM_DESCRICAO write FNCM_DESCRICAO;
    const NCM_DESCRICAO_Name = 'NCM_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_CODIGONCM', ftString, 12)]
    [Dictionary('NCM_CODIGONCM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NCM_CODIGONCM: String read FNCM_CODIGONCM write FNCM_CODIGONCM;
    const NCM_CODIGONCM_Name = 'NCM_CODIGONCM';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_DESATIVADO', ftString, 1)]
    [Dictionary('NCM_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NCM_DESATIVADO: String read FNCM_DESATIVADO write FNCM_DESATIVADO;
    const NCM_DESATIVADO_Name = 'NCM_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_DATAALTERACAO', ftDateTime)]
    [Dictionary('NCM_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NCM_DATAALTERACAO: TDateTime read FNCM_DATAALTERACAO write FNCM_DATAALTERACAO;
    const NCM_DATAALTERACAO_Name = 'NCM_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNCM_00)

end.
