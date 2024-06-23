unit express.dbo.REL_V02_SCR;

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
  [Table('REL_V02_SCR', '')]
  TDtoREL_V02_SCR = class
  private
    { Private declarations } 
    FSCR_TIPODOCUMENTO: String;
    FSCR_ID: Integer;
    FCOM_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FSCR_DATALANCAMENTO: TDateTime;
    FSCR_NUMERODOCTO: String;
    FSCR_NUMEROCHEQUE: String;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FSCR_DATAEMISSAO: TDateTime;
    FSCR_DATAVENCTO: TDateTime;
    FSCR_TOTALVALOR: Double;
    FBCO_CODIGO: Integer;
    FBCO_NOME: String;
    FSCR_EMITENTE_ADMCARTAO: String;
    FUSERS_LOGIN: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_SCR';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('SCR_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_TIPODOCUMENTO: String read FSCR_TIPODOCUMENTO write FSCR_TIPODOCUMENTO;
    const SCR_TIPODOCUMENTO_Name = 'SCR_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_ID', ftInteger)]
    [Dictionary('SCR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SCR_ID: Integer read FSCR_ID write FSCR_ID;
    const SCR_ID_Name = 'SCR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('SCR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('SCR_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property SCR_DATALANCAMENTO: TDateTime read FSCR_DATALANCAMENTO write FSCR_DATALANCAMENTO;
    const SCR_DATALANCAMENTO_Name = 'SCR_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('SCR_NUMERODOCTO', ftString, 20)]
    [Dictionary('SCR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMERODOCTO: String read FSCR_NUMERODOCTO write FSCR_NUMERODOCTO;
    const SCR_NUMERODOCTO_Name = 'SCR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('SCR_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('SCR_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_NUMEROCHEQUE: String read FSCR_NUMEROCHEQUE write FSCR_NUMEROCHEQUE;
    const SCR_NUMEROCHEQUE_Name = 'SCR_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAEMISSAO', ftDateTime)]
    [Dictionary('SCR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAEMISSAO: TDateTime read FSCR_DATAEMISSAO write FSCR_DATAEMISSAO;
    const SCR_DATAEMISSAO_Name = 'SCR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_DATAVENCTO', ftDateTime)]
    [Dictionary('SCR_DATAVENCTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SCR_DATAVENCTO: TDateTime read FSCR_DATAVENCTO write FSCR_DATAVENCTO;
    const SCR_DATAVENCTO_Name = 'SCR_DATAVENCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SCR_TOTALVALOR', ftBCD)]
    [Dictionary('SCR_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property SCR_TOTALVALOR: Double read FSCR_TOTALVALOR write FSCR_TOTALVALOR;
    const SCR_TOTALVALOR_Name = 'SCR_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('SCR_EMITENTE_ADMCARTAO', ftString, 50)]
    [Dictionary('SCR_EMITENTE_ADMCARTAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SCR_EMITENTE_ADMCARTAO: String read FSCR_EMITENTE_ADMCARTAO write FSCR_EMITENTE_ADMCARTAO;
    const SCR_EMITENTE_ADMCARTAO_Name = 'SCR_EMITENTE_ADMCARTAO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_SCR)

end.
