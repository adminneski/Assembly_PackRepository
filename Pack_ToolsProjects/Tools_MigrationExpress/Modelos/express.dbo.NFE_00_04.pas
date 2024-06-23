unit express.dbo.NFE_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.nfe_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('NFE_00_04', '')]
  [PrimaryKey('NFE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFE_ID')]
  TDtoNFE_00_04 = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FNFE_DOCTODUA: String;
    FNFE_TOTALICMSRDUA: Double;
    FNFE_DATAVENCIMENTO: TDateTime;
    FNFE_DATAALTERACAO: TDateTime;
    FNFE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'NFE_00_04';
    const PrimaryKey = 'NFE_ID';
    const Sequence   = 'SEQ_NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [ForeignKey('NFE_00_04_fk', 'NFE_ID', 'NFE_00', 'NFE_ID', SetNull, SetNull)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

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

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DOCTODUA', ftString, 15)]
    [Dictionary('NFE_DOCTODUA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_DOCTODUA: String read FNFE_DOCTODUA write FNFE_DOCTODUA;
    const NFE_DOCTODUA_Name = 'NFE_DOCTODUA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALICMSRDUA', ftBCD, 18, 4)]
    [Dictionary('NFE_TOTALICMSRDUA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALICMSRDUA: Double read FNFE_TOTALICMSRDUA write FNFE_TOTALICMSRDUA;
    const NFE_TOTALICMSRDUA_Name = 'NFE_TOTALICMSRDUA';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('NFE_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAVENCIMENTO: TDateTime read FNFE_DATAVENCIMENTO write FNFE_DATAVENCIMENTO;
    const NFE_DATAVENCIMENTO_Name = 'NFE_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATAALTERACAO: TDateTime read FNFE_DATAALTERACAO write FNFE_DATAALTERACAO;
    const NFE_DATAALTERACAO_Name = 'NFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_ID_OLD', ftInteger)]
    [Dictionary('NFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID_OLD: Integer read FNFE_ID_OLD write FNFE_ID_OLD;
    const NFE_ID_OLD_Name = 'NFE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_00_04)

end.
