unit express.dbo.NFP_00_04;

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
  [Table('NFP_00_04', '')]
  [PrimaryKey('NFP_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFP_04_ID')]
  TDtoNFP_00_04 = class
  private
    { Private declarations } 
    FNFP_04_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFP_ID: Integer;
    FNFP_DIA: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FNFP_DATAVENCTO: TDateTime;
    FNFP_NUMERODOCTO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FNFP_NUMEROPARCELA: Integer;
    FNFP_VALORPARCELA: Double;
    FNFP_DATAALTERACAO: TDateTime;
    FNFP_04_ID_OLD: Integer;
    FNFP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'NFP_00_04';
     const PrimaryKey = 'NFP_04_ID';
     const Sequence   = 'SEQ_NFP_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_04_ID', ftInteger)]
    [Dictionary('NFP_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_04_ID: Integer read FNFP_04_ID write FNFP_04_ID;
    const NFP_04_ID_Name = 'NFP_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_ID', ftInteger)]
    [Dictionary('NFP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID: Integer read FNFP_ID write FNFP_ID;
    const NFP_ID_Name = 'NFP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DIA', ftInteger)]
    [Dictionary('NFP_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_DIA: Integer read FNFP_DIA write FNFP_DIA;
    const NFP_DIA_Name = 'NFP_DIA';

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
    [Column('NFP_DATAVENCTO', ftDateTime)]
    [Dictionary('NFP_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFP_DATAVENCTO: TDateTime read FNFP_DATAVENCTO write FNFP_DATAVENCTO;
    const NFP_DATAVENCTO_Name = 'NFP_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('NFP_NUMERODOCTO', ftString, 15)]
    [Dictionary('NFP_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFP_NUMERODOCTO: String read FNFP_NUMERODOCTO write FNFP_NUMERODOCTO;
    const NFP_NUMERODOCTO_Name = 'NFP_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_NUMEROPARCELA', ftInteger)]
    [Dictionary('NFP_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_NUMEROPARCELA: Integer read FNFP_NUMEROPARCELA write FNFP_NUMEROPARCELA;
    const NFP_NUMEROPARCELA_Name = 'NFP_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_VALORPARCELA', ftBCD)]
    [Dictionary('NFP_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFP_VALORPARCELA: Double read FNFP_VALORPARCELA write FNFP_VALORPARCELA;
    const NFP_VALORPARCELA_Name = 'NFP_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFP_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFP_DATAALTERACAO: TDateTime read FNFP_DATAALTERACAO write FNFP_DATAALTERACAO;
    const NFP_DATAALTERACAO_Name = 'NFP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFP_04_ID_OLD', ftInteger)]
    [Dictionary('NFP_04_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_04_ID_OLD: Integer read FNFP_04_ID_OLD write FNFP_04_ID_OLD;
    const NFP_04_ID_OLD_Name = 'NFP_04_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFP_ID_OLD', ftInteger)]
    [Dictionary('NFP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFP_ID_OLD: Integer read FNFP_ID_OLD write FNFP_ID_OLD;
    const NFP_ID_OLD_Name = 'NFP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFP_00_04)

end.
