unit express.dbo.AUDIT_DISKSPACE;

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
  [Table('AUDIT_DISKSPACE', '')]
  [PrimaryKey('AUD_GUID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_AUD_GUID')]
  TDtoAUDIT_DISKSPACE = class
  private
    { Private declarations } 
    FAUD_GUID: String;
    FPES_CNPJ_CPF: String;
    FAUD_DRIVE: String;
    FAUD_VOLUME: String;
    FAUD_SISTEMAARQUIVO: String;
    FAUD_TOTAL_GB: Double;
    FAUD_ESPACO_USADO_GB: Double;
    FAUD_ESPACO_LIVRE_GB: Double;
    FAUD_PERCENTUAL_EM_USO: Double;
    FAUD_PERCENTUAL_LIVRE: Double;
    FAUD_DATAHORAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'AUDIT_DISKSPACE';
     const PrimaryKey = 'AUD_GUID';
     const Sequence   = 'SEQ_AUD_GUID';

    [Restrictions([NoValidate, NotNull])]
    [Column('AUD_GUID', ftString, 38)]
    [Dictionary('AUD_GUID', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_GUID: String read FAUD_GUID write FAUD_GUID;
    const AUD_GUID_Name = 'AUD_GUID';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('AUD_DRIVE', ftString, 3)]
    [Dictionary('AUD_DRIVE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_DRIVE: String read FAUD_DRIVE write FAUD_DRIVE;
    const AUD_DRIVE_Name = 'AUD_DRIVE';

    [Restrictions([NoValidate])]
    [Column('AUD_VOLUME', ftString, 100)]
    [Dictionary('AUD_VOLUME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_VOLUME: String read FAUD_VOLUME write FAUD_VOLUME;
    const AUD_VOLUME_Name = 'AUD_VOLUME';

    [Restrictions([NoValidate])]
    [Column('AUD_SISTEMAARQUIVO', ftString, 10)]
    [Dictionary('AUD_SISTEMAARQUIVO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AUD_SISTEMAARQUIVO: String read FAUD_SISTEMAARQUIVO write FAUD_SISTEMAARQUIVO;
    const AUD_SISTEMAARQUIVO_Name = 'AUD_SISTEMAARQUIVO';

    [Restrictions([NoValidate])]
    [Column('AUD_TOTAL_GB', ftBCD)]
    [Dictionary('AUD_TOTAL_GB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_TOTAL_GB: Double read FAUD_TOTAL_GB write FAUD_TOTAL_GB;
    const AUD_TOTAL_GB_Name = 'AUD_TOTAL_GB';

    [Restrictions([NoValidate])]
    [Column('AUD_ESPACO_USADO_GB', ftBCD)]
    [Dictionary('AUD_ESPACO_USADO_GB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_ESPACO_USADO_GB: Double read FAUD_ESPACO_USADO_GB write FAUD_ESPACO_USADO_GB;
    const AUD_ESPACO_USADO_GB_Name = 'AUD_ESPACO_USADO_GB';

    [Restrictions([NoValidate])]
    [Column('AUD_ESPACO_LIVRE_GB', ftBCD)]
    [Dictionary('AUD_ESPACO_LIVRE_GB', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_ESPACO_LIVRE_GB: Double read FAUD_ESPACO_LIVRE_GB write FAUD_ESPACO_LIVRE_GB;
    const AUD_ESPACO_LIVRE_GB_Name = 'AUD_ESPACO_LIVRE_GB';

    [Restrictions([NoValidate])]
    [Column('AUD_PERCENTUAL_EM_USO', ftBCD)]
    [Dictionary('AUD_PERCENTUAL_EM_USO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_PERCENTUAL_EM_USO: Double read FAUD_PERCENTUAL_EM_USO write FAUD_PERCENTUAL_EM_USO;
    const AUD_PERCENTUAL_EM_USO_Name = 'AUD_PERCENTUAL_EM_USO';

    [Restrictions([NoValidate])]
    [Column('AUD_PERCENTUAL_LIVRE', ftBCD)]
    [Dictionary('AUD_PERCENTUAL_LIVRE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property AUD_PERCENTUAL_LIVRE: Double read FAUD_PERCENTUAL_LIVRE write FAUD_PERCENTUAL_LIVRE;
    const AUD_PERCENTUAL_LIVRE_Name = 'AUD_PERCENTUAL_LIVRE';

    [Restrictions([NoValidate])]
    [Column('AUD_DATAHORAALTERACAO', ftDateTime)]
    [Dictionary('AUD_DATAHORAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property AUD_DATAHORAALTERACAO: TDateTime read FAUD_DATAHORAALTERACAO write FAUD_DATAHORAALTERACAO;
    const AUD_DATAHORAALTERACAO_Name = 'AUD_DATAHORAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoAUDIT_DISKSPACE)

end.
