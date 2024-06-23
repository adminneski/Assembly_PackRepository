unit express.dbo.VW_PSQ_CFR;

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
  [Table('VW_PSQ_CFR', '')]
  TDtoVW_PSQ_CFR = class
  private
    { Private declarations } 
    FCFR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCFR_CARTAFRETE: String;
    FCFR_DATALANCAMENTO: TDateTime;
    FTRP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOMEPROPRIETARIO: String;
    FPES_NOME: String;
    FCFR_VALEFRETE: Double;
    FCFR_PESOCARGA: Double;
    FCFR_PRECOTONELADA: Double;
    FVEI_CODIGO: Integer;
    FVEI_DESCRICAO: String;
    FVEI_PLACA: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CFR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFR_ID', ftInteger)]
    [Dictionary('CFR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFR_ID: Integer read FCFR_ID write FCFR_ID;
    const CFR_ID_Name = 'CFR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFR_CARTAFRETE', ftString, 6)]
    [Dictionary('CFR_CARTAFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CARTAFRETE: String read FCFR_CARTAFRETE write FCFR_CARTAFRETE;
    const CFR_CARTAFRETE_Name = 'CFR_CARTAFRETE';

    [Restrictions([NoValidate])]
    [Column('CFR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CFR_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFR_DATALANCAMENTO: TDateTime read FCFR_DATALANCAMENTO write FCFR_DATALANCAMENTO;
    const CFR_DATALANCAMENTO_Name = 'CFR_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEPROPRIETARIO', ftString, 100)]
    [Dictionary('PES_NOMEPROPRIETARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEPROPRIETARIO: String read FPES_NOMEPROPRIETARIO write FPES_NOMEPROPRIETARIO;
    const PES_NOMEPROPRIETARIO_Name = 'PES_NOMEPROPRIETARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CFR_VALEFRETE', ftBCD)]
    [Dictionary('CFR_VALEFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_VALEFRETE: Double read FCFR_VALEFRETE write FCFR_VALEFRETE;
    const CFR_VALEFRETE_Name = 'CFR_VALEFRETE';

    [Restrictions([NoValidate])]
    [Column('CFR_PESOCARGA', ftBCD)]
    [Dictionary('CFR_PESOCARGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_PESOCARGA: Double read FCFR_PESOCARGA write FCFR_PESOCARGA;
    const CFR_PESOCARGA_Name = 'CFR_PESOCARGA';

    [Restrictions([NoValidate])]
    [Column('CFR_PRECOTONELADA', ftBCD)]
    [Dictionary('CFR_PRECOTONELADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_PRECOTONELADA: Double read FCFR_PRECOTONELADA write FCFR_PRECOTONELADA;
    const CFR_PRECOTONELADA_Name = 'CFR_PRECOTONELADA';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CFR)

end.
