unit express.dbo.VW_PSQ_NCM;

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
  [Table('VW_PSQ_NCM', '')]
  TDtoVW_PSQ_NCM = class
  private
    { Private declarations } 
    FNCM_CODIGO: Integer;
    FNCM_CODIGONCM: String;
    FNCM_DESCRICAO: String;
    FCST_CODIGO: String;
    FLEF_CODIGO: Integer;
    FLEF_DESCRICAO: String;
    FNCM_DESATIVADO: String;
    FNCM_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_NCM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_CODIGONCM', ftString, 12)]
    [Dictionary('NCM_CODIGONCM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NCM_CODIGONCM: String read FNCM_CODIGONCM write FNCM_CODIGONCM;
    const NCM_CODIGONCM_Name = 'NCM_CODIGONCM';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_DESCRICAO', ftString, 60)]
    [Dictionary('NCM_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NCM_DESCRICAO: String read FNCM_DESCRICAO write FNCM_DESCRICAO;
    const NCM_DESCRICAO_Name = 'NCM_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_DESCRICAO', ftString, 100)]
    [Dictionary('LEF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_DESCRICAO: String read FLEF_DESCRICAO write FLEF_DESCRICAO;
    const LEF_DESCRICAO_Name = 'LEF_DESCRICAO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_NCM)

end.
