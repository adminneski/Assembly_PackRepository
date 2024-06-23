unit express.dbo.ETQ_00_02;

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
  [Table('ETQ_00_02', '')]
  [PrimaryKey('ETQ_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ETQ_02_ID')]
  TDtoETQ_00_02 = class
  private
    { Private declarations } 
    FETQ_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FETQ_DATAVALIDADE: TDateTime;
    FETQ_QUANTIDADEVALIDADE: Double;
    FETQ_DATAALTERACAO: TDateTime;
    FETQ_02_ID_OLD: Integer;
    FETQ_LOTEVALIDADE: String;
  public 
    { Public declarations } 
     const Table      = 'ETQ_00_02';
     const PrimaryKey = 'ETQ_02_ID';
     const Sequence   = 'SEQ_ETQ_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_02_ID', ftInteger)]
    [Dictionary('ETQ_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQ_02_ID: Integer read FETQ_02_ID write FETQ_02_ID;
    const ETQ_02_ID_Name = 'ETQ_02_ID';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_DATAVALIDADE', ftDateTime)]
    [Dictionary('ETQ_DATAVALIDADE', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ETQ_DATAVALIDADE: TDateTime read FETQ_DATAVALIDADE write FETQ_DATAVALIDADE;
    const ETQ_DATAVALIDADE_Name = 'ETQ_DATAVALIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_QUANTIDADEVALIDADE', ftBCD, 18, 4)]
    [Dictionary('ETQ_QUANTIDADEVALIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QUANTIDADEVALIDADE: Double read FETQ_QUANTIDADEVALIDADE write FETQ_QUANTIDADEVALIDADE;
    const ETQ_QUANTIDADEVALIDADE_Name = 'ETQ_QUANTIDADEVALIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_DATAALTERACAO', ftDateTime)]
    [Dictionary('ETQ_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ETQ_DATAALTERACAO: TDateTime read FETQ_DATAALTERACAO write FETQ_DATAALTERACAO;
    const ETQ_DATAALTERACAO_Name = 'ETQ_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ETQ_02_ID_OLD', ftInteger)]
    [Dictionary('ETQ_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQ_02_ID_OLD: Integer read FETQ_02_ID_OLD write FETQ_02_ID_OLD;
    const ETQ_02_ID_OLD_Name = 'ETQ_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ETQ_LOTEVALIDADE', ftString, 30)]
    [Dictionary('ETQ_LOTEVALIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ETQ_LOTEVALIDADE: String read FETQ_LOTEVALIDADE write FETQ_LOTEVALIDADE;
    const ETQ_LOTEVALIDADE_Name = 'ETQ_LOTEVALIDADE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoETQ_00_02)

end.
