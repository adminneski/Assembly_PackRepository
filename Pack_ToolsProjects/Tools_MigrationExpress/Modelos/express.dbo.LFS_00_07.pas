unit express.dbo.LFS_00_07;

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
  [Table('LFS_00_07', '')]
  [PrimaryKey('LFS_07_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_07_ID')]
  TDtoLFS_00_07 = class
  private
    { Private declarations } 
    FLFS_07_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FLFS_CNPJ_CPF: String;
    FLFS_IE: String;
    FLFS_UF: String;
    FLFS_NOMEEXPEDIDOR: String;
    FLFS_TIPODOCUMENTO: String;
    FLFS_SERIE: String;
    FLFS_SUBSERIE: String;
    FLFS_NUMERODOCTOFISCAL: String;
    FLFS_CHAVEACESSO: String;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_07_ID_OLD: Integer;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFS_00_07';
    const PrimaryKey = 'LFS_07_ID';
    const Sequence   = 'SEQ_LFS_07_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_07_ID', ftInteger)]
    [Dictionary('LFS_07_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_07_ID: Integer read FLFS_07_ID write FLFS_07_ID;
    const LFS_07_ID_Name = 'LFS_07_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_07_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_CNPJ_CPF', ftString, 14)]
    [Dictionary('LFS_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CNPJ_CPF: String read FLFS_CNPJ_CPF write FLFS_CNPJ_CPF;
    const LFS_CNPJ_CPF_Name = 'LFS_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('LFS_IE', ftString, 16)]
    [Dictionary('LFS_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_IE: String read FLFS_IE write FLFS_IE;
    const LFS_IE_Name = 'LFS_IE';

    [Restrictions([NoValidate])]
    [Column('LFS_UF', ftString, 2)]
    [Dictionary('LFS_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UF: String read FLFS_UF write FLFS_UF;
    const LFS_UF_Name = 'LFS_UF';

    [Restrictions([NoValidate])]
    [Column('LFS_NOMEEXPEDIDOR', ftString, 60)]
    [Dictionary('LFS_NOMEEXPEDIDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOMEEXPEDIDOR: String read FLFS_NOMEEXPEDIDOR write FLFS_NOMEEXPEDIDOR;
    const LFS_NOMEEXPEDIDOR_Name = 'LFS_NOMEEXPEDIDOR';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPODOCUMENTO', ftString, 2)]
    [Dictionary('LFS_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPODOCUMENTO: String read FLFS_TIPODOCUMENTO write FLFS_TIPODOCUMENTO;
    const LFS_TIPODOCUMENTO_Name = 'LFS_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIE', ftString, 3)]
    [Dictionary('LFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIE: String read FLFS_SERIE write FLFS_SERIE;
    const LFS_SERIE_Name = 'LFS_SERIE';

    [Restrictions([NoValidate])]
    [Column('LFS_SUBSERIE', ftString, 2)]
    [Dictionary('LFS_SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SUBSERIE: String read FLFS_SUBSERIE write FLFS_SUBSERIE;
    const LFS_SUBSERIE_Name = 'LFS_SUBSERIE';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMERODOCTOFISCAL', ftString, 20)]
    [Dictionary('LFS_NUMERODOCTOFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMERODOCTOFISCAL: String read FLFS_NUMERODOCTOFISCAL write FLFS_NUMERODOCTOFISCAL;
    const LFS_NUMERODOCTOFISCAL_Name = 'LFS_NUMERODOCTOFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSO: String read FLFS_CHAVEACESSO write FLFS_CHAVEACESSO;
    const LFS_CHAVEACESSO_Name = 'LFS_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_07_ID_OLD', ftInteger)]
    [Dictionary('LFS_07_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_07_ID_OLD: Integer read FLFS_07_ID_OLD write FLFS_07_ID_OLD;
    const LFS_07_ID_OLD_Name = 'LFS_07_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_07)

end.
