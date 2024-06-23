unit express.dbo.VW_PSQ_PRT;

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
  [Table('VW_PSQ_PRT', '')]
  TDtoVW_PSQ_PRT = class
  private
    { Private declarations } 
    FPRT_ID: Integer;
    FPRT_NUMERODOCUMENTO: String;
    FCOM_CODIGO: Integer;
    FPRT_DATALANCAMENTO: TDateTime;
    FPRT_VEICULODESCRICAO: String;
    FPES_NOME: String;
    FPRT_QUANTIDADETOTAL: Double;
    FPRT_VALORTOTAL: Double;
    FPRT_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PRT';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRT_ID', ftInteger)]
    [Dictionary('PRT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_ID: Integer read FPRT_ID write FPRT_ID;
    const PRT_ID_Name = 'PRT_ID';

    [Restrictions([NoValidate])]
    [Column('PRT_NUMERODOCUMENTO', ftString, 9)]
    [Dictionary('PRT_NUMERODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_NUMERODOCUMENTO: String read FPRT_NUMERODOCUMENTO write FPRT_NUMERODOCUMENTO;
    const PRT_NUMERODOCUMENTO_Name = 'PRT_NUMERODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PRT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRT_DATALANCAMENTO: TDateTime read FPRT_DATALANCAMENTO write FPRT_DATALANCAMENTO;
    const PRT_DATALANCAMENTO_Name = 'PRT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRT_VEICULODESCRICAO', ftString, 100)]
    [Dictionary('PRT_VEICULODESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_VEICULODESCRICAO: String read FPRT_VEICULODESCRICAO write FPRT_VEICULODESCRICAO;
    const PRT_VEICULODESCRICAO_Name = 'PRT_VEICULODESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PRT_QUANTIDADETOTAL', ftBCD)]
    [Dictionary('PRT_QUANTIDADETOTAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_QUANTIDADETOTAL: Double read FPRT_QUANTIDADETOTAL write FPRT_QUANTIDADETOTAL;
    const PRT_QUANTIDADETOTAL_Name = 'PRT_QUANTIDADETOTAL';

    [Restrictions([NoValidate])]
    [Column('PRT_VALORTOTAL', ftBCD)]
    [Dictionary('PRT_VALORTOTAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_VALORTOTAL: Double read FPRT_VALORTOTAL write FPRT_VALORTOTAL;
    const PRT_VALORTOTAL_Name = 'PRT_VALORTOTAL';

    [Restrictions([NoValidate])]
    [Column('PRT_DESATIVADO', ftString, 1)]
    [Dictionary('PRT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_DESATIVADO: String read FPRT_DESATIVADO write FPRT_DESATIVADO;
    const PRT_DESATIVADO_Name = 'PRT_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PRT)

end.
