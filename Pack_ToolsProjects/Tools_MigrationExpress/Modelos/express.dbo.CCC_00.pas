unit express.dbo.CCC_00;

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
  [Table('CCC_00', '')]
  [PrimaryKey('CCC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CCC_ID')]
  TDtoCCC_00 = class
  private
    { Private declarations } 
    FCCC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FCCC_DATALANCAMENTO: TDateTime;
    FCCC_DIASRETORNO: Integer;
    FCCC_STATUS: String;
    FCCC_DATAALTERACAO: TDateTime;
    FCCC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CCC_00';
     const PrimaryKey = 'CCC_ID';
     const Sequence   = 'SEQ_CCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCC_ID', ftInteger)]
    [Dictionary('CCC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_ID: Integer read FCCC_ID write FCCC_ID;
    const CCC_ID_Name = 'CCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CCC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCC_DATALANCAMENTO: TDateTime read FCCC_DATALANCAMENTO write FCCC_DATALANCAMENTO;
    const CCC_DATALANCAMENTO_Name = 'CCC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CCC_DIASRETORNO', ftInteger)]
    [Dictionary('CCC_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_DIASRETORNO: Integer read FCCC_DIASRETORNO write FCCC_DIASRETORNO;
    const CCC_DIASRETORNO_Name = 'CCC_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('CCC_STATUS', ftString, 1)]
    [Dictionary('CCC_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCC_STATUS: String read FCCC_STATUS write FCCC_STATUS;
    const CCC_STATUS_Name = 'CCC_STATUS';

    [Restrictions([NoValidate])]
    [Column('CCC_DATAALTERACAO', ftDateTime)]
    [Dictionary('CCC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCC_DATAALTERACAO: TDateTime read FCCC_DATAALTERACAO write FCCC_DATAALTERACAO;
    const CCC_DATAALTERACAO_Name = 'CCC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CCC_ID_OLD', ftInteger)]
    [Dictionary('CCC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_ID_OLD: Integer read FCCC_ID_OLD write FCCC_ID_OLD;
    const CCC_ID_OLD_Name = 'CCC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCCC_00)

end.
