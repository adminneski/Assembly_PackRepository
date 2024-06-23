unit express.dbo.VW_PSQ_BCX;

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
  [Table('VW_PSQ_BCX', '')]
  TDtoVW_PSQ_BCX = class
  private
    { Private declarations } 
    FBCX_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCX_DATALANCAMENTO: TDateTime;
    FBCX_DC: String;
    FBCX_DESATIVADO: String;
    FBCX_NUMERODOCTO: String;
    FBCX_VALORDOCTO: Double;
    FBCX_STATUS: String;
    FCTA_CODIGO: Integer;
    FCTA_EMITENTE: String;
    FCTA_CONTA: String;
    FBCX_NOTAFISCAL: String;
    FBCX_TIPOMOVTO: String;
    FBCX_HISTORICO: String;
    FBCX_INTEGRACAO: String;
    FBCX_ORDEMDIARIA: Integer;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_BCX';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_ID', ftInteger)]
    [Dictionary('BCX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID: Integer read FBCX_ID write FBCX_ID;
    const BCX_ID_Name = 'BCX_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCX_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCX_DATALANCAMENTO: TDateTime read FBCX_DATALANCAMENTO write FBCX_DATALANCAMENTO;
    const BCX_DATALANCAMENTO_Name = 'BCX_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DC', ftString, 1)]
    [Dictionary('BCX_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DC: String read FBCX_DC write FBCX_DC;
    const BCX_DC_Name = 'BCX_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DESATIVADO', ftString, 1)]
    [Dictionary('BCX_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DESATIVADO: String read FBCX_DESATIVADO write FBCX_DESATIVADO;
    const BCX_DESATIVADO_Name = 'BCX_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_NUMERODOCTO', ftString, 20)]
    [Dictionary('BCX_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NUMERODOCTO: String read FBCX_NUMERODOCTO write FBCX_NUMERODOCTO;
    const BCX_NUMERODOCTO_Name = 'BCX_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_VALORDOCTO', ftBCD)]
    [Dictionary('BCX_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORDOCTO: Double read FBCX_VALORDOCTO write FBCX_VALORDOCTO;
    const BCX_VALORDOCTO_Name = 'BCX_VALORDOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_STATUS', ftString, 1)]
    [Dictionary('BCX_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_STATUS: String read FBCX_STATUS write FBCX_STATUS;
    const BCX_STATUS_Name = 'BCX_STATUS';

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

    [Restrictions([NoValidate])]
    [Column('CTA_CONTA', ftString, 15)]
    [Dictionary('CTA_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTA: String read FCTA_CONTA write FCTA_CONTA;
    const CTA_CONTA_Name = 'CTA_CONTA';

    [Restrictions([NoValidate])]
    [Column('BCX_NOTAFISCAL', ftString, 9)]
    [Dictionary('BCX_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NOTAFISCAL: String read FBCX_NOTAFISCAL write FBCX_NOTAFISCAL;
    const BCX_NOTAFISCAL_Name = 'BCX_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TIPOMOVTO', ftString, 1)]
    [Dictionary('BCX_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPOMOVTO: String read FBCX_TIPOMOVTO write FBCX_TIPOMOVTO;
    const BCX_TIPOMOVTO_Name = 'BCX_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('BCX_HISTORICO', ftString, 5000)]
    [Dictionary('BCX_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_HISTORICO: String read FBCX_HISTORICO write FBCX_HISTORICO;
    const BCX_HISTORICO_Name = 'BCX_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('BCX_INTEGRACAO', ftString, 50)]
    [Dictionary('BCX_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_INTEGRACAO: String read FBCX_INTEGRACAO write FBCX_INTEGRACAO;
    const BCX_INTEGRACAO_Name = 'BCX_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('BCX_ORDEMDIARIA', ftInteger)]
    [Dictionary('BCX_ORDEMDIARIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ORDEMDIARIA: Integer read FBCX_ORDEMDIARIA write FBCX_ORDEMDIARIA;
    const BCX_ORDEMDIARIA_Name = 'BCX_ORDEMDIARIA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_BCX)

end.
