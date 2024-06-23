unit express.dbo.CIAP_00_01;

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
  [Table('CIAP_00_01', '')]
  [PrimaryKey('CIAP_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CIAP_01_ID')]
  TDtoCIAP_00_01 = class
  private
    { Private declarations } 
    FCIAP_01_ID: Integer;
    FCIAP_ID: Integer;
    FCOM_CODIGO: Integer;
    FCIAP_DATAMOVTO: TDateTime;
    FCIAP_TIPOMOVTO: String;
    FCIAP_COMPETENCIA: String;
    FCIAP_NOTAFISCAL: String;
    FCIAP_VALORICMSFRETE: Double;
    FCIAP_VALORICMSOPEPROPRIA: Double;
    FCIAP_VALORICMSOPESUBTRIBUTARIA: Double;
    FCIAP_VALORICMSDIFALIQUOTA: Double;
    FCIAP_NUMEROPARCELA: Integer;
    FCIAP_VALORPARCELAICMSAPROPRIACAO: Double;
    FCIAP_DATAALTERACAO: TDateTime;
    FCIAP_01_ID_OLD: Integer;
    FCIAP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CIAP_00_01';
     const PrimaryKey = 'CIAP_01_ID';
     const Sequence   = 'SEQ_CIAP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CIAP_01_ID', ftInteger)]
    [Dictionary('CIAP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_01_ID: Integer read FCIAP_01_ID write FCIAP_01_ID;
    const CIAP_01_ID_Name = 'CIAP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CIAP_ID', ftInteger)]
    [Dictionary('CIAP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_ID: Integer read FCIAP_ID write FCIAP_ID;
    const CIAP_ID_Name = 'CIAP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CIAP_DATAMOVTO', ftDateTime)]
    [Dictionary('CIAP_DATAMOVTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAMOVTO: TDateTime read FCIAP_DATAMOVTO write FCIAP_DATAMOVTO;
    const CIAP_DATAMOVTO_Name = 'CIAP_DATAMOVTO';

    [Restrictions([NoValidate])]
    [Column('CIAP_TIPOMOVTO', ftString, 2)]
    [Dictionary('CIAP_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOMOVTO: String read FCIAP_TIPOMOVTO write FCIAP_TIPOMOVTO;
    const CIAP_TIPOMOVTO_Name = 'CIAP_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('CIAP_COMPETENCIA', ftString, 6)]
    [Dictionary('CIAP_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_COMPETENCIA: String read FCIAP_COMPETENCIA write FCIAP_COMPETENCIA;
    const CIAP_COMPETENCIA_Name = 'CIAP_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('CIAP_NOTAFISCAL', ftString, 9)]
    [Dictionary('CIAP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOTAFISCAL: String read FCIAP_NOTAFISCAL write FCIAP_NOTAFISCAL;
    const CIAP_NOTAFISCAL_Name = 'CIAP_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CIAP_VALORICMSFRETE', ftBCD)]
    [Dictionary('CIAP_VALORICMSFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSFRETE: Double read FCIAP_VALORICMSFRETE write FCIAP_VALORICMSFRETE;
    const CIAP_VALORICMSFRETE_Name = 'CIAP_VALORICMSFRETE';

    [Restrictions([NoValidate])]
    [Column('CIAP_VALORICMSOPEPROPRIA', ftBCD)]
    [Dictionary('CIAP_VALORICMSOPEPROPRIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSOPEPROPRIA: Double read FCIAP_VALORICMSOPEPROPRIA write FCIAP_VALORICMSOPEPROPRIA;
    const CIAP_VALORICMSOPEPROPRIA_Name = 'CIAP_VALORICMSOPEPROPRIA';

    [Restrictions([NoValidate])]
    [Column('CIAP_VALORICMSOPESUBTRIBUTARIA', ftBCD)]
    [Dictionary('CIAP_VALORICMSOPESUBTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSOPESUBTRIBUTARIA: Double read FCIAP_VALORICMSOPESUBTRIBUTARIA write FCIAP_VALORICMSOPESUBTRIBUTARIA;
    const CIAP_VALORICMSOPESUBTRIBUTARIA_Name = 'CIAP_VALORICMSOPESUBTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('CIAP_VALORICMSDIFALIQUOTA', ftBCD)]
    [Dictionary('CIAP_VALORICMSDIFALIQUOTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORICMSDIFALIQUOTA: Double read FCIAP_VALORICMSDIFALIQUOTA write FCIAP_VALORICMSDIFALIQUOTA;
    const CIAP_VALORICMSDIFALIQUOTA_Name = 'CIAP_VALORICMSDIFALIQUOTA';

    [Restrictions([NoValidate])]
    [Column('CIAP_NUMEROPARCELA', ftInteger)]
    [Dictionary('CIAP_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_NUMEROPARCELA: Integer read FCIAP_NUMEROPARCELA write FCIAP_NUMEROPARCELA;
    const CIAP_NUMEROPARCELA_Name = 'CIAP_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('CIAP_VALORPARCELAICMSAPROPRIACAO', ftBCD)]
    [Dictionary('CIAP_VALORPARCELAICMSAPROPRIACAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CIAP_VALORPARCELAICMSAPROPRIACAO: Double read FCIAP_VALORPARCELAICMSAPROPRIACAO write FCIAP_VALORPARCELAICMSAPROPRIACAO;
    const CIAP_VALORPARCELAICMSAPROPRIACAO_Name = 'CIAP_VALORPARCELAICMSAPROPRIACAO';

    [Restrictions([NoValidate])]
    [Column('CIAP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CIAP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAALTERACAO: TDateTime read FCIAP_DATAALTERACAO write FCIAP_DATAALTERACAO;
    const CIAP_DATAALTERACAO_Name = 'CIAP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CIAP_01_ID_OLD', ftInteger)]
    [Dictionary('CIAP_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_01_ID_OLD: Integer read FCIAP_01_ID_OLD write FCIAP_01_ID_OLD;
    const CIAP_01_ID_OLD_Name = 'CIAP_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CIAP_ID_OLD', ftInteger)]
    [Dictionary('CIAP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_ID_OLD: Integer read FCIAP_ID_OLD write FCIAP_ID_OLD;
    const CIAP_ID_OLD_Name = 'CIAP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCIAP_00_01)

end.
