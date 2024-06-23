unit express.dbo.CTR_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ctr_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CTR_00_03', '')]
  [PrimaryKey('CTR_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTR_03_ID')]
  TDtoCTR_00_03 = class
  private
    { Private declarations } 
    FCTR_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FCTR_CNPJ_CPF: String;
    FCTR_IE: String;
    FCTR_UF: String;
    FCTR_NOMEEXPEDIDOR: String;
    FCTR_TIPODOCUMENTO: String;
    FCTR_SERIE: String;
    FCTR_SUBSERIE: String;
    FCTR_NUMERODOCTOFISCAL: String;
    FCTR_CHAVEACESSO: String;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_DATAALTERACAO: TDateTime;
    FCTR_03_ID_OLD: Integer;
    FCTR_ID_OLD: Integer;
  public
    { Public declarations }

    const Table      = 'CTR_00_03';
    const PrimaryKey = 'CTR_03_ID';
    const Sequence   = 'SEQ_CTR_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_03_ID', ftInteger)]
    [Dictionary('CTR_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_03_ID: Integer read FCTR_03_ID write FCTR_03_ID;
    const CTR_03_ID_Name = 'CTR_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [ForeignKey('CTR_00_03_fk', 'CTR_ID', 'CTR_00', 'CTR_ID', SetNull, SetNull)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_CNPJ_CPF', ftString, 14)]
    [Dictionary('CTR_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CNPJ_CPF: String read FCTR_CNPJ_CPF write FCTR_CNPJ_CPF;
    const CTR_CNPJ_CPF_Name = 'CTR_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('CTR_IE', ftString, 16)]
    [Dictionary('CTR_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_IE: String read FCTR_IE write FCTR_IE;
    const CTR_IE_Name = 'CTR_IE';

    [Restrictions([NoValidate])]
    [Column('CTR_UF', ftString, 2)]
    [Dictionary('CTR_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_UF: String read FCTR_UF write FCTR_UF;
    const CTR_UF_Name = 'CTR_UF';

    [Restrictions([NoValidate])]
    [Column('CTR_NOMEEXPEDIDOR', ftString, 60)]
    [Dictionary('CTR_NOMEEXPEDIDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOMEEXPEDIDOR: String read FCTR_NOMEEXPEDIDOR write FCTR_NOMEEXPEDIDOR;
    const CTR_NOMEEXPEDIDOR_Name = 'CTR_NOMEEXPEDIDOR';

    [Restrictions([NoValidate])]
    [Column('CTR_TIPODOCUMENTO', ftString, 2)]
    [Dictionary('CTR_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPODOCUMENTO: String read FCTR_TIPODOCUMENTO write FCTR_TIPODOCUMENTO;
    const CTR_TIPODOCUMENTO_Name = 'CTR_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_SUBSERIE', ftString, 2)]
    [Dictionary('CTR_SUBSERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SUBSERIE: String read FCTR_SUBSERIE write FCTR_SUBSERIE;
    const CTR_SUBSERIE_Name = 'CTR_SUBSERIE';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTOFISCAL', ftString, 20)]
    [Dictionary('CTR_NUMERODOCTOFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTOFISCAL: String read FCTR_NUMERODOCTOFISCAL write FCTR_NUMERODOCTOFISCAL;
    const CTR_NUMERODOCTOFISCAL_Name = 'CTR_NUMERODOCTOFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSO: String read FCTR_CHAVEACESSO write FCTR_CHAVEACESSO;
    const CTR_CHAVEACESSO_Name = 'CTR_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTR_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAALTERACAO: TDateTime read FCTR_DATAALTERACAO write FCTR_DATAALTERACAO;
    const CTR_DATAALTERACAO_Name = 'CTR_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CTR_03_ID_OLD', ftInteger)]
    [Dictionary('CTR_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_03_ID_OLD: Integer read FCTR_03_ID_OLD write FCTR_03_ID_OLD;
    const CTR_03_ID_OLD_Name = 'CTR_03_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_00_03)

end.
