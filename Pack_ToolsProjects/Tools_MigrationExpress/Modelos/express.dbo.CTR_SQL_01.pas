unit express.dbo.CTR_SQL_01;

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
  [Table('CTR_SQL_01', '')]
  TDtoCTR_SQL_01 = class
  private
    { Private declarations } 
    FCTR_NOTAFISCAL: String;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FCTR_SERIE: String;
    FMNF_CODIGO: String;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_ORDEMITEM: Integer;
    FCTR_NOTAFISCAL_01: String;
    FCTR_VALORNOTAFISCAL: Double;
    FCTR_VALORSEMIPI: Double;
    FCTR_VALORCOMIPI: Double;
    FCTR_PESOLIQUIDO: Double;
    FCTR_DATARECEBIMENTO: TDateTime;
    FCTR_NOMERECEPTOR: String;
    FCTR_OBSERVACAO: String;
    FCTR_PESOLIQUIDORECEBIMENTO: Double;
    FCTR_BAIXADO: String;
    FPES_NOME: String;
    FCTR_PROCESSADO: String;
    FCTR_CANCELADO: String;
  public 
    { Public declarations } 
     const Table      = 'CTR_SQL_01';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ORDEMITEM', ftInteger)]
    [Dictionary('CTR_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ORDEMITEM: Integer read FCTR_ORDEMITEM write FCTR_ORDEMITEM;
    const CTR_ORDEMITEM_Name = 'CTR_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL_01', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL_01: String read FCTR_NOTAFISCAL_01 write FCTR_NOTAFISCAL_01;
    const CTR_NOTAFISCAL_01_Name = 'CTR_NOTAFISCAL_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORNOTAFISCAL: Double read FCTR_VALORNOTAFISCAL write FCTR_VALORNOTAFISCAL;
    const CTR_VALORNOTAFISCAL_Name = 'CTR_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORSEMIPI', ftBCD)]
    [Dictionary('CTR_VALORSEMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORSEMIPI: Double read FCTR_VALORSEMIPI write FCTR_VALORSEMIPI;
    const CTR_VALORSEMIPI_Name = 'CTR_VALORSEMIPI';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORCOMIPI', ftBCD)]
    [Dictionary('CTR_VALORCOMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORCOMIPI: Double read FCTR_VALORCOMIPI write FCTR_VALORCOMIPI;
    const CTR_VALORCOMIPI_Name = 'CTR_VALORCOMIPI';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOLIQUIDO: Double read FCTR_PESOLIQUIDO write FCTR_PESOLIQUIDO;
    const CTR_PESOLIQUIDO_Name = 'CTR_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATARECEBIMENTO', ftDateTime)]
    [Dictionary('CTR_DATARECEBIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATARECEBIMENTO: TDateTime read FCTR_DATARECEBIMENTO write FCTR_DATARECEBIMENTO;
    const CTR_DATARECEBIMENTO_Name = 'CTR_DATARECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOMERECEPTOR', ftString, 50)]
    [Dictionary('CTR_NOMERECEPTOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOMERECEPTOR: String read FCTR_NOMERECEPTOR write FCTR_NOMERECEPTOR;
    const CTR_NOMERECEPTOR_Name = 'CTR_NOMERECEPTOR';

    [Restrictions([NoValidate])]
    [Column('CTR_OBSERVACAO', ftString, 5000)]
    [Dictionary('CTR_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_OBSERVACAO: String read FCTR_OBSERVACAO write FCTR_OBSERVACAO;
    const CTR_OBSERVACAO_Name = 'CTR_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_PESOLIQUIDORECEBIMENTO', ftBCD)]
    [Dictionary('CTR_PESOLIQUIDORECEBIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOLIQUIDORECEBIMENTO: Double read FCTR_PESOLIQUIDORECEBIMENTO write FCTR_PESOLIQUIDORECEBIMENTO;
    const CTR_PESOLIQUIDORECEBIMENTO_Name = 'CTR_PESOLIQUIDORECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_BAIXADO', ftString, 1)]
    [Dictionary('CTR_BAIXADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_BAIXADO: String read FCTR_BAIXADO write FCTR_BAIXADO;
    const CTR_BAIXADO_Name = 'CTR_BAIXADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CTR_PROCESSADO', ftString, 1)]
    [Dictionary('CTR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROCESSADO: String read FCTR_PROCESSADO write FCTR_PROCESSADO;
    const CTR_PROCESSADO_Name = 'CTR_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('CTR_CANCELADO', ftString, 1)]
    [Dictionary('CTR_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CANCELADO: String read FCTR_CANCELADO write FCTR_CANCELADO;
    const CTR_CANCELADO_Name = 'CTR_CANCELADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_SQL_01)

end.
