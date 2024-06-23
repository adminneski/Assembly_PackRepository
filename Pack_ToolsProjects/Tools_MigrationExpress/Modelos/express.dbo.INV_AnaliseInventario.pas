unit express.dbo.INV_ANALISEINVENTARIO;

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
  [Table('INV_AnaliseInventario', '')]
  TDtoINV_AnaliseInventario = class
  private
    { Private declarations } 
    FINV_SIGLA: String;
    FINV_TIPOMOVTO: String;
    FINV_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FINV_QUANTIDADE: Double;
    FINV_VALORCUSTOCOMPRA: Double;
    FINV_VALORCUSTOLIQUIDO: Double;
    FINV_VALORCUSTOINVENTARIO: Double;
    FINV_VALORCUSTOCOMPRAMEDIO: Double;
    FINV_VALORCUSTOLIQUIDOMEDIO: Double;
    FINV_VALORCUSTOINVENTARIOMEDIO: Double;
    FPES_CODIGO: Integer;
    FINV_NOTAFISCAL: String;
    FINV_DATALANCAMENTO: TDateTime;
    FPES_NOME: String;
    FPRO_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'INV_AnaliseInventario';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SIGLA', ftString, 3)]
    [Dictionary('INV_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SIGLA: String read FINV_SIGLA write FINV_SIGLA;
    const INV_SIGLA_Name = 'INV_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_TIPOMOVTO', ftString, 37)]
    [Dictionary('INV_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_TIPOMOVTO: String read FINV_TIPOMOVTO write FINV_TIPOMOVTO;
    const INV_TIPOMOVTO_Name = 'INV_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('INV_ID', ftInteger)]
    [Dictionary('INV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ID: Integer read FINV_ID write FINV_ID;
    const INV_ID_Name = 'INV_ID';

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
    [Column('INV_QUANTIDADE', ftBCD)]
    [Dictionary('INV_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QUANTIDADE: Double read FINV_QUANTIDADE write FINV_QUANTIDADE;
    const INV_QUANTIDADE_Name = 'INV_QUANTIDADE';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOCOMPRA', ftBCD)]
    [Dictionary('INV_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRA: Double read FINV_VALORCUSTOCOMPRA write FINV_VALORCUSTOCOMPRA;
    const INV_VALORCUSTOCOMPRA_Name = 'INV_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOLIQUIDO', ftBCD)]
    [Dictionary('INV_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOLIQUIDO: Double read FINV_VALORCUSTOLIQUIDO write FINV_VALORCUSTOLIQUIDO;
    const INV_VALORCUSTOLIQUIDO_Name = 'INV_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOINVENTARIO', ftBCD)]
    [Dictionary('INV_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIO: Double read FINV_VALORCUSTOINVENTARIO write FINV_VALORCUSTOINVENTARIO;
    const INV_VALORCUSTOINVENTARIO_Name = 'INV_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOCOMPRAMEDIO', ftBCD)]
    [Dictionary('INV_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOCOMPRAMEDIO: Double read FINV_VALORCUSTOCOMPRAMEDIO write FINV_VALORCUSTOCOMPRAMEDIO;
    const INV_VALORCUSTOCOMPRAMEDIO_Name = 'INV_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOLIQUIDOMEDIO', ftBCD, 48, 5)]
    [Dictionary('INV_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOLIQUIDOMEDIO: Double read FINV_VALORCUSTOLIQUIDOMEDIO write FINV_VALORCUSTOLIQUIDOMEDIO;
    const INV_VALORCUSTOLIQUIDOMEDIO_Name = 'INV_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('INV_VALORCUSTOINVENTARIOMEDIO', ftBCD, 48, 5)]
    [Dictionary('INV_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_VALORCUSTOINVENTARIOMEDIO: Double read FINV_VALORCUSTOINVENTARIOMEDIO write FINV_VALORCUSTOINVENTARIOMEDIO;
    const INV_VALORCUSTOINVENTARIOMEDIO_Name = 'INV_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('INV_NOTAFISCAL', ftString, 20)]
    [Dictionary('INV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_NOTAFISCAL: String read FINV_NOTAFISCAL write FINV_NOTAFISCAL;
    const INV_NOTAFISCAL_Name = 'INV_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('INV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('INV_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATALANCAMENTO: TDateTime read FINV_DATALANCAMENTO write FINV_DATALANCAMENTO;
    const INV_DATALANCAMENTO_Name = 'INV_DATALANCAMENTO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoINV_AnaliseInventario)

end.
