unit express.dbo.LEF_00;

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
  [Table('LEF_00', '')]
  [PrimaryKey('LEF_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LEF_CODIGO')]
  TDtoLEF_00 = class
  private
    { Private declarations } 
    FLEF_CODIGO: Integer;
    FLEF_DESCRICAO: String;
    FLEF_SIMBOLO: String;
    FLEF_COMENTARIO: String;
    FLEF_DATAINICIAL: TDateTime;
    FLEF_DATAFINAL: TDateTime;
    FLEF_STATUS: String;
    FLEF_VALORIPI: Double;
    FLEF_PERCENTUALIPI: Double;
    FLEF_PERCENTUALPIS: Double;
    FLEF_PERCENTUALCOFINS: Double;
    FCSTPC_CODIGOENT: String;
    FCSTPC_CODIGOSAI: String;
    FLEF_DESATIVADO: String;
    FLEF_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
    FLEF_PERCENTUALINSS: Double;
    FLEF_PERCENTUALIR: Double;
    FLEF_PERCENTUALCSLL: Double;
    FLEF_DESCONTARICMSBCPISCOFINS: String;
    FLEF_ENQUADRAMENTOIPI: String;
  public 
    { Public declarations } 
     const Table      = 'LEF_00';
     const PrimaryKey = 'LEF_CODIGO';
     const Sequence   = 'SEQ_LEF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_DESCRICAO', ftString, 100)]
    [Dictionary('LEF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_DESCRICAO: String read FLEF_DESCRICAO write FLEF_DESCRICAO;
    const LEF_DESCRICAO_Name = 'LEF_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LEF_SIMBOLO', ftString, 1)]
    [Dictionary('LEF_SIMBOLO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_SIMBOLO: String read FLEF_SIMBOLO write FLEF_SIMBOLO;
    const LEF_SIMBOLO_Name = 'LEF_SIMBOLO';

    [Restrictions([NoValidate])]
    [Column('LEF_COMENTARIO', ftString, 300)]
    [Dictionary('LEF_COMENTARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_COMENTARIO: String read FLEF_COMENTARIO write FLEF_COMENTARIO;
    const LEF_COMENTARIO_Name = 'LEF_COMENTARIO';

    [Restrictions([NoValidate])]
    [Column('LEF_DATAINICIAL', ftDateTime)]
    [Dictionary('LEF_DATAINICIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property LEF_DATAINICIAL: TDateTime read FLEF_DATAINICIAL write FLEF_DATAINICIAL;
    const LEF_DATAINICIAL_Name = 'LEF_DATAINICIAL';

    [Restrictions([NoValidate])]
    [Column('LEF_DATAFINAL', ftDateTime)]
    [Dictionary('LEF_DATAFINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property LEF_DATAFINAL: TDateTime read FLEF_DATAFINAL write FLEF_DATAFINAL;
    const LEF_DATAFINAL_Name = 'LEF_DATAFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_STATUS', ftString, 1)]
    [Dictionary('LEF_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_STATUS: String read FLEF_STATUS write FLEF_STATUS;
    const LEF_STATUS_Name = 'LEF_STATUS';

    [Restrictions([NoValidate])]
    [Column('LEF_VALORIPI', ftBCD)]
    [Dictionary('LEF_VALORIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_VALORIPI: Double read FLEF_VALORIPI write FLEF_VALORIPI;
    const LEF_VALORIPI_Name = 'LEF_VALORIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_PERCENTUALIPI', ftBCD)]
    [Dictionary('LEF_PERCENTUALIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALIPI: Double read FLEF_PERCENTUALIPI write FLEF_PERCENTUALIPI;
    const LEF_PERCENTUALIPI_Name = 'LEF_PERCENTUALIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_PERCENTUALPIS', ftBCD)]
    [Dictionary('LEF_PERCENTUALPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALPIS: Double read FLEF_PERCENTUALPIS write FLEF_PERCENTUALPIS;
    const LEF_PERCENTUALPIS_Name = 'LEF_PERCENTUALPIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_PERCENTUALCOFINS', ftBCD)]
    [Dictionary('LEF_PERCENTUALCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALCOFINS: Double read FLEF_PERCENTUALCOFINS write FLEF_PERCENTUALCOFINS;
    const LEF_PERCENTUALCOFINS_Name = 'LEF_PERCENTUALCOFINS';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGOENT', ftString, 2)]
    [Dictionary('CSTPC_CODIGOENT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGOENT: String read FCSTPC_CODIGOENT write FCSTPC_CODIGOENT;
    const CSTPC_CODIGOENT_Name = 'CSTPC_CODIGOENT';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGOSAI', ftString, 2)]
    [Dictionary('CSTPC_CODIGOSAI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGOSAI: String read FCSTPC_CODIGOSAI write FCSTPC_CODIGOSAI;
    const CSTPC_CODIGOSAI_Name = 'CSTPC_CODIGOSAI';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_DESATIVADO', ftString, 1)]
    [Dictionary('LEF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_DESATIVADO: String read FLEF_DESATIVADO write FLEF_DESATIVADO;
    const LEF_DESATIVADO_Name = 'LEF_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEF_DATAALTERACAO', ftDateTime)]
    [Dictionary('LEF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LEF_DATAALTERACAO: TDateTime read FLEF_DATAALTERACAO write FLEF_DATAALTERACAO;
    const LEF_DATAALTERACAO_Name = 'LEF_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_PERCENTUALINSS', ftBCD)]
    [Dictionary('LEF_PERCENTUALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALINSS: Double read FLEF_PERCENTUALINSS write FLEF_PERCENTUALINSS;
    const LEF_PERCENTUALINSS_Name = 'LEF_PERCENTUALINSS';

    [Restrictions([NoValidate])]
    [Column('LEF_PERCENTUALIR', ftBCD)]
    [Dictionary('LEF_PERCENTUALIR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALIR: Double read FLEF_PERCENTUALIR write FLEF_PERCENTUALIR;
    const LEF_PERCENTUALIR_Name = 'LEF_PERCENTUALIR';

    [Restrictions([NoValidate])]
    [Column('LEF_PERCENTUALCSLL', ftBCD)]
    [Dictionary('LEF_PERCENTUALCSLL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LEF_PERCENTUALCSLL: Double read FLEF_PERCENTUALCSLL write FLEF_PERCENTUALCSLL;
    const LEF_PERCENTUALCSLL_Name = 'LEF_PERCENTUALCSLL';

    [Restrictions([NoValidate])]
    [Column('LEF_DESCONTARICMSBCPISCOFINS', ftString, 1)]
    [Dictionary('LEF_DESCONTARICMSBCPISCOFINS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_DESCONTARICMSBCPISCOFINS: String read FLEF_DESCONTARICMSBCPISCOFINS write FLEF_DESCONTARICMSBCPISCOFINS;
    const LEF_DESCONTARICMSBCPISCOFINS_Name = 'LEF_DESCONTARICMSBCPISCOFINS';

    [Restrictions([NoValidate])]
    [Column('LEF_ENQUADRAMENTOIPI', ftString, 3)]
    [Dictionary('LEF_ENQUADRAMENTOIPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_ENQUADRAMENTOIPI: String read FLEF_ENQUADRAMENTOIPI write FLEF_ENQUADRAMENTOIPI;
    const LEF_ENQUADRAMENTOIPI_Name = 'LEF_ENQUADRAMENTOIPI';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLEF_00)

end.
