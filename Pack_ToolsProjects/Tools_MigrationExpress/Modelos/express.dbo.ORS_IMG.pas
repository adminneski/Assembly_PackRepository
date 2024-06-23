unit express.dbo.ORS_IMG;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ors_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ORS_IMG', '')]
  [PrimaryKey('ORS_IMG_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ORS_IMG_ID')]
  TDtoORS_IMG = class
  private
    { Private declarations } 
    FORS_ID: Integer;
    FORS_IMG_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_IMAGEM: TBlob;
    FORS_DATAALTERACAO: TDateTime;
    FORS_IMG_ID_OLD: Integer;
    FORS_ID_OLD: Integer;

    FORS_00_0:  TORS_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'ORS_IMG';
     const PrimaryKey = 'ORS_IMG_ID';
     const Sequence   = 'SEQ_ORS_IMG_ID';

    [Restrictions([NoValidate])]
    [Column('ORS_ID', ftInteger)]
    [ForeignKey('ORS_IMG_fk', 'ORS_ID', 'ORS_00', 'ORS_ID', SetNull, SetNull)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_IMG_ID', ftInteger)]
    [Dictionary('ORS_IMG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_IMG_ID: Integer read FORS_IMG_ID write FORS_IMG_ID;
    const ORS_IMG_ID_Name = 'ORS_IMG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_IMAGEM', ftBlob)]
    [Dictionary('ORS_IMAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_IMAGEM: TBlob read FORS_IMAGEM write FORS_IMAGEM;
    const ORS_IMAGEM_Name = 'ORS_IMAGEM';

    [Restrictions([NoValidate])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_IMG_ID_OLD', ftInteger)]
    [Dictionary('ORS_IMG_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_IMG_ID_OLD: Integer read FORS_IMG_ID_OLD write FORS_IMG_ID_OLD;
    const ORS_IMG_ID_OLD_Name = 'ORS_IMG_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('ORS_ID_OLD', ftInteger)]
    [Dictionary('ORS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_OLD: Integer read FORS_ID_OLD write FORS_ID_OLD;
    const ORS_ID_OLD_Name = 'ORS_ID_OLD';

    [Association(OneToOne,'ORS_ID','ORS_00','ORS_ID')]
    property ORS_00: TORS_00 read FORS_00_0 write FORS_00_0;

  end;

implementation

constructor TORS_IMG.Create;
begin
  FORS_00_0 := TORS_00.Create;
end;

destructor TORS_IMG.Destroy;
begin
  if Assigned(FORS_00_0) then
    FORS_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoORS_IMG)

end.
