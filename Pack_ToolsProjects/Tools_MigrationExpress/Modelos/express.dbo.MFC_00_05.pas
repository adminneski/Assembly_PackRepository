unit express.dbo.MFC_00_05;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.mfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MFC_00_05', '')]
  [PrimaryKey('MFC_05_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MFC_05_ID')]
  TDtoMFC_00_05 = class
  private
    { Private declarations } 
    FMFC_05_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_ID: Integer;
    FMFC_UF: String;
    FMFC_ORDEMITEM: Integer;
    FMFC_DATAALTERACAO: TDateTime;
    FMFC_05_ID_OLD: Integer;
    FMFC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'MFC_00_05';
    const PrimaryKey = 'MFC_05_ID';
    const Sequence   = 'SEQ_MFC_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_05_ID', ftInteger)]
    [Dictionary('MFC_05_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_05_ID: Integer read FMFC_05_ID write FMFC_05_ID;
    const MFC_05_ID_Name = 'MFC_05_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [ForeignKey('MFC_00_05_fk', 'MFC_ID', 'MFC_00', 'MFC_ID', SetNull, SetNull)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate])]
    [Column('MFC_UF', ftString, 2)]
    [Dictionary('MFC_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_UF: String read FMFC_UF write FMFC_UF;
    const MFC_UF_Name = 'MFC_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ORDEMITEM', ftInteger)]
    [Dictionary('MFC_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ORDEMITEM: Integer read FMFC_ORDEMITEM write FMFC_ORDEMITEM;
    const MFC_ORDEMITEM_Name = 'MFC_ORDEMITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('MFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATAALTERACAO: TDateTime read FMFC_DATAALTERACAO write FMFC_DATAALTERACAO;
    const MFC_DATAALTERACAO_Name = 'MFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_05_ID_OLD', ftInteger)]
    [Dictionary('MFC_05_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_05_ID_OLD: Integer read FMFC_05_ID_OLD write FMFC_05_ID_OLD;
    const MFC_05_ID_OLD_Name = 'MFC_05_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_ID_OLD', ftInteger)]
    [Dictionary('MFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID_OLD: Integer read FMFC_ID_OLD write FMFC_ID_OLD;
    const MFC_ID_OLD_Name = 'MFC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_00_05)

end.
