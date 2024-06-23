unit express.dbo.VW_PSQ_ORC;

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
  [Table('VW_PSQ_ORC', '')]
  TDtoVW_PSQ_ORC = class
  private
    { Private declarations } 
    FORS_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_NUMEROOS: Integer;
    FORS_NUMEROOC: Integer;
    FORS_NUMERODOCTO: String;
    FORS_NOTAFISCAL: String;
    FORS_NOTAFISCALSERVICO: String;
    FPES_CODIGO: Integer;
    FORS_DATAEMISSAO: TDateTime;
    FORS_TOTALLIQUIDO: Double;
    FORS_TIPODOCUMENTO: String;
    FORS_MESCLADO: String;
    FORS_BLOQUEADO: String;
    FORS_CANCELADA: String;
    FPES_NOME: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FORS_FATURADO: String;
    FVEI_PLACA: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_ORC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID', ftInteger)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOS', ftInteger)]
    [Dictionary('ORS_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOS: Integer read FORS_NUMEROOS write FORS_NUMEROOS;
    const ORS_NUMEROOS_Name = 'ORS_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOC', ftInteger)]
    [Dictionary('ORS_NUMEROOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOC: Integer read FORS_NUMEROOC write FORS_NUMEROOC;
    const ORS_NUMEROOC_Name = 'ORS_NUMEROOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_NUMERODOCTO', ftString, 10)]
    [Dictionary('ORS_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NUMERODOCTO: String read FORS_NUMERODOCTO write FORS_NUMERODOCTO;
    const ORS_NUMERODOCTO_Name = 'ORS_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('ORS_NOTAFISCAL', ftString, 9)]
    [Dictionary('ORS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCAL: String read FORS_NOTAFISCAL write FORS_NOTAFISCAL;
    const ORS_NOTAFISCAL_Name = 'ORS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('ORS_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('ORS_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCALSERVICO: String read FORS_NOTAFISCALSERVICO write FORS_NOTAFISCALSERVICO;
    const ORS_NOTAFISCALSERVICO_Name = 'ORS_NOTAFISCALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_DATAEMISSAO', ftDateTime)]
    [Dictionary('ORS_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ORS_DATAEMISSAO: TDateTime read FORS_DATAEMISSAO write FORS_DATAEMISSAO;
    const ORS_DATAEMISSAO_Name = 'ORS_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALLIQUIDO', ftBCD)]
    [Dictionary('ORS_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALLIQUIDO: Double read FORS_TOTALLIQUIDO write FORS_TOTALLIQUIDO;
    const ORS_TOTALLIQUIDO_Name = 'ORS_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('ORS_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPODOCUMENTO: String read FORS_TIPODOCUMENTO write FORS_TIPODOCUMENTO;
    const ORS_TIPODOCUMENTO_Name = 'ORS_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_MESCLADO', ftString, 1)]
    [Dictionary('ORS_MESCLADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_MESCLADO: String read FORS_MESCLADO write FORS_MESCLADO;
    const ORS_MESCLADO_Name = 'ORS_MESCLADO';

    [Restrictions([NoValidate])]
    [Column('ORS_BLOQUEADO', ftString, 1)]
    [Dictionary('ORS_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_BLOQUEADO: String read FORS_BLOQUEADO write FORS_BLOQUEADO;
    const ORS_BLOQUEADO_Name = 'ORS_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('ORS_CANCELADA', ftString, 1)]
    [Dictionary('ORS_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_CANCELADA: String read FORS_CANCELADA write FORS_CANCELADA;
    const ORS_CANCELADA_Name = 'ORS_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_FATURADO', ftString, 1)]
    [Dictionary('ORS_FATURADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_FATURADO: String read FORS_FATURADO write FORS_FATURADO;
    const ORS_FATURADO_Name = 'ORS_FATURADO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_ORC)

end.
