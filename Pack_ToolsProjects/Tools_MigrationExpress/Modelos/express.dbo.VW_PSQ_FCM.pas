unit express.dbo.VW_PSQ_FCM;

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
  [Table('VW_PSQ_FCM', '')]
  TDtoVW_PSQ_FCM = class
  private
    { Private declarations } 
    FFCM_ID: Integer;
    FCOM_CODIGO: Integer;
    FFCM_TIPOPAGTOCOMISSAO: String;
    FFCM_NOTAFISCAL: String;
    FFCM_NUMERODOCTO: String;
    FFCM_NUMERODOCTOREPRESENTANTE: String;
    FFCM_DATAFECHAMENTO: TDateTime;
    FFCM_TOTALCOMISSAO: Double;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FFCM_OBSERVACAO: String;
    FFCM_DATAEMISSAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_FCM';

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
    [Column('FCM_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FCM_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_TIPOPAGTOCOMISSAO: String read FFCM_TIPOPAGTOCOMISSAO write FFCM_TIPOPAGTOCOMISSAO;
    const FCM_TIPOPAGTOCOMISSAO_Name = 'FCM_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('FCM_NOTAFISCAL', ftString, 9)]
    [Dictionary('FCM_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_NOTAFISCAL: String read FFCM_NOTAFISCAL write FFCM_NOTAFISCAL;
    const FCM_NOTAFISCAL_Name = 'FCM_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_NUMERODOCTO', ftString, 15)]
    [Dictionary('FCM_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_NUMERODOCTO: String read FFCM_NUMERODOCTO write FFCM_NUMERODOCTO;
    const FCM_NUMERODOCTO_Name = 'FCM_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FCM_NUMERODOCTOREPRESENTANTE', ftString, 10)]
    [Dictionary('FCM_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_NUMERODOCTOREPRESENTANTE: String read FFCM_NUMERODOCTOREPRESENTANTE write FFCM_NUMERODOCTOREPRESENTANTE;
    const FCM_NUMERODOCTOREPRESENTANTE_Name = 'FCM_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('FCM_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FCM_DATAFECHAMENTO: TDateTime read FFCM_DATAFECHAMENTO write FFCM_DATAFECHAMENTO;
    const FCM_DATAFECHAMENTO_Name = 'FCM_DATAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_TOTALCOMISSAO', ftBCD)]
    [Dictionary('FCM_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FCM_TOTALCOMISSAO: Double read FFCM_TOTALCOMISSAO write FFCM_TOTALCOMISSAO;
    const FCM_TOTALCOMISSAO_Name = 'FCM_TOTALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('FCM_OBSERVACAO', ftString, 300)]
    [Dictionary('FCM_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FCM_OBSERVACAO: String read FFCM_OBSERVACAO write FFCM_OBSERVACAO;
    const FCM_OBSERVACAO_Name = 'FCM_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FCM_DATAEMISSAO', ftDateTime)]
    [Dictionary('FCM_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FCM_DATAEMISSAO: TDateTime read FFCM_DATAEMISSAO write FFCM_DATAEMISSAO;
    const FCM_DATAEMISSAO_Name = 'FCM_DATAEMISSAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_FCM)

end.
