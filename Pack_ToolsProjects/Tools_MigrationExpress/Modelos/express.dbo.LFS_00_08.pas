unit express.dbo.LFS_00_08;

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
  [Table('LFS_00_08', '')]
  [PrimaryKey('LFS_08_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_08_ID')]
  TDtoLFS_00_08 = class
  private
    { Private declarations } 
    FLFS_08_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FLFS_NUMERODOCTO: String;
    FLFS_DESCRICAODOCTO: String;
    FLFS_VALORDOCTO: Double;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_DATAPREVISAOENTREGA: TDateTime;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_08_ID_OLD: Integer;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFS_00_08';
    const PrimaryKey = 'LFS_08_ID';
    const Sequence   = 'SEQ_LFS_08_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_08_ID', ftInteger)]
    [Dictionary('LFS_08_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_08_ID: Integer read FLFS_08_ID write FLFS_08_ID;
    const LFS_08_ID_Name = 'LFS_08_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_08_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMERODOCTO', ftString, 100)]
    [Dictionary('LFS_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMERODOCTO: String read FLFS_NUMERODOCTO write FLFS_NUMERODOCTO;
    const LFS_NUMERODOCTO_Name = 'LFS_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('LFS_DESCRICAODOCTO', ftString, 20)]
    [Dictionary('LFS_DESCRICAODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_DESCRICAODOCTO: String read FLFS_DESCRICAODOCTO write FLFS_DESCRICAODOCTO;
    const LFS_DESCRICAODOCTO_Name = 'LFS_DESCRICAODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORDOCTO', ftBCD)]
    [Dictionary('LFS_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORDOCTO: Double read FLFS_VALORDOCTO write FLFS_VALORDOCTO;
    const LFS_VALORDOCTO_Name = 'LFS_VALORDOCTO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAPREVISAOENTREGA', ftDateTime)]
    [Dictionary('LFS_DATAPREVISAOENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAPREVISAOENTREGA: TDateTime read FLFS_DATAPREVISAOENTREGA write FLFS_DATAPREVISAOENTREGA;
    const LFS_DATAPREVISAOENTREGA_Name = 'LFS_DATAPREVISAOENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_08_ID_OLD', ftInteger)]
    [Dictionary('LFS_08_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_08_ID_OLD: Integer read FLFS_08_ID_OLD write FLFS_08_ID_OLD;
    const LFS_08_ID_OLD_Name = 'LFS_08_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_08)

end.
