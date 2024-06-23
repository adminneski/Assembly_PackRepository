unit express.dbo.NCM_00_01;

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
  [Table('NCM_00_01', '')]
  [PrimaryKey('NCM_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NCM_01_ID')]
  TDtoNCM_00_01 = class
  private
    { Private declarations } 
    FNCM_01_ID: Integer;
    FNCM_CODIGO: Integer;
    FGAI_CODIGO: Integer;
    FNCM_UF: String;
    FNCM_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'NCM_00_01';
     const PrimaryKey = 'NCM_01_ID';
     const Sequence   = 'SEQ_NCM_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_01_ID', ftInteger)]
    [Dictionary('NCM_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_01_ID: Integer read FNCM_01_ID write FNCM_01_ID;
    const NCM_01_ID_Name = 'NCM_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_CODIGO', ftInteger)]
    [Dictionary('NCM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NCM_CODIGO: Integer read FNCM_CODIGO write FNCM_CODIGO;
    const NCM_CODIGO_Name = 'NCM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GAI_CODIGO', ftInteger)]
    [Dictionary('GAI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GAI_CODIGO: Integer read FGAI_CODIGO write FGAI_CODIGO;
    const GAI_CODIGO_Name = 'GAI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NCM_UF', ftString, 2)]
    [Dictionary('NCM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NCM_UF: String read FNCM_UF write FNCM_UF;
    const NCM_UF_Name = 'NCM_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('NCM_DATAALTERACAO', ftDateTime)]
    [Dictionary('NCM_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NCM_DATAALTERACAO: TDateTime read FNCM_DATAALTERACAO write FNCM_DATAALTERACAO;
    const NCM_DATAALTERACAO_Name = 'NCM_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNCM_00_01)

end.
