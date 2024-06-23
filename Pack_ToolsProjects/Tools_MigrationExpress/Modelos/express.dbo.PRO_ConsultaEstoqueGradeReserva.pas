unit express.dbo.PRO_CONSULTAESTOQUEGRADERESERVA;

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
  [Table('PRO_ConsultaEstoqueGradeReserva', '')]
  TDtoPRO_ConsultaEstoqueGradeReserva = class
  private
    { Private declarations } 
    FETR_SIGLA: String;
    FETR_TIPOMOVTO: String;
    FETR_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FGRD_CODIGO: String;
    FETR_QTDPEDIDA: Double;
    FETR_PRECOTABELA: Double;
    FETR_PRECOLIQUIDO: Double;
    FETR_PRECOCUSTOCOMPRA: Double;
    FETR_PRECOCUSTOLIQUIDO: Double;
    FPES_CODIGO: Integer;
    FETR_NUMERODOCTO: String;
    FETR_NUMEROOS: Integer;
    FETR_DATAEMISSAO: TDateTime;
    FPES_NOME: String;
    FPRO_DESCRICAO: String;
    FETR_SIGLAID: String;
  public 
    { Public declarations } 
     const Table      = 'PRO_ConsultaEstoqueGradeReserva';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETR_SIGLA', ftString, 3)]
    [Dictionary('ETR_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ETR_SIGLA: String read FETR_SIGLA write FETR_SIGLA;
    const ETR_SIGLA_Name = 'ETR_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETR_TIPOMOVTO', ftString, 30)]
    [Dictionary('ETR_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ETR_TIPOMOVTO: String read FETR_TIPOMOVTO write FETR_TIPOMOVTO;
    const ETR_TIPOMOVTO_Name = 'ETR_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETR_ID', ftInteger)]
    [Dictionary('ETR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETR_ID: Integer read FETR_ID write FETR_ID;
    const ETR_ID_Name = 'ETR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETR_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('ETR_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETR_QTDPEDIDA: Double read FETR_QTDPEDIDA write FETR_QTDPEDIDA;
    const ETR_QTDPEDIDA_Name = 'ETR_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('ETR_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('ETR_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETR_PRECOTABELA: Double read FETR_PRECOTABELA write FETR_PRECOTABELA;
    const ETR_PRECOTABELA_Name = 'ETR_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('ETR_PRECOLIQUIDO', ftBCD)]
    [Dictionary('ETR_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETR_PRECOLIQUIDO: Double read FETR_PRECOLIQUIDO write FETR_PRECOLIQUIDO;
    const ETR_PRECOLIQUIDO_Name = 'ETR_PRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ETR_PRECOCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('ETR_PRECOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETR_PRECOCUSTOCOMPRA: Double read FETR_PRECOCUSTOCOMPRA write FETR_PRECOCUSTOCOMPRA;
    const ETR_PRECOCUSTOCOMPRA_Name = 'ETR_PRECOCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('ETR_PRECOCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('ETR_PRECOCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETR_PRECOCUSTOLIQUIDO: Double read FETR_PRECOCUSTOLIQUIDO write FETR_PRECOCUSTOLIQUIDO;
    const ETR_PRECOCUSTOLIQUIDO_Name = 'ETR_PRECOCUSTOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETR_NUMERODOCTO', ftString, 20)]
    [Dictionary('ETR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ETR_NUMERODOCTO: String read FETR_NUMERODOCTO write FETR_NUMERODOCTO;
    const ETR_NUMERODOCTO_Name = 'ETR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('ETR_NUMEROOS', ftInteger)]
    [Dictionary('ETR_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETR_NUMEROOS: Integer read FETR_NUMEROOS write FETR_NUMEROOS;
    const ETR_NUMEROOS_Name = 'ETR_NUMEROOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETR_DATAEMISSAO', ftDateTime)]
    [Dictionary('ETR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ETR_DATAEMISSAO: TDateTime read FETR_DATAEMISSAO write FETR_DATAEMISSAO;
    const ETR_DATAEMISSAO_Name = 'ETR_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('ETR_SIGLAID', ftString, 33)]
    [Dictionary('ETR_SIGLAID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ETR_SIGLAID: String read FETR_SIGLAID write FETR_SIGLAID;
    const ETR_SIGLAID_Name = 'ETR_SIGLAID';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_ConsultaEstoqueGradeReserva)

end.
