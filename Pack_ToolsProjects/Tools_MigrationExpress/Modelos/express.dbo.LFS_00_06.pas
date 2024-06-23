unit express.dbo.LFS_00_06;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfs_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFS_00_06', '')]
  [PrimaryKey('LFS_06_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_06_ID')]
  TDtoLFS_00_06 = class
  private
    { Private declarations } 
    FLFS_06_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FLFS_DATAEMISSAO: TDateTime;
    FLFS_ORDEMITEM: Integer;
    FCFOP_CODIGO: String;
    FLFS_SERIE: String;
    FMNF_CODIGO: String;
    FLFS_NOTAFISCAL: String;
    FLFS_NUMEROVOLUMES: Double;
    FLFS_VALORNOTAFISCAL: Double;
    FLFS_VALORPRODUTOS: Double;
    FLFS_VALORICMS: Double;
    FLFS_VALORSEMIPI: Double;
    FLFS_VALORCOMIPI: Double;
    FLFS_VALORBASECALCULOICMS: Double;
    FLFS_VALORBASECALCULOMVA: Double;
    FLFS_VALORSUBSTRIBUTARIA: Double;
    FLFS_PESOBRUTO: Double;
    FLFS_PESOLIQUIDO: Double;
    FLFS_CHAVEACESSO: String;
    FLFS_NUMEROROMANEIO: String;
    FLFS_NUMEROPEDIDO: String;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_06_ID_OLD: Integer;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFS_00_06';
    const PrimaryKey = 'LFS_06_ID';
    const Sequence   = 'SEQ_LFS_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_06_ID', ftInteger)]
    [Dictionary('LFS_06_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_06_ID: Integer read FLFS_06_ID write FLFS_06_ID;
    const LFS_06_ID_Name = 'LFS_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_06_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ORDEMITEM', ftInteger)]
    [Dictionary('LFS_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ORDEMITEM: Integer read FLFS_ORDEMITEM write FLFS_ORDEMITEM;
    const LFS_ORDEMITEM_Name = 'LFS_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIE', ftString, 3)]
    [Dictionary('LFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIE: String read FLFS_SERIE write FLFS_SERIE;
    const LFS_SERIE_Name = 'LFS_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROVOLUMES', ftBCD)]
    [Dictionary('LFS_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_NUMEROVOLUMES: Double read FLFS_NUMEROVOLUMES write FLFS_NUMEROVOLUMES;
    const LFS_NUMEROVOLUMES_Name = 'LFS_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORNOTAFISCAL: Double read FLFS_VALORNOTAFISCAL write FLFS_VALORNOTAFISCAL;
    const LFS_VALORNOTAFISCAL_Name = 'LFS_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORPRODUTOS', ftBCD)]
    [Dictionary('LFS_VALORPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORPRODUTOS: Double read FLFS_VALORPRODUTOS write FLFS_VALORPRODUTOS;
    const LFS_VALORPRODUTOS_Name = 'LFS_VALORPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORICMS', ftBCD)]
    [Dictionary('LFS_VALORICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORICMS: Double read FLFS_VALORICMS write FLFS_VALORICMS;
    const LFS_VALORICMS_Name = 'LFS_VALORICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORSEMIPI', ftBCD)]
    [Dictionary('LFS_VALORSEMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORSEMIPI: Double read FLFS_VALORSEMIPI write FLFS_VALORSEMIPI;
    const LFS_VALORSEMIPI_Name = 'LFS_VALORSEMIPI';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORCOMIPI', ftBCD, 1650, 2)]
    [Dictionary('LFS_VALORCOMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORCOMIPI: Double read FLFS_VALORCOMIPI write FLFS_VALORCOMIPI;
    const LFS_VALORCOMIPI_Name = 'LFS_VALORCOMIPI';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOICMS', ftBCD)]
    [Dictionary('LFS_VALORBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOICMS: Double read FLFS_VALORBASECALCULOICMS write FLFS_VALORBASECALCULOICMS;
    const LFS_VALORBASECALCULOICMS_Name = 'LFS_VALORBASECALCULOICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORBASECALCULOMVA', ftBCD, 66256176, 2)]
    [Dictionary('LFS_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORBASECALCULOMVA: Double read FLFS_VALORBASECALCULOMVA write FLFS_VALORBASECALCULOMVA;
    const LFS_VALORBASECALCULOMVA_Name = 'LFS_VALORBASECALCULOMVA';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('LFS_VALORSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORSUBSTRIBUTARIA: Double read FLFS_VALORSUBSTRIBUTARIA write FLFS_VALORSUBSTRIBUTARIA;
    const LFS_VALORSUBSTRIBUTARIA_Name = 'LFS_VALORSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('LFS_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('LFS_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PESOBRUTO: Double read FLFS_PESOBRUTO write FLFS_PESOBRUTO;
    const LFS_PESOBRUTO_Name = 'LFS_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('LFS_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PESOLIQUIDO: Double read FLFS_PESOLIQUIDO write FLFS_PESOLIQUIDO;
    const LFS_PESOLIQUIDO_Name = 'LFS_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSO: String read FLFS_CHAVEACESSO write FLFS_CHAVEACESSO;
    const LFS_CHAVEACESSO_Name = 'LFS_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROROMANEIO', ftString, 20)]
    [Dictionary('LFS_NUMEROROMANEIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROROMANEIO: String read FLFS_NUMEROROMANEIO write FLFS_NUMEROROMANEIO;
    const LFS_NUMEROROMANEIO_Name = 'LFS_NUMEROROMANEIO';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROPEDIDO', ftString, 20)]
    [Dictionary('LFS_NUMEROPEDIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROPEDIDO: String read FLFS_NUMEROPEDIDO write FLFS_NUMEROPEDIDO;
    const LFS_NUMEROPEDIDO_Name = 'LFS_NUMEROPEDIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_06_ID_OLD', ftInteger)]
    [Dictionary('LFS_06_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_06_ID_OLD: Integer read FLFS_06_ID_OLD write FLFS_06_ID_OLD;
    const LFS_06_ID_OLD_Name = 'LFS_06_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_06)

end.
