unit Dto.PARAMS_00;

interface

uses
  System.SysUtils, 
  System.Classes, 
  Vcl.Graphics, 
  Data.DB, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.consts,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes,
  //Application 
  Core.Mapping.Attributes;

type
  [Entity]
  [Table('PARAMS_00', '')]
  TDtoPARAMS_00 = class
  private
    { Private declarations } 
    FPAR_CODIGO: Integer;
    FPAR_KEY: String;
  public 
    { Public declarations } 
    const Table      = 'PARAMS_00';

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_CODIGO', ftInteger)]
    [ColumnDBGrid('PAR_CODIGO', 'PAR_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_CODIGO: Integer read FPAR_CODIGO write FPAR_CODIGO;

    [Restrictions([NoValidate])]
    [Column('PAR_KEY', ftString, 50)]
    [ColumnDBGrid('PAR_KEY', 'PAR_KEY', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_KEY', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_KEY: String read FPAR_KEY write FPAR_KEY;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPARAMS_00)

end.
