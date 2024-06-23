unit express.dbo.CGA_00;

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
  [Table('CGA_00', '')]
  [PrimaryKey('CGA_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CGA_ID')]
  TDtoCGA_00 = class
  private
    { Private declarations } 
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FFUN_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCGA_DATASAIDA: TDateTime;
    FCGA_DATALACRE: TDateTime;
    FCGA_DATAENTREGA: TDateTime;
    FCGA_DATAFORMACAO: TDateTime;
    FCGA_DATAATUALIZACAO: TDateTime;
    FCGA_DATACANCELAMENTO: TDateTime;
    FCGA_DATAFATURAMENTO: TDateTime;
    FCGA_TIPODOCUMENTO: String;
    FCGA_TITULOCARGA: String;
    FCGA_NUMEROLACRE: String;
    FCGA_TOTALFRETECIF: Double;
    FCGA_TOTALFRETEFOB: Double;
    FCGA_TOTALFINANCEIRO: Double;
    FCGA_TOTALPESOLIQUIDO: Double;
    FCGA_TOTALADIANTAMENTOTRP: Double;
    FCGA_PLACAVEICULO: String;
    FCGA_UFVEICULO: String;
    FCGA_RNTRC: String;
    FCGA_INFCOMPLEMENTAR: String;
    FCGA_OBSERVACAO: String;
    FCGA_FATURADA: String;
    FCGA_PROCESSADA: String;
    FCGA_LACRADA: String;
    FCGA_ATUALIZADA: String;
    FCGA_LIVROFISCAL: String;
    FCGA_CANCELADA: String;
    FCGA_DESATIVADO: String;
    FCGA_DATAALTERACAO: TDateTime;
    FCGA_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CGA_00';
     const PrimaryKey = 'CGA_ID';
     const Sequence   = 'SEQ_CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FUN_CODIGO', ftInteger)]
    [Dictionary('FUN_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FUN_CODIGO: Integer read FFUN_CODIGO write FFUN_CODIGO;
    const FUN_CODIGO_Name = 'FUN_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CGA_DATASAIDA', ftDateTime)]
    [Dictionary('CGA_DATASAIDA', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATASAIDA: TDateTime read FCGA_DATASAIDA write FCGA_DATASAIDA;
    const CGA_DATASAIDA_Name = 'CGA_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('CGA_DATALACRE', ftDateTime)]
    [Dictionary('CGA_DATALACRE', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATALACRE: TDateTime read FCGA_DATALACRE write FCGA_DATALACRE;
    const CGA_DATALACRE_Name = 'CGA_DATALACRE';

    [Restrictions([NoValidate])]
    [Column('CGA_DATAENTREGA', ftDateTime)]
    [Dictionary('CGA_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATAENTREGA: TDateTime read FCGA_DATAENTREGA write FCGA_DATAENTREGA;
    const CGA_DATAENTREGA_Name = 'CGA_DATAENTREGA';

    [Restrictions([NoValidate])]
    [Column('CGA_DATAFORMACAO', ftDateTime)]
    [Dictionary('CGA_DATAFORMACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATAFORMACAO: TDateTime read FCGA_DATAFORMACAO write FCGA_DATAFORMACAO;
    const CGA_DATAFORMACAO_Name = 'CGA_DATAFORMACAO';

    [Restrictions([NoValidate])]
    [Column('CGA_DATAATUALIZACAO', ftDateTime)]
    [Dictionary('CGA_DATAATUALIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATAATUALIZACAO: TDateTime read FCGA_DATAATUALIZACAO write FCGA_DATAATUALIZACAO;
    const CGA_DATAATUALIZACAO_Name = 'CGA_DATAATUALIZACAO';

    [Restrictions([NoValidate])]
    [Column('CGA_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('CGA_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATACANCELAMENTO: TDateTime read FCGA_DATACANCELAMENTO write FCGA_DATACANCELAMENTO;
    const CGA_DATACANCELAMENTO_Name = 'CGA_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CGA_DATAFATURAMENTO', ftDateTime)]
    [Dictionary('CGA_DATAFATURAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CGA_DATAFATURAMENTO: TDateTime read FCGA_DATAFATURAMENTO write FCGA_DATAFATURAMENTO;
    const CGA_DATAFATURAMENTO_Name = 'CGA_DATAFATURAMENTO';

    [Restrictions([NoValidate])]
    [Column('CGA_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('CGA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_TIPODOCUMENTO: String read FCGA_TIPODOCUMENTO write FCGA_TIPODOCUMENTO;
    const CGA_TIPODOCUMENTO_Name = 'CGA_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_TITULOCARGA', ftString, 40)]
    [Dictionary('CGA_TITULOCARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_TITULOCARGA: String read FCGA_TITULOCARGA write FCGA_TITULOCARGA;
    const CGA_TITULOCARGA_Name = 'CGA_TITULOCARGA';

    [Restrictions([NoValidate])]
    [Column('CGA_NUMEROLACRE', ftString, 40)]
    [Dictionary('CGA_NUMEROLACRE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_NUMEROLACRE: String read FCGA_NUMEROLACRE write FCGA_NUMEROLACRE;
    const CGA_NUMEROLACRE_Name = 'CGA_NUMEROLACRE';

    [Restrictions([NoValidate])]
    [Column('CGA_TOTALFRETECIF', ftBCD)]
    [Dictionary('CGA_TOTALFRETECIF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CGA_TOTALFRETECIF: Double read FCGA_TOTALFRETECIF write FCGA_TOTALFRETECIF;
    const CGA_TOTALFRETECIF_Name = 'CGA_TOTALFRETECIF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_TOTALFRETEFOB', ftBCD)]
    [Dictionary('CGA_TOTALFRETEFOB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CGA_TOTALFRETEFOB: Double read FCGA_TOTALFRETEFOB write FCGA_TOTALFRETEFOB;
    const CGA_TOTALFRETEFOB_Name = 'CGA_TOTALFRETEFOB';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_TOTALFINANCEIRO', ftBCD)]
    [Dictionary('CGA_TOTALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CGA_TOTALFINANCEIRO: Double read FCGA_TOTALFINANCEIRO write FCGA_TOTALFINANCEIRO;
    const CGA_TOTALFINANCEIRO_Name = 'CGA_TOTALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CGA_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CGA_TOTALPESOLIQUIDO: Double read FCGA_TOTALPESOLIQUIDO write FCGA_TOTALPESOLIQUIDO;
    const CGA_TOTALPESOLIQUIDO_Name = 'CGA_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_TOTALADIANTAMENTOTRP', ftBCD)]
    [Dictionary('CGA_TOTALADIANTAMENTOTRP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CGA_TOTALADIANTAMENTOTRP: Double read FCGA_TOTALADIANTAMENTOTRP write FCGA_TOTALADIANTAMENTOTRP;
    const CGA_TOTALADIANTAMENTOTRP_Name = 'CGA_TOTALADIANTAMENTOTRP';

    [Restrictions([NoValidate])]
    [Column('CGA_PLACAVEICULO', ftString, 7)]
    [Dictionary('CGA_PLACAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_PLACAVEICULO: String read FCGA_PLACAVEICULO write FCGA_PLACAVEICULO;
    const CGA_PLACAVEICULO_Name = 'CGA_PLACAVEICULO';

    [Restrictions([NoValidate])]
    [Column('CGA_UFVEICULO', ftString, 2)]
    [Dictionary('CGA_UFVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_UFVEICULO: String read FCGA_UFVEICULO write FCGA_UFVEICULO;
    const CGA_UFVEICULO_Name = 'CGA_UFVEICULO';

    [Restrictions([NoValidate])]
    [Column('CGA_RNTRC', ftString, 14)]
    [Dictionary('CGA_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_RNTRC: String read FCGA_RNTRC write FCGA_RNTRC;
    const CGA_RNTRC_Name = 'CGA_RNTRC';

    [Restrictions([NoValidate])]
    [Column('CGA_INFCOMPLEMENTAR', ftString, 4000)]
    [Dictionary('CGA_INFCOMPLEMENTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_INFCOMPLEMENTAR: String read FCGA_INFCOMPLEMENTAR write FCGA_INFCOMPLEMENTAR;
    const CGA_INFCOMPLEMENTAR_Name = 'CGA_INFCOMPLEMENTAR';

    [Restrictions([NoValidate])]
    [Column('CGA_OBSERVACAO', ftString, 300)]
    [Dictionary('CGA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_OBSERVACAO: String read FCGA_OBSERVACAO write FCGA_OBSERVACAO;
    const CGA_OBSERVACAO_Name = 'CGA_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_FATURADA', ftString, 1)]
    [Dictionary('CGA_FATURADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_FATURADA: String read FCGA_FATURADA write FCGA_FATURADA;
    const CGA_FATURADA_Name = 'CGA_FATURADA';

    [Restrictions([NoValidate])]
    [Column('CGA_PROCESSADA', ftString, 1)]
    [Dictionary('CGA_PROCESSADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_PROCESSADA: String read FCGA_PROCESSADA write FCGA_PROCESSADA;
    const CGA_PROCESSADA_Name = 'CGA_PROCESSADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_LACRADA', ftString, 1)]
    [Dictionary('CGA_LACRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_LACRADA: String read FCGA_LACRADA write FCGA_LACRADA;
    const CGA_LACRADA_Name = 'CGA_LACRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_ATUALIZADA', ftString, 1)]
    [Dictionary('CGA_ATUALIZADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_ATUALIZADA: String read FCGA_ATUALIZADA write FCGA_ATUALIZADA;
    const CGA_ATUALIZADA_Name = 'CGA_ATUALIZADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_LIVROFISCAL', ftString, 1)]
    [Dictionary('CGA_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_LIVROFISCAL: String read FCGA_LIVROFISCAL write FCGA_LIVROFISCAL;
    const CGA_LIVROFISCAL_Name = 'CGA_LIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_CANCELADA', ftString, 1)]
    [Dictionary('CGA_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_CANCELADA: String read FCGA_CANCELADA write FCGA_CANCELADA;
    const CGA_CANCELADA_Name = 'CGA_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_DESATIVADO', ftString, 1)]
    [Dictionary('CGA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_DESATIVADO: String read FCGA_DESATIVADO write FCGA_DESATIVADO;
    const CGA_DESATIVADO_Name = 'CGA_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CGA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CGA_DATAALTERACAO: TDateTime read FCGA_DATAALTERACAO write FCGA_DATAALTERACAO;
    const CGA_DATAALTERACAO_Name = 'CGA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CGA_ID_OLD', ftInteger)]
    [Dictionary('CGA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID_OLD: Integer read FCGA_ID_OLD write FCGA_ID_OLD;
    const CGA_ID_OLD_Name = 'CGA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCGA_00)

end.
