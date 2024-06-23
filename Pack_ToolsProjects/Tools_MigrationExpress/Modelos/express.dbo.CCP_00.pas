unit express.dbo.CCP_00;

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
  [Table('CCP_00', '')]
  [PrimaryKey('CCP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CCP_CODIGO')]
  TDtoCCP_00 = class
  private
    { Private declarations } 
    FCCP_CODIGO: Integer;
    FCCP_CENTROCUSTO: String;
    FCCP_DESCRICAO: String;
    FCCP_VALORUNITARIO: Double;
    FCCP_PERCENTUALENCARGOS: Double;
    FCCP_FATORCALCULO: Integer;
    FCCP_MESESDURACAO: Integer;
    FCCP_TOTALVALOR: Double;
    FCCP_DATAALTERACAO: TDateTime;
    FCCP_DESATIVADO: String;
    FFSP_CODIGO: Integer;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CCP_00';
     const PrimaryKey = 'CCP_CODIGO';
     const Sequence   = 'SEQ_CCP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_CODIGO', ftInteger)]
    [Dictionary('CCP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCP_CODIGO: Integer read FCCP_CODIGO write FCCP_CODIGO;
    const CCP_CODIGO_Name = 'CCP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_CENTROCUSTO', ftString, 6)]
    [Dictionary('CCP_CENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCP_CENTROCUSTO: String read FCCP_CENTROCUSTO write FCCP_CENTROCUSTO;
    const CCP_CENTROCUSTO_Name = 'CCP_CENTROCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_DESCRICAO', ftString, 50)]
    [Dictionary('CCP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCP_DESCRICAO: String read FCCP_DESCRICAO write FCCP_DESCRICAO;
    const CCP_DESCRICAO_Name = 'CCP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_VALORUNITARIO', ftBCD)]
    [Dictionary('CCP_VALORUNITARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CCP_VALORUNITARIO: Double read FCCP_VALORUNITARIO write FCCP_VALORUNITARIO;
    const CCP_VALORUNITARIO_Name = 'CCP_VALORUNITARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_PERCENTUALENCARGOS', ftBCD)]
    [Dictionary('CCP_PERCENTUALENCARGOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CCP_PERCENTUALENCARGOS: Double read FCCP_PERCENTUALENCARGOS write FCCP_PERCENTUALENCARGOS;
    const CCP_PERCENTUALENCARGOS_Name = 'CCP_PERCENTUALENCARGOS';

    [Restrictions([NoValidate])]
    [Column('CCP_FATORCALCULO', ftInteger)]
    [Dictionary('CCP_FATORCALCULO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCP_FATORCALCULO: Integer read FCCP_FATORCALCULO write FCCP_FATORCALCULO;
    const CCP_FATORCALCULO_Name = 'CCP_FATORCALCULO';

    [Restrictions([NoValidate])]
    [Column('CCP_MESESDURACAO', ftInteger)]
    [Dictionary('CCP_MESESDURACAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCP_MESESDURACAO: Integer read FCCP_MESESDURACAO write FCCP_MESESDURACAO;
    const CCP_MESESDURACAO_Name = 'CCP_MESESDURACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_TOTALVALOR', ftBCD)]
    [Dictionary('CCP_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CCP_TOTALVALOR: Double read FCCP_TOTALVALOR write FCCP_TOTALVALOR;
    const CCP_TOTALVALOR_Name = 'CCP_TOTALVALOR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CCP_DATAALTERACAO: TDateTime read FCCP_DATAALTERACAO write FCCP_DATAALTERACAO;
    const CCP_DATAALTERACAO_Name = 'CCP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCP_DESATIVADO', ftString, 1)]
    [Dictionary('CCP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCP_DESATIVADO: String read FCCP_DESATIVADO write FCCP_DESATIVADO;
    const CCP_DESATIVADO_Name = 'CCP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('FSP_CODIGO', ftInteger)]
    [Dictionary('FSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FSP_CODIGO: Integer read FFSP_CODIGO write FFSP_CODIGO;
    const FSP_CODIGO_Name = 'FSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCCP_00)

end.
