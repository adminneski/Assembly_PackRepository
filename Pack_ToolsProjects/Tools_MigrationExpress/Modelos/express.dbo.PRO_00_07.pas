unit express.dbo.PRO_00_07;

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
  [Table('PRO_00_07', '')]
  [PrimaryKey('PRO_07_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_07_ID')]
  TDtoPRO_00_07 = class
  private
    { Private declarations } 
    FPRO_07_ID: Integer;
    FPRO_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FPRO_DATAMOVTO: TDateTime;
    FPRO_TIPOMOVTO: String;
    FPRO_VALORICMSOPEPROPRIA: Double;
    FPRO_VALORICMSOPESUBTRIBUTARIA: Double;
    FPRO_VALORICMSFRETE: Double;
    FPRO_VALORICMSDIFALIQUOTA: Double;
    FPRO_NUMEROPARCELA: Integer;
    FPRO_VALORPARCELAICMSAPROPRIACAO: Double;
    FPRO_DATAALTERACAO: TDateTime;
    FPRO_COMPETENCIA: String;
    FPRO_NOTAFISCAL: String;
  public 
    { Public declarations } 
     const Table      = 'PRO_00_07';
     const PrimaryKey = 'PRO_07_ID';
     const Sequence   = 'SEQ_PRO_07_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_07_ID', ftInteger)]
    [Dictionary('PRO_07_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_07_ID: Integer read FPRO_07_ID write FPRO_07_ID;
    const PRO_07_ID_Name = 'PRO_07_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DATAMOVTO', ftDateTime)]
    [Dictionary('PRO_DATAMOVTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAMOVTO: TDateTime read FPRO_DATAMOVTO write FPRO_DATAMOVTO;
    const PRO_DATAMOVTO_Name = 'PRO_DATAMOVTO';

    [Restrictions([NoValidate])]
    [Column('PRO_TIPOMOVTO', ftString, 2)]
    [Dictionary('PRO_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_TIPOMOVTO: String read FPRO_TIPOMOVTO write FPRO_TIPOMOVTO;
    const PRO_TIPOMOVTO_Name = 'PRO_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORICMSOPEPROPRIA', ftBCD, 1529377646, 2)]
    [Dictionary('PRO_VALORICMSOPEPROPRIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORICMSOPEPROPRIA: Double read FPRO_VALORICMSOPEPROPRIA write FPRO_VALORICMSOPEPROPRIA;
    const PRO_VALORICMSOPEPROPRIA_Name = 'PRO_VALORICMSOPEPROPRIA';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORICMSOPESUBTRIBUTARIA', ftBCD, 1952531540, 2)]
    [Dictionary('PRO_VALORICMSOPESUBTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORICMSOPESUBTRIBUTARIA: Double read FPRO_VALORICMSOPESUBTRIBUTARIA write FPRO_VALORICMSOPESUBTRIBUTARIA;
    const PRO_VALORICMSOPESUBTRIBUTARIA_Name = 'PRO_VALORICMSOPESUBTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORICMSFRETE', ftBCD, 1411398223, 2)]
    [Dictionary('PRO_VALORICMSFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORICMSFRETE: Double read FPRO_VALORICMSFRETE write FPRO_VALORICMSFRETE;
    const PRO_VALORICMSFRETE_Name = 'PRO_VALORICMSFRETE';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORICMSDIFALIQUOTA', ftBCD, 1415532614, 2)]
    [Dictionary('PRO_VALORICMSDIFALIQUOTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORICMSDIFALIQUOTA: Double read FPRO_VALORICMSDIFALIQUOTA write FPRO_VALORICMSDIFALIQUOTA;
    const PRO_VALORICMSDIFALIQUOTA_Name = 'PRO_VALORICMSDIFALIQUOTA';

    [Restrictions([NoValidate])]
    [Column('PRO_NUMEROPARCELA', ftInteger)]
    [Dictionary('PRO_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_NUMEROPARCELA: Integer read FPRO_NUMEROPARCELA write FPRO_NUMEROPARCELA;
    const PRO_NUMEROPARCELA_Name = 'PRO_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORPARCELAICMSAPROPRIACAO', ftBCD, 1769238085, 2)]
    [Dictionary('PRO_VALORPARCELAICMSAPROPRIACAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORPARCELAICMSAPROPRIACAO: Double read FPRO_VALORPARCELAICMSAPROPRIACAO write FPRO_VALORPARCELAICMSAPROPRIACAO;
    const PRO_VALORPARCELAICMSAPROPRIACAO_Name = 'PRO_VALORPARCELAICMSAPROPRIACAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PRO_COMPETENCIA', ftString, 6)]
    [Dictionary('PRO_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_COMPETENCIA: String read FPRO_COMPETENCIA write FPRO_COMPETENCIA;
    const PRO_COMPETENCIA_Name = 'PRO_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('PRO_NOTAFISCAL', ftString, 9)]
    [Dictionary('PRO_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NOTAFISCAL: String read FPRO_NOTAFISCAL write FPRO_NOTAFISCAL;
    const PRO_NOTAFISCAL_Name = 'PRO_NOTAFISCAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_00_07)

end.
