unit express.dbo.G_PES_00_08;

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
  [Table('G_PES_00_08', '')]
  [PrimaryKey('PES_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PES_CODIGO')]
  TDtoG_PES_00_08 = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FSYS_VERSION_NUMBER: Integer;
    FSYS_DATA_ATUALIZACAO: TDateTime;
    FSYS_HORA_ATUALIZACAO: String;
    FPES_MEGA_USUARIO: String;
    FPES_MEGA_SENHA: String;
    FPES_MEGA_RECOVERYKEY: String;
    FCTD_CODIGO: Integer;
    FPES_ATIVIDADEECONOMICA: String;
    FPES_REGIMETRIBUTARIO: String;
    FPES_TIPOLICENCA: Integer;
    FPES_HOLDING: Integer;
  public 
    { Public declarations } 
     const Table      = 'G_PES_00_08';
     const PrimaryKey = 'PES_CODIGO';
     const Sequence   = 'SEQ_PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SYS_VERSION_NUMBER', ftInteger)]
    [Dictionary('SYS_VERSION_NUMBER', 'Mensagem de validação', '0', '', '', taCenter)]
    property SYS_VERSION_NUMBER: Integer read FSYS_VERSION_NUMBER write FSYS_VERSION_NUMBER;
    const SYS_VERSION_NUMBER_Name = 'SYS_VERSION_NUMBER';

    [Restrictions([NoValidate])]
    [Column('SYS_DATA_ATUALIZACAO', ftDateTime)]
    [Dictionary('SYS_DATA_ATUALIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property SYS_DATA_ATUALIZACAO: TDateTime read FSYS_DATA_ATUALIZACAO write FSYS_DATA_ATUALIZACAO;
    const SYS_DATA_ATUALIZACAO_Name = 'SYS_DATA_ATUALIZACAO';

    [Restrictions([NoValidate])]
    [Column('SYS_HORA_ATUALIZACAO', ftString, 8)]
    [Dictionary('SYS_HORA_ATUALIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SYS_HORA_ATUALIZACAO: String read FSYS_HORA_ATUALIZACAO write FSYS_HORA_ATUALIZACAO;
    const SYS_HORA_ATUALIZACAO_Name = 'SYS_HORA_ATUALIZACAO';

    [Restrictions([NoValidate])]
    [Column('PES_MEGA_USUARIO', ftString, 100)]
    [Dictionary('PES_MEGA_USUARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_MEGA_USUARIO: String read FPES_MEGA_USUARIO write FPES_MEGA_USUARIO;
    const PES_MEGA_USUARIO_Name = 'PES_MEGA_USUARIO';

    [Restrictions([NoValidate])]
    [Column('PES_MEGA_SENHA', ftString, 50)]
    [Dictionary('PES_MEGA_SENHA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_MEGA_SENHA: String read FPES_MEGA_SENHA write FPES_MEGA_SENHA;
    const PES_MEGA_SENHA_Name = 'PES_MEGA_SENHA';

    [Restrictions([NoValidate])]
    [Column('PES_MEGA_RECOVERYKEY', ftString, 50)]
    [Dictionary('PES_MEGA_RECOVERYKEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_MEGA_RECOVERYKEY: String read FPES_MEGA_RECOVERYKEY write FPES_MEGA_RECOVERYKEY;
    const PES_MEGA_RECOVERYKEY_Name = 'PES_MEGA_RECOVERYKEY';

    [Restrictions([NoValidate])]
    [Column('CTD_CODIGO', ftInteger)]
    [Dictionary('CTD_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTD_CODIGO: Integer read FCTD_CODIGO write FCTD_CODIGO;
    const CTD_CODIGO_Name = 'CTD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_ATIVIDADEECONOMICA', ftString, 100)]
    [Dictionary('PES_ATIVIDADEECONOMICA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ATIVIDADEECONOMICA: String read FPES_ATIVIDADEECONOMICA write FPES_ATIVIDADEECONOMICA;
    const PES_ATIVIDADEECONOMICA_Name = 'PES_ATIVIDADEECONOMICA';

    [Restrictions([NoValidate])]
    [Column('PES_REGIMETRIBUTARIO', ftString, 1)]
    [Dictionary('PES_REGIMETRIBUTARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_REGIMETRIBUTARIO: String read FPES_REGIMETRIBUTARIO write FPES_REGIMETRIBUTARIO;
    const PES_REGIMETRIBUTARIO_Name = 'PES_REGIMETRIBUTARIO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOLICENCA', ftInteger)]
    [Dictionary('PES_TIPOLICENCA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_TIPOLICENCA: Integer read FPES_TIPOLICENCA write FPES_TIPOLICENCA;
    const PES_TIPOLICENCA_Name = 'PES_TIPOLICENCA';

    [Restrictions([NoValidate])]
    [Column('PES_HOLDING', ftInteger)]
    [Dictionary('PES_HOLDING', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_HOLDING: Integer read FPES_HOLDING write FPES_HOLDING;
    const PES_HOLDING_Name = 'PES_HOLDING';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_PES_00_08)

end.
