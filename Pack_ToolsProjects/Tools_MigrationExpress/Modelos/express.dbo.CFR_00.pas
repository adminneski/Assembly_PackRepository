unit express.dbo.CFR_00;

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
  [Table('CFR_00', '')]
  [PrimaryKey('CFR_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFR_ID')]
  TDtoCFR_00 = class
  private
    { Private declarations } 
    FCFR_ID: Integer;
    FCOM_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FCFR_DATALANCAMENTO: TDateTime;
    FCFR_CARTAFRETE: String;
    FCFR_NOTAFISCAL: String;
    FCFR_CONHECIMENTO: String;
    FCID_IBGEORIGEM: String;
    FCID_IBGEDESTINO: String;
    FCFR_PRECOTONELADA: Double;
    FCFR_PESOCARGA: Double;
    FCFR_VALEFRETE: Double;
    FCFR_DATAALTERACAO: TDateTime;
    FCFR_CIDADEORIGEM: String;
    FCFR_UFORIGEM: String;
    FCFR_CIDADEDESTINO: String;
    FCFR_UFDESTINO: String;
    FCFR_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CFR_00';
     const PrimaryKey = 'CFR_ID';
     const Sequence   = 'SEQ_CFR_ID';

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
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFR_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CFR_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFR_DATALANCAMENTO: TDateTime read FCFR_DATALANCAMENTO write FCFR_DATALANCAMENTO;
    const CFR_DATALANCAMENTO_Name = 'CFR_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CFR_CARTAFRETE', ftString, 6)]
    [Dictionary('CFR_CARTAFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CARTAFRETE: String read FCFR_CARTAFRETE write FCFR_CARTAFRETE;
    const CFR_CARTAFRETE_Name = 'CFR_CARTAFRETE';

    [Restrictions([NoValidate])]
    [Column('CFR_NOTAFISCAL', ftString, 300)]
    [Dictionary('CFR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_NOTAFISCAL: String read FCFR_NOTAFISCAL write FCFR_NOTAFISCAL;
    const CFR_NOTAFISCAL_Name = 'CFR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CFR_CONHECIMENTO', ftString, 300)]
    [Dictionary('CFR_CONHECIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CONHECIMENTO: String read FCFR_CONHECIMENTO write FCFR_CONHECIMENTO;
    const CFR_CONHECIMENTO_Name = 'CFR_CONHECIMENTO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftString, 7)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEORIGEM: String read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftString, 7)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEDESTINO: String read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CFR_PRECOTONELADA', ftBCD)]
    [Dictionary('CFR_PRECOTONELADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_PRECOTONELADA: Double read FCFR_PRECOTONELADA write FCFR_PRECOTONELADA;
    const CFR_PRECOTONELADA_Name = 'CFR_PRECOTONELADA';

    [Restrictions([NoValidate])]
    [Column('CFR_PESOCARGA', ftBCD)]
    [Dictionary('CFR_PESOCARGA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_PESOCARGA: Double read FCFR_PESOCARGA write FCFR_PESOCARGA;
    const CFR_PESOCARGA_Name = 'CFR_PESOCARGA';

    [Restrictions([NoValidate])]
    [Column('CFR_VALEFRETE', ftBCD)]
    [Dictionary('CFR_VALEFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFR_VALEFRETE: Double read FCFR_VALEFRETE write FCFR_VALEFRETE;
    const CFR_VALEFRETE_Name = 'CFR_VALEFRETE';

    [Restrictions([NoValidate])]
    [Column('CFR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFR_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFR_DATAALTERACAO: TDateTime read FCFR_DATAALTERACAO write FCFR_DATAALTERACAO;
    const CFR_DATAALTERACAO_Name = 'CFR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CFR_CIDADEORIGEM', ftString, 100)]
    [Dictionary('CFR_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CIDADEORIGEM: String read FCFR_CIDADEORIGEM write FCFR_CIDADEORIGEM;
    const CFR_CIDADEORIGEM_Name = 'CFR_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CFR_UFORIGEM', ftString, 2)]
    [Dictionary('CFR_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_UFORIGEM: String read FCFR_UFORIGEM write FCFR_UFORIGEM;
    const CFR_UFORIGEM_Name = 'CFR_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('CFR_CIDADEDESTINO', ftString, 100)]
    [Dictionary('CFR_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_CIDADEDESTINO: String read FCFR_CIDADEDESTINO write FCFR_CIDADEDESTINO;
    const CFR_CIDADEDESTINO_Name = 'CFR_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CFR_UFDESTINO', ftString, 2)]
    [Dictionary('CFR_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFR_UFDESTINO: String read FCFR_UFDESTINO write FCFR_UFDESTINO;
    const CFR_UFDESTINO_Name = 'CFR_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('CFR_ID_OLD', ftInteger)]
    [Dictionary('CFR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFR_ID_OLD: Integer read FCFR_ID_OLD write FCFR_ID_OLD;
    const CFR_ID_OLD_Name = 'CFR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCFR_00)

end.
