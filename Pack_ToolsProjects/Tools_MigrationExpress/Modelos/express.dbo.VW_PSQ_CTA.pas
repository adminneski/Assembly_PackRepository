unit express.dbo.VW_PSQ_CTA;

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
  [Table('VW_PSQ_CTA', '')]
  TDtoVW_PSQ_CTA = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FCTA_AGENCIA: String;
    FCTA_CONTA: String;
    FCTA_EMITENTE: String;
    FBCO_CODIGO: Integer;
    FBCO_NOME: String;
    FCTA_DESATIVADO: String;
    FCTA_CONTROLER: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_AGENCIA', ftString, 10)]
    [Dictionary('CTA_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_AGENCIA: String read FCTA_AGENCIA write FCTA_AGENCIA;
    const CTA_AGENCIA_Name = 'CTA_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTA', ftString, 15)]
    [Dictionary('CTA_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTA: String read FCTA_CONTA write FCTA_CONTA;
    const CTA_CONTA_Name = 'CTA_CONTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DESATIVADO', ftString, 1)]
    [Dictionary('CTA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DESATIVADO: String read FCTA_DESATIVADO write FCTA_DESATIVADO;
    const CTA_DESATIVADO_Name = 'CTA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTROLER', ftString, 1)]
    [Dictionary('CTA_CONTROLER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTROLER: String read FCTA_CONTROLER write FCTA_CONTROLER;
    const CTA_CONTROLER_Name = 'CTA_CONTROLER';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CTA)

end.
