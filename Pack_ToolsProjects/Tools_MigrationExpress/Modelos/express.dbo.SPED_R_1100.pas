unit express.dbo.SPED_R_1100;

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
  [Table('SPED_R_1100', '')]
  TDtoSPED_R_1100 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FTIPO_DOC: String;
    FNUM_DOC: String;
    FID_DOC: Integer;
    FIND_DOC: String;
    FNRO_DE: String;
    FDT_DE: TDateTime;
    FNAT_EXP: String;
    FNRO_RE: String;
    FDT_RE: TDateTime;
    FCHC_EMB: String;
    FDT_CHC: TDateTime;
    FDT_AVB: TDateTime;
    FTP_CHC: String;
    FPAIS: String;
  public 
    { Public declarations } 
     const Table      = 'SPED_R_1100';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO_DOC', ftString, 3)]
    [Dictionary('TIPO_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_DOC: String read FTIPO_DOC write FTIPO_DOC;
    const TIPO_DOC_Name = 'TIPO_DOC';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ID_DOC', ftInteger)]
    [Dictionary('ID_DOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ID_DOC: Integer read FID_DOC write FID_DOC;
    const ID_DOC_Name = 'ID_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('IND_DOC', ftString, 1)]
    [Dictionary('IND_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IND_DOC: String read FIND_DOC write FIND_DOC;
    const IND_DOC_Name = 'IND_DOC';

    [Restrictions([NoValidate])]
    [Column('NRO_DE', ftString, 11)]
    [Dictionary('NRO_DE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NRO_DE: String read FNRO_DE write FNRO_DE;
    const NRO_DE_Name = 'NRO_DE';

    [Restrictions([NoValidate])]
    [Column('DT_DE', ftDateTime)]
    [Dictionary('DT_DE', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DE: TDateTime read FDT_DE write FDT_DE;
    const DT_DE_Name = 'DT_DE';

    [Restrictions([NoValidate])]
    [Column('NAT_EXP', ftString, 1)]
    [Dictionary('NAT_EXP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NAT_EXP: String read FNAT_EXP write FNAT_EXP;
    const NAT_EXP_Name = 'NAT_EXP';

    [Restrictions([NoValidate])]
    [Column('NRO_RE', ftString, 12)]
    [Dictionary('NRO_RE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NRO_RE: String read FNRO_RE write FNRO_RE;
    const NRO_RE_Name = 'NRO_RE';

    [Restrictions([NoValidate])]
    [Column('DT_RE', ftDateTime)]
    [Dictionary('DT_RE', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_RE: TDateTime read FDT_RE write FDT_RE;
    const DT_RE_Name = 'DT_RE';

    [Restrictions([NoValidate])]
    [Column('CHC_EMB', ftString, 16)]
    [Dictionary('CHC_EMB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CHC_EMB: String read FCHC_EMB write FCHC_EMB;
    const CHC_EMB_Name = 'CHC_EMB';

    [Restrictions([NoValidate])]
    [Column('DT_CHC', ftDateTime)]
    [Dictionary('DT_CHC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_CHC: TDateTime read FDT_CHC write FDT_CHC;
    const DT_CHC_Name = 'DT_CHC';

    [Restrictions([NoValidate])]
    [Column('DT_AVB', ftDateTime)]
    [Dictionary('DT_AVB', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_AVB: TDateTime read FDT_AVB write FDT_AVB;
    const DT_AVB_Name = 'DT_AVB';

    [Restrictions([NoValidate])]
    [Column('TP_CHC', ftString, 2)]
    [Dictionary('TP_CHC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TP_CHC: String read FTP_CHC write FTP_CHC;
    const TP_CHC_Name = 'TP_CHC';

    [Restrictions([NoValidate])]
    [Column('PAIS', ftString, 4)]
    [Dictionary('PAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PAIS: String read FPAIS write FPAIS;
    const PAIS_Name = 'PAIS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPED_R_1100)

end.
