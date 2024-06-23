unit express.dbo.RETQ_SELECIONAPEDIDOS_01;

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
  [Table('RETQ_SelecionaPedidos_01', '')]
  TDtoRETQ_SelecionaPedidos_01 = class
  private
    { Private declarations } 
    FRETQ_TIPOMOVTO: String;
    FRETQ_ID_OS: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FRETQ_QTDRETIRADA: Double;
    FRETQ_QTDATUAL: Double;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_REFERENCIAINTERNA: String;
    FSGM_CODIGO: String;
    FPES_NOME: String;
    FRETQ_NUMERODOCTO: String;
    FRETQ_DATAEMISSAO: TDateTime;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FRETQ_QTDANTERIOR: Double;
    FRETQ_STATUS: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'RETQ_SelecionaPedidos_01';

    [Restrictions([NoValidate])]
    [Column('RETQ_TIPOMOVTO', ftString, 5)]
    [Dictionary('RETQ_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_TIPOMOVTO: String read FRETQ_TIPOMOVTO write FRETQ_TIPOMOVTO;
    const RETQ_TIPOMOVTO_Name = 'RETQ_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('RETQ_ID_OS', ftInteger)]
    [Dictionary('RETQ_ID_OS', 'Mensagem de validação', '0', '', '', taCenter)]
    property RETQ_ID_OS: Integer read FRETQ_ID_OS write FRETQ_ID_OS;
    const RETQ_ID_OS_Name = 'RETQ_ID_OS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RETQ_QTDRETIRADA', ftBCD)]
    [Dictionary('RETQ_QTDRETIRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RETQ_QTDRETIRADA: Double read FRETQ_QTDRETIRADA write FRETQ_QTDRETIRADA;
    const RETQ_QTDRETIRADA_Name = 'RETQ_QTDRETIRADA';

    [Restrictions([NoValidate])]
    [Column('RETQ_QTDATUAL', ftBCD)]
    [Dictionary('RETQ_QTDATUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RETQ_QTDATUAL: Double read FRETQ_QTDATUAL write FRETQ_QTDATUAL;
    const RETQ_QTDATUAL_Name = 'RETQ_QTDATUAL';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('RETQ_NUMERODOCTO', ftString, 15)]
    [Dictionary('RETQ_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_NUMERODOCTO: String read FRETQ_NUMERODOCTO write FRETQ_NUMERODOCTO;
    const RETQ_NUMERODOCTO_Name = 'RETQ_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('RETQ_DATAEMISSAO', ftDateTime)]
    [Dictionary('RETQ_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property RETQ_DATAEMISSAO: TDateTime read FRETQ_DATAEMISSAO write FRETQ_DATAEMISSAO;
    const RETQ_DATAEMISSAO_Name = 'RETQ_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LCZ_CODIGO', ftInteger)]
    [Dictionary('LCZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LCZ_CODIGO: Integer read FLCZ_CODIGO write FLCZ_CODIGO;
    const LCZ_CODIGO_Name = 'LCZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LCZ_DESCRICAO', ftString, 30)]
    [Dictionary('LCZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_DESCRICAO: String read FLCZ_DESCRICAO write FLCZ_DESCRICAO;
    const LCZ_DESCRICAO_Name = 'LCZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('RETQ_QTDANTERIOR', ftBCD)]
    [Dictionary('RETQ_QTDANTERIOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RETQ_QTDANTERIOR: Double read FRETQ_QTDANTERIOR write FRETQ_QTDANTERIOR;
    const RETQ_QTDANTERIOR_Name = 'RETQ_QTDANTERIOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('RETQ_STATUS', ftString, 9)]
    [Dictionary('RETQ_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_STATUS: String read FRETQ_STATUS write FRETQ_STATUS;
    const RETQ_STATUS_Name = 'RETQ_STATUS';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRETQ_SelecionaPedidos_01)

end.
