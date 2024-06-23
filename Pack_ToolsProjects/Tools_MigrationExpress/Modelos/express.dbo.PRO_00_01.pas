unit express.dbo.PRO_00_01;

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
  [Table('PRO_00_01', '')]
  [PrimaryKey('PRO_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_01_ID')]
  TDtoPRO_00_01 = class
  private
    { Private declarations } 
    FPRO_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FLCZ_CODIGO: Integer;
    FDEP_CODIGO: Integer;
    FPRO_VALORICMSR: Double;
    FPRO_ESTOQUEMINIMO: Double;
    FPRO_ESTOQUEMAXIMO: Double;
    FPRO_VALORBASECALCULOMVA: Double;
    FPRO_DATAALTERACAO: TDateTime;
    FPRO_ULTIMOFORNECEDOR: String;
    FPRO_ULTIMANFENTRADA: String;
  public 
    { Public declarations } 
     const Table      = 'PRO_00_01';
     const PrimaryKey = 'PRO_01_ID';
     const Sequence   = 'SEQ_PRO_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_01_ID', ftInteger)]
    [Dictionary('PRO_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_01_ID: Integer read FPRO_01_ID write FPRO_01_ID;
    const PRO_01_ID_Name = 'PRO_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LCZ_CODIGO', ftInteger)]
    [Dictionary('LCZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LCZ_CODIGO: Integer read FLCZ_CODIGO write FLCZ_CODIGO;
    const LCZ_CODIGO_Name = 'LCZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('DEP_CODIGO', ftInteger)]
    [Dictionary('DEP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property DEP_CODIGO: Integer read FDEP_CODIGO write FDEP_CODIGO;
    const DEP_CODIGO_Name = 'DEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORICMSR', ftBCD, 18, 4)]
    [Dictionary('PRO_VALORICMSR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORICMSR: Double read FPRO_VALORICMSR write FPRO_VALORICMSR;
    const PRO_VALORICMSR_Name = 'PRO_VALORICMSR';

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUEMINIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMINIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMINIMO: Double read FPRO_ESTOQUEMINIMO write FPRO_ESTOQUEMINIMO;
    const PRO_ESTOQUEMINIMO_Name = 'PRO_ESTOQUEMINIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_ESTOQUEMAXIMO', ftBCD, 18, 4)]
    [Dictionary('PRO_ESTOQUEMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_ESTOQUEMAXIMO: Double read FPRO_ESTOQUEMAXIMO write FPRO_ESTOQUEMAXIMO;
    const PRO_ESTOQUEMAXIMO_Name = 'PRO_ESTOQUEMAXIMO';

    [Restrictions([NoValidate])]
    [Column('PRO_VALORBASECALCULOMVA', ftBCD, 18, 4)]
    [Dictionary('PRO_VALORBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_VALORBASECALCULOMVA: Double read FPRO_VALORBASECALCULOMVA write FPRO_VALORBASECALCULOMVA;
    const PRO_VALORBASECALCULOMVA_Name = 'PRO_VALORBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PRO_ULTIMOFORNECEDOR', ftString, 6)]
    [Dictionary('PRO_ULTIMOFORNECEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_ULTIMOFORNECEDOR: String read FPRO_ULTIMOFORNECEDOR write FPRO_ULTIMOFORNECEDOR;
    const PRO_ULTIMOFORNECEDOR_Name = 'PRO_ULTIMOFORNECEDOR';

    [Restrictions([NoValidate])]
    [Column('PRO_ULTIMANFENTRADA', ftString, 9)]
    [Dictionary('PRO_ULTIMANFENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_ULTIMANFENTRADA: String read FPRO_ULTIMANFENTRADA write FPRO_ULTIMANFENTRADA;
    const PRO_ULTIMANFENTRADA_Name = 'PRO_ULTIMANFENTRADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_00_01)

end.
