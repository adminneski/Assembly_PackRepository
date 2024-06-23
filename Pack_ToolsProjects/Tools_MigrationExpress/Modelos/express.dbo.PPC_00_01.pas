unit express.dbo.PPC_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ppc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PPC_00_01', '')]
  [PrimaryKey('PPC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PPC_01_ID')]
  TDtoPPC_00_01 = class
  private
    { Private declarations } 
    FPPC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPPC_ID: Integer;
    FPRO_CODIGO: Integer;
    FPPC_QTDPERDAPRODUCAO: Double;
    FPPC_VALORCUSTOCOMPRA: Double;
    FPPC_VALORCUSTOLIQUIDO: Double;
    FPPC_VALORCUSTOINVENTARIO: Double;
    FPPC_VALORCUSTOCOMPRAMEDIO: Double;
    FPPC_VALORCUSTOLIQUIDOMEDIO: Double;
    FPPC_VALORCUSTOINVENTARIOMEDIO: Double;
    FPPC_DATAALTERACAO: TDateTime;
    FPPC_01_ID_OLD: Integer;
    FPPC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PPC_00_01';
    const PrimaryKey = 'PPC_01_ID';
    const Sequence   = 'SEQ_PPC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPC_01_ID', ftInteger)]
    [Dictionary('PPC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPC_01_ID: Integer read FPPC_01_ID write FPPC_01_ID;
    const PPC_01_ID_Name = 'PPC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PPC_ID', ftInteger)]
    [ForeignKey('PPC_00_01_fk', 'PPC_ID', 'PPC_00', 'PPC_ID', SetNull, SetNull)]
    [Dictionary('PPC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPC_ID: Integer read FPPC_ID write FPPC_ID;
    const PPC_ID_Name = 'PPC_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PPC_QTDPERDAPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('PPC_QTDPERDAPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_QTDPERDAPRODUCAO: Double read FPPC_QTDPERDAPRODUCAO write FPPC_QTDPERDAPRODUCAO;
    const PPC_QTDPERDAPRODUCAO_Name = 'PPC_QTDPERDAPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('PPC_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('PPC_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_VALORCUSTOCOMPRA: Double read FPPC_VALORCUSTOCOMPRA write FPPC_VALORCUSTOCOMPRA;
    const PPC_VALORCUSTOCOMPRA_Name = 'PPC_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('PPC_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PPC_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_VALORCUSTOLIQUIDO: Double read FPPC_VALORCUSTOLIQUIDO write FPPC_VALORCUSTOLIQUIDO;
    const PPC_VALORCUSTOLIQUIDO_Name = 'PPC_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PPC_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('PPC_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_VALORCUSTOINVENTARIO: Double read FPPC_VALORCUSTOINVENTARIO write FPPC_VALORCUSTOINVENTARIO;
    const PPC_VALORCUSTOINVENTARIO_Name = 'PPC_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('PPC_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPC_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_VALORCUSTOCOMPRAMEDIO: Double read FPPC_VALORCUSTOCOMPRAMEDIO write FPPC_VALORCUSTOCOMPRAMEDIO;
    const PPC_VALORCUSTOCOMPRAMEDIO_Name = 'PPC_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPC_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPC_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_VALORCUSTOLIQUIDOMEDIO: Double read FPPC_VALORCUSTOLIQUIDOMEDIO write FPPC_VALORCUSTOLIQUIDOMEDIO;
    const PPC_VALORCUSTOLIQUIDOMEDIO_Name = 'PPC_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPC_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPC_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_VALORCUSTOINVENTARIOMEDIO: Double read FPPC_VALORCUSTOINVENTARIOMEDIO write FPPC_VALORCUSTOINVENTARIOMEDIO;
    const PPC_VALORCUSTOINVENTARIOMEDIO_Name = 'PPC_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PPC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PPC_DATAALTERACAO: TDateTime read FPPC_DATAALTERACAO write FPPC_DATAALTERACAO;
    const PPC_DATAALTERACAO_Name = 'PPC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PPC_01_ID_OLD', ftInteger)]
    [Dictionary('PPC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPC_01_ID_OLD: Integer read FPPC_01_ID_OLD write FPPC_01_ID_OLD;
    const PPC_01_ID_OLD_Name = 'PPC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PPC_ID_OLD', ftInteger)]
    [Dictionary('PPC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPC_ID_OLD: Integer read FPPC_ID_OLD write FPPC_ID_OLD;
    const PPC_ID_OLD_Name = 'PPC_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoPPC_00_01)

end.
