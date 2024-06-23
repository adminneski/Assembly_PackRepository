unit Dto.PARAMS_00_02;

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
  [Table('PARAMS_00_02', '')]
  TDtoPARAMS_00_02 = class
  private
    { Private declarations } 
    FPAR_02_ID: Integer;
    FPAR_CODIGO: Integer;
    FPAR_BAL_KEY: String;
    FPAR_BAL_PORTA: String;
    FPAR_BAL_MODELOINDEX: Integer;
    FPAR_BAL_MODELOSTR: String;
    FPAR_BAL_HANDSHAKE: Integer;
    FPAR_BAL_PARITY: Integer;
    FPAR_BAL_STOPBITS: Integer;
    FPAR_BAL_DATABITS: Integer;
    FPAR_BAL_BAUDRATE: Integer;
    FPAR_BAL_TIMEOUT: Integer;
  public 
    { Public declarations } 
    const Table      = 'PARAMS_00_02';

    [Restrictions([NoValidate])]
    [Column('PAR_02_ID', ftInteger)]
    [ColumnDBGrid('PAR_02_ID', 'PAR_02_ID', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_02_ID', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_02_ID: Integer read FPAR_02_ID write FPAR_02_ID;

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_CODIGO', ftInteger)]
    [ColumnDBGrid('PAR_CODIGO', 'PAR_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_CODIGO: Integer read FPAR_CODIGO write FPAR_CODIGO;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_KEY', ftString, 50)]
    [ColumnDBGrid('PAR_BAL_KEY', 'PAR_BAL_KEY', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_BAL_KEY', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_BAL_KEY: String read FPAR_BAL_KEY write FPAR_BAL_KEY;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_PORTA', ftString, 5)]
    [ColumnDBGrid('PAR_BAL_PORTA', 'PAR_BAL_PORTA', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_BAL_PORTA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_BAL_PORTA: String read FPAR_BAL_PORTA write FPAR_BAL_PORTA;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_MODELOINDEX', ftInteger)]
    [ColumnDBGrid('PAR_BAL_MODELOINDEX', 'PAR_BAL_MODELOINDEX', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_BAL_MODELOINDEX', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_BAL_MODELOINDEX: Integer read FPAR_BAL_MODELOINDEX write FPAR_BAL_MODELOINDEX;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_MODELOSTR', ftString, 50)]
    [ColumnDBGrid('PAR_BAL_MODELOSTR', 'PAR_BAL_MODELOSTR', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_BAL_MODELOSTR', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_BAL_MODELOSTR: String read FPAR_BAL_MODELOSTR write FPAR_BAL_MODELOSTR;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_HANDSHAKE', ftInteger)]
    [ColumnDBGrid('PAR_BAL_HANDSHAKE', 'PAR_BAL_HANDSHAKE', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_BAL_HANDSHAKE', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_BAL_HANDSHAKE: Integer read FPAR_BAL_HANDSHAKE write FPAR_BAL_HANDSHAKE;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_PARITY', ftInteger)]
    [ColumnDBGrid('PAR_BAL_PARITY', 'PAR_BAL_PARITY', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_BAL_PARITY', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_BAL_PARITY: Integer read FPAR_BAL_PARITY write FPAR_BAL_PARITY;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_STOPBITS', ftInteger)]
    [ColumnDBGrid('PAR_BAL_STOPBITS', 'PAR_BAL_STOPBITS', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_BAL_STOPBITS', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_BAL_STOPBITS: Integer read FPAR_BAL_STOPBITS write FPAR_BAL_STOPBITS;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_DATABITS', ftInteger)]
    [ColumnDBGrid('PAR_BAL_DATABITS', 'PAR_BAL_DATABITS', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_BAL_DATABITS', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_BAL_DATABITS: Integer read FPAR_BAL_DATABITS write FPAR_BAL_DATABITS;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_BAUDRATE', ftInteger)]
    [ColumnDBGrid('PAR_BAL_BAUDRATE', 'PAR_BAL_BAUDRATE', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_BAL_BAUDRATE', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_BAL_BAUDRATE: Integer read FPAR_BAL_BAUDRATE write FPAR_BAL_BAUDRATE;

    [Restrictions([NoValidate])]
    [Column('PAR_BAL_TIMEOUT', ftInteger)]
    [ColumnDBGrid('PAR_BAL_TIMEOUT', 'PAR_BAL_TIMEOUT', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_BAL_TIMEOUT', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_BAL_TIMEOUT: Integer read FPAR_BAL_TIMEOUT write FPAR_BAL_TIMEOUT;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPARAMS_00_02)

end.
