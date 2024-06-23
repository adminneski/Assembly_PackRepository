unit express.dbo.CPS_00;

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
  [Table('CPS_00', '')]
  [PrimaryKey('CPS_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPS_ID')]
  TDtoCPS_00 = class
  private
    { Private declarations } 
    FCPS_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCPS_DATACADASTRO: TDateTime;
    FNTO_CODIGO: Integer;
    FMDO_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FCPS_VALORMENSALIDADE: Double;
    FCPS_VALORNOTAFISCAL: Double;
    FCPS_DIAPAGAMENTO: String;
    FCPS_RESPONSAVELFINANCEIRO: String;
    FCPS_PLANO: String;
    FCPS_PARAMETROS: String;
    FCPS_OBSERVACAO: String;
    FCPS_ULTIMOMESANOGERADO: String;
    FCPS_ULTIMANOTAFISCALGERADA: Integer;
    FCPS_DESATIVADO: String;
    FCPS_DATAALTERACAO: TDateTime;
    FCPS_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CPS_00';
     const PrimaryKey = 'CPS_ID';
     const Sequence   = 'SEQ_CPS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPS_ID', ftInteger)]
    [Dictionary('CPS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPS_ID: Integer read FCPS_ID write FCPS_ID;
    const CPS_ID_Name = 'CPS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPS_DATACADASTRO', ftDateTime)]
    [Dictionary('CPS_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPS_DATACADASTRO: TDateTime read FCPS_DATACADASTRO write FCPS_DATACADASTRO;
    const CPS_DATACADASTRO_Name = 'CPS_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPS_VALORMENSALIDADE', ftBCD)]
    [Dictionary('CPS_VALORMENSALIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPS_VALORMENSALIDADE: Double read FCPS_VALORMENSALIDADE write FCPS_VALORMENSALIDADE;
    const CPS_VALORMENSALIDADE_Name = 'CPS_VALORMENSALIDADE';

    [Restrictions([NoValidate])]
    [Column('CPS_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('CPS_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPS_VALORNOTAFISCAL: Double read FCPS_VALORNOTAFISCAL write FCPS_VALORNOTAFISCAL;
    const CPS_VALORNOTAFISCAL_Name = 'CPS_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPS_DIAPAGAMENTO', ftString, 2)]
    [Dictionary('CPS_DIAPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_DIAPAGAMENTO: String read FCPS_DIAPAGAMENTO write FCPS_DIAPAGAMENTO;
    const CPS_DIAPAGAMENTO_Name = 'CPS_DIAPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('CPS_RESPONSAVELFINANCEIRO', ftString, 50)]
    [Dictionary('CPS_RESPONSAVELFINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_RESPONSAVELFINANCEIRO: String read FCPS_RESPONSAVELFINANCEIRO write FCPS_RESPONSAVELFINANCEIRO;
    const CPS_RESPONSAVELFINANCEIRO_Name = 'CPS_RESPONSAVELFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('CPS_PLANO', ftString, 100)]
    [Dictionary('CPS_PLANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_PLANO: String read FCPS_PLANO write FCPS_PLANO;
    const CPS_PLANO_Name = 'CPS_PLANO';

    [Restrictions([NoValidate])]
    [Column('CPS_PARAMETROS', ftString, 30)]
    [Dictionary('CPS_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_PARAMETROS: String read FCPS_PARAMETROS write FCPS_PARAMETROS;
    const CPS_PARAMETROS_Name = 'CPS_PARAMETROS';

    [Restrictions([NoValidate])]
    [Column('CPS_OBSERVACAO', ftString, 5000)]
    [Dictionary('CPS_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_OBSERVACAO: String read FCPS_OBSERVACAO write FCPS_OBSERVACAO;
    const CPS_OBSERVACAO_Name = 'CPS_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CPS_ULTIMOMESANOGERADO', ftString, 6)]
    [Dictionary('CPS_ULTIMOMESANOGERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_ULTIMOMESANOGERADO: String read FCPS_ULTIMOMESANOGERADO write FCPS_ULTIMOMESANOGERADO;
    const CPS_ULTIMOMESANOGERADO_Name = 'CPS_ULTIMOMESANOGERADO';

    [Restrictions([NoValidate])]
    [Column('CPS_ULTIMANOTAFISCALGERADA', ftInteger)]
    [Dictionary('CPS_ULTIMANOTAFISCALGERADA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPS_ULTIMANOTAFISCALGERADA: Integer read FCPS_ULTIMANOTAFISCALGERADA write FCPS_ULTIMANOTAFISCALGERADA;
    const CPS_ULTIMANOTAFISCALGERADA_Name = 'CPS_ULTIMANOTAFISCALGERADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPS_DESATIVADO', ftString, 1)]
    [Dictionary('CPS_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPS_DESATIVADO: String read FCPS_DESATIVADO write FCPS_DESATIVADO;
    const CPS_DESATIVADO_Name = 'CPS_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPS_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPS_DATAALTERACAO: TDateTime read FCPS_DATAALTERACAO write FCPS_DATAALTERACAO;
    const CPS_DATAALTERACAO_Name = 'CPS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPS_ID_OLD', ftInteger)]
    [Dictionary('CPS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPS_ID_OLD: Integer read FCPS_ID_OLD write FCPS_ID_OLD;
    const CPS_ID_OLD_Name = 'CPS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPS_00)

end.
