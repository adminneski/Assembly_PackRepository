unit express.dbo.GNRE_00;

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
  [Table('GNRE_00', '')]
  [PrimaryKey('GNRE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_GNRE_ID')]
  TDtoGNRE_00 = class
  private
    { Private declarations } 
    FGNRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FLEE_CODIGO: Integer;
    FCGA_ID: Integer;
    FGNRE_NOTAFISCAL: String;
    FGNRE_SERIE: String;
    FGNRE_TOTALVALOR: Double;
    FGNRE_UF: String;
    FGNRE_REGIAO: String;
    FGNRE_BANCO: String;
    FGNRE_AGENCIA: String;
    FGNRE_PERIODO: String;
    FGNRE_RECEITA: String;
    FGNRE_CONDICAOPAGTO: String;
    FGNRE_DATAEMISSAO: TDateTime;
    FGNRE_DATAVENCTO: TDateTime;
    FGNRE_OBSERVACAO: String;
    FGNRE_INTEGRACAO: String;
    FGNRE_DATAALTERACAO: TDateTime;
    FGNRE_NUMERODOCTO: String;
    FGNRE_NUMEROCONVENIO: String;
    FGNRE_ID_OLD: Integer;
    FCGA_ID_OLD: Integer;
    FGNRE_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'GNRE_00';
     const PrimaryKey = 'GNRE_ID';
     const Sequence   = 'SEQ_GNRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('GNRE_ID', ftInteger)]
    [Dictionary('GNRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property GNRE_ID: Integer read FGNRE_ID write FGNRE_ID;
    const GNRE_ID_Name = 'GNRE_ID';

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
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('GNRE_NOTAFISCAL', ftString, 9)]
    [Dictionary('GNRE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_NOTAFISCAL: String read FGNRE_NOTAFISCAL write FGNRE_NOTAFISCAL;
    const GNRE_NOTAFISCAL_Name = 'GNRE_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('GNRE_SERIE', ftString, 3)]
    [Dictionary('GNRE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_SERIE: String read FGNRE_SERIE write FGNRE_SERIE;
    const GNRE_SERIE_Name = 'GNRE_SERIE';

    [Restrictions([NoValidate])]
    [Column('GNRE_TOTALVALOR', ftBCD)]
    [Dictionary('GNRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property GNRE_TOTALVALOR: Double read FGNRE_TOTALVALOR write FGNRE_TOTALVALOR;
    const GNRE_TOTALVALOR_Name = 'GNRE_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('GNRE_UF', ftString, 3)]
    [Dictionary('GNRE_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_UF: String read FGNRE_UF write FGNRE_UF;
    const GNRE_UF_Name = 'GNRE_UF';

    [Restrictions([NoValidate])]
    [Column('GNRE_REGIAO', ftString, 3)]
    [Dictionary('GNRE_REGIAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_REGIAO: String read FGNRE_REGIAO write FGNRE_REGIAO;
    const GNRE_REGIAO_Name = 'GNRE_REGIAO';

    [Restrictions([NoValidate])]
    [Column('GNRE_BANCO', ftString, 3)]
    [Dictionary('GNRE_BANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_BANCO: String read FGNRE_BANCO write FGNRE_BANCO;
    const GNRE_BANCO_Name = 'GNRE_BANCO';

    [Restrictions([NoValidate])]
    [Column('GNRE_AGENCIA', ftString, 6)]
    [Dictionary('GNRE_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_AGENCIA: String read FGNRE_AGENCIA write FGNRE_AGENCIA;
    const GNRE_AGENCIA_Name = 'GNRE_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('GNRE_PERIODO', ftString, 6)]
    [Dictionary('GNRE_PERIODO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_PERIODO: String read FGNRE_PERIODO write FGNRE_PERIODO;
    const GNRE_PERIODO_Name = 'GNRE_PERIODO';

    [Restrictions([NoValidate])]
    [Column('GNRE_RECEITA', ftString, 6)]
    [Dictionary('GNRE_RECEITA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_RECEITA: String read FGNRE_RECEITA write FGNRE_RECEITA;
    const GNRE_RECEITA_Name = 'GNRE_RECEITA';

    [Restrictions([NoValidate])]
    [Column('GNRE_CONDICAOPAGTO', ftString, 1)]
    [Dictionary('GNRE_CONDICAOPAGTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_CONDICAOPAGTO: String read FGNRE_CONDICAOPAGTO write FGNRE_CONDICAOPAGTO;
    const GNRE_CONDICAOPAGTO_Name = 'GNRE_CONDICAOPAGTO';

    [Restrictions([NoValidate])]
    [Column('GNRE_DATAEMISSAO', ftDateTime)]
    [Dictionary('GNRE_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property GNRE_DATAEMISSAO: TDateTime read FGNRE_DATAEMISSAO write FGNRE_DATAEMISSAO;
    const GNRE_DATAEMISSAO_Name = 'GNRE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('GNRE_DATAVENCTO', ftDateTime)]
    [Dictionary('GNRE_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property GNRE_DATAVENCTO: TDateTime read FGNRE_DATAVENCTO write FGNRE_DATAVENCTO;
    const GNRE_DATAVENCTO_Name = 'GNRE_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('GNRE_OBSERVACAO', ftString, 300)]
    [Dictionary('GNRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_OBSERVACAO: String read FGNRE_OBSERVACAO write FGNRE_OBSERVACAO;
    const GNRE_OBSERVACAO_Name = 'GNRE_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('GNRE_INTEGRACAO', ftString, 20)]
    [Dictionary('GNRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_INTEGRACAO: String read FGNRE_INTEGRACAO write FGNRE_INTEGRACAO;
    const GNRE_INTEGRACAO_Name = 'GNRE_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('GNRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('GNRE_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property GNRE_DATAALTERACAO: TDateTime read FGNRE_DATAALTERACAO write FGNRE_DATAALTERACAO;
    const GNRE_DATAALTERACAO_Name = 'GNRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('GNRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('GNRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_NUMERODOCTO: String read FGNRE_NUMERODOCTO write FGNRE_NUMERODOCTO;
    const GNRE_NUMERODOCTO_Name = 'GNRE_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('GNRE_NUMEROCONVENIO', ftString, 30)]
    [Dictionary('GNRE_NUMEROCONVENIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_NUMEROCONVENIO: String read FGNRE_NUMEROCONVENIO write FGNRE_NUMEROCONVENIO;
    const GNRE_NUMEROCONVENIO_Name = 'GNRE_NUMEROCONVENIO';

    [Restrictions([NoValidate])]
    [Column('GNRE_ID_OLD', ftInteger)]
    [Dictionary('GNRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property GNRE_ID_OLD: Integer read FGNRE_ID_OLD write FGNRE_ID_OLD;
    const GNRE_ID_OLD_Name = 'GNRE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CGA_ID_OLD', ftInteger)]
    [Dictionary('CGA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID_OLD: Integer read FCGA_ID_OLD write FCGA_ID_OLD;
    const CGA_ID_OLD_Name = 'CGA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('GNRE_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('GNRE_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_INTEGRACAO_OLD: String read FGNRE_INTEGRACAO_OLD write FGNRE_INTEGRACAO_OLD;
    const GNRE_INTEGRACAO_OLD_Name = 'GNRE_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGNRE_00)

end.
