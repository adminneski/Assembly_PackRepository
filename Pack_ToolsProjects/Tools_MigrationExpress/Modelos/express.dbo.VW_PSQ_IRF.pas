unit express.dbo.VW_PSQ_IRF;

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
  [Table('VW_PSQ_IRF', '')]
  TDtoVW_PSQ_IRF = class
  private
    { Private declarations } 
    FIRF_CODIGO: Integer;
    FIRF_DESCRICAO: String;
    FIRF_PERCENTUALIMPOSTO: Double;
    FIRF_DEDUCAOIMPOSTO: Double;
    FIRF_TETOFINAL: Double;
    FIRF_TETOINICIAL: Double;
    FIRF_DESATIVADO: String;
    FIRF_DATAALTERACAO: TDateTime;
    FIRF_PERCENTUALINSSRPA: Double;
    FIRF_PERCENTUALSEST_SENAT: Double;
    FIRF_PERCENTUALBASECALCULOINSS: Double;
    FIRF_VALORTETOMAXIMOINSS: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_IRF';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_CODIGO', ftInteger)]
    [Dictionary('IRF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property IRF_CODIGO: Integer read FIRF_CODIGO write FIRF_CODIGO;
    const IRF_CODIGO_Name = 'IRF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_DESCRICAO', ftString, 50)]
    [Dictionary('IRF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IRF_DESCRICAO: String read FIRF_DESCRICAO write FIRF_DESCRICAO;
    const IRF_DESCRICAO_Name = 'IRF_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALIMPOSTO', ftBCD)]
    [Dictionary('IRF_PERCENTUALIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALIMPOSTO: Double read FIRF_PERCENTUALIMPOSTO write FIRF_PERCENTUALIMPOSTO;
    const IRF_PERCENTUALIMPOSTO_Name = 'IRF_PERCENTUALIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('IRF_DEDUCAOIMPOSTO', ftBCD)]
    [Dictionary('IRF_DEDUCAOIMPOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_DEDUCAOIMPOSTO: Double read FIRF_DEDUCAOIMPOSTO write FIRF_DEDUCAOIMPOSTO;
    const IRF_DEDUCAOIMPOSTO_Name = 'IRF_DEDUCAOIMPOSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_TETOFINAL', ftBCD)]
    [Dictionary('IRF_TETOFINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_TETOFINAL: Double read FIRF_TETOFINAL write FIRF_TETOFINAL;
    const IRF_TETOFINAL_Name = 'IRF_TETOFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_TETOINICIAL', ftBCD)]
    [Dictionary('IRF_TETOINICIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_TETOINICIAL: Double read FIRF_TETOINICIAL write FIRF_TETOINICIAL;
    const IRF_TETOINICIAL_Name = 'IRF_TETOINICIAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_DESATIVADO', ftString, 1)]
    [Dictionary('IRF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IRF_DESATIVADO: String read FIRF_DESATIVADO write FIRF_DESATIVADO;
    const IRF_DESATIVADO_Name = 'IRF_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_DATAALTERACAO', ftDateTime)]
    [Dictionary('IRF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property IRF_DATAALTERACAO: TDateTime read FIRF_DATAALTERACAO write FIRF_DATAALTERACAO;
    const IRF_DATAALTERACAO_Name = 'IRF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALINSSRPA', ftBCD)]
    [Dictionary('IRF_PERCENTUALINSSRPA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALINSSRPA: Double read FIRF_PERCENTUALINSSRPA write FIRF_PERCENTUALINSSRPA;
    const IRF_PERCENTUALINSSRPA_Name = 'IRF_PERCENTUALINSSRPA';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALSEST_SENAT', ftBCD, 10, 2)]
    [Dictionary('IRF_PERCENTUALSEST_SENAT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALSEST_SENAT: Double read FIRF_PERCENTUALSEST_SENAT write FIRF_PERCENTUALSEST_SENAT;
    const IRF_PERCENTUALSEST_SENAT_Name = 'IRF_PERCENTUALSEST_SENAT';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALBASECALCULOINSS', ftBCD)]
    [Dictionary('IRF_PERCENTUALBASECALCULOINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALBASECALCULOINSS: Double read FIRF_PERCENTUALBASECALCULOINSS write FIRF_PERCENTUALBASECALCULOINSS;
    const IRF_PERCENTUALBASECALCULOINSS_Name = 'IRF_PERCENTUALBASECALCULOINSS';

    [Restrictions([NoValidate])]
    [Column('IRF_VALORTETOMAXIMOINSS', ftBCD)]
    [Dictionary('IRF_VALORTETOMAXIMOINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property IRF_VALORTETOMAXIMOINSS: Double read FIRF_VALORTETOMAXIMOINSS write FIRF_VALORTETOMAXIMOINSS;
    const IRF_VALORTETOMAXIMOINSS_Name = 'IRF_VALORTETOMAXIMOINSS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_IRF)

end.
