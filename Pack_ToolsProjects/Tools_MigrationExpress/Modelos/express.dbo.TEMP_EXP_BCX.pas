unit express.dbo.TEMP_EXP_BCX;

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
  [Table('TEMP_EXP_BCX', '')]
  TDtoTEMP_EXP_BCX = class
  private
    { Private declarations } 
    FDATA: TDateTime;
    FNR_DOCUMENTO: String;
    FCNPJ_CPF: String;
    FHISTORICO: String;
    FVR_DOCUMENTO: Double;
    FRECEBIMENTO: Double;
    FPAGAMENTO: Double;
    FJUROS_REC: Double;
    FJUROS_PGTO: Double;
    FDESCONTO_OBTIDO: Double;
    FDESCONTO_CONCEDIDO: Double;
    FBANCO: String;
    FBAIRRO: String;
    FCIDADE: String;
    FUF: String;
  public 
    { Public declarations } 
     const Table      = 'TEMP_EXP_BCX';

    [Restrictions([NoValidate])]
    [Column('DATA', ftDateTime)]
    [Dictionary('DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property DATA: TDateTime read FDATA write FDATA;
    const DATA_Name = 'DATA';

    [Restrictions([NoValidate])]
    [Column('NR_DOCUMENTO', ftString, 20)]
    [Dictionary('NR_DOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NR_DOCUMENTO: String read FNR_DOCUMENTO write FNR_DOCUMENTO;
    const NR_DOCUMENTO_Name = 'NR_DOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CNPJ_CPF', ftString, 14)]
    [Dictionary('CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNPJ_CPF: String read FCNPJ_CPF write FCNPJ_CPF;
    const CNPJ_CPF_Name = 'CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('HISTORICO', ftString, 5000)]
    [Dictionary('HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property HISTORICO: String read FHISTORICO write FHISTORICO;
    const HISTORICO_Name = 'HISTORICO';

    [Restrictions([NoValidate])]
    [Column('VR_DOCUMENTO', ftBCD, 1952867660, 2)]
    [Dictionary('VR_DOCUMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VR_DOCUMENTO: Double read FVR_DOCUMENTO write FVR_DOCUMENTO;
    const VR_DOCUMENTO_Name = 'VR_DOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('RECEBIMENTO', ftBCD, 2097273, 2)]
    [Dictionary('RECEBIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RECEBIMENTO: Double read FRECEBIMENTO write FRECEBIMENTO;
    const RECEBIMENTO_Name = 'RECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('PAGAMENTO', ftBCD, 4522064, 2)]
    [Dictionary('PAGAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PAGAMENTO: Double read FPAGAMENTO write FPAGAMENTO;
    const PAGAMENTO_Name = 'PAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('JUROS_REC', ftBCD, 1869770784, 2)]
    [Dictionary('JUROS_REC', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property JUROS_REC: Double read FJUROS_REC write FJUROS_REC;
    const JUROS_REC_Name = 'JUROS_REC';

    [Restrictions([NoValidate])]
    [Column('JUROS_PGTO', ftBCD, 7077999, 2)]
    [Dictionary('JUROS_PGTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property JUROS_PGTO: Double read FJUROS_PGTO write FJUROS_PGTO;
    const JUROS_PGTO_Name = 'JUROS_PGTO';

    [Restrictions([NoValidate])]
    [Column('DESCONTO_OBTIDO', ftBCD, 1529377646, 2)]
    [Dictionary('DESCONTO_OBTIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DESCONTO_OBTIDO: Double read FDESCONTO_OBTIDO write FDESCONTO_OBTIDO;
    const DESCONTO_OBTIDO_Name = 'DESCONTO_OBTIDO';

    [Restrictions([NoValidate])]
    [Column('DESCONTO_CONCEDIDO', ftBCD, 544040295, 2)]
    [Dictionary('DESCONTO_CONCEDIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DESCONTO_CONCEDIDO: Double read FDESCONTO_CONCEDIDO write FDESCONTO_CONCEDIDO;
    const DESCONTO_CONCEDIDO_Name = 'DESCONTO_CONCEDIDO';

    [Restrictions([NoValidate])]
    [Column('BANCO', ftString, 50)]
    [Dictionary('BANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BANCO: String read FBANCO write FBANCO;
    const BANCO_Name = 'BANCO';

    [Restrictions([NoValidate])]
    [Column('BAIRRO', ftString, 100)]
    [Dictionary('BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BAIRRO: String read FBAIRRO write FBAIRRO;
    const BAIRRO_Name = 'BAIRRO';

    [Restrictions([NoValidate])]
    [Column('CIDADE', ftString, 100)]
    [Dictionary('CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIDADE: String read FCIDADE write FCIDADE;
    const CIDADE_Name = 'CIDADE';

    [Restrictions([NoValidate])]
    [Column('UF', ftString, 2)]
    [Dictionary('UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UF: String read FUF write FUF;
    const UF_Name = 'UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTEMP_EXP_BCX)

end.
