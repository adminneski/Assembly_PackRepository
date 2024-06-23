unit express.dbo.ACT_XX;

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
  [Table('ACT_XX', '')]
  [PrimaryKey('ACT_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ACT_CODIGO')]
  TDtoACT_XX = class
  private
    { Private declarations } 
    FACT_CODIGO: Integer;
    FACT_CHAVE: String;
    FACT_SIGLA: String;
    FACT_TELA: String;
    FACT_DESCRICAO: String;
    FACT_TECLAATALHO: String;
    FACT_VISUALIZAR_MOD_NSK: String;
    FACT_VISUALIZAR_MOD_IND: String;
    FACT_VISUALIZAR_MOD_TRA: String;
    FACT_VISUALIZAR_MOD_ATA: String;
    FACT_VISUALIZAR_MOD_IGR: String;
    FACT_VISUALIZAR_MOD_SPL: String;
    FACT_VISUALIZAR_MOD_NGA: String;
    FACT_VISUALIZAR_MOD_ECF: String;
  public 
    { Public declarations } 
     const Table      = 'ACT_XX';
     const PrimaryKey = 'ACT_CODIGO';
     const Sequence   = 'SEQ_ACT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACT_CODIGO', ftInteger)]
    [Dictionary('ACT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACT_CODIGO: Integer read FACT_CODIGO write FACT_CODIGO;
    const ACT_CODIGO_Name = 'ACT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACT_CHAVE', ftString, 50)]
    [Dictionary('ACT_CHAVE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_CHAVE: String read FACT_CHAVE write FACT_CHAVE;
    const ACT_CHAVE_Name = 'ACT_CHAVE';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACT_SIGLA', ftString, 3)]
    [Dictionary('ACT_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_SIGLA: String read FACT_SIGLA write FACT_SIGLA;
    const ACT_SIGLA_Name = 'ACT_SIGLA';

    [Restrictions([NoValidate])]
    [Column('ACT_TELA', ftString, 10)]
    [Dictionary('ACT_TELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_TELA: String read FACT_TELA write FACT_TELA;
    const ACT_TELA_Name = 'ACT_TELA';

    [Restrictions([NoValidate])]
    [Column('ACT_DESCRICAO', ftString, 300)]
    [Dictionary('ACT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_DESCRICAO: String read FACT_DESCRICAO write FACT_DESCRICAO;
    const ACT_DESCRICAO_Name = 'ACT_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('ACT_TECLAATALHO', ftString, 20)]
    [Dictionary('ACT_TECLAATALHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_TECLAATALHO: String read FACT_TECLAATALHO write FACT_TECLAATALHO;
    const ACT_TECLAATALHO_Name = 'ACT_TECLAATALHO';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_NSK', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_NSK', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_NSK: String read FACT_VISUALIZAR_MOD_NSK write FACT_VISUALIZAR_MOD_NSK;
    const ACT_VISUALIZAR_MOD_NSK_Name = 'ACT_VISUALIZAR_MOD_NSK';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_IND', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_IND', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_IND: String read FACT_VISUALIZAR_MOD_IND write FACT_VISUALIZAR_MOD_IND;
    const ACT_VISUALIZAR_MOD_IND_Name = 'ACT_VISUALIZAR_MOD_IND';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_TRA', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_TRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_TRA: String read FACT_VISUALIZAR_MOD_TRA write FACT_VISUALIZAR_MOD_TRA;
    const ACT_VISUALIZAR_MOD_TRA_Name = 'ACT_VISUALIZAR_MOD_TRA';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_ATA', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_ATA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_ATA: String read FACT_VISUALIZAR_MOD_ATA write FACT_VISUALIZAR_MOD_ATA;
    const ACT_VISUALIZAR_MOD_ATA_Name = 'ACT_VISUALIZAR_MOD_ATA';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_IGR', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_IGR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_IGR: String read FACT_VISUALIZAR_MOD_IGR write FACT_VISUALIZAR_MOD_IGR;
    const ACT_VISUALIZAR_MOD_IGR_Name = 'ACT_VISUALIZAR_MOD_IGR';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_SPL', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_SPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_SPL: String read FACT_VISUALIZAR_MOD_SPL write FACT_VISUALIZAR_MOD_SPL;
    const ACT_VISUALIZAR_MOD_SPL_Name = 'ACT_VISUALIZAR_MOD_SPL';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_NGA', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_NGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_NGA: String read FACT_VISUALIZAR_MOD_NGA write FACT_VISUALIZAR_MOD_NGA;
    const ACT_VISUALIZAR_MOD_NGA_Name = 'ACT_VISUALIZAR_MOD_NGA';

    [Restrictions([NoValidate])]
    [Column('ACT_VISUALIZAR_MOD_ECF', ftString, 1)]
    [Dictionary('ACT_VISUALIZAR_MOD_ECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ACT_VISUALIZAR_MOD_ECF: String read FACT_VISUALIZAR_MOD_ECF write FACT_VISUALIZAR_MOD_ECF;
    const ACT_VISUALIZAR_MOD_ECF_Name = 'ACT_VISUALIZAR_MOD_ECF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoACT_XX)

end.
