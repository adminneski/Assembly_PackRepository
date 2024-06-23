unit express.dbo.REL_V01_TAB;

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
  [Table('REL_V01_TAB', '')]
  TDtoREL_V01_TAB = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_EMBALAGEM: String;
    FPRO_REFERENCIAINTERNA: String;
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FSGM_CODIGO: String;
    FMAR_CODIGO: Integer;
    FETQ_ESTOQUEFILIAL: Double;
    FETQ_VALORCUSTOCOMPRA: Double;
    FETQ_VALORCUSTOINVENTARIO: Double;
    FETQ_VALORCUSTOLIQUIDO: Double;
    FETQ_TOTALCUSTOCOMPRA: Double;
    FETQ_TOTALCUSTOINVENTARIO: Double;
    FETQ_TOTALCUSTOLIQUIDO: Double;
    FETQ_MARGEMCUSTOCOMPRA: Double;
    FETQ_MARGEMCUSTOINVENTARIO: Double;
    FETQ_MARGEMCUSTOLIQUIDO: Double;
    FTAB_CODIGO: Integer;
    FPRO_PRECOTABELA: Double;
    FPRO_PRECOPEDIDO: Double;
    FPRO_TOTALPRECOTABELA: Double;
    FPRO_TOTALPRECOPEDIDO: Double;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_TAB';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEFILIAL', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIAL: Double read FETQ_ESTOQUEFILIAL write FETQ_ESTOQUEFILIAL;
    const ETQ_ESTOQUEFILIAL_Name = 'ETQ_ESTOQUEFILIAL';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOCOMPRA: Double read FETQ_VALORCUSTOCOMPRA write FETQ_VALORCUSTOCOMPRA;
    const ETQ_VALORCUSTOCOMPRA_Name = 'ETQ_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOINVENTARIO: Double read FETQ_VALORCUSTOINVENTARIO write FETQ_VALORCUSTOINVENTARIO;
    const ETQ_VALORCUSTOINVENTARIO_Name = 'ETQ_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('ETQ_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_VALORCUSTOLIQUIDO: Double read FETQ_VALORCUSTOLIQUIDO write FETQ_VALORCUSTOLIQUIDO;
    const ETQ_VALORCUSTOLIQUIDO_Name = 'ETQ_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ETQ_TOTALCUSTOCOMPRA', ftBCD)]
    [Dictionary('ETQ_TOTALCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_TOTALCUSTOCOMPRA: Double read FETQ_TOTALCUSTOCOMPRA write FETQ_TOTALCUSTOCOMPRA;
    const ETQ_TOTALCUSTOCOMPRA_Name = 'ETQ_TOTALCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('ETQ_TOTALCUSTOINVENTARIO', ftBCD)]
    [Dictionary('ETQ_TOTALCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_TOTALCUSTOINVENTARIO: Double read FETQ_TOTALCUSTOINVENTARIO write FETQ_TOTALCUSTOINVENTARIO;
    const ETQ_TOTALCUSTOINVENTARIO_Name = 'ETQ_TOTALCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('ETQ_TOTALCUSTOLIQUIDO', ftBCD)]
    [Dictionary('ETQ_TOTALCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_TOTALCUSTOLIQUIDO: Double read FETQ_TOTALCUSTOLIQUIDO write FETQ_TOTALCUSTOLIQUIDO;
    const ETQ_TOTALCUSTOLIQUIDO_Name = 'ETQ_TOTALCUSTOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_MARGEMCUSTOCOMPRA', ftBCD)]
    [Dictionary('ETQ_MARGEMCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_MARGEMCUSTOCOMPRA: Double read FETQ_MARGEMCUSTOCOMPRA write FETQ_MARGEMCUSTOCOMPRA;
    const ETQ_MARGEMCUSTOCOMPRA_Name = 'ETQ_MARGEMCUSTOCOMPRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_MARGEMCUSTOINVENTARIO', ftBCD)]
    [Dictionary('ETQ_MARGEMCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_MARGEMCUSTOINVENTARIO: Double read FETQ_MARGEMCUSTOINVENTARIO write FETQ_MARGEMCUSTOINVENTARIO;
    const ETQ_MARGEMCUSTOINVENTARIO_Name = 'ETQ_MARGEMCUSTOINVENTARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_MARGEMCUSTOLIQUIDO', ftBCD)]
    [Dictionary('ETQ_MARGEMCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_MARGEMCUSTOLIQUIDO: Double read FETQ_MARGEMCUSTOLIQUIDO write FETQ_MARGEMCUSTOLIQUIDO;
    const ETQ_MARGEMCUSTOLIQUIDO_Name = 'ETQ_MARGEMCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOTABELA', ftBCD)]
    [Dictionary('PRO_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOTABELA: Double read FPRO_PRECOTABELA write FPRO_PRECOTABELA;
    const PRO_PRECOTABELA_Name = 'PRO_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PRO_PRECOPEDIDO', ftBCD, 10, 2)]
    [Dictionary('PRO_PRECOPEDIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PRECOPEDIDO: Double read FPRO_PRECOPEDIDO write FPRO_PRECOPEDIDO;
    const PRO_PRECOPEDIDO_Name = 'PRO_PRECOPEDIDO';

    [Restrictions([NoValidate])]
    [Column('PRO_TOTALPRECOTABELA', ftBCD)]
    [Dictionary('PRO_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_TOTALPRECOTABELA: Double read FPRO_TOTALPRECOTABELA write FPRO_TOTALPRECOTABELA;
    const PRO_TOTALPRECOTABELA_Name = 'PRO_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PRO_TOTALPRECOPEDIDO', ftBCD)]
    [Dictionary('PRO_TOTALPRECOPEDIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_TOTALPRECOPEDIDO: Double read FPRO_TOTALPRECOPEDIDO write FPRO_TOTALPRECOPEDIDO;
    const PRO_TOTALPRECOPEDIDO_Name = 'PRO_TOTALPRECOPEDIDO';

    [Restrictions([NoValidate])]
    [Column('FAB_CODIGO', ftInteger)]
    [Dictionary('FAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAB_CODIGO: Integer read FFAB_CODIGO write FFAB_CODIGO;
    const FAB_CODIGO_Name = 'FAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAB_NOME', ftString, 100)]
    [Dictionary('FAB_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAB_NOME: String read FFAB_NOME write FFAB_NOME;
    const FAB_NOME_Name = 'FAB_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_TAB)

end.
