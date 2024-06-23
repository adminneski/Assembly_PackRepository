unit express.dbo.REL_V02_BCX_PLC;

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
  [Table('REL_V02_BCX_PLC', '')]
  TDtoREL_V02_BCX_PLC = class
  private
    { Private declarations } 
    FBCX_ID: Integer;
    FCOM_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FPLC_DESCRICAO: String;
    FCRE_ID: Integer;
    FCPA_ID: Integer;
    FBCX_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FBCX_DC: String;
    FCTA_CODIGO: Integer;
    FHSP_CODIGO: Integer;
    FBCX_STATUS: String;
    FBCX_DATALANCAMENTO: TDateTime;
    FBCX_COMPETENCIA: String;
    FBCX_NUMERODOCTO: String;
    FBCX_VALORDOCTO: Double;
    FBCX_HISTORICO: String;
    FBCX_TIPOMOVTO: String;
    FBCX_VISTOBAIXA: String;
    FBCX_DATAVISTOBAIXA: TDateTime;
    FBCX_PLANOCONTARATEIO: Double;
    FCTA_CODIGOTRANSFERENCIA: Integer;
    FCOM_CODIGOTRANSFERENCIA: String;
    FBCX_DESATIVADO: String;
    FBCX_ORDEMDIARIA: Integer;
    FBCX_INTEGRACAOCONTABIL: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_BCX_PLC';

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
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_DESCRICAO', ftString, 30)]
    [Dictionary('PLC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESCRICAO: String read FPLC_DESCRICAO write FPLC_DESCRICAO;
    const PLC_DESCRICAO_Name = 'PLC_DESCRICAO';

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

    [Restrictions([NoValidate])]
    [Column('BCX_NOTAFISCAL', ftString, 9)]
    [Dictionary('BCX_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NOTAFISCAL: String read FBCX_NOTAFISCAL write FBCX_NOTAFISCAL;
    const BCX_NOTAFISCAL_Name = 'BCX_NOTAFISCAL';

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

    [Restrictions([NoValidate])]
    [Column('BCX_STATUS', ftString, 1)]
    [Dictionary('BCX_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_STATUS: String read FBCX_STATUS write FBCX_STATUS;
    const BCX_STATUS_Name = 'BCX_STATUS';

    [Restrictions([NoValidate])]
    [Column('BCX_DATALANCAMENTO', ftDateTime)]
    [Dictionary('BCX_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCX_DATALANCAMENTO: TDateTime read FBCX_DATALANCAMENTO write FBCX_DATALANCAMENTO;
    const BCX_DATALANCAMENTO_Name = 'BCX_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('BCX_COMPETENCIA', ftString, 61)]
    [Dictionary('BCX_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_COMPETENCIA: String read FBCX_COMPETENCIA write FBCX_COMPETENCIA;
    const BCX_COMPETENCIA_Name = 'BCX_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('BCX_NUMERODOCTO', ftString, 51)]
    [Dictionary('BCX_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NUMERODOCTO: String read FBCX_NUMERODOCTO write FBCX_NUMERODOCTO;
    const BCX_NUMERODOCTO_Name = 'BCX_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_VALORDOCTO', ftBCD)]
    [Dictionary('BCX_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORDOCTO: Double read FBCX_VALORDOCTO write FBCX_VALORDOCTO;
    const BCX_VALORDOCTO_Name = 'BCX_VALORDOCTO';

    [Restrictions([NoValidate])]
    [Column('BCX_HISTORICO', ftString, 5010)]
    [Dictionary('BCX_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_HISTORICO: String read FBCX_HISTORICO write FBCX_HISTORICO;
    const BCX_HISTORICO_Name = 'BCX_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('BCX_TIPOMOVTO', ftString, 1)]
    [Dictionary('BCX_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPOMOVTO: String read FBCX_TIPOMOVTO write FBCX_TIPOMOVTO;
    const BCX_TIPOMOVTO_Name = 'BCX_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('BCX_VISTOBAIXA', ftString, 1)]
    [Dictionary('BCX_VISTOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_VISTOBAIXA: String read FBCX_VISTOBAIXA write FBCX_VISTOBAIXA;
    const BCX_VISTOBAIXA_Name = 'BCX_VISTOBAIXA';

    [Restrictions([NoValidate])]
    [Column('BCX_DATAVISTOBAIXA', ftDateTime)]
    [Dictionary('BCX_DATAVISTOBAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property BCX_DATAVISTOBAIXA: TDateTime read FBCX_DATAVISTOBAIXA write FBCX_DATAVISTOBAIXA;
    const BCX_DATAVISTOBAIXA_Name = 'BCX_DATAVISTOBAIXA';

    [Restrictions([NoValidate])]
    [Column('BCX_PLANOCONTARATEIO', ftBCD, 48, 2)]
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
    [Column('BCX_DESATIVADO', ftString, 1)]
    [Dictionary('BCX_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DESATIVADO: String read FBCX_DESATIVADO write FBCX_DESATIVADO;
    const BCX_DESATIVADO_Name = 'BCX_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('BCX_ORDEMDIARIA', ftInteger)]
    [Dictionary('BCX_ORDEMDIARIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ORDEMDIARIA: Integer read FBCX_ORDEMDIARIA write FBCX_ORDEMDIARIA;
    const BCX_ORDEMDIARIA_Name = 'BCX_ORDEMDIARIA';

    [Restrictions([NoValidate])]
    [Column('BCX_INTEGRACAOCONTABIL', ftString, 15)]
    [Dictionary('BCX_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_INTEGRACAOCONTABIL: String read FBCX_INTEGRACAOCONTABIL write FBCX_INTEGRACAOCONTABIL;
    const BCX_INTEGRACAOCONTABIL_Name = 'BCX_INTEGRACAOCONTABIL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_BCX_PLC)

end.
