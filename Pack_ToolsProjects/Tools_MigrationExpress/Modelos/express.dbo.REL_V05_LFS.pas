unit express.dbo.REL_V05_LFS;

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
  [Table('REL_V05_LFS', '')]
  TDtoREL_V05_LFS = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_CANCELADO: String;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_TOTALCNPJ: Double;
    FLFS_TOTALCPF: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V05_LFS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('LFS_CANCELADO', ftString, 1)]
    [Dictionary('LFS_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CANCELADO: String read FLFS_CANCELADO write FLFS_CANCELADO;
    const LFS_CANCELADO_Name = 'LFS_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALCNPJ', ftBCD)]
    [Dictionary('LFS_TOTALCNPJ', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCNPJ: Double read FLFS_TOTALCNPJ write FLFS_TOTALCNPJ;
    const LFS_TOTALCNPJ_Name = 'LFS_TOTALCNPJ';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TOTALCPF', ftBCD)]
    [Dictionary('LFS_TOTALCPF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCPF: Double read FLFS_TOTALCPF write FLFS_TOTALCPF;
    const LFS_TOTALCPF_Name = 'LFS_TOTALCPF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V05_LFS)

end.
