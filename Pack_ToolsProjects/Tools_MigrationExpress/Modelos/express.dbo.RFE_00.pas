unit express.dbo.RFE_00;

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
  [Table('RFE_00', '')]
  [PrimaryKey('RFE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RFE_ID')]
  TDtoRFE_00 = class
  private
    { Private declarations } 
    FRFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FRFE_DATARUPTURA: TDateTime;
    FRFE_QTDENTRADA: Double;
    FRFE_QTDSAIDA: Double;
    FRFE_SALDO: Double;
    FRFE_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'RFE_00';
     const PrimaryKey = 'RFE_ID';
     const Sequence   = 'SEQ_RFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFE_ID', ftInteger)]
    [Dictionary('RFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFE_ID: Integer read FRFE_ID write FRFE_ID;
    const RFE_ID_Name = 'RFE_ID';

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
    [Column('RFE_DATARUPTURA', ftDateTime)]
    [Dictionary('RFE_DATARUPTURA', 'Mensagem de validação', '', '', '', taCenter)]
    property RFE_DATARUPTURA: TDateTime read FRFE_DATARUPTURA write FRFE_DATARUPTURA;
    const RFE_DATARUPTURA_Name = 'RFE_DATARUPTURA';

    [Restrictions([NoValidate])]
    [Column('RFE_QTDENTRADA', ftBCD, 1869770784, 2)]
    [Dictionary('RFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFE_QTDENTRADA: Double read FRFE_QTDENTRADA write FRFE_QTDENTRADA;
    const RFE_QTDENTRADA_Name = 'RFE_QTDENTRADA';

    [Restrictions([NoValidate])]
    [Column('RFE_QTDSAIDA', ftBCD, 1529377646, 2)]
    [Dictionary('RFE_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFE_QTDSAIDA: Double read FRFE_QTDSAIDA write FRFE_QTDSAIDA;
    const RFE_QTDSAIDA_Name = 'RFE_QTDSAIDA';

    [Restrictions([NoValidate])]
    [Column('RFE_SALDO', ftBCD, 4522064, 2)]
    [Dictionary('RFE_SALDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFE_SALDO: Double read FRFE_SALDO write FRFE_SALDO;
    const RFE_SALDO_Name = 'RFE_SALDO';

    [Restrictions([NoValidate])]
    [Column('RFE_ID_OLD', ftInteger)]
    [Dictionary('RFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFE_ID_OLD: Integer read FRFE_ID_OLD write FRFE_ID_OLD;
    const RFE_ID_OLD_Name = 'RFE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRFE_00)

end.
