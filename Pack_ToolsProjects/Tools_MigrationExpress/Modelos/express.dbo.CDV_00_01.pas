unit express.dbo.CDV_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cdv_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CDV_00_01', '')]
  [PrimaryKey('CDV_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CDV_01_ID')]
  TDtoCDV_00_01 = class
  private
    { Private declarations } 
    FCDV_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCDV_ID: Integer;
    FDSP_CODIGO: Integer;
    FCDV_VALORDESPESAS: Double;
    FCDV_DATAALTERACAO: TDateTime;
    FCDV_DATADOCTO: TDateTime;
    FCDV_KMHORIMETRO: Integer;
    FCDV_NUMERODOCTO: String;
    FCDV_QTDLITROS: Double;
    FCDV_ROTA: String;
    FCDV_TIPOBOMBA: String;
    FCDV_01_ID_OLD: Integer;
    FCDV_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CDV_00_01';
    const PrimaryKey = 'CDV_01_ID';
    const Sequence   = 'SEQ_CDV_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDV_01_ID', ftInteger)]
    [Dictionary('CDV_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_01_ID: Integer read FCDV_01_ID write FCDV_01_ID;
    const CDV_01_ID_Name = 'CDV_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDV_ID', ftInteger)]
    [ForeignKey('CDV_00_01_fk', 'CDV_ID', 'CDV_00', 'CDV_ID', SetNull, SetNull)]
    [Dictionary('CDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_ID: Integer read FCDV_ID write FCDV_ID;
    const CDV_ID_Name = 'CDV_ID';

    [Restrictions([NoValidate])]
    [Column('DSP_CODIGO', ftInteger)]
    [Dictionary('DSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property DSP_CODIGO: Integer read FDSP_CODIGO write FDSP_CODIGO;
    const DSP_CODIGO_Name = 'DSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CDV_VALORDESPESAS', ftBCD, 18, 4)]
    [Dictionary('CDV_VALORDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_VALORDESPESAS: Double read FCDV_VALORDESPESAS write FCDV_VALORDESPESAS;
    const CDV_VALORDESPESAS_Name = 'CDV_VALORDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CDV_DATAALTERACAO', ftDateTime)]
    [Dictionary('CDV_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CDV_DATAALTERACAO: TDateTime read FCDV_DATAALTERACAO write FCDV_DATAALTERACAO;
    const CDV_DATAALTERACAO_Name = 'CDV_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CDV_DATADOCTO', ftDateTime)]
    [Dictionary('CDV_DATADOCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CDV_DATADOCTO: TDateTime read FCDV_DATADOCTO write FCDV_DATADOCTO;
    const CDV_DATADOCTO_Name = 'CDV_DATADOCTO';

    [Restrictions([NoValidate])]
    [Column('CDV_KMHORIMETRO', ftInteger)]
    [Dictionary('CDV_KMHORIMETRO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_KMHORIMETRO: Integer read FCDV_KMHORIMETRO write FCDV_KMHORIMETRO;
    const CDV_KMHORIMETRO_Name = 'CDV_KMHORIMETRO';

    [Restrictions([NoValidate])]
    [Column('CDV_NUMERODOCTO', ftString, 10)]
    [Dictionary('CDV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_NUMERODOCTO: String read FCDV_NUMERODOCTO write FCDV_NUMERODOCTO;
    const CDV_NUMERODOCTO_Name = 'CDV_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CDV_QTDLITROS', ftBCD)]
    [Dictionary('CDV_QTDLITROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_QTDLITROS: Double read FCDV_QTDLITROS write FCDV_QTDLITROS;
    const CDV_QTDLITROS_Name = 'CDV_QTDLITROS';

    [Restrictions([NoValidate])]
    [Column('CDV_ROTA', ftString, 100)]
    [Dictionary('CDV_ROTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_ROTA: String read FCDV_ROTA write FCDV_ROTA;
    const CDV_ROTA_Name = 'CDV_ROTA';

    [Restrictions([NoValidate])]
    [Column('CDV_TIPOBOMBA', ftString, 1)]
    [Dictionary('CDV_TIPOBOMBA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_TIPOBOMBA: String read FCDV_TIPOBOMBA write FCDV_TIPOBOMBA;
    const CDV_TIPOBOMBA_Name = 'CDV_TIPOBOMBA';

    [Restrictions([NoValidate])]
    [Column('CDV_01_ID_OLD', ftInteger)]
    [Dictionary('CDV_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_01_ID_OLD: Integer read FCDV_01_ID_OLD write FCDV_01_ID_OLD;
    const CDV_01_ID_OLD_Name = 'CDV_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CDV_ID_OLD', ftInteger)]
    [Dictionary('CDV_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_ID_OLD: Integer read FCDV_ID_OLD write FCDV_ID_OLD;
    const CDV_ID_OLD_Name = 'CDV_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCDV_00_01)

end.
