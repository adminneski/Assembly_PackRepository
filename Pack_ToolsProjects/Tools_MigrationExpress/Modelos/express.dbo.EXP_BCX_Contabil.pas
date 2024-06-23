unit express.dbo.EXP_BCX_CONTABIL;

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
  [Table('EXP_BCX_Contabil', '')]
  TDtoEXP_BCX_Contabil = class
  private
    { Private declarations } 
    FBCX_ID: Integer;
    FBCX_DC: String;
    FCOM_CODIGO: Integer;
    FBCX_DATALANCAMENTO: TDateTime;
    FBCX_NUMERODOCTO: String;
    FBCX_VALORDOCTO: Double;
    FBCX_VALORDOCTOORIGINAL: Double;
    FCPA_ID: Integer;
    FCRE_ID: Integer;
    FCRE_TOTALDESCTO: Double;
    FCPA_TOTALDESCTO: Double;
    FCRE_TOTALJUROS: Double;
    FCPA_TOTALJUROS: Double;
    FBCX_TIPOMOVTO: String;
    FBCX_HISTORICO: String;
    FCTA_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FBCO_NOME: String;
    FCTA_INTEGRACAOCONTABIL: String;
    FBCX_INTEGRACAO: String;
    FCTA_CODIGOTRANSFERENCIA: Integer;
    FCTA_INTEGRACAOCONTABIL_TRF: String;
    FBCX_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_BAIRRO: String;
    FPES_CIDADE: String;
    FPES_UF: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_BCX_Contabil';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_ID', ftInteger)]
    [Dictionary('BCX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID: Integer read FBCX_ID write FBCX_ID;
    const BCX_ID_Name = 'BCX_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_DC', ftString, 1)]
    [Dictionary('BCX_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DC: String read FBCX_DC write FBCX_DC;
    const BCX_DC_Name = 'BCX_DC';

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
    [Column('BCX_NUMERODOCTO', ftString, 20)]
    [Dictionary('BCX_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NUMERODOCTO: String read FBCX_NUMERODOCTO write FBCX_NUMERODOCTO;
    const BCX_NUMERODOCTO_Name = 'BCX_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_VALORDOCTO', ftBCD)]
    [Dictionary('BCX_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORDOCTO: Double read FBCX_VALORDOCTO write FBCX_VALORDOCTO;
    const BCX_VALORDOCTO_Name = 'BCX_VALORDOCTO';

    [Restrictions([NoValidate])]
    [Column('BCX_VALORDOCTOORIGINAL', ftBCD)]
    [Dictionary('BCX_VALORDOCTOORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_VALORDOCTOORIGINAL: Double read FBCX_VALORDOCTOORIGINAL write FBCX_VALORDOCTOORIGINAL;
    const BCX_VALORDOCTOORIGINAL_Name = 'BCX_VALORDOCTOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALDESCTO', ftBCD)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALDESCTO', ftBCD)]
    [Dictionary('CPA_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTO: Double read FCPA_TOTALDESCTO write FCPA_TOTALDESCTO;
    const CPA_TOTALDESCTO_Name = 'CPA_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_TOTALJUROS', ftBCD, 10, 2)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALJUROS', ftBCD)]
    [Dictionary('CPA_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROS: Double read FCPA_TOTALJUROS write FCPA_TOTALJUROS;
    const CPA_TOTALJUROS_Name = 'CPA_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TIPOMOVTO', ftString, 1)]
    [Dictionary('BCX_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPOMOVTO: String read FBCX_TIPOMOVTO write FBCX_TIPOMOVTO;
    const BCX_TIPOMOVTO_Name = 'BCX_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('BCX_HISTORICO', ftString, 5010)]
    [Dictionary('BCX_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_HISTORICO: String read FBCX_HISTORICO write FBCX_HISTORICO;
    const BCX_HISTORICO_Name = 'BCX_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('CTA_INTEGRACAOCONTABIL', ftString, 15)]
    [Dictionary('CTA_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_INTEGRACAOCONTABIL: String read FCTA_INTEGRACAOCONTABIL write FCTA_INTEGRACAOCONTABIL;
    const CTA_INTEGRACAOCONTABIL_Name = 'CTA_INTEGRACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('BCX_INTEGRACAO', ftString, 50)]
    [Dictionary('BCX_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_INTEGRACAO: String read FBCX_INTEGRACAO write FBCX_INTEGRACAO;
    const BCX_INTEGRACAO_Name = 'BCX_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOTRANSFERENCIA', ftInteger)]
    [Dictionary('CTA_CODIGOTRANSFERENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOTRANSFERENCIA: Integer read FCTA_CODIGOTRANSFERENCIA write FCTA_CODIGOTRANSFERENCIA;
    const CTA_CODIGOTRANSFERENCIA_Name = 'CTA_CODIGOTRANSFERENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_INTEGRACAOCONTABIL_TRF', ftString, 15)]
    [Dictionary('CTA_INTEGRACAOCONTABIL_TRF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_INTEGRACAOCONTABIL_TRF: String read FCTA_INTEGRACAOCONTABIL_TRF write FCTA_INTEGRACAOCONTABIL_TRF;
    const CTA_INTEGRACAOCONTABIL_TRF_Name = 'CTA_INTEGRACAOCONTABIL_TRF';

    [Restrictions([NoValidate])]
    [Column('BCX_NOTAFISCAL', ftString, 22)]
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
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_BCX_Contabil)

end.
