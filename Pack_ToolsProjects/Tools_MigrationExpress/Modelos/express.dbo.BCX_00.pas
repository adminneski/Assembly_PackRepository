unit express.dbo.BCX_00;

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
  [Table('BCX_00', '')]
  [PrimaryKey('BCX_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCX_ID')]
  TDtoBCX_00 = class
  private
    { Private declarations } 
    FBCX_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRE_ID: Integer;
    FCPA_ID: Integer;
    FBCX_DC: String;
    FCTA_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FBCX_STATUS: String;
    FBCX_TIPOMOVTO: String;
    FBCX_DATALANCAMENTO: TDateTime;
    FBCX_NUMERODOCTO: String;
    FBCX_NOTAFISCAL: String;
    FBCX_VALORDOCTO: Double;
    FBCX_HISTORICO: String;
    FBCX_DATAVISTOBAIXA: TDateTime;
    FBCX_PLANOCONTARATEIO: Double;
    FCTA_CODIGOTRANSFERENCIA: Integer;
    FCOM_CODIGOTRANSFERENCIA: String;
    FBCX_NAOGERAREXPORTACAOCONTABIL: String;
    FBCX_VISTOBAIXA: String;
    FBCX_CANCELADO: String;
    FBCX_DESATIVADO: String;
    FBCX_INTEGRACAO: String;
    FBCX_DATAALTERACAO: TDateTime;
    FBCX_ID_OLD: Integer;
    FBCX_INTEGRACAO_OLD: String;
    FCPA_ID_OLD: Integer;
    FCRE_ID_OLD: Integer;
    FBCX_TIPOPARCELA: String;
    FBCX_ORDEMDIARIA: Integer;
    FCRT_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'BCX_00';
     const PrimaryKey = 'BCX_ID';
     const Sequence   = 'SEQ_BCX_ID';

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

    [Restrictions([NoValidate])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DC', ftString, 1)]
    [Dictionary('BCX_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DC: String read FBCX_DC write FBCX_DC;
    const BCX_DC_Name = 'BCX_DC';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_STATUS', ftString, 1)]
    [Dictionary('BCX_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_STATUS: String read FBCX_STATUS write FBCX_STATUS;
    const BCX_STATUS_Name = 'BCX_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TIPOMOVTO', ftString, 1)]
    [Dictionary('BCX_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPOMOVTO: String read FBCX_TIPOMOVTO write FBCX_TIPOMOVTO;
    const BCX_TIPOMOVTO_Name = 'BCX_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCX_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCX_DATALANCAMENTO: TDateTime read FBCX_DATALANCAMENTO write FBCX_DATALANCAMENTO;
    const BCX_DATALANCAMENTO_Name = 'BCX_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_NUMERODOCTO', ftString, 20)]
    [Dictionary('BCX_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NUMERODOCTO: String read FBCX_NUMERODOCTO write FBCX_NUMERODOCTO;
    const BCX_NUMERODOCTO_Name = 'BCX_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('BCX_NOTAFISCAL', ftString, 9)]
    [Dictionary('BCX_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NOTAFISCAL: String read FBCX_NOTAFISCAL write FBCX_NOTAFISCAL;
    const BCX_NOTAFISCAL_Name = 'BCX_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_VALORDOCTO', ftBCD)]
    [Dictionary('BCX_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORDOCTO: Double read FBCX_VALORDOCTO write FBCX_VALORDOCTO;
    const BCX_VALORDOCTO_Name = 'BCX_VALORDOCTO';

    [Restrictions([NoValidate])]
    [Column('BCX_HISTORICO', ftString, 5000)]
    [Dictionary('BCX_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_HISTORICO: String read FBCX_HISTORICO write FBCX_HISTORICO;
    const BCX_HISTORICO_Name = 'BCX_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('BCX_DATAVISTOBAIXA', ftDateTime)]
    [Dictionary('BCX_DATAVISTOBAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property BCX_DATAVISTOBAIXA: TDateTime read FBCX_DATAVISTOBAIXA write FBCX_DATAVISTOBAIXA;
    const BCX_DATAVISTOBAIXA_Name = 'BCX_DATAVISTOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('BCX_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_PLANOCONTARATEIO: Double read FBCX_PLANOCONTARATEIO write FBCX_PLANOCONTARATEIO;
    const BCX_PLANOCONTARATEIO_Name = 'BCX_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOTRANSFERENCIA', ftInteger)]
    [Dictionary('CTA_CODIGOTRANSFERENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOTRANSFERENCIA: Integer read FCTA_CODIGOTRANSFERENCIA write FCTA_CODIGOTRANSFERENCIA;
    const CTA_CODIGOTRANSFERENCIA_Name = 'CTA_CODIGOTRANSFERENCIA';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGOTRANSFERENCIA', ftString, 3)]
    [Dictionary('COM_CODIGOTRANSFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGOTRANSFERENCIA: String read FCOM_CODIGOTRANSFERENCIA write FCOM_CODIGOTRANSFERENCIA;
    const COM_CODIGOTRANSFERENCIA_Name = 'COM_CODIGOTRANSFERENCIA';

    [Restrictions([NoValidate])]
    [Column('BCX_NAOGERAREXPORTACAOCONTABIL', ftString, 1)]
    [Dictionary('BCX_NAOGERAREXPORTACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NAOGERAREXPORTACAOCONTABIL: String read FBCX_NAOGERAREXPORTACAOCONTABIL write FBCX_NAOGERAREXPORTACAOCONTABIL;
    const BCX_NAOGERAREXPORTACAOCONTABIL_Name = 'BCX_NAOGERAREXPORTACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('BCX_VISTOBAIXA', ftString, 1)]
    [Dictionary('BCX_VISTOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_VISTOBAIXA: String read FBCX_VISTOBAIXA write FBCX_VISTOBAIXA;
    const BCX_VISTOBAIXA_Name = 'BCX_VISTOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_CANCELADO', ftString, 1)]
    [Dictionary('BCX_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_CANCELADO: String read FBCX_CANCELADO write FBCX_CANCELADO;
    const BCX_CANCELADO_Name = 'BCX_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DESATIVADO', ftString, 1)]
    [Dictionary('BCX_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DESATIVADO: String read FBCX_DESATIVADO write FBCX_DESATIVADO;
    const BCX_DESATIVADO_Name = 'BCX_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('BCX_INTEGRACAO', ftString, 50)]
    [Dictionary('BCX_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_INTEGRACAO: String read FBCX_INTEGRACAO write FBCX_INTEGRACAO;
    const BCX_INTEGRACAO_Name = 'BCX_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCX_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCX_DATAALTERACAO: TDateTime read FBCX_DATAALTERACAO write FBCX_DATAALTERACAO;
    const BCX_DATAALTERACAO_Name = 'BCX_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BCX_ID_OLD', ftInteger)]
    [Dictionary('BCX_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID_OLD: Integer read FBCX_ID_OLD write FBCX_ID_OLD;
    const BCX_ID_OLD_Name = 'BCX_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCX_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('BCX_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_INTEGRACAO_OLD: String read FBCX_INTEGRACAO_OLD write FBCX_INTEGRACAO_OLD;
    const BCX_INTEGRACAO_OLD_Name = 'BCX_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_ID_OLD', ftInteger)]
    [Dictionary('CPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID_OLD: Integer read FCPA_ID_OLD write FCPA_ID_OLD;
    const CPA_ID_OLD_Name = 'CPA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCX_TIPOPARCELA', ftString, 1)]
    [Dictionary('BCX_TIPOPARCELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPOPARCELA: String read FBCX_TIPOPARCELA write FBCX_TIPOPARCELA;
    const BCX_TIPOPARCELA_Name = 'BCX_TIPOPARCELA';

    [Restrictions([NoValidate])]
    [Column('BCX_ORDEMDIARIA', ftInteger)]
    [Dictionary('BCX_ORDEMDIARIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ORDEMDIARIA: Integer read FBCX_ORDEMDIARIA write FBCX_ORDEMDIARIA;
    const BCX_ORDEMDIARIA_Name = 'BCX_ORDEMDIARIA';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCX_00)

end.
