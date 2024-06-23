unit express.dbo.CTR_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ctr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CTR_00_04', '')]
  [PrimaryKey('CTR_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTR_04_ID')]
  TDtoCTR_00_04 = class
  private
    { Private declarations } 
    FCTR_04_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_DATAPREVISAOENTREGA: TDateTime;
    FCTR_NUMERODOCTO: String;
    FCTR_DESCRICAODOCTO: String;
    FCTR_VALORDOCTO: Double;
    FCTR_DATAALTERACAO: TDateTime;
    FCTR_04_ID_OLD: Integer;
    FCTR_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CTR_00_04';
    const PrimaryKey = 'CTR_04_ID';
    const Sequence   = 'SEQ_CTR_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_04_ID', ftInteger)]
    [Dictionary('CTR_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_04_ID: Integer read FCTR_04_ID write FCTR_04_ID;
    const CTR_04_ID_Name = 'CTR_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [ForeignKey('CTR_00_04_fk', 'CTR_ID', 'CTR_00', 'CTR_ID', SetNull, SetNull)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAPREVISAOENTREGA', ftDateTime)]
    [Dictionary('CTR_DATAPREVISAOENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAPREVISAOENTREGA: TDateTime read FCTR_DATAPREVISAOENTREGA write FCTR_DATAPREVISAOENTREGA;
    const CTR_DATAPREVISAOENTREGA_Name = 'CTR_DATAPREVISAOENTREGA';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 100)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CTR_DESCRICAODOCTO', ftString, 20)]
    [Dictionary('CTR_DESCRICAODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_DESCRICAODOCTO: String read FCTR_DESCRICAODOCTO write FCTR_DESCRICAODOCTO;
    const CTR_DESCRICAODOCTO_Name = 'CTR_DESCRICAODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_VALORDOCTO', ftBCD)]
    [Dictionary('CTR_VALORDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORDOCTO: Double read FCTR_VALORDOCTO write FCTR_VALORDOCTO;
    const CTR_VALORDOCTO_Name = 'CTR_VALORDOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAALTERACAO: TDateTime read FCTR_DATAALTERACAO write FCTR_DATAALTERACAO;
    const CTR_DATAALTERACAO_Name = 'CTR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_04_ID_OLD', ftInteger)]
    [Dictionary('CTR_04_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_04_ID_OLD: Integer read FCTR_04_ID_OLD write FCTR_04_ID_OLD;
    const CTR_04_ID_OLD_Name = 'CTR_04_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_00_04)

end.
