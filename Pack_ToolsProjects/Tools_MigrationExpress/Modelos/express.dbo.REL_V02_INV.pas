unit express.dbo.REL_V02_INV;

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
  [Table('REL_V02_INV', '')]
  TDtoREL_V02_INV = class
  private
    { Private declarations } 
    FINV_ES: String;
    FINV_TIPOMOVTO: String;
    FINV_SIGLA: String;
    FINV_SIGLA2: String;
    FINV_DATA: TDateTime;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FGRP_CODIGO: Integer;
    FINV_QTDENTRADA: Double;
    FINV_QTDSAIDA: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_INV';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ES', ftString, 1)]
    [Dictionary('INV_ES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_ES: String read FINV_ES write FINV_ES;
    const INV_ES_Name = 'INV_ES';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_TIPOMOVTO', ftString, 43)]
    [Dictionary('INV_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_TIPOMOVTO: String read FINV_TIPOMOVTO write FINV_TIPOMOVTO;
    const INV_TIPOMOVTO_Name = 'INV_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SIGLA', ftString, 3)]
    [Dictionary('INV_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SIGLA: String read FINV_SIGLA write FINV_SIGLA;
    const INV_SIGLA_Name = 'INV_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SIGLA2', ftString, 3)]
    [Dictionary('INV_SIGLA2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SIGLA2: String read FINV_SIGLA2 write FINV_SIGLA2;
    const INV_SIGLA2_Name = 'INV_SIGLA2';

    [Restrictions([NoValidate])]
    [Column('INV_DATA', ftDateTime)]
    [Dictionary('INV_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATA: TDateTime read FINV_DATA write FINV_DATA;
    const INV_DATA_Name = 'INV_DATA';

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
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('INV_QTDENTRADA', ftBCD, 66260064, 4)]
    [Dictionary('INV_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDENTRADA: Double read FINV_QTDENTRADA write FINV_QTDENTRADA;
    const INV_QTDENTRADA_Name = 'INV_QTDENTRADA';

    [Restrictions([NoValidate])]
    [Column('INV_QTDSAIDA', ftBCD)]
    [Dictionary('INV_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QTDSAIDA: Double read FINV_QTDSAIDA write FINV_QTDSAIDA;
    const INV_QTDSAIDA_Name = 'INV_QTDSAIDA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_INV)

end.
