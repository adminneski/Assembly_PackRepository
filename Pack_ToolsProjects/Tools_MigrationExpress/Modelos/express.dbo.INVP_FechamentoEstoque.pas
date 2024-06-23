unit express.dbo.INVP_FECHAMENTOESTOQUE;

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
  [Table('INVP_FechamentoEstoque', '')]
  TDtoINVP_FechamentoEstoque = class
  private
    { Private declarations } 
    FINVP_TIPOMOVTO: String;
    FINVP_SIGLA: String;
    FINVP_ORDEM: Integer;
    FINVP_DATA: TDateTime;
    FINVP_NUMERODOCTO: String;
    FPES_CODIGO: Integer;
    FINVP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FCST_CODIGO: String;
    FINVP_QUANTIDADE: Double;
    FINVP_VALORCUSTOARMAZENAGEM: Double;
    FINVP_VALORCUSTOARMAZENAGEMMEDIO: Double;
    FINVP_TIPOPOSSE: String;
  public 
    { Public declarations } 
     const Table      = 'INVP_FechamentoEstoque';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_TIPOMOVTO', ftString, 25)]
    [Dictionary('INVP_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_TIPOMOVTO: String read FINVP_TIPOMOVTO write FINVP_TIPOMOVTO;
    const INVP_TIPOMOVTO_Name = 'INVP_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_SIGLA', ftString, 3)]
    [Dictionary('INVP_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_SIGLA: String read FINVP_SIGLA write FINVP_SIGLA;
    const INVP_SIGLA_Name = 'INVP_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_ORDEM', ftInteger)]
    [Dictionary('INVP_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ORDEM: Integer read FINVP_ORDEM write FINVP_ORDEM;
    const INVP_ORDEM_Name = 'INVP_ORDEM';

    [Restrictions([NoValidate])]
    [Column('INVP_DATA', ftDateTime)]
    [Dictionary('INVP_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property INVP_DATA: TDateTime read FINVP_DATA write FINVP_DATA;
    const INVP_DATA_Name = 'INVP_DATA';

    [Restrictions([NoValidate])]
    [Column('INVP_NUMERODOCTO', ftString, 9)]
    [Dictionary('INVP_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_NUMERODOCTO: String read FINVP_NUMERODOCTO write FINVP_NUMERODOCTO;
    const INVP_NUMERODOCTO_Name = 'INVP_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_ID', ftInteger)]
    [Dictionary('INVP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ID: Integer read FINVP_ID write FINVP_ID;
    const INVP_ID_Name = 'INVP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_QUANTIDADE', ftBCD, 18, 4)]
    [Dictionary('INVP_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_QUANTIDADE: Double read FINVP_QUANTIDADE write FINVP_QUANTIDADE;
    const INVP_QUANTIDADE_Name = 'INVP_QUANTIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_VALORCUSTOARMAZENAGEM', ftBCD, 2, 2)]
    [Dictionary('INVP_VALORCUSTOARMAZENAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_VALORCUSTOARMAZENAGEM: Double read FINVP_VALORCUSTOARMAZENAGEM write FINVP_VALORCUSTOARMAZENAGEM;
    const INVP_VALORCUSTOARMAZENAGEM_Name = 'INVP_VALORCUSTOARMAZENAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_VALORCUSTOARMAZENAGEMMEDIO', ftBCD, 2, 2)]
    [Dictionary('INVP_VALORCUSTOARMAZENAGEMMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_VALORCUSTOARMAZENAGEMMEDIO: Double read FINVP_VALORCUSTOARMAZENAGEMMEDIO write FINVP_VALORCUSTOARMAZENAGEMMEDIO;
    const INVP_VALORCUSTOARMAZENAGEMMEDIO_Name = 'INVP_VALORCUSTOARMAZENAGEMMEDIO';

    [Restrictions([NoValidate])]
    [Column('INVP_TIPOPOSSE', ftString, 1)]
    [Dictionary('INVP_TIPOPOSSE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_TIPOPOSSE: String read FINVP_TIPOPOSSE write FINVP_TIPOPOSSE;
    const INVP_TIPOPOSSE_Name = 'INVP_TIPOPOSSE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoINVP_FechamentoEstoque)

end.
