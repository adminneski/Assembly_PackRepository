unit express.dbo.FUN_00;

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
  [Table('FUN_00', '')]
  [PrimaryKey('FUN_CONTROLE', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FUN_CONTROLE')]
  TDtoFUN_00 = class
  private
    { Private declarations } 
    FFUN_CONTROLE: Integer;
    FFUN_TELA: String;
    FFUN_POSITION: Integer;
    FFUN_DESCRICAO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'FUN_00';
     const PrimaryKey = 'FUN_CONTROLE';
     const Sequence   = 'SEQ_FUN_CONTROLE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FUN_CONTROLE', ftInteger)]
    [Dictionary('FUN_CONTROLE', 'Mensagem de validação', '0', '', '', taCenter)]
    property FUN_CONTROLE: Integer read FFUN_CONTROLE write FFUN_CONTROLE;
    const FUN_CONTROLE_Name = 'FUN_CONTROLE';

    [Restrictions([NoValidate])]
    [Column('FUN_TELA', ftString, 10)]
    [Dictionary('FUN_TELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FUN_TELA: String read FFUN_TELA write FFUN_TELA;
    const FUN_TELA_Name = 'FUN_TELA';

    [Restrictions([NoValidate])]
    [Column('FUN_POSITION', ftInteger)]
    [Dictionary('FUN_POSITION', 'Mensagem de validação', '0', '', '', taCenter)]
    property FUN_POSITION: Integer read FFUN_POSITION write FFUN_POSITION;
    const FUN_POSITION_Name = 'FUN_POSITION';

    [Restrictions([NoValidate])]
    [Column('FUN_DESCRICAO', ftString, 100)]
    [Dictionary('FUN_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FUN_DESCRICAO: String read FFUN_DESCRICAO write FFUN_DESCRICAO;
    const FUN_DESCRICAO_Name = 'FUN_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFUN_00)

end.
