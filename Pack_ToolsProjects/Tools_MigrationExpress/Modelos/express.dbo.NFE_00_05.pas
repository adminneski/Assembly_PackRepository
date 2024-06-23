unit express.dbo.NFE_00_05;

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
  [Table('NFE_00_05', '')]
  [PrimaryKey('NFE_05_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFE_05_ID')]
  TDtoNFE_00_05 = class
  private
    { Private declarations } 
    FNFE_05_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_ID: Integer;
    FNFE_DIA: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FNFE_DATAVENCTO: TDateTime;
    FNFE_NUMERODOCTO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FNFE_NUMEROPARCELA: Integer;
    FNFE_VALORPARCELA: Double;
    FNFE_DATAALTERACAO: TDateTime;
    FNFE_05_ID_OLD: Integer;
    FNFE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'NFE_00_05';
    const PrimaryKey = 'NFE_05_ID';
    const Sequence   = 'SEQ_NFE_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_05_ID', ftInteger)]
    [Dictionary('NFE_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_05_ID: Integer read FNFE_05_ID write FNFE_05_ID;
    const NFE_05_ID_Name = 'NFE_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [ForeignKey('NFE_00_05_fk', 'NFE_ID', 'NFE_00', 'NFE_ID', SetNull, SetNull)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DIA', ftInteger)]
    [Dictionary('NFE_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_DIA: Integer read FNFE_DIA write FNFE_DIA;
    const NFE_DIA_Name = 'NFE_DIA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAVENCTO', ftDateTime)]
    [Dictionary('NFE_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAVENCTO: TDateTime read FNFE_DATAVENCTO write FNFE_DATAVENCTO;
    const NFE_DATAVENCTO_Name = 'NFE_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('NFE_NUMERODOCTO', ftString, 15)]
    [Dictionary('NFE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NUMERODOCTO: String read FNFE_NUMERODOCTO write FNFE_NUMERODOCTO;
    const NFE_NUMERODOCTO_Name = 'NFE_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_NUMEROPARCELA', ftInteger)]
    [Dictionary('NFE_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_NUMEROPARCELA: Integer read FNFE_NUMEROPARCELA write FNFE_NUMEROPARCELA;
    const NFE_NUMEROPARCELA_Name = 'NFE_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORPARCELA', ftBCD)]
    [Dictionary('NFE_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORPARCELA: Double read FNFE_VALORPARCELA write FNFE_VALORPARCELA;
    const NFE_VALORPARCELA_Name = 'NFE_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATAALTERACAO: TDateTime read FNFE_DATAALTERACAO write FNFE_DATAALTERACAO;
    const NFE_DATAALTERACAO_Name = 'NFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_05_ID_OLD', ftInteger)]
    [Dictionary('NFE_05_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_05_ID_OLD: Integer read FNFE_05_ID_OLD write FNFE_05_ID_OLD;
    const NFE_05_ID_OLD_Name = 'NFE_05_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_ID_OLD', ftInteger)]
    [Dictionary('NFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID_OLD: Integer read FNFE_ID_OLD write FNFE_ID_OLD;
    const NFE_ID_OLD_Name = 'NFE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_00_05)

end.
