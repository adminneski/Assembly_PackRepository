unit express.dbo.PRO_00_03;

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
  [Table('PRO_00_03', '')]
  [PrimaryKey('PRO_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_03_ID')]
  TDtoPRO_00_03 = class
  private
    { Private declarations } 
    FPRO_03_ID: Integer;
    FPRO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPRO_NOTAFISCAL: String;
    FPRO_DATANOTAFISCAL: TDateTime;
    FPRO_CODIGOFORNECEDOR: String;
    FPRO_FATORCONVERSAO: Double;
    FPRO_DEFAULT: String;
    FPRO_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRO_00_03';
     const PrimaryKey = 'PRO_03_ID';
     const Sequence   = 'SEQ_PRO_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_03_ID', ftInteger)]
    [Dictionary('PRO_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_03_ID: Integer read FPRO_03_ID write FPRO_03_ID;
    const PRO_03_ID_Name = 'PRO_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_NOTAFISCAL', ftString, 9)]
    [Dictionary('PRO_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NOTAFISCAL: String read FPRO_NOTAFISCAL write FPRO_NOTAFISCAL;
    const PRO_NOTAFISCAL_Name = 'PRO_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('PRO_DATANOTAFISCAL', ftDateTime)]
    [Dictionary('PRO_DATANOTAFISCAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATANOTAFISCAL: TDateTime read FPRO_DATANOTAFISCAL write FPRO_DATANOTAFISCAL;
    const PRO_DATANOTAFISCAL_Name = 'PRO_DATANOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGOFORNECEDOR', ftString, 50)]
    [Dictionary('PRO_CODIGOFORNECEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOFORNECEDOR: String read FPRO_CODIGOFORNECEDOR write FPRO_CODIGOFORNECEDOR;
    const PRO_CODIGOFORNECEDOR_Name = 'PRO_CODIGOFORNECEDOR';

    [Restrictions([NoValidate])]
    [Column('PRO_FATORCONVERSAO', ftBCD, 1145132617, 2)]
    [Dictionary('PRO_FATORCONVERSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_FATORCONVERSAO: Double read FPRO_FATORCONVERSAO write FPRO_FATORCONVERSAO;
    const PRO_FATORCONVERSAO_Name = 'PRO_FATORCONVERSAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DEFAULT', ftString, 1)]
    [Dictionary('PRO_DEFAULT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DEFAULT: String read FPRO_DEFAULT write FPRO_DEFAULT;
    const PRO_DEFAULT_Name = 'PRO_DEFAULT';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_00_03)

end.
