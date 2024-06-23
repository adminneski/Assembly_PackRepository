unit express.dbo.LFS_SELECIONASEQUENCIANOTASEMITIDAS;

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
  [Table('LFS_SelecionaSequenciaNotasEmitidas', '')]
  TDtoLFS_SelecionaSequenciaNotasEmitidas = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLFS_SERIE: String;
    FMNF_CODIGO: String;
    FLFS_NOTAFISCAL: String;
  public 
    { Public declarations } 
     const Table      = 'LFS_SelecionaSequenciaNotasEmitidas';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIE', ftString, 3)]
    [Dictionary('LFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIE: String read FLFS_SERIE write FLFS_SERIE;
    const LFS_SERIE_Name = 'LFS_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_SelecionaSequenciaNotasEmitidas)

end.
