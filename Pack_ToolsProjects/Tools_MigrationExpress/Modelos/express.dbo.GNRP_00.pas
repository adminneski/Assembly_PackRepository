unit express.dbo.GNRP_00;

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
  [Table('GNRP_00', '')]
  [PrimaryKey('GNRP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('COM_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_GNRP_CODIGO')]
  [Sequence('SEQ_COM_CODIGO')]
  TDtoGNRP_00 = class
  private
    { Private declarations } 
    FGNRP_CODIGO: String;
    FCOM_CODIGO: Integer;
    FGNRP_UF: String;
    FGNRP_CODIGOUF: String;
    FGNRP_REGIAO: String;
    FGNRP_BANCO: String;
    FGNRP_AGENCIA: String;
    FGNRP_RECEITA: String;
    FGNRP_CONDICAOPAGTO: String;
    FGNRP_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'GNRP_00';
     const PrimaryKey = 'GNRP_CODIGO';
     const Sequence   = 'SEQ_GNRP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GNRP_CODIGO', ftString, 3)]
    [Dictionary('GNRP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_CODIGO: String read FGNRP_CODIGO write FGNRP_CODIGO;
    const GNRP_CODIGO_Name = 'GNRP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GNRP_UF', ftString, 2)]
    [Dictionary('GNRP_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_UF: String read FGNRP_UF write FGNRP_UF;
    const GNRP_UF_Name = 'GNRP_UF';

    [Restrictions([NoValidate])]
    [Column('GNRP_CODIGOUF', ftString, 3)]
    [Dictionary('GNRP_CODIGOUF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_CODIGOUF: String read FGNRP_CODIGOUF write FGNRP_CODIGOUF;
    const GNRP_CODIGOUF_Name = 'GNRP_CODIGOUF';

    [Restrictions([NoValidate])]
    [Column('GNRP_REGIAO', ftString, 3)]
    [Dictionary('GNRP_REGIAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_REGIAO: String read FGNRP_REGIAO write FGNRP_REGIAO;
    const GNRP_REGIAO_Name = 'GNRP_REGIAO';

    [Restrictions([NoValidate])]
    [Column('GNRP_BANCO', ftString, 3)]
    [Dictionary('GNRP_BANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_BANCO: String read FGNRP_BANCO write FGNRP_BANCO;
    const GNRP_BANCO_Name = 'GNRP_BANCO';

    [Restrictions([NoValidate])]
    [Column('GNRP_AGENCIA', ftString, 6)]
    [Dictionary('GNRP_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_AGENCIA: String read FGNRP_AGENCIA write FGNRP_AGENCIA;
    const GNRP_AGENCIA_Name = 'GNRP_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('GNRP_RECEITA', ftString, 6)]
    [Dictionary('GNRP_RECEITA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_RECEITA: String read FGNRP_RECEITA write FGNRP_RECEITA;
    const GNRP_RECEITA_Name = 'GNRP_RECEITA';

    [Restrictions([NoValidate])]
    [Column('GNRP_CONDICAOPAGTO', ftString, 1)]
    [Dictionary('GNRP_CONDICAOPAGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRP_CONDICAOPAGTO: String read FGNRP_CONDICAOPAGTO write FGNRP_CONDICAOPAGTO;
    const GNRP_CONDICAOPAGTO_Name = 'GNRP_CONDICAOPAGTO';

    [Restrictions([NoValidate])]
    [Column('GNRP_DATAALTERACAO', ftDateTime)]
    [Dictionary('GNRP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property GNRP_DATAALTERACAO: TDateTime read FGNRP_DATAALTERACAO write FGNRP_DATAALTERACAO;
    const GNRP_DATAALTERACAO_Name = 'GNRP_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGNRP_00)

end.
