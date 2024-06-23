unit express.dbo.LFS_APURACAOICMS;

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
  [Table('LFS_ApuracaoIcms', '')]
  TDtoLFS_ApuracaoIcms = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FGAI_DESCRICAO: String;
    FLEE_CODIGO: Integer;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_VALORBASECALCULOICMS: Double;
  public 
    { Public declarations } 
     const Table      = 'LFS_ApuracaoIcms';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_DESCRICAO', ftString, 30)]
    [Dictionary('GAI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GAI_DESCRICAO: String read FGAI_DESCRICAO write FGAI_DESCRICAO;
    const GAI_DESCRICAO_Name = 'GAI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOICMS', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMS: Double read FLFS_VALORBASECALCULOICMS write FLFS_VALORBASECALCULOICMS;
    const LFS_VALORBASECALCULOICMS_Name = 'LFS_VALORBASECALCULOICMS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_ApuracaoIcms)

end.
