unit express.dbo.VW_PSQ_CRB;

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
  [Table('VW_PSQ_CRB', '')]
  TDtoVW_PSQ_CRB = class
  private
    { Private declarations } 
    FCRB_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRB_NUMEROCONTRATO: String;
    FCRB_DATAEMISSAO: TDateTime;
    FCRB_DATASAIDA: TDateTime;
    FPES_CODIGOCONTRATANTE: Integer;
    FCRB_CANCELADO: String;
    FCRB_PROCESSADO: String;
    FPES_NOME: String;
    FPES_CODIGOCONTRATADO: Integer;
    FPES_NOMECONTRATADO: String;
    FCRB_TOTALCONTRATO: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CRB';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_ID', ftInteger)]
    [Dictionary('CRB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_ID: Integer read FCRB_ID write FCRB_ID;
    const CRB_ID_Name = 'CRB_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRB_NUMEROCONTRATO', ftString, 6)]
    [Dictionary('CRB_NUMEROCONTRATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_NUMEROCONTRATO: String read FCRB_NUMEROCONTRATO write FCRB_NUMEROCONTRATO;
    const CRB_NUMEROCONTRATO_Name = 'CRB_NUMEROCONTRATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRB_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATAEMISSAO: TDateTime read FCRB_DATAEMISSAO write FCRB_DATAEMISSAO;
    const CRB_DATAEMISSAO_Name = 'CRB_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATASAIDA', ftDateTime)]
    [Dictionary('CRB_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATASAIDA: TDateTime read FCRB_DATASAIDA write FCRB_DATASAIDA;
    const CRB_DATASAIDA_Name = 'CRB_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCONTRATANTE', ftInteger)]
    [Dictionary('PES_CODIGOCONTRATANTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCONTRATANTE: Integer read FPES_CODIGOCONTRATANTE write FPES_CODIGOCONTRATANTE;
    const PES_CODIGOCONTRATANTE_Name = 'PES_CODIGOCONTRATANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_CANCELADO', ftString, 1)]
    [Dictionary('CRB_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CANCELADO: String read FCRB_CANCELADO write FCRB_CANCELADO;
    const CRB_CANCELADO_Name = 'CRB_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CRB_PROCESSADO', ftString, 1)]
    [Dictionary('CRB_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_PROCESSADO: String read FCRB_PROCESSADO write FCRB_PROCESSADO;
    const CRB_PROCESSADO_Name = 'CRB_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCONTRATADO', ftInteger)]
    [Dictionary('PES_CODIGOCONTRATADO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCONTRATADO: Integer read FPES_CODIGOCONTRATADO write FPES_CODIGOCONTRATADO;
    const PES_CODIGOCONTRATADO_Name = 'PES_CODIGOCONTRATADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECONTRATADO', ftString, 100)]
    [Dictionary('PES_NOMECONTRATADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECONTRATADO: String read FPES_NOMECONTRATADO write FPES_NOMECONTRATADO;
    const PES_NOMECONTRATADO_Name = 'PES_NOMECONTRATADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALCONTRATO', ftBCD, 48, 2)]
    [Dictionary('CRB_TOTALCONTRATO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALCONTRATO: Double read FCRB_TOTALCONTRATO write FCRB_TOTALCONTRATO;
    const CRB_TOTALCONTRATO_Name = 'CRB_TOTALCONTRATO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CRB)

end.
