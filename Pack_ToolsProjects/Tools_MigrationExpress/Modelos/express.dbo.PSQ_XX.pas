unit express.dbo.PSQ_XX;

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
  [Table('PSQ_XX', '')]
  [PrimaryKey('PSQ_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PSQ_ID')]
  TDtoPSQ_XX = class
  private
    { Private declarations } 
    FPSQ_ID: Integer;
    FPSQ_SIGLA: String;
    FPSQ_NOMEPESQUISA: String;
    FPSQ_NOMETABELA: String;
    FPSQ_NOMETELA: String;
    FPSQ_ORDER: Integer;
    FPSQ_FIELDPESQUISA: String;
    FPSQ_MASKFIELD: String;
    FPSQ_PARTIALKEY: String;
    FPSQ_INTERVALO: String;
    FPSQ_TIPOCAMPO: String;
    FPSQ_VALORESPERMITIDOS: String;
    FPSQ_VALORPESQUISA01: String;
    FPSQ_VALORPESQUISA02: String;
    FPSQ_OPERADORES: String;
    FPSQ_OPERADORESLOGICOS: String;
    FPSQ_FILIAL: String;
    FPSQ_LEGENDA: String;
    FPSQ_VISUALIZAR_MOD_NSK: String;
    FPSQ_VISUALIZAR_MOD_IND: String;
    FPSQ_VISUALIZAR_MOD_TRA: String;
    FPSQ_VISUALIZAR_MOD_ATA: String;
    FPSQ_VISUALIZAR_MOD_IGR: String;
    FPSQ_VISUALIZAR_MOD_SPL: String;
    FPSQ_VISUALIZAR_MOD_NGA: String;
    FPSQ_VISUALIZAR_MOD_ECF: String;
  public 
    { Public declarations } 
     const Table      = 'PSQ_XX';
     const PrimaryKey = 'PSQ_ID';
     const Sequence   = 'SEQ_PSQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PSQ_ID', ftInteger)]
    [Dictionary('PSQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PSQ_ID: Integer read FPSQ_ID write FPSQ_ID;
    const PSQ_ID_Name = 'PSQ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PSQ_SIGLA', ftString, 3)]
    [Dictionary('PSQ_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_SIGLA: String read FPSQ_SIGLA write FPSQ_SIGLA;
    const PSQ_SIGLA_Name = 'PSQ_SIGLA';

    [Restrictions([NoValidate])]
    [Column('PSQ_NOMEPESQUISA', ftString, 50)]
    [Dictionary('PSQ_NOMEPESQUISA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_NOMEPESQUISA: String read FPSQ_NOMEPESQUISA write FPSQ_NOMEPESQUISA;
    const PSQ_NOMEPESQUISA_Name = 'PSQ_NOMEPESQUISA';

    [Restrictions([NoValidate])]
    [Column('PSQ_NOMETABELA', ftString, 50)]
    [Dictionary('PSQ_NOMETABELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_NOMETABELA: String read FPSQ_NOMETABELA write FPSQ_NOMETABELA;
    const PSQ_NOMETABELA_Name = 'PSQ_NOMETABELA';

    [Restrictions([NoValidate])]
    [Column('PSQ_NOMETELA', ftString, 10)]
    [Dictionary('PSQ_NOMETELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_NOMETELA: String read FPSQ_NOMETELA write FPSQ_NOMETELA;
    const PSQ_NOMETELA_Name = 'PSQ_NOMETELA';

    [Restrictions([NoValidate])]
    [Column('PSQ_ORDER', ftInteger)]
    [Dictionary('PSQ_ORDER', 'Mensagem de validação', '0', '', '', taCenter)]
    property PSQ_ORDER: Integer read FPSQ_ORDER write FPSQ_ORDER;
    const PSQ_ORDER_Name = 'PSQ_ORDER';

    [Restrictions([NoValidate])]
    [Column('PSQ_FIELDPESQUISA', ftString, 50)]
    [Dictionary('PSQ_FIELDPESQUISA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_FIELDPESQUISA: String read FPSQ_FIELDPESQUISA write FPSQ_FIELDPESQUISA;
    const PSQ_FIELDPESQUISA_Name = 'PSQ_FIELDPESQUISA';

    [Restrictions([NoValidate])]
    [Column('PSQ_MASKFIELD', ftString, 50)]
    [Dictionary('PSQ_MASKFIELD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_MASKFIELD: String read FPSQ_MASKFIELD write FPSQ_MASKFIELD;
    const PSQ_MASKFIELD_Name = 'PSQ_MASKFIELD';

    [Restrictions([NoValidate])]
    [Column('PSQ_PARTIALKEY', ftString, 1)]
    [Dictionary('PSQ_PARTIALKEY', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_PARTIALKEY: String read FPSQ_PARTIALKEY write FPSQ_PARTIALKEY;
    const PSQ_PARTIALKEY_Name = 'PSQ_PARTIALKEY';

    [Restrictions([NoValidate])]
    [Column('PSQ_INTERVALO', ftString, 1)]
    [Dictionary('PSQ_INTERVALO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_INTERVALO: String read FPSQ_INTERVALO write FPSQ_INTERVALO;
    const PSQ_INTERVALO_Name = 'PSQ_INTERVALO';

    [Restrictions([NoValidate])]
    [Column('PSQ_TIPOCAMPO', ftString, 30)]
    [Dictionary('PSQ_TIPOCAMPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_TIPOCAMPO: String read FPSQ_TIPOCAMPO write FPSQ_TIPOCAMPO;
    const PSQ_TIPOCAMPO_Name = 'PSQ_TIPOCAMPO';

    [Restrictions([NoValidate])]
    [Column('PSQ_VALORESPERMITIDOS', ftString, 100)]
    [Dictionary('PSQ_VALORESPERMITIDOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VALORESPERMITIDOS: String read FPSQ_VALORESPERMITIDOS write FPSQ_VALORESPERMITIDOS;
    const PSQ_VALORESPERMITIDOS_Name = 'PSQ_VALORESPERMITIDOS';

    [Restrictions([NoValidate])]
    [Column('PSQ_VALORPESQUISA01', ftString, 100)]
    [Dictionary('PSQ_VALORPESQUISA01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VALORPESQUISA01: String read FPSQ_VALORPESQUISA01 write FPSQ_VALORPESQUISA01;
    const PSQ_VALORPESQUISA01_Name = 'PSQ_VALORPESQUISA01';

    [Restrictions([NoValidate])]
    [Column('PSQ_VALORPESQUISA02', ftString, 100)]
    [Dictionary('PSQ_VALORPESQUISA02', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VALORPESQUISA02: String read FPSQ_VALORPESQUISA02 write FPSQ_VALORPESQUISA02;
    const PSQ_VALORPESQUISA02_Name = 'PSQ_VALORPESQUISA02';

    [Restrictions([NoValidate])]
    [Column('PSQ_OPERADORES', ftString, 10)]
    [Dictionary('PSQ_OPERADORES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_OPERADORES: String read FPSQ_OPERADORES write FPSQ_OPERADORES;
    const PSQ_OPERADORES_Name = 'PSQ_OPERADORES';

    [Restrictions([NoValidate])]
    [Column('PSQ_OPERADORESLOGICOS', ftString, 10)]
    [Dictionary('PSQ_OPERADORESLOGICOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_OPERADORESLOGICOS: String read FPSQ_OPERADORESLOGICOS write FPSQ_OPERADORESLOGICOS;
    const PSQ_OPERADORESLOGICOS_Name = 'PSQ_OPERADORESLOGICOS';

    [Restrictions([NoValidate])]
    [Column('PSQ_FILIAL', ftString, 1)]
    [Dictionary('PSQ_FILIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_FILIAL: String read FPSQ_FILIAL write FPSQ_FILIAL;
    const PSQ_FILIAL_Name = 'PSQ_FILIAL';

    [Restrictions([NoValidate])]
    [Column('PSQ_LEGENDA', ftString, 500)]
    [Dictionary('PSQ_LEGENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_LEGENDA: String read FPSQ_LEGENDA write FPSQ_LEGENDA;
    const PSQ_LEGENDA_Name = 'PSQ_LEGENDA';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_NSK', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_NSK', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_NSK: String read FPSQ_VISUALIZAR_MOD_NSK write FPSQ_VISUALIZAR_MOD_NSK;
    const PSQ_VISUALIZAR_MOD_NSK_Name = 'PSQ_VISUALIZAR_MOD_NSK';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_IND', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_IND', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_IND: String read FPSQ_VISUALIZAR_MOD_IND write FPSQ_VISUALIZAR_MOD_IND;
    const PSQ_VISUALIZAR_MOD_IND_Name = 'PSQ_VISUALIZAR_MOD_IND';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_TRA', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_TRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_TRA: String read FPSQ_VISUALIZAR_MOD_TRA write FPSQ_VISUALIZAR_MOD_TRA;
    const PSQ_VISUALIZAR_MOD_TRA_Name = 'PSQ_VISUALIZAR_MOD_TRA';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_ATA', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_ATA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_ATA: String read FPSQ_VISUALIZAR_MOD_ATA write FPSQ_VISUALIZAR_MOD_ATA;
    const PSQ_VISUALIZAR_MOD_ATA_Name = 'PSQ_VISUALIZAR_MOD_ATA';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_IGR', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_IGR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_IGR: String read FPSQ_VISUALIZAR_MOD_IGR write FPSQ_VISUALIZAR_MOD_IGR;
    const PSQ_VISUALIZAR_MOD_IGR_Name = 'PSQ_VISUALIZAR_MOD_IGR';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_SPL', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_SPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_SPL: String read FPSQ_VISUALIZAR_MOD_SPL write FPSQ_VISUALIZAR_MOD_SPL;
    const PSQ_VISUALIZAR_MOD_SPL_Name = 'PSQ_VISUALIZAR_MOD_SPL';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_NGA', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_NGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_NGA: String read FPSQ_VISUALIZAR_MOD_NGA write FPSQ_VISUALIZAR_MOD_NGA;
    const PSQ_VISUALIZAR_MOD_NGA_Name = 'PSQ_VISUALIZAR_MOD_NGA';

    [Restrictions([NoValidate])]
    [Column('PSQ_VISUALIZAR_MOD_ECF', ftString, 1)]
    [Dictionary('PSQ_VISUALIZAR_MOD_ECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PSQ_VISUALIZAR_MOD_ECF: String read FPSQ_VISUALIZAR_MOD_ECF write FPSQ_VISUALIZAR_MOD_ECF;
    const PSQ_VISUALIZAR_MOD_ECF_Name = 'PSQ_VISUALIZAR_MOD_ECF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPSQ_XX)

end.
