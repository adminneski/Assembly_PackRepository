unit Dto.PARAMS_00_01;

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
  [Table('PARAMS_00_01', '')]
  TDtoPARAMS_00_01 = class
  private
    { Private declarations } 
    FPAR_01_ID: Integer;
    FPAR_CODIGO: Integer;
    FPAR_IMP_KEY: String;
    FPAR_IMP_PORTA: String;
    FPAR_IMP_MODELOINDEX: Integer;
    FPAR_IMP_MODELOSTR: String;
    FPAR_IMP_DPI: Integer;
    FPAR_IMP_TEMPERATURA: Integer;
    FPAR_IMP_MARGEMESQUERDA: Integer;
    FPAR_IMP_VELOCIDADE: Integer;
    FPAR_IMP_AVANCOETIQUETA: Integer;
    FPAR_IMP_BACKFEED: Integer;
    FPAR_IMP_PAGINACODIGO: Integer;
    FPAR_IMP_ORIGEM: Integer;
    FPAR_IMP_LIMPARMEMORIA: String;
  public 
    { Public declarations } 
    const Table      = 'PARAMS_00_01';

    [Restrictions([NoValidate])]
    [Column('PAR_01_ID', ftInteger)]
    [ColumnDBGrid('PAR_01_ID', 'PAR_01_ID', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_01_ID', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_01_ID: Integer read FPAR_01_ID write FPAR_01_ID;

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_CODIGO', ftInteger)]
    [ColumnDBGrid('PAR_CODIGO', 'PAR_CODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_CODIGO: Integer read FPAR_CODIGO write FPAR_CODIGO;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_KEY', ftString, 50)]
    [ColumnDBGrid('PAR_IMP_KEY', 'PAR_IMP_KEY', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_IMP_KEY', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_IMP_KEY: String read FPAR_IMP_KEY write FPAR_IMP_KEY;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_PORTA', ftString, 5)]
    [ColumnDBGrid('PAR_IMP_PORTA', 'PAR_IMP_PORTA', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_IMP_PORTA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_IMP_PORTA: String read FPAR_IMP_PORTA write FPAR_IMP_PORTA;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_MODELOINDEX', ftInteger)]
    [ColumnDBGrid('PAR_IMP_MODELOINDEX', 'PAR_IMP_MODELOINDEX', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_MODELOINDEX', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_MODELOINDEX: Integer read FPAR_IMP_MODELOINDEX write FPAR_IMP_MODELOINDEX;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_MODELOSTR', ftString, 50)]
    [ColumnDBGrid('PAR_IMP_MODELOSTR', 'PAR_IMP_MODELOSTR', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_IMP_MODELOSTR', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_IMP_MODELOSTR: String read FPAR_IMP_MODELOSTR write FPAR_IMP_MODELOSTR;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_DPI', ftInteger)]
    [ColumnDBGrid('PAR_IMP_DPI', 'PAR_IMP_DPI', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_DPI', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_DPI: Integer read FPAR_IMP_DPI write FPAR_IMP_DPI;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_TEMPERATURA', ftInteger)]
    [ColumnDBGrid('PAR_IMP_TEMPERATURA', 'PAR_IMP_TEMPERATURA', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_TEMPERATURA', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_TEMPERATURA: Integer read FPAR_IMP_TEMPERATURA write FPAR_IMP_TEMPERATURA;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_MARGEMESQUERDA', ftInteger)]
    [ColumnDBGrid('PAR_IMP_MARGEMESQUERDA', 'PAR_IMP_MARGEMESQUERDA', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_MARGEMESQUERDA', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_MARGEMESQUERDA: Integer read FPAR_IMP_MARGEMESQUERDA write FPAR_IMP_MARGEMESQUERDA;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_VELOCIDADE', ftInteger)]
    [ColumnDBGrid('PAR_IMP_VELOCIDADE', 'PAR_IMP_VELOCIDADE', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_VELOCIDADE', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_VELOCIDADE: Integer read FPAR_IMP_VELOCIDADE write FPAR_IMP_VELOCIDADE;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_AVANCOETIQUETA', ftInteger)]
    [ColumnDBGrid('PAR_IMP_AVANCOETIQUETA', 'PAR_IMP_AVANCOETIQUETA', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_AVANCOETIQUETA', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_AVANCOETIQUETA: Integer read FPAR_IMP_AVANCOETIQUETA write FPAR_IMP_AVANCOETIQUETA;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_BACKFEED', ftInteger)]
    [ColumnDBGrid('PAR_IMP_BACKFEED', 'PAR_IMP_BACKFEED', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_BACKFEED', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_BACKFEED: Integer read FPAR_IMP_BACKFEED write FPAR_IMP_BACKFEED;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_PAGINACODIGO', ftInteger)]
    [ColumnDBGrid('PAR_IMP_PAGINACODIGO', 'PAR_IMP_PAGINACODIGO', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_PAGINACODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_PAGINACODIGO: Integer read FPAR_IMP_PAGINACODIGO write FPAR_IMP_PAGINACODIGO;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_ORIGEM', ftInteger)]
    [ColumnDBGrid('PAR_IMP_ORIGEM', 'PAR_IMP_ORIGEM', 100, 'Arial', 10, clWindowText, False, taCenter, 'PSQ;')]
    [Dictionary('PAR_IMP_ORIGEM', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property PAR_IMP_ORIGEM: Integer read FPAR_IMP_ORIGEM write FPAR_IMP_ORIGEM;

    [Restrictions([NoValidate])]
    [Column('PAR_IMP_LIMPARMEMORIA', ftString, 1)]
    [ColumnDBGrid('PAR_IMP_LIMPARMEMORIA', 'PAR_IMP_LIMPARMEMORIA', 100, 'Arial', 10, clWindowText, False, taLeftJustify, 'PSQ;')]
    [Dictionary('PAR_IMP_LIMPARMEMORIA', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property PAR_IMP_LIMPARMEMORIA: String read FPAR_IMP_LIMPARMEMORIA write FPAR_IMP_LIMPARMEMORIA;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPARAMS_00_01)

end.
