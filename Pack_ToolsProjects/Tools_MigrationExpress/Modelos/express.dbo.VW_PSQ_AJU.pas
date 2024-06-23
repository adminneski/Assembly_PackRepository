unit express.dbo.VW_PSQ_AJU;

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
  [Table('VW_PSQ_AJU', '')]
  TDtoVW_PSQ_AJU = class
  private
    { Private declarations } 
    FAJU_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FAJU_DATALANCAMENTO: TDateTime;
    FAJU_SALDOFINALDIA: Double;
    FAJU_VALORCUSTOCOMPRA: Double;
    FAJU_VALORCUSTOLIQUIDO: Double;
    FAJU_VALORCUSTOINVENTARIO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_AJU';

    [Restrictions([NoValidate, NotNull])]
    [Column('AJU_ID', ftInteger)]
    [Dictionary('AJU_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property AJU_ID: Integer read FAJU_ID write FAJU_ID;
    const AJU_ID_Name = 'AJU_ID';

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
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('AJU_DATALANCAMENTO', ftDateTime)]
    [Dictionary('AJU_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property AJU_DATALANCAMENTO: TDateTime read FAJU_DATALANCAMENTO write FAJU_DATALANCAMENTO;
    const AJU_DATALANCAMENTO_Name = 'AJU_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('AJU_SALDOFINALDIA', ftBCD, 18, 4)]
    [Dictionary('AJU_SALDOFINALDIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_SALDOFINALDIA: Double read FAJU_SALDOFINALDIA write FAJU_SALDOFINALDIA;
    const AJU_SALDOFINALDIA_Name = 'AJU_SALDOFINALDIA';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOCOMPRA: Double read FAJU_VALORCUSTOCOMPRA write FAJU_VALORCUSTOCOMPRA;
    const AJU_VALORCUSTOCOMPRA_Name = 'AJU_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOLIQUIDO: Double read FAJU_VALORCUSTOLIQUIDO write FAJU_VALORCUSTOLIQUIDO;
    const AJU_VALORCUSTOLIQUIDO_Name = 'AJU_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('AJU_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('AJU_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AJU_VALORCUSTOINVENTARIO: Double read FAJU_VALORCUSTOINVENTARIO write FAJU_VALORCUSTOINVENTARIO;
    const AJU_VALORCUSTOINVENTARIO_Name = 'AJU_VALORCUSTOINVENTARIO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_AJU)

end.
