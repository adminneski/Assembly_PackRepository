unit express.dbo.PALM_V01_REG;

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
  [Table('PALM_V01_REG', '')]
  TDtoPALM_V01_REG = class
  private
    { Private declarations } 
    FREG_CODIGO: Integer;
    FREG_DESCRICAO: String;
    FREG_NOMEAPELIDO: String;
    FREG_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_REG';

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_CODIGO', ftInteger)]
    [Dictionary('REG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property REG_CODIGO: Integer read FREG_CODIGO write FREG_CODIGO;
    const REG_CODIGO_Name = 'REG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_DESCRICAO', ftString, 30)]
    [Dictionary('REG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REG_DESCRICAO: String read FREG_DESCRICAO write FREG_DESCRICAO;
    const REG_DESCRICAO_Name = 'REG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('REG_NOMEAPELIDO', ftString, 10)]
    [Dictionary('REG_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REG_NOMEAPELIDO: String read FREG_NOMEAPELIDO write FREG_NOMEAPELIDO;
    const REG_NOMEAPELIDO_Name = 'REG_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_DESATIVADO', ftString, 1)]
    [Dictionary('REG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property REG_DESATIVADO: String read FREG_DESATIVADO write FREG_DESATIVADO;
    const REG_DESATIVADO_Name = 'REG_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_REG)

end.
