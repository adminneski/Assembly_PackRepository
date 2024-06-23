unit express.dbo.EXP_LFE_CONTABIL_FPG;

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
  [Table('EXP_LFE_Contabil_FPG', '')]
  TDtoEXP_LFE_Contabil_FPG = class
  private
    { Private declarations } 
    FLFE_SIGLA: String;
    FLFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFE_TIPOPAGAMENTO: Integer;
    FLFE_NUMERODOCTO: String;
    FLFE_NUMEROPARCELA: Integer;
    FLFE_VALORPARCELA: Double;
    FLFE_DATAVENCIMENTO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'EXP_LFE_Contabil_FPG';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_SIGLA', ftString, 3)]
    [Dictionary('LFE_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_SIGLA: String read FLFE_SIGLA write FLFE_SIGLA;
    const LFE_SIGLA_Name = 'LFE_SIGLA';

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

    [Restrictions([NoValidate])]
    [Column('LFE_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('LFE_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_TIPOPAGAMENTO: Integer read FLFE_TIPOPAGAMENTO write FLFE_TIPOPAGAMENTO;
    const LFE_TIPOPAGAMENTO_Name = 'LFE_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFE_NUMERODOCTO', ftString, 15)]
    [Dictionary('LFE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFE_NUMERODOCTO: String read FLFE_NUMERODOCTO write FLFE_NUMERODOCTO;
    const LFE_NUMERODOCTO_Name = 'LFE_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_NUMEROPARCELA', ftInteger)]
    [Dictionary('LFE_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFE_NUMEROPARCELA: Integer read FLFE_NUMEROPARCELA write FLFE_NUMEROPARCELA;
    const LFE_NUMEROPARCELA_Name = 'LFE_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFE_VALORPARCELA', ftBCD)]
    [Dictionary('LFE_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFE_VALORPARCELA: Double read FLFE_VALORPARCELA write FLFE_VALORPARCELA;
    const LFE_VALORPARCELA_Name = 'LFE_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('LFE_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('LFE_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFE_DATAVENCIMENTO: TDateTime read FLFE_DATAVENCIMENTO write FLFE_DATAVENCIMENTO;
    const LFE_DATAVENCIMENTO_Name = 'LFE_DATAVENCIMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_LFE_Contabil_FPG)

end.
