unit express.dbo.CCU_00;

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
  [Table('CCU_00', '')]
  [PrimaryKey('CCU_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CCU_CODIGO')]
  TDtoCCU_00 = class
  private
    { Private declarations } 
    FCCU_CODIGO: Integer;
    FCCU_CENTROCUSTO: String;
    FCCU_DESCRICAO: String;
    FHSP_CODIGO: Integer;
    FCCU_DATAALTERACAO: TDateTime;
    FCCU_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CCU_00';
     const PrimaryKey = 'CCU_CODIGO';
     const Sequence   = 'SEQ_CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_CENTROCUSTO', ftString, 6)]
    [Dictionary('CCU_CENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCU_CENTROCUSTO: String read FCCU_CENTROCUSTO write FCCU_CENTROCUSTO;
    const CCU_CENTROCUSTO_Name = 'CCU_CENTROCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_DESCRICAO', ftString, 50)]
    [Dictionary('CCU_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCU_DESCRICAO: String read FCCU_DESCRICAO write FCCU_DESCRICAO;
    const CCU_DESCRICAO_Name = 'CCU_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_DATAALTERACAO', ftDateTime)]
    [Dictionary('CCU_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CCU_DATAALTERACAO: TDateTime read FCCU_DATAALTERACAO write FCCU_DATAALTERACAO;
    const CCU_DATAALTERACAO_Name = 'CCU_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_DESATIVADO', ftString, 1)]
    [Dictionary('CCU_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCU_DESATIVADO: String read FCCU_DESATIVADO write FCCU_DESATIVADO;
    const CCU_DESATIVADO_Name = 'CCU_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCCU_00)

end.
