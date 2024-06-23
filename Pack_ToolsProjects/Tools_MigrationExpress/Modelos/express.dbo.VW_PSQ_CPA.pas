unit express.dbo.VW_PSQ_CPA;

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
  [Table('VW_PSQ_CPA', '')]
  TDtoVW_PSQ_CPA = class
  private
    { Private declarations } 
    FCPA_ID: Integer;
    FCPA_DC: String;
    FCOM_CODIGO: Integer;
    FCPA_DATAEMISSAO: TDateTime;
    FCPA_DATAVENCTO: TDateTime;
    FCPA_DESATIVADO: String;
    FCPA_NUMERODOCTO: String;
    FCPA_NOTAFISCAL: String;
    FCPA_ORDEMPARCIAL: Integer;
    FCPA_TOTALVALOR: Double;
    FCPA_STATUS: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FCPA_CHEQUEVINCULADO: String;
    FCPA_TIPODOCUMENTO: String;
    FCPA_SIGLATIPODOCUMENTO: String;
    FCPA_INTEGRACAO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CPA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate])]
    [Column('CPA_DC', ftString, 1)]
    [Dictionary('CPA_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DC: String read FCPA_DC write FCPA_DC;
    const CPA_DC_Name = 'CPA_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAEMISSAO', ftDateTime)]
    [Dictionary('CPA_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAEMISSAO: TDateTime read FCPA_DATAEMISSAO write FCPA_DATAEMISSAO;
    const CPA_DATAEMISSAO_Name = 'CPA_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAVENCTO', ftDateTime)]
    [Dictionary('CPA_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAVENCTO: TDateTime read FCPA_DATAVENCTO write FCPA_DATAVENCTO;
    const CPA_DATAVENCTO_Name = 'CPA_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DESATIVADO', ftString, 1)]
    [Dictionary('CPA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DESATIVADO: String read FCPA_DESATIVADO write FCPA_DESATIVADO;
    const CPA_DESATIVADO_Name = 'CPA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CPA_NUMERODOCTO', ftString, 20)]
    [Dictionary('CPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NUMERODOCTO: String read FCPA_NUMERODOCTO write FCPA_NUMERODOCTO;
    const CPA_NUMERODOCTO_Name = 'CPA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_NOTAFISCAL', ftString, 9)]
    [Dictionary('CPA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NOTAFISCAL: String read FCPA_NOTAFISCAL write FCPA_NOTAFISCAL;
    const CPA_NOTAFISCAL_Name = 'CPA_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPA_ORDEMPARCIAL', ftInteger)]
    [Dictionary('CPA_ORDEMPARCIAL', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ORDEMPARCIAL: Integer read FCPA_ORDEMPARCIAL write FCPA_ORDEMPARCIAL;
    const CPA_ORDEMPARCIAL_Name = 'CPA_ORDEMPARCIAL';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALOR', ftBCD)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('CPA_STATUS', ftString, 1)]
    [Dictionary('CPA_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_STATUS: String read FCPA_STATUS write FCPA_STATUS;
    const CPA_STATUS_Name = 'CPA_STATUS';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CPA_CHEQUEVINCULADO', ftString, 1)]
    [Dictionary('CPA_CHEQUEVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_CHEQUEVINCULADO: String read FCPA_CHEQUEVINCULADO write FCPA_CHEQUEVINCULADO;
    const CPA_CHEQUEVINCULADO_Name = 'CPA_CHEQUEVINCULADO';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPODOCUMENTO', ftString, 1)]
    [Dictionary('CPA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPODOCUMENTO: String read FCPA_TIPODOCUMENTO write FCPA_TIPODOCUMENTO;
    const CPA_TIPODOCUMENTO_Name = 'CPA_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_SIGLATIPODOCUMENTO', ftString, 3)]
    [Dictionary('CPA_SIGLATIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_SIGLATIPODOCUMENTO: String read FCPA_SIGLATIPODOCUMENTO write FCPA_SIGLATIPODOCUMENTO;
    const CPA_SIGLATIPODOCUMENTO_Name = 'CPA_SIGLATIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CPA_INTEGRACAO', ftString, 20)]
    [Dictionary('CPA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_INTEGRACAO: String read FCPA_INTEGRACAO write FCPA_INTEGRACAO;
    const CPA_INTEGRACAO_Name = 'CPA_INTEGRACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CPA)

end.
