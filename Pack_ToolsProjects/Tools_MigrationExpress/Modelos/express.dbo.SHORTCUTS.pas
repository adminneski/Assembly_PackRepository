unit express.dbo.SHORTCUTS;

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
  [Table('SHORTCUTS', '')]
  [PrimaryKey('SHO_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_SHO_ID')]
  TDtoSHORTCUTS = class
  private
    { Private declarations } 
    FSHO_ID: Integer;
    FACC_CODIGO: Integer;
    FMEN_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'SHORTCUTS';
     const PrimaryKey = 'SHO_ID';
     const Sequence   = 'SEQ_SHO_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('SHO_ID', ftInteger)]
    [Dictionary('SHO_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SHO_ID: Integer read FSHO_ID write FSHO_ID;
    const SHO_ID_Name = 'SHO_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [Dictionary('ACC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;
    const ACC_CODIGO_Name = 'ACC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEN_CODIGO', ftInteger)]
    [Dictionary('MEN_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEN_CODIGO: Integer read FMEN_CODIGO write FMEN_CODIGO;
    const MEN_CODIGO_Name = 'MEN_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSHORTCUTS)

end.
