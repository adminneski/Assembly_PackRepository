unit express.dbo.VW_PSQ_MFC;

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
  [Table('VW_PSQ_MFC', '')]
  TDtoVW_PSQ_MFC = class
  private
    { Private declarations } 
    FMFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_PROCESSADO: String;
    FMFC_CANCELADO: String;
    FMFC_NUMERODOCTO: String;
    FMFC_NOTAFISCAL: String;
    FMFC_DATASAIDA: TDateTime;
    FTRP_CODIGO: Integer;
    FPES_NOME: String;
    FMFC_TOTALNOTAFISCAL: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MFC';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MFC_PROCESSADO', ftString, 1)]
    [Dictionary('MFC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_PROCESSADO: String read FMFC_PROCESSADO write FMFC_PROCESSADO;
    const MFC_PROCESSADO_Name = 'MFC_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('MFC_CANCELADO', ftString, 1)]
    [Dictionary('MFC_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CANCELADO: String read FMFC_CANCELADO write FMFC_CANCELADO;
    const MFC_CANCELADO_Name = 'MFC_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMERODOCTO', ftString, 6)]
    [Dictionary('MFC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMERODOCTO: String read FMFC_NUMERODOCTO write FMFC_NUMERODOCTO;
    const MFC_NUMERODOCTO_Name = 'MFC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('MFC_NOTAFISCAL', ftString, 9)]
    [Dictionary('MFC_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NOTAFISCAL: String read FMFC_NOTAFISCAL write FMFC_NOTAFISCAL;
    const MFC_NOTAFISCAL_Name = 'MFC_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATASAIDA', ftDateTime)]
    [Dictionary('MFC_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATASAIDA: TDateTime read FMFC_DATASAIDA write FMFC_DATASAIDA;
    const MFC_DATASAIDA_Name = 'MFC_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALNOTAFISCAL', ftBCD, 48, 2)]
    [Dictionary('MFC_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALNOTAFISCAL: Double read FMFC_TOTALNOTAFISCAL write FMFC_TOTALNOTAFISCAL;
    const MFC_TOTALNOTAFISCAL_Name = 'MFC_TOTALNOTAFISCAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MFC)

end.
