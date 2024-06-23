unit express.dbo.CPA_LOTEESTORNO;

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
  [Table('CPA_LoteEstorno', '')]
  TDtoCPA_LoteEstorno = class
  private
    { Private declarations } 
    FCPA_ID: Integer;
    FCOM_CODIGO: Integer;
    FCOM_RAZAO: String;
    FPES_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCPA_DESATIVADO: String;
    FCPA_STATUS: String;
    FCPA_TOTALVALOR: Double;
    FCPA_TOTALVALORBAIXA: Double;
    FCPA_NOTAFISCAL: String;
    FCPA_NUMERODOCTO: String;
    FCPA_DATAEMISSAO: TDateTime;
    FCPA_DATAVENCTO: TDateTime;
    FCPA_DATABAIXA: TDateTime;
    FCPA_DC: String;
    FCTA_CODIGOBAIXA: Integer;
    FCPA_ORDEMPARCIAL: Integer;
    FCPA_TOTALVALORORIGINAL: Double;
    FCPA_TOTALOUTRASDESPESAS: Double;
    FCPA_TOTALDESCTO: Double;
    FCPA_TOTALJUROS: Double;
    FCPA_TOTALMULTA: Double;
    FCPA_TIPOBAIXA: String;
    FCPA_HISTORICO: String;
    FCPA_DATAULTIMOPAGTO: TDateTime;
    FCPA_TIPODOCUMENTO: String;
    FCPA_PLANOCONTARATEIO: Double;
    FCPA_INTEGRACAO: String;
    FCPA_CHEQUEVINCULADO: String;
    FPES_NOME: String;
    FCTA_EMITENTE: String;
    FBCO_NOME: String;
    FCPA_TOTALNOTAFISCAL: Double;
    FCPA_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'CPA_LoteEstorno';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_RAZAO', ftString, 100)]
    [Dictionary('COM_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;
    const COM_RAZAO_Name = 'COM_RAZAO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPA_DESATIVADO', ftString, 1)]
    [Dictionary('CPA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DESATIVADO: String read FCPA_DESATIVADO write FCPA_DESATIVADO;
    const CPA_DESATIVADO_Name = 'CPA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CPA_STATUS', ftString, 1)]
    [Dictionary('CPA_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_STATUS: String read FCPA_STATUS write FCPA_STATUS;
    const CPA_STATUS_Name = 'CPA_STATUS';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALOR', ftBCD)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CPA_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORBAIXA: Double read FCPA_TOTALVALORBAIXA write FCPA_TOTALVALORBAIXA;
    const CPA_TOTALVALORBAIXA_Name = 'CPA_TOTALVALORBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_NOTAFISCAL', ftString, 9)]
    [Dictionary('CPA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NOTAFISCAL: String read FCPA_NOTAFISCAL write FCPA_NOTAFISCAL;
    const CPA_NOTAFISCAL_Name = 'CPA_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPA_NUMERODOCTO', ftString, 20)]
    [Dictionary('CPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NUMERODOCTO: String read FCPA_NUMERODOCTO write FCPA_NUMERODOCTO;
    const CPA_NUMERODOCTO_Name = 'CPA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAEMISSAO', ftDateTime)]
    [Dictionary('CPA_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAEMISSAO: TDateTime read FCPA_DATAEMISSAO write FCPA_DATAEMISSAO;
    const CPA_DATAEMISSAO_Name = 'CPA_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAVENCTO', ftDateTime)]
    [Dictionary('CPA_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAVENCTO: TDateTime read FCPA_DATAVENCTO write FCPA_DATAVENCTO;
    const CPA_DATAVENCTO_Name = 'CPA_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATABAIXA', ftDateTime)]
    [Dictionary('CPA_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATABAIXA: TDateTime read FCPA_DATABAIXA write FCPA_DATABAIXA;
    const CPA_DATABAIXA_Name = 'CPA_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_DC', ftString, 1)]
    [Dictionary('CPA_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DC: String read FCPA_DC write FCPA_DC;
    const CPA_DC_Name = 'CPA_DC';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_ORDEMPARCIAL', ftInteger)]
    [Dictionary('CPA_ORDEMPARCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ORDEMPARCIAL: Integer read FCPA_ORDEMPARCIAL write FCPA_ORDEMPARCIAL;
    const CPA_ORDEMPARCIAL_Name = 'CPA_ORDEMPARCIAL';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALORORIGINAL', ftBCD)]
    [Dictionary('CPA_TOTALVALORORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORORIGINAL: Double read FCPA_TOTALVALORORIGINAL write FCPA_TOTALVALORORIGINAL;
    const CPA_TOTALVALORORIGINAL_Name = 'CPA_TOTALVALORORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CPA_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESAS: Double read FCPA_TOTALOUTRASDESPESAS write FCPA_TOTALOUTRASDESPESAS;
    const CPA_TOTALOUTRASDESPESAS_Name = 'CPA_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALDESCTO', ftBCD)]
    [Dictionary('CPA_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALDESCTO: Double read FCPA_TOTALDESCTO write FCPA_TOTALDESCTO;
    const CPA_TOTALDESCTO_Name = 'CPA_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALJUROS', ftBCD)]
    [Dictionary('CPA_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALJUROS: Double read FCPA_TOTALJUROS write FCPA_TOTALJUROS;
    const CPA_TOTALJUROS_Name = 'CPA_TOTALJUROS';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALMULTA', ftBCD)]
    [Dictionary('CPA_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALMULTA: Double read FCPA_TOTALMULTA write FCPA_TOTALMULTA;
    const CPA_TOTALMULTA_Name = 'CPA_TOTALMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPOBAIXA', ftString, 1)]
    [Dictionary('CPA_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPOBAIXA: String read FCPA_TIPOBAIXA write FCPA_TIPOBAIXA;
    const CPA_TIPOBAIXA_Name = 'CPA_TIPOBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_HISTORICO', ftString, 300)]
    [Dictionary('CPA_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_HISTORICO: String read FCPA_HISTORICO write FCPA_HISTORICO;
    const CPA_HISTORICO_Name = 'CPA_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAULTIMOPAGTO', ftDateTime)]
    [Dictionary('CPA_DATAULTIMOPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAULTIMOPAGTO: TDateTime read FCPA_DATAULTIMOPAGTO write FCPA_DATAULTIMOPAGTO;
    const CPA_DATAULTIMOPAGTO_Name = 'CPA_DATAULTIMOPAGTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPODOCUMENTO', ftString, 1)]
    [Dictionary('CPA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPODOCUMENTO: String read FCPA_TIPODOCUMENTO write FCPA_TIPODOCUMENTO;
    const CPA_TIPODOCUMENTO_Name = 'CPA_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CPA_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('CPA_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PLANOCONTARATEIO: Double read FCPA_PLANOCONTARATEIO write FCPA_PLANOCONTARATEIO;
    const CPA_PLANOCONTARATEIO_Name = 'CPA_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CPA_INTEGRACAO', ftString, 20)]
    [Dictionary('CPA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_INTEGRACAO: String read FCPA_INTEGRACAO write FCPA_INTEGRACAO;
    const CPA_INTEGRACAO_Name = 'CPA_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_CHEQUEVINCULADO', ftString, 1)]
    [Dictionary('CPA_CHEQUEVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_CHEQUEVINCULADO: String read FCPA_CHEQUEVINCULADO write FCPA_CHEQUEVINCULADO;
    const CPA_CHEQUEVINCULADO_Name = 'CPA_CHEQUEVINCULADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CPA_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALNOTAFISCAL: Double read FCPA_TOTALNOTAFISCAL write FCPA_TOTALNOTAFISCAL;
    const CPA_TOTALNOTAFISCAL_Name = 'CPA_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPA_OBSERVACAO', ftString, 300)]
    [Dictionary('CPA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_OBSERVACAO: String read FCPA_OBSERVACAO write FCPA_OBSERVACAO;
    const CPA_OBSERVACAO_Name = 'CPA_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPA_LoteEstorno)

end.
