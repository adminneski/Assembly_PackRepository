unit express.dbo.BCP_SQL_00;

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
  [Table('BCP_SQL_00', '')]
  TDtoBCP_SQL_00 = class
  private
    { Private declarations } 
    FBCP_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCP_DATALANCAMENTO: TDateTime;
    FBCP_PROCESSADO: String;
    FCTA_CODIGO: Integer;
    FCTA_EMITENTE: String;
  public 
    { Public declarations } 
     const Table      = 'BCP_SQL_00';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_ID', ftInteger)]
    [Dictionary('BCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID: Integer read FBCP_ID write FBCP_ID;
    const BCP_ID_Name = 'BCP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCP_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCP_DATALANCAMENTO: TDateTime read FBCP_DATALANCAMENTO write FBCP_DATALANCAMENTO;
    const BCP_DATALANCAMENTO_Name = 'BCP_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_PROCESSADO', ftString, 1)]
    [Dictionary('BCP_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCP_PROCESSADO: String read FBCP_PROCESSADO write FBCP_PROCESSADO;
    const BCP_PROCESSADO_Name = 'BCP_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCP_SQL_00)

end.
