unit express.dbo.NFE_00_02;

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
  [Table('NFE_00_02', '')]
  [PrimaryKey('NFE_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NFE_02_ID')]
  TDtoNFE_00_02 = class
  private
    { Private declarations } 
    FNFE_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_ID: Integer;
    FNFE_UF: String;
    FPRO_CODIGO: Integer;
    FNFE_VALORVENDASUGERIDO: Double;
    FNFE_VALORVENDAADOTADO: Double;
    FPES_TIPOCLIENTE: String;
    FNFE_DATAALTERACAO: TDateTime;
    FNFE_02_ID_OLD: Integer;
    FNFE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'NFE_00_02';
    const PrimaryKey = 'NFE_02_ID';
    const Sequence   = 'SEQ_NFE_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_02_ID', ftInteger)]
    [Dictionary('NFE_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_02_ID: Integer read FNFE_02_ID write FNFE_02_ID;
    const NFE_02_ID_Name = 'NFE_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [ForeignKey('NFE_00_02_fk', 'NFE_ID', 'NFE_00', 'NFE_ID', SetNull, SetNull)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate])]
    [Column('NFE_UF', ftString, 2)]
    [Dictionary('NFE_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_UF: String read FNFE_UF write FNFE_UF;
    const NFE_UF_Name = 'NFE_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORVENDASUGERIDO', ftBCD)]
    [Dictionary('NFE_VALORVENDASUGERIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORVENDASUGERIDO: Double read FNFE_VALORVENDASUGERIDO write FNFE_VALORVENDASUGERIDO;
    const NFE_VALORVENDASUGERIDO_Name = 'NFE_VALORVENDASUGERIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORVENDAADOTADO', ftBCD)]
    [Dictionary('NFE_VALORVENDAADOTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORVENDAADOTADO: Double read FNFE_VALORVENDAADOTADO write FNFE_VALORVENDAADOTADO;
    const NFE_VALORVENDAADOTADO_Name = 'NFE_VALORVENDAADOTADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOCLIENTE', ftString, 1)]
    [Dictionary('PES_TIPOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCLIENTE: String read FPES_TIPOCLIENTE write FPES_TIPOCLIENTE;
    const PES_TIPOCLIENTE_Name = 'PES_TIPOCLIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_DATAALTERACAO', ftDateTime)]
    [Dictionary('NFE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NFE_DATAALTERACAO: TDateTime read FNFE_DATAALTERACAO write FNFE_DATAALTERACAO;
    const NFE_DATAALTERACAO_Name = 'NFE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NFE_02_ID_OLD', ftInteger)]
    [Dictionary('NFE_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_02_ID_OLD: Integer read FNFE_02_ID_OLD write FNFE_02_ID_OLD;
    const NFE_02_ID_OLD_Name = 'NFE_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('NFE_ID_OLD', ftInteger)]
    [Dictionary('NFE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID_OLD: Integer read FNFE_ID_OLD write FNFE_ID_OLD;
    const NFE_ID_OLD_Name = 'NFE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNFE_00_02)

end.
