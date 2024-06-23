unit express.dbo.CTR_EMAILS_PESSOAS;

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
  [Table('CTR_Emails_Pessoas', '')]
  TDtoCTR_Emails_Pessoas = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FLFS_INTEGRACAO: String;
    FLFS_TIPOFRETE: String;
    FLFS_NOTAFISCAL: String;
    FMNF_CODIGO: String;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_CLIENTECONSIGNATARIO: Integer;
    FPES_CLIENTEREDESPACHO: Integer;
    FPES_CLIENTEOUTROS: Integer;
    FPES_EMAILREMETENTE: String;
    FPES_EMAILDESTINATARIO: String;
    FPES_EMAILCONSIGNATARIO: String;
    FPES_EMAILREDESPACHO: String;
    FPES_EMAILOUTROS: String;
  public 
    { Public declarations } 
     const Table      = 'CTR_Emails_Pessoas';

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
    [Column('LFS_INTEGRACAO', ftString, 20)]
    [Dictionary('LFS_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_INTEGRACAO: String read FLFS_INTEGRACAO write FLFS_INTEGRACAO;
    const LFS_INTEGRACAO_Name = 'LFS_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOFRETE', ftString, 1)]
    [Dictionary('LFS_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOFRETE: String read FLFS_TIPOFRETE write FLFS_TIPOFRETE;
    const LFS_TIPOFRETE_Name = 'LFS_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTECONSIGNATARIO', ftInteger)]
    [Dictionary('PES_CLIENTECONSIGNATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTECONSIGNATARIO: Integer read FPES_CLIENTECONSIGNATARIO write FPES_CLIENTECONSIGNATARIO;
    const PES_CLIENTECONSIGNATARIO_Name = 'PES_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREDESPACHO', ftInteger)]
    [Dictionary('PES_CLIENTEREDESPACHO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREDESPACHO: Integer read FPES_CLIENTEREDESPACHO write FPES_CLIENTEREDESPACHO;
    const PES_CLIENTEREDESPACHO_Name = 'PES_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEOUTROS', ftInteger)]
    [Dictionary('PES_CLIENTEOUTROS', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEOUTROS: Integer read FPES_CLIENTEOUTROS write FPES_CLIENTEOUTROS;
    const PES_CLIENTEOUTROS_Name = 'PES_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILREMETENTE', ftString, 300)]
    [Dictionary('PES_EMAILREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILREMETENTE: String read FPES_EMAILREMETENTE write FPES_EMAILREMETENTE;
    const PES_EMAILREMETENTE_Name = 'PES_EMAILREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILDESTINATARIO', ftString, 300)]
    [Dictionary('PES_EMAILDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILDESTINATARIO: String read FPES_EMAILDESTINATARIO write FPES_EMAILDESTINATARIO;
    const PES_EMAILDESTINATARIO_Name = 'PES_EMAILDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILCONSIGNATARIO', ftString, 300)]
    [Dictionary('PES_EMAILCONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILCONSIGNATARIO: String read FPES_EMAILCONSIGNATARIO write FPES_EMAILCONSIGNATARIO;
    const PES_EMAILCONSIGNATARIO_Name = 'PES_EMAILCONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILREDESPACHO', ftString, 300)]
    [Dictionary('PES_EMAILREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILREDESPACHO: String read FPES_EMAILREDESPACHO write FPES_EMAILREDESPACHO;
    const PES_EMAILREDESPACHO_Name = 'PES_EMAILREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_EMAILOUTROS', ftString, 300)]
    [Dictionary('PES_EMAILOUTROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMAILOUTROS: String read FPES_EMAILOUTROS write FPES_EMAILOUTROS;
    const PES_EMAILOUTROS_Name = 'PES_EMAILOUTROS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_Emails_Pessoas)

end.
