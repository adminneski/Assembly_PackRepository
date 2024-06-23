unit express.dbo.VW_PSQ_TLN;

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
  [Table('VW_PSQ_TLN', '')]
  TDtoVW_PSQ_TLN = class
  private
    { Private declarations } 
    FTLN_ID: Integer;
    FCOM_CODIGO: Integer;
    FTLN_NUMEROCHEQUE: String;
    FTLN_DESATIVADO: String;
    FTLN_ASSINADO: String;
    FTLN_STATUS: String;
    FTLN_VALORCHEQUE: Double;
    FCTA_EMITENTE: String;
    FCTA_CONTA: String;
    FCTA_CODIGO: Integer;
    FCTA_CIDADE: String;
    FTLN_DATABOMPARA: TDateTime;
    FBCO_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_TLN';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_ID', ftInteger)]
    [Dictionary('TLN_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID: Integer read FTLN_ID write FTLN_ID;
    const TLN_ID_Name = 'TLN_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('TLN_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_NUMEROCHEQUE: String read FTLN_NUMEROCHEQUE write FTLN_NUMEROCHEQUE;
    const TLN_NUMEROCHEQUE_Name = 'TLN_NUMEROCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_DESATIVADO', ftString, 1)]
    [Dictionary('TLN_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_DESATIVADO: String read FTLN_DESATIVADO write FTLN_DESATIVADO;
    const TLN_DESATIVADO_Name = 'TLN_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_ASSINADO', ftString, 1)]
    [Dictionary('TLN_ASSINADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_ASSINADO: String read FTLN_ASSINADO write FTLN_ASSINADO;
    const TLN_ASSINADO_Name = 'TLN_ASSINADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_STATUS', ftString, 1)]
    [Dictionary('TLN_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_STATUS: String read FTLN_STATUS write FTLN_STATUS;
    const TLN_STATUS_Name = 'TLN_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_VALORCHEQUE', ftBCD)]
    [Dictionary('TLN_VALORCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TLN_VALORCHEQUE: Double read FTLN_VALORCHEQUE write FTLN_VALORCHEQUE;
    const TLN_VALORCHEQUE_Name = 'TLN_VALORCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTA', ftString, 15)]
    [Dictionary('CTA_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTA: String read FCTA_CONTA write FCTA_CONTA;
    const CTA_CONTA_Name = 'CTA_CONTA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CIDADE', ftString, 100)]
    [Dictionary('CTA_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CIDADE: String read FCTA_CIDADE write FCTA_CIDADE;
    const CTA_CIDADE_Name = 'CTA_CIDADE';

    [Restrictions([NoValidate])]
    [Column('TLN_DATABOMPARA', ftDateTime)]
    [Dictionary('TLN_DATABOMPARA', 'Mensagem de validação', '', '', '', taCenter)]
    property TLN_DATABOMPARA: TDateTime read FTLN_DATABOMPARA write FTLN_DATABOMPARA;
    const TLN_DATABOMPARA_Name = 'TLN_DATABOMPARA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_TLN)

end.
