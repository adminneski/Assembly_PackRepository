unit express.dbo.VW_PSQ_CRF;

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
  [Table('VW_PSQ_CRF', '')]
  TDtoVW_PSQ_CRF = class
  private
    { Private declarations } 
    FCRF_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRF_NUMERODOCTO: String;
    FCRF_DATALANCAMENTO: TDateTime;
    FCRF_TOTALQTDRECOLHIDA: Double;
    FCRF_CANCELADO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CRF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_ID', ftInteger)]
    [Dictionary('CRF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRF_ID: Integer read FCRF_ID write FCRF_ID;
    const CRF_ID_Name = 'CRF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRF_NUMERODOCTO', ftString, 10)]
    [Dictionary('CRF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRF_NUMERODOCTO: String read FCRF_NUMERODOCTO write FCRF_NUMERODOCTO;
    const CRF_NUMERODOCTO_Name = 'CRF_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CRF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRF_DATALANCAMENTO: TDateTime read FCRF_DATALANCAMENTO write FCRF_DATALANCAMENTO;
    const CRF_DATALANCAMENTO_Name = 'CRF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_TOTALQTDRECOLHIDA', ftBCD)]
    [Dictionary('CRF_TOTALQTDRECOLHIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRF_TOTALQTDRECOLHIDA: Double read FCRF_TOTALQTDRECOLHIDA write FCRF_TOTALQTDRECOLHIDA;
    const CRF_TOTALQTDRECOLHIDA_Name = 'CRF_TOTALQTDRECOLHIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_CANCELADO', ftString, 1)]
    [Dictionary('CRF_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRF_CANCELADO: String read FCRF_CANCELADO write FCRF_CANCELADO;
    const CRF_CANCELADO_Name = 'CRF_CANCELADO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CRF)

end.
