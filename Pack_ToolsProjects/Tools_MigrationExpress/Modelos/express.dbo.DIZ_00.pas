unit express.dbo.DIZ_00;

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
  [Table('DIZ_00', '')]
  [PrimaryKey('DIZ_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DIZ_ID')]
  TDtoDIZ_00 = class
  private
    { Private declarations } 
    FDIZ_ID: Integer;
    FDIZ_TURNO: String;
    FPES_CODIGO: Integer;
    FDIZ_MES: Integer;
    FDIZ_ANO: Integer;
    FDIZ_VALORPAGTO: Double;
    FDIZ_DATAPAGTO: TDateTime;
    FUSERS_LOGIN: String;
    FDIZ_DATAALTERACAO: TDateTime;
    FDIZ_ID_OLD: Integer;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'DIZ_00';
     const PrimaryKey = 'DIZ_ID';
     const Sequence   = 'SEQ_DIZ_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('DIZ_ID', ftInteger)]
    [Dictionary('DIZ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property DIZ_ID: Integer read FDIZ_ID write FDIZ_ID;
    const DIZ_ID_Name = 'DIZ_ID';

    [Restrictions([NoValidate])]
    [Column('DIZ_TURNO', ftString, 1)]
    [Dictionary('DIZ_TURNO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DIZ_TURNO: String read FDIZ_TURNO write FDIZ_TURNO;
    const DIZ_TURNO_Name = 'DIZ_TURNO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DIZ_MES', ftInteger)]
    [Dictionary('DIZ_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property DIZ_MES: Integer read FDIZ_MES write FDIZ_MES;
    const DIZ_MES_Name = 'DIZ_MES';

    [Restrictions([NoValidate])]
    [Column('DIZ_ANO', ftInteger)]
    [Dictionary('DIZ_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property DIZ_ANO: Integer read FDIZ_ANO write FDIZ_ANO;
    const DIZ_ANO_Name = 'DIZ_ANO';

    [Restrictions([NoValidate])]
    [Column('DIZ_VALORPAGTO', ftBCD)]
    [Dictionary('DIZ_VALORPAGTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property DIZ_VALORPAGTO: Double read FDIZ_VALORPAGTO write FDIZ_VALORPAGTO;
    const DIZ_VALORPAGTO_Name = 'DIZ_VALORPAGTO';

    [Restrictions([NoValidate])]
    [Column('DIZ_DATAPAGTO', ftDateTime)]
    [Dictionary('DIZ_DATAPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property DIZ_DATAPAGTO: TDateTime read FDIZ_DATAPAGTO write FDIZ_DATAPAGTO;
    const DIZ_DATAPAGTO_Name = 'DIZ_DATAPAGTO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('DIZ_DATAALTERACAO', ftDateTime)]
    [Dictionary('DIZ_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property DIZ_DATAALTERACAO: TDateTime read FDIZ_DATAALTERACAO write FDIZ_DATAALTERACAO;
    const DIZ_DATAALTERACAO_Name = 'DIZ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DIZ_ID_OLD', ftInteger)]
    [Dictionary('DIZ_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property DIZ_ID_OLD: Integer read FDIZ_ID_OLD write FDIZ_ID_OLD;
    const DIZ_ID_OLD_Name = 'DIZ_ID_OLD';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDIZ_00)

end.
