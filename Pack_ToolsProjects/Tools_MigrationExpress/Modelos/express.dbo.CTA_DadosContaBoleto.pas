unit express.dbo.CTA_DADOSCONTABOLETO;

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
  [Table('CTA_DadosContaBoleto', '')]
  TDtoCTA_DadosContaBoleto = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCTA_EMITENTE: String;
    FCTA_DESATIVADO: String;
    FCTA_CONTROLER: String;
    FCTA_CODIGO: Integer;
    FCTA_DATAALTERACAO: TDateTime;
    FCTA_AGENCIA: String;
    FCTA_DIGITOAGENCIA: String;
    FCTA_CONTA: Integer;
    FCTA_DIGITOCONTA: String;
    FCTA_CODCEDENTE: String;
    FCTA_CONVENIO: String;
    FCTA_MODALIDADE: String;
    FCTA_CPFCNPJCEDENTE: String;
    FCTA_CARTEIRA: String;
    FCTA_ESPECIEDOC: String;
    FCTA_MSGBOLETO: String;
    FCTA_DIRETORIOREMESSA: String;
    FCTA_TIPOCEF: String;
    FCTA_TAXAJUROS: Double;
    FCTA_PERCENTUALMULTA: Double;
    FCTA_CARENCIAPERMITIDA: Integer;
    FCTA_DIASPROTESTO: Integer;
    FCTA_DIASDESCONTO: Integer;
    FCTA_PERCENTUALDESCONTO: Double;
  public 
    { Public declarations } 
     const Table      = 'CTA_DadosContaBoleto';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DESATIVADO', ftString, 1)]
    [Dictionary('CTA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DESATIVADO: String read FCTA_DESATIVADO write FCTA_DESATIVADO;
    const CTA_DESATIVADO_Name = 'CTA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTROLER', ftString, 1)]
    [Dictionary('CTA_CONTROLER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTROLER: String read FCTA_CONTROLER write FCTA_CONTROLER;
    const CTA_CONTROLER_Name = 'CTA_CONTROLER';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTA_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTA_DATAALTERACAO: TDateTime read FCTA_DATAALTERACAO write FCTA_DATAALTERACAO;
    const CTA_DATAALTERACAO_Name = 'CTA_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_AGENCIA', ftString, 10)]
    [Dictionary('CTA_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_AGENCIA: String read FCTA_AGENCIA write FCTA_AGENCIA;
    const CTA_AGENCIA_Name = 'CTA_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_DIGITOAGENCIA', ftString, 1)]
    [Dictionary('CTA_DIGITOAGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DIGITOAGENCIA: String read FCTA_DIGITOAGENCIA write FCTA_DIGITOAGENCIA;
    const CTA_DIGITOAGENCIA_Name = 'CTA_DIGITOAGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTA', ftInteger)]
    [Dictionary('CTA_CONTA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CONTA: Integer read FCTA_CONTA write FCTA_CONTA;
    const CTA_CONTA_Name = 'CTA_CONTA';

    [Restrictions([NoValidate])]
    [Column('CTA_DIGITOCONTA', ftString, 1)]
    [Dictionary('CTA_DIGITOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DIGITOCONTA: String read FCTA_DIGITOCONTA write FCTA_DIGITOCONTA;
    const CTA_DIGITOCONTA_Name = 'CTA_DIGITOCONTA';

    [Restrictions([NoValidate])]
    [Column('CTA_CODCEDENTE', ftString, 30)]
    [Dictionary('CTA_CODCEDENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CODCEDENTE: String read FCTA_CODCEDENTE write FCTA_CODCEDENTE;
    const CTA_CODCEDENTE_Name = 'CTA_CODCEDENTE';

    [Restrictions([NoValidate])]
    [Column('CTA_CONVENIO', ftString, 30)]
    [Dictionary('CTA_CONVENIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONVENIO: String read FCTA_CONVENIO write FCTA_CONVENIO;
    const CTA_CONVENIO_Name = 'CTA_CONVENIO';

    [Restrictions([NoValidate])]
    [Column('CTA_MODALIDADE', ftString, 30)]
    [Dictionary('CTA_MODALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_MODALIDADE: String read FCTA_MODALIDADE write FCTA_MODALIDADE;
    const CTA_MODALIDADE_Name = 'CTA_MODALIDADE';

    [Restrictions([NoValidate])]
    [Column('CTA_CPFCNPJCEDENTE', ftString, 14)]
    [Dictionary('CTA_CPFCNPJCEDENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CPFCNPJCEDENTE: String read FCTA_CPFCNPJCEDENTE write FCTA_CPFCNPJCEDENTE;
    const CTA_CPFCNPJCEDENTE_Name = 'CTA_CPFCNPJCEDENTE';

    [Restrictions([NoValidate])]
    [Column('CTA_CARTEIRA', ftString, 10)]
    [Dictionary('CTA_CARTEIRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CARTEIRA: String read FCTA_CARTEIRA write FCTA_CARTEIRA;
    const CTA_CARTEIRA_Name = 'CTA_CARTEIRA';

    [Restrictions([NoValidate])]
    [Column('CTA_ESPECIEDOC', ftString, 2)]
    [Dictionary('CTA_ESPECIEDOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_ESPECIEDOC: String read FCTA_ESPECIEDOC write FCTA_ESPECIEDOC;
    const CTA_ESPECIEDOC_Name = 'CTA_ESPECIEDOC';

    [Restrictions([NoValidate])]
    [Column('CTA_MSGBOLETO', ftString, 80)]
    [Dictionary('CTA_MSGBOLETO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_MSGBOLETO: String read FCTA_MSGBOLETO write FCTA_MSGBOLETO;
    const CTA_MSGBOLETO_Name = 'CTA_MSGBOLETO';

    [Restrictions([NoValidate])]
    [Column('CTA_DIRETORIOREMESSA', ftString, 100)]
    [Dictionary('CTA_DIRETORIOREMESSA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DIRETORIOREMESSA: String read FCTA_DIRETORIOREMESSA write FCTA_DIRETORIOREMESSA;
    const CTA_DIRETORIOREMESSA_Name = 'CTA_DIRETORIOREMESSA';

    [Restrictions([NoValidate])]
    [Column('CTA_TIPOCEF', ftString, 5)]
    [Dictionary('CTA_TIPOCEF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_TIPOCEF: String read FCTA_TIPOCEF write FCTA_TIPOCEF;
    const CTA_TIPOCEF_Name = 'CTA_TIPOCEF';

    [Restrictions([NoValidate])]
    [Column('CTA_TAXAJUROS', ftBCD)]
    [Dictionary('CTA_TAXAJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_TAXAJUROS: Double read FCTA_TAXAJUROS write FCTA_TAXAJUROS;
    const CTA_TAXAJUROS_Name = 'CTA_TAXAJUROS';

    [Restrictions([NoValidate])]
    [Column('CTA_PERCENTUALMULTA', ftBCD)]
    [Dictionary('CTA_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_PERCENTUALMULTA: Double read FCTA_PERCENTUALMULTA write FCTA_PERCENTUALMULTA;
    const CTA_PERCENTUALMULTA_Name = 'CTA_PERCENTUALMULTA';

    [Restrictions([NoValidate])]
    [Column('CTA_CARENCIAPERMITIDA', ftInteger)]
    [Dictionary('CTA_CARENCIAPERMITIDA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CARENCIAPERMITIDA: Integer read FCTA_CARENCIAPERMITIDA write FCTA_CARENCIAPERMITIDA;
    const CTA_CARENCIAPERMITIDA_Name = 'CTA_CARENCIAPERMITIDA';

    [Restrictions([NoValidate])]
    [Column('CTA_DIASPROTESTO', ftInteger)]
    [Dictionary('CTA_DIASPROTESTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_DIASPROTESTO: Integer read FCTA_DIASPROTESTO write FCTA_DIASPROTESTO;
    const CTA_DIASPROTESTO_Name = 'CTA_DIASPROTESTO';

    [Restrictions([NoValidate])]
    [Column('CTA_DIASDESCONTO', ftInteger)]
    [Dictionary('CTA_DIASDESCONTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_DIASDESCONTO: Integer read FCTA_DIASDESCONTO write FCTA_DIASDESCONTO;
    const CTA_DIASDESCONTO_Name = 'CTA_DIASDESCONTO';

    [Restrictions([NoValidate])]
    [Column('CTA_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('CTA_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_PERCENTUALDESCONTO: Double read FCTA_PERCENTUALDESCONTO write FCTA_PERCENTUALDESCONTO;
    const CTA_PERCENTUALDESCONTO_Name = 'CTA_PERCENTUALDESCONTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTA_DadosContaBoleto)

end.
