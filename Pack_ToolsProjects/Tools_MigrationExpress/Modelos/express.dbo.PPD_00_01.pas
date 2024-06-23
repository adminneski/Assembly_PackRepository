unit express.dbo.PPD_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ppd_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PPD_00_01', '')]
  [PrimaryKey('PPD_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PPD_01_ID')]
  TDtoPPD_00_01 = class
  private
    { Private declarations } 
    FPPD_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPPD_ID: Integer;
    FPRO_CODIGO: Integer;
    FPPD_QTDPRODUCAO: Double;
    FPPD_PESOLIQUIDO: Double;
    FPPD_PRECOCUSTO: Double;
    FPPD_VALORPRODUTOPRIMARIO: Double;
    FPPD_VALORPRODUTOEMBALAGEM: Double;
    FPPD_ULTIMOCUSTOCOMPRA: Double;
    FPPD_ULTIMOCUSTOLIQUIDO: Double;
    FPPD_ULTIMOCUSTOINVENTARIO: Double;
    FPPD_ULTIMOCUSTOCOMPRAMEDIO: Double;
    FPPD_ULTIMOCUSTOLIQUIDOMEDIO: Double;
    FPPD_ULTIMOCUSTOINVENTARIOMEDIO: Double;
    FPPD_PRODUTOSEMCOMPOSICAO: String;
    FPPD_DATAALTERACAO: TDateTime;
    FPPD_01_ID_OLD: Integer;
    FPPD_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PPD_00_01';
    const PrimaryKey = 'PPD_01_ID';
    const Sequence   = 'SEQ_PPD_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_01_ID', ftInteger)]
    [Dictionary('PPD_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_01_ID: Integer read FPPD_01_ID write FPPD_01_ID;
    const PPD_01_ID_Name = 'PPD_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_ID', ftInteger)]
    [ForeignKey('PPD_00_01_fk', 'PPD_ID', 'PPD_00', 'PPD_ID', SetNull, SetNull)]
    [Dictionary('PPD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_ID: Integer read FPPD_ID write FPPD_ID;
    const PPD_ID_Name = 'PPD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_QTDPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('PPD_QTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_QTDPRODUCAO: Double read FPPD_QTDPRODUCAO write FPPD_QTDPRODUCAO;
    const PPD_QTDPRODUCAO_Name = 'PPD_QTDPRODUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PPD_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_PESOLIQUIDO: Double read FPPD_PESOLIQUIDO write FPPD_PESOLIQUIDO;
    const PPD_PESOLIQUIDO_Name = 'PPD_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PPD_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PPD_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_PRECOCUSTO: Double read FPPD_PRECOCUSTO write FPPD_PRECOCUSTO;
    const PPD_PRECOCUSTO_Name = 'PPD_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORPRODUTOPRIMARIO', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORPRODUTOPRIMARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORPRODUTOPRIMARIO: Double read FPPD_VALORPRODUTOPRIMARIO write FPPD_VALORPRODUTOPRIMARIO;
    const PPD_VALORPRODUTOPRIMARIO_Name = 'PPD_VALORPRODUTOPRIMARIO';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORPRODUTOEMBALAGEM', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORPRODUTOEMBALAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORPRODUTOEMBALAGEM: Double read FPPD_VALORPRODUTOEMBALAGEM write FPPD_VALORPRODUTOEMBALAGEM;
    const PPD_VALORPRODUTOEMBALAGEM_Name = 'PPD_VALORPRODUTOEMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PPD_ULTIMOCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('PPD_ULTIMOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_ULTIMOCUSTOCOMPRA: Double read FPPD_ULTIMOCUSTOCOMPRA write FPPD_ULTIMOCUSTOCOMPRA;
    const PPD_ULTIMOCUSTOCOMPRA_Name = 'PPD_ULTIMOCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('PPD_ULTIMOCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PPD_ULTIMOCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_ULTIMOCUSTOLIQUIDO: Double read FPPD_ULTIMOCUSTOLIQUIDO write FPPD_ULTIMOCUSTOLIQUIDO;
    const PPD_ULTIMOCUSTOLIQUIDO_Name = 'PPD_ULTIMOCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PPD_ULTIMOCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('PPD_ULTIMOCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_ULTIMOCUSTOINVENTARIO: Double read FPPD_ULTIMOCUSTOINVENTARIO write FPPD_ULTIMOCUSTOINVENTARIO;
    const PPD_ULTIMOCUSTOINVENTARIO_Name = 'PPD_ULTIMOCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('PPD_ULTIMOCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPD_ULTIMOCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_ULTIMOCUSTOCOMPRAMEDIO: Double read FPPD_ULTIMOCUSTOCOMPRAMEDIO write FPPD_ULTIMOCUSTOCOMPRAMEDIO;
    const PPD_ULTIMOCUSTOCOMPRAMEDIO_Name = 'PPD_ULTIMOCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPD_ULTIMOCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPD_ULTIMOCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_ULTIMOCUSTOLIQUIDOMEDIO: Double read FPPD_ULTIMOCUSTOLIQUIDOMEDIO write FPPD_ULTIMOCUSTOLIQUIDOMEDIO;
    const PPD_ULTIMOCUSTOLIQUIDOMEDIO_Name = 'PPD_ULTIMOCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPD_ULTIMOCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPD_ULTIMOCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_ULTIMOCUSTOINVENTARIOMEDIO: Double read FPPD_ULTIMOCUSTOINVENTARIOMEDIO write FPPD_ULTIMOCUSTOINVENTARIOMEDIO;
    const PPD_ULTIMOCUSTOINVENTARIOMEDIO_Name = 'PPD_ULTIMOCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPD_PRODUTOSEMCOMPOSICAO', ftString, 1)]
    [Dictionary('PPD_PRODUTOSEMCOMPOSICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPD_PRODUTOSEMCOMPOSICAO: String read FPPD_PRODUTOSEMCOMPOSICAO write FPPD_PRODUTOSEMCOMPOSICAO;
    const PPD_PRODUTOSEMCOMPOSICAO_Name = 'PPD_PRODUTOSEMCOMPOSICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_DATAALTERACAO', ftDateTime)]
    [Dictionary('PPD_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PPD_DATAALTERACAO: TDateTime read FPPD_DATAALTERACAO write FPPD_DATAALTERACAO;
    const PPD_DATAALTERACAO_Name = 'PPD_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PPD_01_ID_OLD', ftInteger)]
    [Dictionary('PPD_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_01_ID_OLD: Integer read FPPD_01_ID_OLD write FPPD_01_ID_OLD;
    const PPD_01_ID_OLD_Name = 'PPD_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PPD_ID_OLD', ftInteger)]
    [Dictionary('PPD_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_ID_OLD: Integer read FPPD_ID_OLD write FPPD_ID_OLD;
    const PPD_ID_OLD_Name = 'PPD_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPPD_00_01)

end.
