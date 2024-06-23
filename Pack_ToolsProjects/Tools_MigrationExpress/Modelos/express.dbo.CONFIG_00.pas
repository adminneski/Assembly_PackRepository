unit express.dbo.CONFIG_00;

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
  [Table('CONFIG_00', '')]
  [PrimaryKey('CFG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFG_CODIGO')]
  TDtoCONFIG_00 = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FCFG_DESCRICAO: String;
    FCFG_OBSERVACAO: String;
    FCFG_DATAALTERACAO: TDateTime;
    FCFG_DESATIVADO: String;
    FCFG_IE_MUNICIPAL: String;
    FPRO_CODIGOANP: String;
    FCOM_CODIGOPAIS: String;
    FCFG_PAIS: String;
    FCFG_LICENSEKEY: TBlob;
    FCFG_LICENSEKEYACTIVATION: TBlob;
  public 
    { Public declarations } 
     const Table      = 'CONFIG_00';
     const PrimaryKey = 'CFG_CODIGO';
     const Sequence   = 'SEQ_CFG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFG_DESCRICAO', ftString, 50)]
    [Dictionary('CFG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_DESCRICAO: String read FCFG_DESCRICAO write FCFG_DESCRICAO;
    const CFG_DESCRICAO_Name = 'CFG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CFG_OBSERVACAO', ftString, 300)]
    [Dictionary('CFG_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_OBSERVACAO: String read FCFG_OBSERVACAO write FCFG_OBSERVACAO;
    const CFG_OBSERVACAO_Name = 'CFG_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_DESATIVADO', ftString, 1)]
    [Dictionary('CFG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_DESATIVADO: String read FCFG_DESATIVADO write FCFG_DESATIVADO;
    const CFG_DESATIVADO_Name = 'CFG_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CFG_IE_MUNICIPAL', ftString, 16)]
    [Dictionary('CFG_IE_MUNICIPAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IE_MUNICIPAL: String read FCFG_IE_MUNICIPAL write FCFG_IE_MUNICIPAL;
    const CFG_IE_MUNICIPAL_Name = 'CFG_IE_MUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOANP', ftString, 9)]
    [Dictionary('PRO_CODIGOANP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOANP: String read FPRO_CODIGOANP write FPRO_CODIGOANP;
    const PRO_CODIGOANP_Name = 'PRO_CODIGOANP';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGOPAIS', ftString, 4)]
    [Dictionary('COM_CODIGOPAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CODIGOPAIS: String read FCOM_CODIGOPAIS write FCOM_CODIGOPAIS;
    const COM_CODIGOPAIS_Name = 'COM_CODIGOPAIS';

    [Restrictions([NoValidate])]
    [Column('CFG_PAIS', ftString, 100)]
    [Dictionary('CFG_PAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_PAIS: String read FCFG_PAIS write FCFG_PAIS;
    const CFG_PAIS_Name = 'CFG_PAIS';

    [Restrictions([NoValidate])]
    [Column('CFG_LICENSEKEY', ftBlob)]
    [Dictionary('CFG_LICENSEKEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_LICENSEKEY: TBlob read FCFG_LICENSEKEY write FCFG_LICENSEKEY;
    const CFG_LICENSEKEY_Name = 'CFG_LICENSEKEY';

    [Restrictions([NoValidate])]
    [Column('CFG_LICENSEKEYACTIVATION', ftBlob)]
    [Dictionary('CFG_LICENSEKEYACTIVATION', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_LICENSEKEYACTIVATION: TBlob read FCFG_LICENSEKEYACTIVATION write FCFG_LICENSEKEYACTIVATION;
    const CFG_LICENSEKEYACTIVATION_Name = 'CFG_LICENSEKEYACTIVATION';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONFIG_00)

end.
