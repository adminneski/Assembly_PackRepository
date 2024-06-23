unit express.dbo.PSQ_XX_01;

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
  [Table('PSQ_XX_01', '')]
  [PrimaryKey('PSQ_OPERADOR', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PSQ_OPERADOR')]
  TDtoPSQ_XX_01 = class
  private
    { Private declarations } 
    FPSQ_OPERADOR: String;
    FPSQ_NOMEOPERADORE: String;
    FPSQ_LOGICO: String;
  public 
    { Public declarations } 
     const Table      = 'PSQ_XX_01';
     const PrimaryKey = 'PSQ_OPERADOR';
     const Sequence   = 'SEQ_PSQ_OPERADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PSQ_OPERADOR', ftString, 10)]
    [Dictionary('PSQ_OPERADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_OPERADOR: String read FPSQ_OPERADOR write FPSQ_OPERADOR;
    const PSQ_OPERADOR_Name = 'PSQ_OPERADOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PSQ_NOMEOPERADORE', ftString, 50)]
    [Dictionary('PSQ_NOMEOPERADORE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_NOMEOPERADORE: String read FPSQ_NOMEOPERADORE write FPSQ_NOMEOPERADORE;
    const PSQ_NOMEOPERADORE_Name = 'PSQ_NOMEOPERADORE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PSQ_LOGICO', ftString, 1)]
    [Dictionary('PSQ_LOGICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_LOGICO: String read FPSQ_LOGICO write FPSQ_LOGICO;
    const PSQ_LOGICO_Name = 'PSQ_LOGICO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPSQ_XX_01)

end.
