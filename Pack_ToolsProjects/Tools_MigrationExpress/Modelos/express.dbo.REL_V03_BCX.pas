unit express.dbo.REL_V03_BCX;

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
  [Table('REL_V03_BCX', '')]
  TDtoREL_V03_BCX = class
  private
    { Private declarations } 
    FBCX_ORDEM: Integer;
    FBCX_TIPO: String;
    FBCX_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FBCX_NUMERODOCTO: String;
    FBCX_DATAEMISSAO: TDateTime;
    FBCX_DATAVENCTO: TDateTime;
    FBCX_TOTALVALOR: Double;
    FBCX_TIPODOCUMENTO: String;
    FBCX_SIGLATIPODOCUMENTO: String;
    FBCX_STATUS: String;
    FBCX_DESATIVADO: String;
    FBCX_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V03_BCX';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_ORDEM', ftInteger)]
    [Dictionary('BCX_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ORDEM: Integer read FBCX_ORDEM write FBCX_ORDEM;
    const BCX_ORDEM_Name = 'BCX_ORDEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_TIPO', ftString, 3)]
    [Dictionary('BCX_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPO: String read FBCX_TIPO write FBCX_TIPO;
    const BCX_TIPO_Name = 'BCX_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_ID', ftInteger)]
    [Dictionary('BCX_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCX_ID: Integer read FBCX_ID write FBCX_ID;
    const BCX_ID_Name = 'BCX_ID';

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
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('BCX_NUMERODOCTO', ftString, 20)]
    [Dictionary('BCX_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_NUMERODOCTO: String read FBCX_NUMERODOCTO write FBCX_NUMERODOCTO;
    const BCX_NUMERODOCTO_Name = 'BCX_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('BCX_DATAEMISSAO', ftDateTime)]
    [Dictionary('BCX_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCX_DATAEMISSAO: TDateTime read FBCX_DATAEMISSAO write FBCX_DATAEMISSAO;
    const BCX_DATAEMISSAO_Name = 'BCX_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('BCX_DATAVENCTO', ftDateTime)]
    [Dictionary('BCX_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCX_DATAVENCTO: TDateTime read FBCX_DATAVENCTO write FBCX_DATAVENCTO;
    const BCX_DATAVENCTO_Name = 'BCX_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('BCX_TOTALVALOR', ftBCD)]
    [Dictionary('BCX_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCX_TOTALVALOR: Double read FBCX_TOTALVALOR write FBCX_TOTALVALOR;
    const BCX_TOTALVALOR_Name = 'BCX_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('BCX_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('BCX_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_TIPODOCUMENTO: String read FBCX_TIPODOCUMENTO write FBCX_TIPODOCUMENTO;
    const BCX_TIPODOCUMENTO_Name = 'BCX_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCX_SIGLATIPODOCUMENTO', ftString, 3)]
    [Dictionary('BCX_SIGLATIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_SIGLATIPODOCUMENTO: String read FBCX_SIGLATIPODOCUMENTO write FBCX_SIGLATIPODOCUMENTO;
    const BCX_SIGLATIPODOCUMENTO_Name = 'BCX_SIGLATIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('BCX_STATUS', ftString, 1)]
    [Dictionary('BCX_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_STATUS: String read FBCX_STATUS write FBCX_STATUS;
    const BCX_STATUS_Name = 'BCX_STATUS';

    [Restrictions([NoValidate])]
    [Column('BCX_DESATIVADO', ftString, 1)]
    [Dictionary('BCX_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_DESATIVADO: String read FBCX_DESATIVADO write FBCX_DESATIVADO;
    const BCX_DESATIVADO_Name = 'BCX_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('BCX_OBSERVACAO', ftString, 5000)]
    [Dictionary('BCX_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCX_OBSERVACAO: String read FBCX_OBSERVACAO write FBCX_OBSERVACAO;
    const BCX_OBSERVACAO_Name = 'BCX_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V03_BCX)

end.
