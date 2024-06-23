unit express.dbo.LFS_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfs_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFS_00_04', '')]
  [PrimaryKey('LFS_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_04_ID')]
  TDtoLFS_00_04 = class
  private
    { Private declarations } 
    FLFS_04_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FFPG_CODIGO: Integer;
    FFPG_TIPOPAGAMENTO: Integer;
    FLFS_VALORPARCELA: Double;
    FLFS_NUMEROPARCELA: Integer;
    FLFS_DATAVENCIMENTO: TDateTime;
    FLFS_DATAALTERACAO: TDateTime;
    FCRT_CODIGO: Integer;
    FLFS_AUTORIZACAOCARTAO: String;
    FLFS_04_ID_OLD: Integer;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFS_00_04';
    const PrimaryKey = 'LFS_04_ID';
    const Sequence   = 'SEQ_LFS_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_04_ID', ftInteger)]
    [Dictionary('LFS_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_04_ID: Integer read FLFS_04_ID write FLFS_04_ID;
    const LFS_04_ID_Name = 'LFS_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_04_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPARCELA', ftBCD)]
    [Dictionary('LFS_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPARCELA: Double read FLFS_VALORPARCELA write FLFS_VALORPARCELA;
    const LFS_VALORPARCELA_Name = 'LFS_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROPARCELA', ftInteger)]
    [Dictionary('LFS_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_NUMEROPARCELA: Integer read FLFS_NUMEROPARCELA write FLFS_NUMEROPARCELA;
    const LFS_NUMEROPARCELA_Name = 'LFS_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('LFS_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAVENCIMENTO: TDateTime read FLFS_DATAVENCIMENTO write FLFS_DATAVENCIMENTO;
    const LFS_DATAVENCIMENTO_Name = 'LFS_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_AUTORIZACAOCARTAO', ftString, 10)]
    [Dictionary('LFS_AUTORIZACAOCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_AUTORIZACAOCARTAO: String read FLFS_AUTORIZACAOCARTAO write FLFS_AUTORIZACAOCARTAO;
    const LFS_AUTORIZACAOCARTAO_Name = 'LFS_AUTORIZACAOCARTAO';

    [Restrictions([NoValidate])]
    [Column('LFS_04_ID_OLD', ftInteger)]
    [Dictionary('LFS_04_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_04_ID_OLD: Integer read FLFS_04_ID_OLD write FLFS_04_ID_OLD;
    const LFS_04_ID_OLD_Name = 'LFS_04_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_04)

end.
