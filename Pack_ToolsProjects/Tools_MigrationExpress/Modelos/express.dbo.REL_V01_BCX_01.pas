unit express.dbo.REL_V01_BCX_01;

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
  [Table('REL_V01_BCX_01', '')]
  TDtoREL_V01_BCX_01 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FPLC_PLANOCONTA: String;
    FBCX_ANO: Integer;
    FBCX_MES: Integer;
    FTOT_JANEIRO_C: Double;
    FTOT_FEVEREIRO_C: Double;
    FTOT_MARCO_C: Double;
    FTOT_ABRIL_C: Double;
    FTOT_MAIO_C: Double;
    FTOT_JUNHO_C: Double;
    FTOT_JULHO_C: Double;
    FTOT_AGOSTO_C: Double;
    FTOT_SETEMBRO_C: Double;
    FTOT_OUTUBRO_C: Double;
    FTOT_NOVEMBRO_C: Double;
    FTOT_DEZEMBRO_C: Double;
    FTOT_JANEIRO_D: Double;
    FTOT_FEVEREIRO_D: Double;
    FTOT_MARCO_D: Double;
    FTOT_ABRIL_D: Double;
    FTOT_MAIO_D: Double;
    FTOT_JUNHO_D: Double;
    FTOT_JULHO_D: Double;
    FTOT_AGOSTO_D: Double;
    FTOT_SETEMBRO_D: Double;
    FTOT_OUTUBRO_D: Double;
    FTOT_NOVEMBRO_D: Double;
    FTOT_DEZEMBRO_D: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_BCX_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_PLANOCONTA', ftString, 10)]
    [Dictionary('PLC_PLANOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_PLANOCONTA: String read FPLC_PLANOCONTA write FPLC_PLANOCONTA;
    const PLC_PLANOCONTA_Name = 'PLC_PLANOCONTA';

    [Restrictions([NoValidate])]
    [Column('BCX_ANO', ftInteger)]
    [Dictionary('BCX_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ANO: Integer read FBCX_ANO write FBCX_ANO;
    const BCX_ANO_Name = 'BCX_ANO';

    [Restrictions([NoValidate])]
    [Column('BCX_MES', ftInteger)]
    [Dictionary('BCX_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_MES: Integer read FBCX_MES write FBCX_MES;
    const BCX_MES_Name = 'BCX_MES';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_JANEIRO_C', ftBCD)]
    [Dictionary('TOT_JANEIRO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JANEIRO_C: Double read FTOT_JANEIRO_C write FTOT_JANEIRO_C;
    const TOT_JANEIRO_C_Name = 'TOT_JANEIRO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_FEVEREIRO_C', ftBCD)]
    [Dictionary('TOT_FEVEREIRO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_FEVEREIRO_C: Double read FTOT_FEVEREIRO_C write FTOT_FEVEREIRO_C;
    const TOT_FEVEREIRO_C_Name = 'TOT_FEVEREIRO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_MARCO_C', ftBCD)]
    [Dictionary('TOT_MARCO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_MARCO_C: Double read FTOT_MARCO_C write FTOT_MARCO_C;
    const TOT_MARCO_C_Name = 'TOT_MARCO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_ABRIL_C', ftBCD)]
    [Dictionary('TOT_ABRIL_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_ABRIL_C: Double read FTOT_ABRIL_C write FTOT_ABRIL_C;
    const TOT_ABRIL_C_Name = 'TOT_ABRIL_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_MAIO_C', ftBCD, 48, 2)]
    [Dictionary('TOT_MAIO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_MAIO_C: Double read FTOT_MAIO_C write FTOT_MAIO_C;
    const TOT_MAIO_C_Name = 'TOT_MAIO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_JUNHO_C', ftBCD)]
    [Dictionary('TOT_JUNHO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JUNHO_C: Double read FTOT_JUNHO_C write FTOT_JUNHO_C;
    const TOT_JUNHO_C_Name = 'TOT_JUNHO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_JULHO_C', ftBCD)]
    [Dictionary('TOT_JULHO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JULHO_C: Double read FTOT_JULHO_C write FTOT_JULHO_C;
    const TOT_JULHO_C_Name = 'TOT_JULHO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_AGOSTO_C', ftBCD)]
    [Dictionary('TOT_AGOSTO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_AGOSTO_C: Double read FTOT_AGOSTO_C write FTOT_AGOSTO_C;
    const TOT_AGOSTO_C_Name = 'TOT_AGOSTO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_SETEMBRO_C', ftBCD)]
    [Dictionary('TOT_SETEMBRO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_SETEMBRO_C: Double read FTOT_SETEMBRO_C write FTOT_SETEMBRO_C;
    const TOT_SETEMBRO_C_Name = 'TOT_SETEMBRO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_OUTUBRO_C', ftBCD)]
    [Dictionary('TOT_OUTUBRO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_OUTUBRO_C: Double read FTOT_OUTUBRO_C write FTOT_OUTUBRO_C;
    const TOT_OUTUBRO_C_Name = 'TOT_OUTUBRO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_NOVEMBRO_C', ftBCD, 48, 2)]
    [Dictionary('TOT_NOVEMBRO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_NOVEMBRO_C: Double read FTOT_NOVEMBRO_C write FTOT_NOVEMBRO_C;
    const TOT_NOVEMBRO_C_Name = 'TOT_NOVEMBRO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_DEZEMBRO_C', ftBCD)]
    [Dictionary('TOT_DEZEMBRO_C', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_DEZEMBRO_C: Double read FTOT_DEZEMBRO_C write FTOT_DEZEMBRO_C;
    const TOT_DEZEMBRO_C_Name = 'TOT_DEZEMBRO_C';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_JANEIRO_D', ftBCD)]
    [Dictionary('TOT_JANEIRO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JANEIRO_D: Double read FTOT_JANEIRO_D write FTOT_JANEIRO_D;
    const TOT_JANEIRO_D_Name = 'TOT_JANEIRO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_FEVEREIRO_D', ftBCD)]
    [Dictionary('TOT_FEVEREIRO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_FEVEREIRO_D: Double read FTOT_FEVEREIRO_D write FTOT_FEVEREIRO_D;
    const TOT_FEVEREIRO_D_Name = 'TOT_FEVEREIRO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_MARCO_D', ftBCD)]
    [Dictionary('TOT_MARCO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_MARCO_D: Double read FTOT_MARCO_D write FTOT_MARCO_D;
    const TOT_MARCO_D_Name = 'TOT_MARCO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_ABRIL_D', ftBCD)]
    [Dictionary('TOT_ABRIL_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_ABRIL_D: Double read FTOT_ABRIL_D write FTOT_ABRIL_D;
    const TOT_ABRIL_D_Name = 'TOT_ABRIL_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_MAIO_D', ftBCD)]
    [Dictionary('TOT_MAIO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_MAIO_D: Double read FTOT_MAIO_D write FTOT_MAIO_D;
    const TOT_MAIO_D_Name = 'TOT_MAIO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_JUNHO_D', ftBCD)]
    [Dictionary('TOT_JUNHO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JUNHO_D: Double read FTOT_JUNHO_D write FTOT_JUNHO_D;
    const TOT_JUNHO_D_Name = 'TOT_JUNHO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_JULHO_D', ftBCD)]
    [Dictionary('TOT_JULHO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_JULHO_D: Double read FTOT_JULHO_D write FTOT_JULHO_D;
    const TOT_JULHO_D_Name = 'TOT_JULHO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_AGOSTO_D', ftBCD, 10, 2)]
    [Dictionary('TOT_AGOSTO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_AGOSTO_D: Double read FTOT_AGOSTO_D write FTOT_AGOSTO_D;
    const TOT_AGOSTO_D_Name = 'TOT_AGOSTO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_SETEMBRO_D', ftBCD)]
    [Dictionary('TOT_SETEMBRO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_SETEMBRO_D: Double read FTOT_SETEMBRO_D write FTOT_SETEMBRO_D;
    const TOT_SETEMBRO_D_Name = 'TOT_SETEMBRO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_OUTUBRO_D', ftBCD)]
    [Dictionary('TOT_OUTUBRO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_OUTUBRO_D: Double read FTOT_OUTUBRO_D write FTOT_OUTUBRO_D;
    const TOT_OUTUBRO_D_Name = 'TOT_OUTUBRO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_NOVEMBRO_D', ftBCD, 48, 2)]
    [Dictionary('TOT_NOVEMBRO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_NOVEMBRO_D: Double read FTOT_NOVEMBRO_D write FTOT_NOVEMBRO_D;
    const TOT_NOVEMBRO_D_Name = 'TOT_NOVEMBRO_D';

    [Restrictions([NoValidate, NotNull])]
    [Column('TOT_DEZEMBRO_D', ftBCD)]
    [Dictionary('TOT_DEZEMBRO_D', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TOT_DEZEMBRO_D: Double read FTOT_DEZEMBRO_D write FTOT_DEZEMBRO_D;
    const TOT_DEZEMBRO_D_Name = 'TOT_DEZEMBRO_D';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_BCX_01)

end.
