unit express.dbo.REL_V02_LFS;

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
  [Table('REL_V02_LFS', '')]
  TDtoREL_V02_LFS = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FLFS_DIA: Integer;
    FFPG_CODIGO: Integer;
    FLFS_NUMERODOCTO: String;
    FLFS_NUMEROPARCELA: Integer;
    FLFS_VALORPARCELA: Double;
    FFPG_TIPOPAGAMENTO: Integer;
    FLFS_DATAVENCIMENTO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_LFS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_DIA', ftInteger)]
    [Dictionary('LFS_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_DIA: Integer read FLFS_DIA write FLFS_DIA;
    const LFS_DIA_Name = 'LFS_DIA';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

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
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('LFS_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAVENCIMENTO: TDateTime read FLFS_DATAVENCIMENTO write FLFS_DATAVENCIMENTO;
    const LFS_DATAVENCIMENTO_Name = 'LFS_DATAVENCIMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_LFS)

end.
