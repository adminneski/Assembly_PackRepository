unit express.dbo.GRF_VALIDADEPRODUTO;

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
  [Table('GRF_VALIDADEPRODUTO', '')]
  TDtoGRF_VALIDADEPRODUTO = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FCOM_CODIGO: Integer;
    FETQ_QUANTIDADEVALIDADE: Double;
    FETQ_DATAVALIDADE: TDateTime;
    FETQ_ESTOQUEFILIAL: Double;
  public 
    { Public declarations } 
     const Table      = 'GRF_VALIDADEPRODUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_QUANTIDADEVALIDADE', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVALIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVALIDADE: Double read FETQ_QUANTIDADEVALIDADE write FETQ_QUANTIDADEVALIDADE;
    const ETQ_QUANTIDADEVALIDADE_Name = 'ETQ_QUANTIDADEVALIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_DATAVALIDADE', ftDateTime)]
    [Dictionary('ETQ_DATAVALIDADE', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ETQ_DATAVALIDADE: TDateTime read FETQ_DATAVALIDADE write FETQ_DATAVALIDADE;
    const ETQ_DATAVALIDADE_Name = 'ETQ_DATAVALIDADE';

    [Restrictions([NoValidate])]
    [Column('ETQ_ESTOQUEFILIAL', ftBCD, 18, 4)]
    [Dictionary('ETQ_ESTOQUEFILIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_ESTOQUEFILIAL: Double read FETQ_ESTOQUEFILIAL write FETQ_ESTOQUEFILIAL;
    const ETQ_ESTOQUEFILIAL_Name = 'ETQ_ESTOQUEFILIAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGRF_VALIDADEPRODUTO)

end.
