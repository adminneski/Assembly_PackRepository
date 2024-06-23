unit express.dbo.IRF_00;

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
  [Table('IRF_00', '')]
  [PrimaryKey('IRF_CODIGO', AutoInc, NoSort, False, 'Chave prim�ria')]
  [Sequence('SEQ_IRF_CODIGO')]
  TDtoIRF_00 = class
  private
    { Private declarations } 
    FIRF_CODIGO: Integer;
    FIRF_DESCRICAO: String;
    FIRF_TETOINICIAL: Double;
    FIRF_TETOFINAL: Double;
    FIRF_DESATIVADO: String;
    FIRF_DATAALTERACAO: TDateTime;
    FIRF_PERCENTUALIMPOSTO: Double;
    FIRF_DEDUCAOIMPOSTO: Double;
    FIRF_PERCENTUALINSSRPA: Double;
    FIRF_PERCENTUALSEST_SENAT: Double;
    FIRF_PERCENTUALBASECALCULOINSS: Double;
    FIRF_VALORTETOMAXIMOINSS: Double;
    FIRF_TETOFINALINSS: Double;
    FIRF_TETOINICIALINSS: Double;
    FIRF_PARAMETROIRF: String;
    FIRF_PARAMETROINSS: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'IRF_00';
     const PrimaryKey = 'IRF_CODIGO';
     const Sequence   = 'SEQ_IRF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_CODIGO', ftInteger)]
    [Dictionary('IRF_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property IRF_CODIGO: Integer read FIRF_CODIGO write FIRF_CODIGO;
    const IRF_CODIGO_Name = 'IRF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_DESCRICAO', ftString, 50)]
    [Dictionary('IRF_DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property IRF_DESCRICAO: String read FIRF_DESCRICAO write FIRF_DESCRICAO;
    const IRF_DESCRICAO_Name = 'IRF_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_TETOINICIAL', ftBCD)]
    [Dictionary('IRF_TETOINICIAL', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_TETOINICIAL: Double read FIRF_TETOINICIAL write FIRF_TETOINICIAL;
    const IRF_TETOINICIAL_Name = 'IRF_TETOINICIAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_TETOFINAL', ftBCD)]
    [Dictionary('IRF_TETOFINAL', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_TETOFINAL: Double read FIRF_TETOFINAL write FIRF_TETOFINAL;
    const IRF_TETOFINAL_Name = 'IRF_TETOFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_DESATIVADO', ftString, 1)]
    [Dictionary('IRF_DESATIVADO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property IRF_DESATIVADO: String read FIRF_DESATIVADO write FIRF_DESATIVADO;
    const IRF_DESATIVADO_Name = 'IRF_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('IRF_DATAALTERACAO', ftDateTime)]
    [Dictionary('IRF_DATAALTERACAO', 'Mensagem de valida��o', 'Date', '', '!##/##/####;1;_', taCenter)]
    property IRF_DATAALTERACAO: TDateTime read FIRF_DATAALTERACAO write FIRF_DATAALTERACAO;
    const IRF_DATAALTERACAO_Name = 'IRF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALIMPOSTO', ftBCD)]
    [Dictionary('IRF_PERCENTUALIMPOSTO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALIMPOSTO: Double read FIRF_PERCENTUALIMPOSTO write FIRF_PERCENTUALIMPOSTO;
    const IRF_PERCENTUALIMPOSTO_Name = 'IRF_PERCENTUALIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('IRF_DEDUCAOIMPOSTO', ftBCD)]
    [Dictionary('IRF_DEDUCAOIMPOSTO', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_DEDUCAOIMPOSTO: Double read FIRF_DEDUCAOIMPOSTO write FIRF_DEDUCAOIMPOSTO;
    const IRF_DEDUCAOIMPOSTO_Name = 'IRF_DEDUCAOIMPOSTO';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALINSSRPA', ftBCD)]
    [Dictionary('IRF_PERCENTUALINSSRPA', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALINSSRPA: Double read FIRF_PERCENTUALINSSRPA write FIRF_PERCENTUALINSSRPA;
    const IRF_PERCENTUALINSSRPA_Name = 'IRF_PERCENTUALINSSRPA';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALSEST_SENAT', ftBCD)]
    [Dictionary('IRF_PERCENTUALSEST_SENAT', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALSEST_SENAT: Double read FIRF_PERCENTUALSEST_SENAT write FIRF_PERCENTUALSEST_SENAT;
    const IRF_PERCENTUALSEST_SENAT_Name = 'IRF_PERCENTUALSEST_SENAT';

    [Restrictions([NoValidate])]
    [Column('IRF_PERCENTUALBASECALCULOINSS', ftBCD)]
    [Dictionary('IRF_PERCENTUALBASECALCULOINSS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_PERCENTUALBASECALCULOINSS: Double read FIRF_PERCENTUALBASECALCULOINSS write FIRF_PERCENTUALBASECALCULOINSS;
    const IRF_PERCENTUALBASECALCULOINSS_Name = 'IRF_PERCENTUALBASECALCULOINSS';

    [Restrictions([NoValidate])]
    [Column('IRF_VALORTETOMAXIMOINSS', ftBCD)]
    [Dictionary('IRF_VALORTETOMAXIMOINSS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_VALORTETOMAXIMOINSS: Double read FIRF_VALORTETOMAXIMOINSS write FIRF_VALORTETOMAXIMOINSS;
    const IRF_VALORTETOMAXIMOINSS_Name = 'IRF_VALORTETOMAXIMOINSS';

    [Restrictions([NoValidate])]
    [Column('IRF_TETOFINALINSS', ftBCD)]
    [Dictionary('IRF_TETOFINALINSS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_TETOFINALINSS: Double read FIRF_TETOFINALINSS write FIRF_TETOFINALINSS;
    const IRF_TETOFINALINSS_Name = 'IRF_TETOFINALINSS';

    [Restrictions([NoValidate])]
    [Column('IRF_TETOINICIALINSS', ftBCD)]
    [Dictionary('IRF_TETOINICIALINSS', 'Mensagem de valida��o', '0', '', '', taRightJustify)]
    property IRF_TETOINICIALINSS: Double read FIRF_TETOINICIALINSS write FIRF_TETOINICIALINSS;
    const IRF_TETOINICIALINSS_Name = 'IRF_TETOINICIALINSS';

    [Restrictions([NoValidate])]
    [Column('IRF_PARAMETROIRF', ftString, 1)]
    [Dictionary('IRF_PARAMETROIRF', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property IRF_PARAMETROIRF: String read FIRF_PARAMETROIRF write FIRF_PARAMETROIRF;
    const IRF_PARAMETROIRF_Name = 'IRF_PARAMETROIRF';

    [Restrictions([NoValidate])]
    [Column('IRF_PARAMETROINSS', ftString, 1)]
    [Dictionary('IRF_PARAMETROINSS', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property IRF_PARAMETROINSS: String read FIRF_PARAMETROINSS write FIRF_PARAMETROINSS;
    const IRF_PARAMETROINSS_Name = 'IRF_PARAMETROINSS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoIRF_00)

end.
