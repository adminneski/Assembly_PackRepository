unit express.dbo.VW_PSQ_GNRE;

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
  [Table('VW_PSQ_GNRE', '')]
  TDtoVW_PSQ_GNRE = class
  private
    { Private declarations } 
    FGNRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FGNRE_NOTAFISCAL: String;
    FGNRE_SERIE: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FGNRE_DATAEMISSAO: TDateTime;
    FGNRE_DATAVENCTO: TDateTime;
    FGNRE_TOTALVALOR: Double;
    FGNRE_OBSERVACAO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_GNRE';

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
    [Column('GNRE_TOTALVALOR', ftBCD, 48, 2)]
    [Dictionary('GNRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property GNRE_TOTALVALOR: Double read FGNRE_TOTALVALOR write FGNRE_TOTALVALOR;
    const GNRE_TOTALVALOR_Name = 'GNRE_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('GNRE_OBSERVACAO', ftString, 300)]
    [Dictionary('GNRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_OBSERVACAO: String read FGNRE_OBSERVACAO write FGNRE_OBSERVACAO;
    const GNRE_OBSERVACAO_Name = 'GNRE_OBSERVACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_GNRE)

end.
