unit express.dbo.BLC_00;

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
  [Table('BLC_00', '')]
  [PrimaryKey('BLC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BLC_ID')]
  TDtoBLC_00 = class
  private
    { Private declarations } 
    FBLC_ID: Integer;
    FCOM_CODIGO: Integer;
    FBLC_DATABALANCO: TDateTime;
    FPES_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_CODIGOBARRA: String;
    FBLC_SALDOESTOQUE: Double;
    FBLC_DESATIVADO: String;
    FBLC_DATAALTERACAO: TDateTime;
    FBLC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'BLC_00';
     const PrimaryKey = 'BLC_ID';
     const Sequence   = 'SEQ_BLC_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('BLC_DATABALANCO', ftDateTime)]
    [Dictionary('BLC_DATABALANCO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BLC_DATABALANCO: TDateTime read FBLC_DATABALANCO write FBLC_DATABALANCO;
    const BLC_DATABALANCO_Name = 'BLC_DATABALANCO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOBARRA', ftString, 14)]
    [Dictionary('PRO_CODIGOBARRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOBARRA: String read FPRO_CODIGOBARRA write FPRO_CODIGOBARRA;
    const PRO_CODIGOBARRA_Name = 'PRO_CODIGOBARRA';

    [Restrictions([NoValidate])]
    [Column('BLC_SALDOESTOQUE', ftBCD)]
    [Dictionary('BLC_SALDOESTOQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BLC_SALDOESTOQUE: Double read FBLC_SALDOESTOQUE write FBLC_SALDOESTOQUE;
    const BLC_SALDOESTOQUE_Name = 'BLC_SALDOESTOQUE';

    [Restrictions([NoValidate])]
    [Column('BLC_DESATIVADO', ftString, 1)]
    [Dictionary('BLC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BLC_DESATIVADO: String read FBLC_DESATIVADO write FBLC_DESATIVADO;
    const BLC_DESATIVADO_Name = 'BLC_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('BLC_DATAALTERACAO', ftDateTime)]
    [Dictionary('BLC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property BLC_DATAALTERACAO: TDateTime read FBLC_DATAALTERACAO write FBLC_DATAALTERACAO;
    const BLC_DATAALTERACAO_Name = 'BLC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BLC_ID_OLD', ftInteger)]
    [Dictionary('BLC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BLC_ID_OLD: Integer read FBLC_ID_OLD write FBLC_ID_OLD;
    const BLC_ID_OLD_Name = 'BLC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBLC_00)

end.
