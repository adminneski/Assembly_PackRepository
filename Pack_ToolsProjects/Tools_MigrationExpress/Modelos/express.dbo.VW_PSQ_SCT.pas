unit express.dbo.VW_PSQ_SCT;

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
  [Table('VW_PSQ_SCT', '')]
  TDtoVW_PSQ_SCT = class
  private
    { Private declarations } 
    FSCT_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FSCT_ID: Integer;
    FPES_CODIGO: Integer;
    FSCT_DATAVENCTO: TDateTime;
    FSCT_TOTALVALOR: Double;
    FSCT_DATAEMISSAO: TDateTime;
    FSCT_NUMERODOCTO: String;
    FSCT_NOSSONUMERO: String;
    FSCT_COMPETENCIA: String;
    FSCT_DATALANCAMENTO: TDateTime;
    FSCT_PROCESSADO: String;
    FPES_NOME: String;
    FSCT_TOTALVALORSUBSTITUTO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_SCT';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_02_ID', ftInteger)]
    [Dictionary('SCT_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_02_ID: Integer read FSCT_02_ID write FSCT_02_ID;
    const SCT_02_ID_Name = 'SCT_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_ID', ftInteger)]
    [Dictionary('SCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCT_ID: Integer read FSCT_ID write FSCT_ID;
    const SCT_ID_Name = 'SCT_ID';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAVENCTO', ftDateTime)]
    [Dictionary('SCT_DATAVENCTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAVENCTO: TDateTime read FSCT_DATAVENCTO write FSCT_DATAVENCTO;
    const SCT_DATAVENCTO_Name = 'SCT_DATAVENCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_TOTALVALOR', ftBCD)]
    [Dictionary('SCT_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALOR: Double read FSCT_TOTALVALOR write FSCT_TOTALVALOR;
    const SCT_TOTALVALOR_Name = 'SCT_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCT_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATAEMISSAO: TDateTime read FSCT_DATAEMISSAO write FSCT_DATAEMISSAO;
    const SCT_DATAEMISSAO_Name = 'SCT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('SCT_NUMERODOCTO', ftString, 15)]
    [Dictionary('SCT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_NUMERODOCTO: String read FSCT_NUMERODOCTO write FSCT_NUMERODOCTO;
    const SCT_NUMERODOCTO_Name = 'SCT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCT_NOSSONUMERO', ftString, 20)]
    [Dictionary('SCT_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_NOSSONUMERO: String read FSCT_NOSSONUMERO write FSCT_NOSSONUMERO;
    const SCT_NOSSONUMERO_Name = 'SCT_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('SCT_COMPETENCIA', ftString, 6)]
    [Dictionary('SCT_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_COMPETENCIA: String read FSCT_COMPETENCIA write FSCT_COMPETENCIA;
    const SCT_COMPETENCIA_Name = 'SCT_COMPETENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCT_DATALANCAMENTO: TDateTime read FSCT_DATALANCAMENTO write FSCT_DATALANCAMENTO;
    const SCT_DATALANCAMENTO_Name = 'SCT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_PROCESSADO', ftString, 1)]
    [Dictionary('SCT_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCT_PROCESSADO: String read FSCT_PROCESSADO write FSCT_PROCESSADO;
    const SCT_PROCESSADO_Name = 'SCT_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCT_TOTALVALORSUBSTITUTO', ftBCD, 48, 2)]
    [Dictionary('SCT_TOTALVALORSUBSTITUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCT_TOTALVALORSUBSTITUTO: Double read FSCT_TOTALVALORSUBSTITUTO write FSCT_TOTALVALORSUBSTITUTO;
    const SCT_TOTALVALORSUBSTITUTO_Name = 'SCT_TOTALVALORSUBSTITUTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_SCT)

end.
