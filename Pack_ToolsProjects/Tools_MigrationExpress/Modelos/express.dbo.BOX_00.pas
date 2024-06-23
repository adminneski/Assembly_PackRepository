unit express.dbo.BOX_00;

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
  [Table('BOX_00', '')]
  [PrimaryKey('BOX_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BOX_CODIGO')]
  TDtoBOX_00 = class
  private
    { Private declarations } 
    FBOX_CODIGO: String;
    FBOX_DESCRICAO: String;
    FBOX_ORDEM: Integer;
    FBOX_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'BOX_00';
     const PrimaryKey = 'BOX_CODIGO';
     const Sequence   = 'SEQ_BOX_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BOX_CODIGO', ftString, 3)]
    [Dictionary('BOX_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BOX_CODIGO: String read FBOX_CODIGO write FBOX_CODIGO;
    const BOX_CODIGO_Name = 'BOX_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BOX_DESCRICAO', ftString, 100)]
    [Dictionary('BOX_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BOX_DESCRICAO: String read FBOX_DESCRICAO write FBOX_DESCRICAO;
    const BOX_DESCRICAO_Name = 'BOX_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('BOX_ORDEM', ftInteger)]
    [Dictionary('BOX_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property BOX_ORDEM: Integer read FBOX_ORDEM write FBOX_ORDEM;
    const BOX_ORDEM_Name = 'BOX_ORDEM';

    [Restrictions([NoValidate])]
    [Column('BOX_DESATIVADO', ftString, 1)]
    [Dictionary('BOX_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BOX_DESATIVADO: String read FBOX_DESATIVADO write FBOX_DESATIVADO;
    const BOX_DESATIVADO_Name = 'BOX_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBOX_00)

end.
