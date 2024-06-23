unit Dto.VW_ACCOUNT_E_ACCOUNTGROUP;

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
  [Table('VW_ACCOUNT_E_ACCOUNTGROUP', '')]
  TDtoVW_ACCOUNT_E_ACCOUNTGROUP = class
  private
    { Private declarations } 
    FACC_CODIGO: Integer;
    FACC_FULLNAME: String;
    FDISPLAY_FULL: String;
    FREG_TYPE: String;
  public 
    { Public declarations } 
    const Table      = 'VW_ACCOUNT_E_ACCOUNTGROUP';

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO', ftInteger)]
    [ColumnDBGrid('ACC_CODIGO', 'ACC_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('ACC_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property ACC_CODIGO: Integer read FACC_CODIGO write FACC_CODIGO;

    [Restrictions([NoValidate])]
    [Column('ACC_FULLNAME', ftString, 100)]
    [ColumnDBGrid('ACC_FULLNAME', 'ACC_FULLNAME', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('ACC_FULLNAME', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property ACC_FULLNAME: String read FACC_FULLNAME write FACC_FULLNAME;

    [Restrictions([NoValidate])]
    [Column('DISPLAY_FULL', ftString, 108)]
    [ColumnDBGrid('DISPLAY_FULL', 'DISPLAY_FULL', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('DISPLAY_FULL', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property DISPLAY_FULL: String read FDISPLAY_FULL write FDISPLAY_FULL;

    [Restrictions([NoValidate, NotNull])]
    [Column('REG_TYPE', ftString, 3)]
    [ColumnDBGrid('REG_TYPE', 'REG_TYPE', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('REG_TYPE', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property REG_TYPE: String read FREG_TYPE write FREG_TYPE;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_ACCOUNT_E_ACCOUNTGROUP)

end.
