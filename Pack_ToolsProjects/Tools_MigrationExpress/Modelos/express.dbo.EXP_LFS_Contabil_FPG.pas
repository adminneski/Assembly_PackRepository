unit express.dbo.EXP_LFS_CONTABIL_FPG;

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
  [Table('EXP_LFS_Contabil_FPG', '')]
  TDtoEXP_LFS_Contabil_FPG = class
  private
    { Private declarations } 
    FLFS_SIGLA: String;
    FLFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_TIPOPAGAMENTO: Integer;
    FLFS_NUMERODOCTO: String;
    FLFS_NUMEROPARCELA: Integer;
    FLFS_VALORPARCELA: Double;
    FLFS_DATAVENCIMENTO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'EXP_LFS_Contabil_FPG';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_SIGLA', ftString, 3)]
    [Dictionary('LFS_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SIGLA: String read FLFS_SIGLA write FLFS_SIGLA;
    const LFS_SIGLA_Name = 'LFS_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('LFS_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_TIPOPAGAMENTO: Integer read FLFS_TIPOPAGAMENTO write FLFS_TIPOPAGAMENTO;
    const LFS_TIPOPAGAMENTO_Name = 'LFS_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMERODOCTO', ftString, 20)]
    [Dictionary('LFS_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMERODOCTO: String read FLFS_NUMERODOCTO write FLFS_NUMERODOCTO;
    const LFS_NUMERODOCTO_Name = 'LFS_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROPARCELA', ftInteger)]
    [Dictionary('LFS_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_NUMEROPARCELA: Integer read FLFS_NUMEROPARCELA write FLFS_NUMEROPARCELA;
    const LFS_NUMEROPARCELA_Name = 'LFS_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPARCELA', ftBCD)]
    [Dictionary('LFS_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPARCELA: Double read FLFS_VALORPARCELA write FLFS_VALORPARCELA;
    const LFS_VALORPARCELA_Name = 'LFS_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('LFS_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAVENCIMENTO: TDateTime read FLFS_DATAVENCIMENTO write FLFS_DATAVENCIMENTO;
    const LFS_DATAVENCIMENTO_Name = 'LFS_DATAVENCIMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_LFS_Contabil_FPG)

end.
