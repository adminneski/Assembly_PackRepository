unit express.dbo.REL_V02_LFE;

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
  [Table('REL_V02_LFE', '')]
  TDtoREL_V02_LFE = class
  private
    { Private declarations } 
    FLFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_DATAENTRADA: TDateTime;
    FPES_CODIGO: Integer;
    FPES_UF: String;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FLFE_VALORITEM: Double;
    FLFE_VALORPIS: Double;
    FLFE_VALORCOFINS: Double;
    FLFE_VALORBCALCULOPISCOFINS: Double;
    FLFE_VALORBASEISENTOPISCOFINS: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_LFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_ID', ftInteger)]
    [Dictionary('LFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_ID: Integer read FLFE_ID write FLFE_ID;
    const LFE_ID_Name = 'LFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_DATAENTRADA', ftDateTime)]
    [Dictionary('LFE_DATAENTRADA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFE_DATAENTRADA: TDateTime read FLFE_DATAENTRADA write FLFE_DATAENTRADA;
    const LFE_DATAENTRADA_Name = 'LFE_DATAENTRADA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORITEM', ftBCD)]
    [Dictionary('LFE_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORITEM: Double read FLFE_VALORITEM write FLFE_VALORITEM;
    const LFE_VALORITEM_Name = 'LFE_VALORITEM';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORPIS', ftBCD)]
    [Dictionary('LFE_VALORPIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORPIS: Double read FLFE_VALORPIS write FLFE_VALORPIS;
    const LFE_VALORPIS_Name = 'LFE_VALORPIS';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORCOFINS', ftBCD)]
    [Dictionary('LFE_VALORCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORCOFINS: Double read FLFE_VALORCOFINS write FLFE_VALORCOFINS;
    const LFE_VALORCOFINS_Name = 'LFE_VALORCOFINS';

    [Restrictions([NoValidate])]
    [Column('LFE_VALORBCALCULOPISCOFINS', ftBCD, 48, 2)]
    [Dictionary('LFE_VALORBCALCULOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBCALCULOPISCOFINS: Double read FLFE_VALORBCALCULOPISCOFINS write FLFE_VALORBCALCULOPISCOFINS;
    const LFE_VALORBCALCULOPISCOFINS_Name = 'LFE_VALORBCALCULOPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORBASEISENTOPISCOFINS', ftBCD)]
    [Dictionary('LFE_VALORBASEISENTOPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORBASEISENTOPISCOFINS: Double read FLFE_VALORBASEISENTOPISCOFINS write FLFE_VALORBASEISENTOPISCOFINS;
    const LFE_VALORBASEISENTOPISCOFINS_Name = 'LFE_VALORBASEISENTOPISCOFINS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_LFE)

end.
