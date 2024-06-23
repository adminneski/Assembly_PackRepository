unit express.dbo.TEMP_BCX_ANALISEHORIZONTAL;

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
  [Table('TEMP_BCX_ANALISEHORIZONTAL', '')]
  TDtoTEMP_BCX_ANALISEHORIZONTAL = class
  private
    { Private declarations } 
    FPLC_NIVEL: Integer;
    FPLC_CODIGO: Integer;
    FPLC_PLANOCONTA: String;
    FPLC_DESCRICAO: String;
    FPLC_SIGLA: String;
    FTOT_JANEIRO: Double;
    FTOT_FEVEREIRO: Double;
    FTOT_MARCO: Double;
    FTOT_ABRIL: Double;
    FTOT_MAIO: Double;
    FTOT_JUNHO: Double;
    FTOT_JULHO: Double;
    FTOT_AGOSTO: Double;
    FTOT_SETEMBRO: Double;
    FTOT_OUTUBRO: Double;
    FTOT_NOVEMBRO: Double;
    FTOT_DEZEMBRO: Double;
  public 
    { Public declarations } 
     const Table      = 'TEMP_BCX_ANALISEHORIZONTAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_NIVEL', ftInteger)]
    [Dictionary('PLC_NIVEL', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_NIVEL: Integer read FPLC_NIVEL write FPLC_NIVEL;
    const PLC_NIVEL_Name = 'PLC_NIVEL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_PLANOCONTA', ftString, 10)]
    [Dictionary('PLC_PLANOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_PLANOCONTA: String read FPLC_PLANOCONTA write FPLC_PLANOCONTA;
    const PLC_PLANOCONTA_Name = 'PLC_PLANOCONTA';

    [Restrictions([NoValidate])]
    [Column('PLC_DESCRICAO', ftString, 30)]
    [Dictionary('PLC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESCRICAO: String read FPLC_DESCRICAO write FPLC_DESCRICAO;
    const PLC_DESCRICAO_Name = 'PLC_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PLC_SIGLA', ftString, 3)]
    [Dictionary('PLC_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_SIGLA: String read FPLC_SIGLA write FPLC_SIGLA;
    const PLC_SIGLA_Name = 'PLC_SIGLA';

    [Restrictions([NoValidate])]
    [Column('TOT_JANEIRO', ftBCD, 4522064, 2)]
    [Dictionary('TOT_JANEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JANEIRO: Double read FTOT_JANEIRO write FTOT_JANEIRO;
    const TOT_JANEIRO_Name = 'TOT_JANEIRO';

    [Restrictions([NoValidate])]
    [Column('TOT_FEVEREIRO', ftBCD, 1869770784, 2)]
    [Dictionary('TOT_FEVEREIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_FEVEREIRO: Double read FTOT_FEVEREIRO write FTOT_FEVEREIRO;
    const TOT_FEVEREIRO_Name = 'TOT_FEVEREIRO';

    [Restrictions([NoValidate])]
    [Column('TOT_MARCO', ftBCD, 7077999, 2)]
    [Dictionary('TOT_MARCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_MARCO: Double read FTOT_MARCO write FTOT_MARCO;
    const TOT_MARCO_Name = 'TOT_MARCO';

    [Restrictions([NoValidate])]
    [Column('TOT_ABRIL', ftBCD, 1529377646, 2)]
    [Dictionary('TOT_ABRIL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_ABRIL: Double read FTOT_ABRIL write FTOT_ABRIL;
    const TOT_ABRIL_Name = 'TOT_ABRIL';

    [Restrictions([NoValidate])]
    [Column('TOT_MAIO', ftBCD, 544040295, 2)]
    [Dictionary('TOT_MAIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_MAIO: Double read FTOT_MAIO write FTOT_MAIO;
    const TOT_MAIO_Name = 'TOT_MAIO';

    [Restrictions([NoValidate])]
    [Column('TOT_JUNHO', ftBCD, 4456531, 2)]
    [Dictionary('TOT_JUNHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JUNHO: Double read FTOT_JUNHO write FTOT_JUNHO;
    const TOT_JUNHO_Name = 'TOT_JUNHO';

    [Restrictions([NoValidate])]
    [Column('TOT_JULHO', ftBCD, 1195983951, 2)]
    [Dictionary('TOT_JULHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JULHO: Double read FTOT_JULHO write FTOT_JULHO;
    const TOT_JULHO_Name = 'TOT_JULHO';

    [Restrictions([NoValidate])]
    [Column('TOT_AGOSTO', ftBCD, 1397311055, 2)]
    [Dictionary('TOT_AGOSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_AGOSTO: Double read FTOT_AGOSTO write FTOT_AGOSTO;
    const TOT_AGOSTO_Name = 'TOT_AGOSTO';

    [Restrictions([NoValidate])]
    [Column('TOT_SETEMBRO', ftBCD, 218762555, 2)]
    [Dictionary('TOT_SETEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_SETEMBRO: Double read FTOT_SETEMBRO write FTOT_SETEMBRO;
    const TOT_SETEMBRO_Name = 'TOT_SETEMBRO';

    [Restrictions([NoValidate])]
    [Column('TOT_OUTUBRO', ftBCD, 1952672068, 2)]
    [Dictionary('TOT_OUTUBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_OUTUBRO: Double read FTOT_OUTUBRO write FTOT_OUTUBRO;
    const TOT_OUTUBRO_Name = 'TOT_OUTUBRO';

    [Restrictions([NoValidate])]
    [Column('TOT_NOVEMBRO', ftBCD, 537529693, 2)]
    [Dictionary('TOT_NOVEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_NOVEMBRO: Double read FTOT_NOVEMBRO write FTOT_NOVEMBRO;
    const TOT_NOVEMBRO_Name = 'TOT_NOVEMBRO';

    [Restrictions([NoValidate])]
    [Column('TOT_DEZEMBRO', ftBCD, 1162039111, 2)]
    [Dictionary('TOT_DEZEMBRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_DEZEMBRO: Double read FTOT_DEZEMBRO write FTOT_DEZEMBRO;
    const TOT_DEZEMBRO_Name = 'TOT_DEZEMBRO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTEMP_BCX_ANALISEHORIZONTAL)

end.
