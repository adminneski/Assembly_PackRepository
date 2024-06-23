unit express.dbo.RETQ_00;

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
  [Table('RETQ_00', '')]
  [PrimaryKey('RETQ_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RETQ_ID')]
  TDtoRETQ_00 = class
  private
    { Private declarations } 
    FRETQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FRETQ_ID_OS: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FRETQ_TIPOMOVTO: String;
    FRETQ_NUMERODOCTO: String;
    FRETQ_DATAMOVTO: TDateTime;
    FRETQ_QTDATUAL: Double;
    FRETQ_QTDRETIRADA: Double;
    FRETQ_DATAALTERACAO: TDateTime;
    FRETQ_RETIRADO: String;
    FRETQ_DEVOLUCAO: String;
    FRETQ_BLOQUEADO: String;
    FRETQ_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'RETQ_00';
     const PrimaryKey = 'RETQ_ID';
     const Sequence   = 'SEQ_RETQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RETQ_ID', ftInteger)]
    [Dictionary('RETQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RETQ_ID: Integer read FRETQ_ID write FRETQ_ID;
    const RETQ_ID_Name = 'RETQ_ID';

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
    [Column('RETQ_ID_OS', ftInteger)]
    [Dictionary('RETQ_ID_OS', 'Mensagem de validação', '0', '', '', taCenter)]
    property RETQ_ID_OS: Integer read FRETQ_ID_OS write FRETQ_ID_OS;
    const RETQ_ID_OS_Name = 'RETQ_ID_OS';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RETQ_TIPOMOVTO', ftString, 5)]
    [Dictionary('RETQ_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_TIPOMOVTO: String read FRETQ_TIPOMOVTO write FRETQ_TIPOMOVTO;
    const RETQ_TIPOMOVTO_Name = 'RETQ_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('RETQ_NUMERODOCTO', ftString, 15)]
    [Dictionary('RETQ_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_NUMERODOCTO: String read FRETQ_NUMERODOCTO write FRETQ_NUMERODOCTO;
    const RETQ_NUMERODOCTO_Name = 'RETQ_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('RETQ_DATAMOVTO', ftDateTime)]
    [Dictionary('RETQ_DATAMOVTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RETQ_DATAMOVTO: TDateTime read FRETQ_DATAMOVTO write FRETQ_DATAMOVTO;
    const RETQ_DATAMOVTO_Name = 'RETQ_DATAMOVTO';

    [Restrictions([NoValidate])]
    [Column('RETQ_QTDATUAL', ftBCD, 1952531540, 3)]
    [Dictionary('RETQ_QTDATUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RETQ_QTDATUAL: Double read FRETQ_QTDATUAL write FRETQ_QTDATUAL;
    const RETQ_QTDATUAL_Name = 'RETQ_QTDATUAL';

    [Restrictions([NoValidate])]
    [Column('RETQ_QTDRETIRADA', ftBCD, 1769238085, 3)]
    [Dictionary('RETQ_QTDRETIRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RETQ_QTDRETIRADA: Double read FRETQ_QTDRETIRADA write FRETQ_QTDRETIRADA;
    const RETQ_QTDRETIRADA_Name = 'RETQ_QTDRETIRADA';

    [Restrictions([NoValidate])]
    [Column('RETQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('RETQ_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property RETQ_DATAALTERACAO: TDateTime read FRETQ_DATAALTERACAO write FRETQ_DATAALTERACAO;
    const RETQ_DATAALTERACAO_Name = 'RETQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('RETQ_RETIRADO', ftString, 1)]
    [Dictionary('RETQ_RETIRADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_RETIRADO: String read FRETQ_RETIRADO write FRETQ_RETIRADO;
    const RETQ_RETIRADO_Name = 'RETQ_RETIRADO';

    [Restrictions([NoValidate])]
    [Column('RETQ_DEVOLUCAO', ftString, 1)]
    [Dictionary('RETQ_DEVOLUCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_DEVOLUCAO: String read FRETQ_DEVOLUCAO write FRETQ_DEVOLUCAO;
    const RETQ_DEVOLUCAO_Name = 'RETQ_DEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('RETQ_BLOQUEADO', ftString, 1)]
    [Dictionary('RETQ_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RETQ_BLOQUEADO: String read FRETQ_BLOQUEADO write FRETQ_BLOQUEADO;
    const RETQ_BLOQUEADO_Name = 'RETQ_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('RETQ_ID_OLD', ftInteger)]
    [Dictionary('RETQ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RETQ_ID_OLD: Integer read FRETQ_ID_OLD write FRETQ_ID_OLD;
    const RETQ_ID_OLD_Name = 'RETQ_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRETQ_00)

end.
