unit express.dbo.VW_PSQ_OMF;

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
  [Table('VW_PSQ_OMF', '')]
  TDtoVW_PSQ_OMF = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_DATAENTRADA: TDateTime;
    FOMF_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FOMF_TOTALPRODUTOS: Double;
    FOMF_TOTALNOTAFISCAL: Double;
    FOMF_NOTAFISCAL: String;
    FOMF_PROCESSADO: String;
    FOMF_LIVROFISCAL: String;
    FOMF_CANCELADA: String;
    FOMF_TIPODOCUMENTO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_OMF';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAENTRADA', ftDateTime)]
    [Dictionary('OMF_DATAENTRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAENTRADA: TDateTime read FOMF_DATAENTRADA write FOMF_DATAENTRADA;
    const OMF_DATAENTRADA_Name = 'OMF_DATAENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('OMF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property OMF_DATALANCAMENTO: TDateTime read FOMF_DATALANCAMENTO write FOMF_DATALANCAMENTO;
    const OMF_DATALANCAMENTO_Name = 'OMF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALPRODUTOS', ftBCD)]
    [Dictionary('OMF_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALPRODUTOS: Double read FOMF_TOTALPRODUTOS write FOMF_TOTALPRODUTOS;
    const OMF_TOTALPRODUTOS_Name = 'OMF_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_TOTALNOTAFISCAL', ftBCD, 10, 2)]
    [Dictionary('OMF_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALNOTAFISCAL: Double read FOMF_TOTALNOTAFISCAL write FOMF_TOTALNOTAFISCAL;
    const OMF_TOTALNOTAFISCAL_Name = 'OMF_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('OMF_NOTAFISCAL', ftString, 9)]
    [Dictionary('OMF_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NOTAFISCAL: String read FOMF_NOTAFISCAL write FOMF_NOTAFISCAL;
    const OMF_NOTAFISCAL_Name = 'OMF_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_PROCESSADO', ftString, 1)]
    [Dictionary('OMF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_PROCESSADO: String read FOMF_PROCESSADO write FOMF_PROCESSADO;
    const OMF_PROCESSADO_Name = 'OMF_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('OMF_LIVROFISCAL', ftString, 1)]
    [Dictionary('OMF_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_LIVROFISCAL: String read FOMF_LIVROFISCAL write FOMF_LIVROFISCAL;
    const OMF_LIVROFISCAL_Name = 'OMF_LIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_CANCELADA', ftString, 1)]
    [Dictionary('OMF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CANCELADA: String read FOMF_CANCELADA write FOMF_CANCELADA;
    const OMF_CANCELADA_Name = 'OMF_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('OMF_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPODOCUMENTO: String read FOMF_TIPODOCUMENTO write FOMF_TIPODOCUMENTO;
    const OMF_TIPODOCUMENTO_Name = 'OMF_TIPODOCUMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_OMF)

end.
