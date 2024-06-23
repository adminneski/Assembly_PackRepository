unit express.dbo.FCM_00;

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
  [Table('FCM_00', '')]
  [PrimaryKey('FCM_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FCM_ID')]
  TDtoFCM_00 = class
  private
    { Private declarations } 
    FFCM_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FFCM_DATAEMISSAO: TDateTime;
    FFCM_DATAFECHAMENTO: TDateTime;
    FFCM_NUMERODOCTO: String;
    FFCM_NOTAFISCAL: String;
    FFCM_NUMERODOCTOREPRESENTANTE: String;
    FFCM_TOTALDOCTO: Double;
    FFCM_TOTALCOMISSAO: Double;
    FFCM_TIPOPAGTOCOMISSAO: String;
    FFCM_PERCENTUALCOMISSAO: Double;
    FFCM_OBSERVACAO: String;
    FFCM_INTEGRACAO: String;
    FFCM_DATAALTERACAO: TDateTime;
    FFCM_ID_OLD: Integer;
    FFCM_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'FCM_00';
     const PrimaryKey = 'FCM_ID';
     const Sequence   = 'SEQ_FCM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_ID', ftInteger)]
    [Dictionary('FCM_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FCM_ID: Integer read FFCM_ID write FFCM_ID;
    const FCM_ID_Name = 'FCM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_DATAEMISSAO', ftDateTime)]
    [Dictionary('FCM_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FCM_DATAEMISSAO: TDateTime read FFCM_DATAEMISSAO write FFCM_DATAEMISSAO;
    const FCM_DATAEMISSAO_Name = 'FCM_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('FCM_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FCM_DATAFECHAMENTO: TDateTime read FFCM_DATAFECHAMENTO write FFCM_DATAFECHAMENTO;
    const FCM_DATAFECHAMENTO_Name = 'FCM_DATAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_NUMERODOCTO', ftString, 15)]
    [Dictionary('FCM_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_NUMERODOCTO: String read FFCM_NUMERODOCTO write FFCM_NUMERODOCTO;
    const FCM_NUMERODOCTO_Name = 'FCM_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FCM_NOTAFISCAL', ftString, 9)]
    [Dictionary('FCM_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_NOTAFISCAL: String read FFCM_NOTAFISCAL write FFCM_NOTAFISCAL;
    const FCM_NOTAFISCAL_Name = 'FCM_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FCM_NUMERODOCTOREPRESENTANTE', ftString, 10)]
    [Dictionary('FCM_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_NUMERODOCTOREPRESENTANTE: String read FFCM_NUMERODOCTOREPRESENTANTE write FFCM_NUMERODOCTOREPRESENTANTE;
    const FCM_NUMERODOCTOREPRESENTANTE_Name = 'FCM_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_TOTALDOCTO', ftBCD)]
    [Dictionary('FCM_TOTALDOCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FCM_TOTALDOCTO: Double read FFCM_TOTALDOCTO write FFCM_TOTALDOCTO;
    const FCM_TOTALDOCTO_Name = 'FCM_TOTALDOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_TOTALCOMISSAO', ftBCD)]
    [Dictionary('FCM_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FCM_TOTALCOMISSAO: Double read FFCM_TOTALCOMISSAO write FFCM_TOTALCOMISSAO;
    const FCM_TOTALCOMISSAO_Name = 'FCM_TOTALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FCM_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_TIPOPAGTOCOMISSAO: String read FFCM_TIPOPAGTOCOMISSAO write FFCM_TIPOPAGTOCOMISSAO;
    const FCM_TIPOPAGTOCOMISSAO_Name = 'FCM_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('FCM_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FCM_PERCENTUALCOMISSAO: Double read FFCM_PERCENTUALCOMISSAO write FFCM_PERCENTUALCOMISSAO;
    const FCM_PERCENTUALCOMISSAO_Name = 'FCM_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('FCM_OBSERVACAO', ftString, 300)]
    [Dictionary('FCM_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_OBSERVACAO: String read FFCM_OBSERVACAO write FFCM_OBSERVACAO;
    const FCM_OBSERVACAO_Name = 'FCM_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('FCM_INTEGRACAO', ftString, 20)]
    [Dictionary('FCM_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_INTEGRACAO: String read FFCM_INTEGRACAO write FFCM_INTEGRACAO;
    const FCM_INTEGRACAO_Name = 'FCM_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_DATAALTERACAO', ftDateTime)]
    [Dictionary('FCM_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FCM_DATAALTERACAO: TDateTime read FFCM_DATAALTERACAO write FFCM_DATAALTERACAO;
    const FCM_DATAALTERACAO_Name = 'FCM_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FCM_ID_OLD', ftInteger)]
    [Dictionary('FCM_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FCM_ID_OLD: Integer read FFCM_ID_OLD write FFCM_ID_OLD;
    const FCM_ID_OLD_Name = 'FCM_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FCM_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('FCM_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_INTEGRACAO_OLD: String read FFCM_INTEGRACAO_OLD write FFCM_INTEGRACAO_OLD;
    const FCM_INTEGRACAO_OLD_Name = 'FCM_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFCM_00)

end.
