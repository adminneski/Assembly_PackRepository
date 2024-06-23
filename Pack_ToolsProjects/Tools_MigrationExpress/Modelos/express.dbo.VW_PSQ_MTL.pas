unit express.dbo.VW_PSQ_MTL;

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
  [Table('VW_PSQ_MTL', '')]
  TDtoVW_PSQ_MTL = class
  private
    { Private declarations } 
    FTLN_ID: Integer;
    FMTL_ID: Integer;
    FCOM_CODIGO: Integer;
    FTLN_NUMEROCHEQUE: String;
    FMTL_DATALANCAMENTO: TDateTime;
    FMTL_PROCESSADO: String;
    FCTA_EMITENTE: String;
    FCTA_CONTA: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FCPA_NUMERODOCTO: String;
    FCPA_NOTAFISCAL: String;
    FTLN_VALORCHEQUE: Double;
    FCPA_TOTALVALOR: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MTL';

    [Restrictions([NoValidate])]
    [Column('TLN_ID', ftInteger)]
    [Dictionary('TLN_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID: Integer read FTLN_ID write FTLN_ID;
    const TLN_ID_Name = 'TLN_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_ID', ftInteger)]
    [Dictionary('MTL_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTL_ID: Integer read FMTL_ID write FMTL_ID;
    const MTL_ID_Name = 'MTL_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TLN_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('TLN_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_NUMEROCHEQUE: String read FTLN_NUMEROCHEQUE write FTLN_NUMEROCHEQUE;
    const TLN_NUMEROCHEQUE_Name = 'TLN_NUMEROCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_DATALANCAMENTO', ftDateTime)]
    [Dictionary('MTL_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTL_DATALANCAMENTO: TDateTime read FMTL_DATALANCAMENTO write FMTL_DATALANCAMENTO;
    const MTL_DATALANCAMENTO_Name = 'MTL_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_PROCESSADO', ftString, 1)]
    [Dictionary('MTL_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MTL_PROCESSADO: String read FMTL_PROCESSADO write FMTL_PROCESSADO;
    const MTL_PROCESSADO_Name = 'MTL_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CPA_NUMERODOCTO', ftString, 20)]
    [Dictionary('CPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NUMERODOCTO: String read FCPA_NUMERODOCTO write FCPA_NUMERODOCTO;
    const CPA_NUMERODOCTO_Name = 'CPA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_NOTAFISCAL', ftString, 9)]
    [Dictionary('CPA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NOTAFISCAL: String read FCPA_NOTAFISCAL write FCPA_NOTAFISCAL;
    const CPA_NOTAFISCAL_Name = 'CPA_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_VALORCHEQUE', ftBCD)]
    [Dictionary('TLN_VALORCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TLN_VALORCHEQUE: Double read FTLN_VALORCHEQUE write FTLN_VALORCHEQUE;
    const TLN_VALORCHEQUE_Name = 'TLN_VALORCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALOR', ftBCD, 48, 2)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MTL)

end.
