unit express.dbo.CHE_LOTEBAIXA;

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
  [Table('CHE_LoteBaixa', '')]
  TDtoCHE_LoteBaixa = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FCRE_DESATIVADO: String;
    FCRE_TIPODOCUMENTO: String;
    FCRE_PRORROGACOES: Integer;
    FCRE_STATUS: String;
    FCRE_TOTALVALOR: Double;
    FCRE_NOTAFISCAL: String;
    FCRE_NUMERODOCTO: String;
    FCRE_DATAEMISSAO: TDateTime;
    FCRE_DATAVENCTO: TDateTime;
    FCRE_DATABAIXA: TDateTime;
    FCTA_CODIGOBAIXA: Integer;
    FCRE_DC: String;
    FCRE_HISTORICO: String;
    FCRE_OBSERVACAO: String;
    FBCO_CODIGO: Integer;
    FCRE_AGENCIA: String;
    FCRE_CONTA: String;
    FCRE_NUMEROCHEQUE: String;
    FCRE_EMITENTE: String;
    FPES_NOME: String;
    FFIL_TAXADEJUROSAOMES: Double;
    FCRE_DIAATRASO: Integer;
    FCRE_DIAJUROS: Integer;
    FCRE_NFCUPOM: String;
  public 
    { Public declarations } 
     const Table      = 'CHE_LoteBaixa';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DESATIVADO', ftString, 1)]
    [Dictionary('CRE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DESATIVADO: String read FCRE_DESATIVADO write FCRE_DESATIVADO;
    const CRE_DESATIVADO_Name = 'CRE_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CRE_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPODOCUMENTO: String read FCRE_TIPODOCUMENTO write FCRE_TIPODOCUMENTO;
    const CRE_TIPODOCUMENTO_Name = 'CRE_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PRORROGACOES', ftInteger)]
    [Dictionary('CRE_PRORROGACOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PRORROGACOES: Integer read FCRE_PRORROGACOES write FCRE_PRORROGACOES;
    const CRE_PRORROGACOES_Name = 'CRE_PRORROGACOES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_STATUS', ftString, 1)]
    [Dictionary('CRE_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_STATUS: String read FCRE_STATUS write FCRE_STATUS;
    const CRE_STATUS_Name = 'CRE_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALOR', ftBCD)]
    [Dictionary('CRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALOR: Double read FCRE_TOTALVALOR write FCRE_TOTALVALOR;
    const CRE_TOTALVALOR_Name = 'CRE_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('CRE_NOTAFISCAL', ftString, 9)]
    [Dictionary('CRE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOTAFISCAL: String read FCRE_NOTAFISCAL write FCRE_NOTAFISCAL;
    const CRE_NOTAFISCAL_Name = 'CRE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('CRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMERODOCTO: String read FCRE_NUMERODOCTO write FCRE_NUMERODOCTO;
    const CRE_NUMERODOCTO_Name = 'CRE_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRE_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAEMISSAO: TDateTime read FCRE_DATAEMISSAO write FCRE_DATAEMISSAO;
    const CRE_DATAEMISSAO_Name = 'CRE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAVENCTO', ftDateTime)]
    [Dictionary('CRE_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAVENCTO: TDateTime read FCRE_DATAVENCTO write FCRE_DATAVENCTO;
    const CRE_DATAVENCTO_Name = 'CRE_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATABAIXA', ftDateTime)]
    [Dictionary('CRE_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATABAIXA: TDateTime read FCRE_DATABAIXA write FCRE_DATABAIXA;
    const CRE_DATABAIXA_Name = 'CRE_DATABAIXA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DC', ftString, 1)]
    [Dictionary('CRE_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DC: String read FCRE_DC write FCRE_DC;
    const CRE_DC_Name = 'CRE_DC';

    [Restrictions([NoValidate])]
    [Column('CRE_HISTORICO', ftString, 5000)]
    [Dictionary('CRE_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_HISTORICO: String read FCRE_HISTORICO write FCRE_HISTORICO;
    const CRE_HISTORICO_Name = 'CRE_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CRE_OBSERVACAO', ftString, 5000)]
    [Dictionary('CRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSERVACAO: String read FCRE_OBSERVACAO write FCRE_OBSERVACAO;
    const CRE_OBSERVACAO_Name = 'CRE_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_AGENCIA', ftString, 6)]
    [Dictionary('CRE_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_AGENCIA: String read FCRE_AGENCIA write FCRE_AGENCIA;
    const CRE_AGENCIA_Name = 'CRE_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CRE_CONTA', ftString, 15)]
    [Dictionary('CRE_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_CONTA: String read FCRE_CONTA write FCRE_CONTA;
    const CRE_CONTA_Name = 'CRE_CONTA';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('CRE_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROCHEQUE: String read FCRE_NUMEROCHEQUE write FCRE_NUMEROCHEQUE;
    const CRE_NUMEROCHEQUE_Name = 'CRE_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CRE_EMITENTE', ftString, 50)]
    [Dictionary('CRE_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_EMITENTE: String read FCRE_EMITENTE write FCRE_EMITENTE;
    const CRE_EMITENTE_Name = 'CRE_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('FIL_TAXADEJUROSAOMES', ftBCD)]
    [Dictionary('FIL_TAXADEJUROSAOMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FIL_TAXADEJUROSAOMES: Double read FFIL_TAXADEJUROSAOMES write FFIL_TAXADEJUROSAOMES;
    const FIL_TAXADEJUROSAOMES_Name = 'FIL_TAXADEJUROSAOMES';

    [Restrictions([NoValidate])]
    [Column('CRE_DIAATRASO', ftInteger)]
    [Dictionary('CRE_DIAATRASO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_DIAATRASO: Integer read FCRE_DIAATRASO write FCRE_DIAATRASO;
    const CRE_DIAATRASO_Name = 'CRE_DIAATRASO';

    [Restrictions([NoValidate])]
    [Column('CRE_DIAJUROS', ftInteger)]
    [Dictionary('CRE_DIAJUROS', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_DIAJUROS: Integer read FCRE_DIAJUROS write FCRE_DIAJUROS;
    const CRE_DIAJUROS_Name = 'CRE_DIAJUROS';

    [Restrictions([NoValidate])]
    [Column('CRE_NFCUPOM', ftString, 13)]
    [Dictionary('CRE_NFCUPOM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NFCUPOM: String read FCRE_NFCUPOM write FCRE_NFCUPOM;
    const CRE_NFCUPOM_Name = 'CRE_NFCUPOM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCHE_LoteBaixa)

end.
