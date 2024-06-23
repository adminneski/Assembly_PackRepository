unit express.dbo.VW_PSQ_BLC;

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
  [Table('VW_PSQ_BLC', '')]
  TDtoVW_PSQ_BLC = class
  private
    { Private declarations } 
    FBLC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FBLC_DATABALANCO: TDateTime;
    FPRO_DESCRICAO: String;
    FPES_NOME: String;
    FBLC_SALDOESTOQUE: Double;
    FPRO_CODIGOBARRA: String;
    FBLC_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_BLC';

    [Restrictions([NoValidate, NotNull])]
    [Column('BLC_ID', ftInteger)]
    [Dictionary('BLC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BLC_ID: Integer read FBLC_ID write FBLC_ID;
    const BLC_ID_Name = 'BLC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BLC_DATABALANCO', ftDateTime)]
    [Dictionary('BLC_DATABALANCO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BLC_DATABALANCO: TDateTime read FBLC_DATABALANCO write FBLC_DATABALANCO;
    const BLC_DATABALANCO_Name = 'BLC_DATABALANCO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('BLC_SALDOESTOQUE', ftBCD)]
    [Dictionary('BLC_SALDOESTOQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BLC_SALDOESTOQUE: Double read FBLC_SALDOESTOQUE write FBLC_SALDOESTOQUE;
    const BLC_SALDOESTOQUE_Name = 'BLC_SALDOESTOQUE';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA', ftString, 14)]
    [Dictionary('PRO_CODIGOBARRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA: String read FPRO_CODIGOBARRA write FPRO_CODIGOBARRA;
    const PRO_CODIGOBARRA_Name = 'PRO_CODIGOBARRA';

    [Restrictions([NoValidate])]
    [Column('BLC_DESATIVADO', ftString, 1)]
    [Dictionary('BLC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BLC_DESATIVADO: String read FBLC_DESATIVADO write FBLC_DESATIVADO;
    const BLC_DESATIVADO_Name = 'BLC_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_BLC)

end.
