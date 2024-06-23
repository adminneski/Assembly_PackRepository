unit express.dbo.G_TML_00;

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
  [Table('G_TML_00', '')]
  [PrimaryKey('TML_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TML_ID')]
  TDtoG_TML_00 = class
  private
    { Private declarations } 
    FTML_ID: Integer;
    FPES_CODIGO: Integer;
    FTML_OPERADOR: String;
    FTML_ATENDENTE: String;
    FTML_ASSUNTO: String;
    FTML_SOLUCAO: String;
    FTML_DATAHORAINICIAL: TDateTime;
    FTML_DATAHORAFINAL: TDateTime;
    FTML_DATAALTERACAO: TDateTime;
    FTML_TITULO: String;
    FACC_ID: Integer;
    FTML_TIPOATENDIMENTO: String;
    FTML_EXTERNO: String;
    FHPA_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'G_TML_00';
     const PrimaryKey = 'TML_ID';
     const Sequence   = 'SEQ_TML_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TML_ID', ftInteger)]
    [Dictionary('TML_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TML_ID: Integer read FTML_ID write FTML_ID;
    const TML_ID_Name = 'TML_ID';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TML_OPERADOR', ftString, 50)]
    [Dictionary('TML_OPERADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TML_OPERADOR: String read FTML_OPERADOR write FTML_OPERADOR;
    const TML_OPERADOR_Name = 'TML_OPERADOR';

    [Restrictions([NoValidate])]
    [Column('TML_ATENDENTE', ftString, 100)]
    [Dictionary('TML_ATENDENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TML_ATENDENTE: String read FTML_ATENDENTE write FTML_ATENDENTE;
    const TML_ATENDENTE_Name = 'TML_ATENDENTE';

    [Restrictions([NoValidate])]
    [Column('TML_ASSUNTO', ftString, 5000)]
    [Dictionary('TML_ASSUNTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TML_ASSUNTO: String read FTML_ASSUNTO write FTML_ASSUNTO;
    const TML_ASSUNTO_Name = 'TML_ASSUNTO';

    [Restrictions([NoValidate])]
    [Column('TML_SOLUCAO', ftString, 5000)]
    [Dictionary('TML_SOLUCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TML_SOLUCAO: String read FTML_SOLUCAO write FTML_SOLUCAO;
    const TML_SOLUCAO_Name = 'TML_SOLUCAO';

    [Restrictions([NoValidate])]
    [Column('TML_DATAHORAINICIAL', ftDateTime)]
    [Dictionary('TML_DATAHORAINICIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property TML_DATAHORAINICIAL: TDateTime read FTML_DATAHORAINICIAL write FTML_DATAHORAINICIAL;
    const TML_DATAHORAINICIAL_Name = 'TML_DATAHORAINICIAL';

    [Restrictions([NoValidate])]
    [Column('TML_DATAHORAFINAL', ftDateTime)]
    [Dictionary('TML_DATAHORAFINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property TML_DATAHORAFINAL: TDateTime read FTML_DATAHORAFINAL write FTML_DATAHORAFINAL;
    const TML_DATAHORAFINAL_Name = 'TML_DATAHORAFINAL';

    [Restrictions([NoValidate])]
    [Column('TML_DATAALTERACAO', ftDateTime)]
    [Dictionary('TML_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property TML_DATAALTERACAO: TDateTime read FTML_DATAALTERACAO write FTML_DATAALTERACAO;
    const TML_DATAALTERACAO_Name = 'TML_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('TML_TITULO', ftString, 100)]
    [Dictionary('TML_TITULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TML_TITULO: String read FTML_TITULO write FTML_TITULO;
    const TML_TITULO_Name = 'TML_TITULO';

    [Restrictions([NoValidate])]
    [Column('ACC_ID', ftInteger)]
    [Dictionary('ACC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ACC_ID: Integer read FACC_ID write FACC_ID;
    const ACC_ID_Name = 'ACC_ID';

    [Restrictions([NoValidate])]
    [Column('TML_TIPOATENDIMENTO', ftString, 2)]
    [Dictionary('TML_TIPOATENDIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TML_TIPOATENDIMENTO: String read FTML_TIPOATENDIMENTO write FTML_TIPOATENDIMENTO;
    const TML_TIPOATENDIMENTO_Name = 'TML_TIPOATENDIMENTO';

    [Restrictions([NoValidate])]
    [Column('TML_EXTERNO', ftString, 1)]
    [Dictionary('TML_EXTERNO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TML_EXTERNO: String read FTML_EXTERNO write FTML_EXTERNO;
    const TML_EXTERNO_Name = 'TML_EXTERNO';

    [Restrictions([NoValidate])]
    [Column('HPA_CODIGO', ftInteger)]
    [Dictionary('HPA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HPA_CODIGO: Integer read FHPA_CODIGO write FHPA_CODIGO;
    const HPA_CODIGO_Name = 'HPA_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoG_TML_00)

end.
