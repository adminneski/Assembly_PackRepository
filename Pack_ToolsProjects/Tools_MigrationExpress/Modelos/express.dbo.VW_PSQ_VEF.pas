unit express.dbo.VW_PSQ_VEF;

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
  [Table('VW_PSQ_VEF', '')]
  TDtoVW_PSQ_VEF = class
  private
    { Private declarations } 
    FVEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FVEF_NUMERODOCTO: String;
    FPES_CODIGO: Integer;
    FVEF_DATALANCAMENTO: TDateTime;
    FVEF_TOTALLIQUIDO: Double;
    FPES_NOME: String;
    FVEF_PROCESSADO: String;
    FVEF_CANCELADA: String;
    FVEF_FINANCEIRO: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FVEF_QTDDESISTENCIA: Integer;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_VEF';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_NUMERODOCTO', ftString, 10)]
    [Dictionary('VEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_NUMERODOCTO: String read FVEF_NUMERODOCTO write FVEF_NUMERODOCTO;
    const VEF_NUMERODOCTO_Name = 'VEF_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('VEF_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEF_DATALANCAMENTO: TDateTime read FVEF_DATALANCAMENTO write FVEF_DATALANCAMENTO;
    const VEF_DATALANCAMENTO_Name = 'VEF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TOTALLIQUIDO', ftBCD)]
    [Dictionary('VEF_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALLIQUIDO: Double read FVEF_TOTALLIQUIDO write FVEF_TOTALLIQUIDO;
    const VEF_TOTALLIQUIDO_Name = 'VEF_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('VEF_PROCESSADO', ftString, 1)]
    [Dictionary('VEF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_PROCESSADO: String read FVEF_PROCESSADO write FVEF_PROCESSADO;
    const VEF_PROCESSADO_Name = 'VEF_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('VEF_CANCELADA', ftString, 1)]
    [Dictionary('VEF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_CANCELADA: String read FVEF_CANCELADA write FVEF_CANCELADA;
    const VEF_CANCELADA_Name = 'VEF_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('VEF_FINANCEIRO', ftString, 1)]
    [Dictionary('VEF_FINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_FINANCEIRO: String read FVEF_FINANCEIRO write FVEF_FINANCEIRO;
    const VEF_FINANCEIRO_Name = 'VEF_FINANCEIRO';

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
    [Column('VEF_QTDDESISTENCIA', ftInteger)]
    [Dictionary('VEF_QTDDESISTENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_QTDDESISTENCIA: Integer read FVEF_QTDDESISTENCIA write FVEF_QTDDESISTENCIA;
    const VEF_QTDDESISTENCIA_Name = 'VEF_QTDDESISTENCIA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_VEF)

end.
