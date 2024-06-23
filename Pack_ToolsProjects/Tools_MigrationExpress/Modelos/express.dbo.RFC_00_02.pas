unit express.dbo.RFC_00_02;

interface

uses
  DB,
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.rfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('RFC_00_02', '')]
  [PrimaryKey('RFC_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RFC_02_ID')]
  TDtoRFC_00_02 = class
  private
    { Private declarations }
    FRFC_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FRFC_ID: Integer;
    FFAT_ID: Integer;
    FFAT_01_ID: Integer;
    FMDV_ID: Integer;
    FPRO_CODIGO: Integer;
    FRFC_PRECOLIQUIDO: Double;
    FRFC_QTDFATURADA: Double;
    FRFC_QTDFALTA: Double;
    FRFC_QTDQUEBRA: Double;
    FRFC_QTDDEVOLVIDA: Double;
    FRFC_VALORFALTA: Double;
    FRFC_VALORQUEBRA: Double;
    FRFC_VALORDEVOLUCAO: Double;
    FRFC_OBSERVACAO: String;
    FRFC_DATAALTERACAO: TDateTime;
    FGRD_CODIGO: String;
    FCOR_CODIGO: String;
    FRFC_02_ID_OLD: Integer;
    FRFC_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_01_ID_OLD: Integer;
  public
    { Public declarations }

    const Table      = 'RFC_00_02';
    const PrimaryKey = 'RFC_02_ID';
    const Sequence   = 'SEQ_RFC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_02_ID', ftInteger)]
    [Dictionary('RFC_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_02_ID: Integer read FRFC_02_ID write FRFC_02_ID;
    const RFC_02_ID_Name = 'RFC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_ID', ftInteger)]
    [ForeignKey('RFC_00_02_fk', 'RFC_ID', 'RFC_00', 'RFC_ID', SetNull, SetNull)]
    [Dictionary('RFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID: Integer read FRFC_ID write FRFC_ID;
    const RFC_ID_Name = 'RFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_01_ID', ftInteger)]
    [Dictionary('FAT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID: Integer read FFAT_01_ID write FFAT_01_ID;
    const FAT_01_ID_Name = 'FAT_01_ID';

    [Restrictions([NoValidate])]
    [Column('MDV_ID', ftInteger)]
    [Dictionary('MDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDV_ID: Integer read FMDV_ID write FMDV_ID;
    const MDV_ID_Name = 'MDV_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_PRECOLIQUIDO', ftBCD, 659507017, 2)]
    [Dictionary('RFC_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_PRECOLIQUIDO: Double read FRFC_PRECOLIQUIDO write FRFC_PRECOLIQUIDO;
    const RFC_PRECOLIQUIDO_Name = 'RFC_PRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_QTDFATURADA', ftBCD, 1869770784, 2)]
    [Dictionary('RFC_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_QTDFATURADA: Double read FRFC_QTDFATURADA write FRFC_QTDFATURADA;
    const RFC_QTDFATURADA_Name = 'RFC_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('RFC_QTDFALTA', ftBCD, 1529377646, 2)]
    [Dictionary('RFC_QTDFALTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_QTDFALTA: Double read FRFC_QTDFALTA write FRFC_QTDFALTA;
    const RFC_QTDFALTA_Name = 'RFC_QTDFALTA';

    [Restrictions([NoValidate])]
    [Column('RFC_QTDQUEBRA', ftBCD, 4522064, 2)]
    [Dictionary('RFC_QTDQUEBRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_QTDQUEBRA: Double read FRFC_QTDQUEBRA write FRFC_QTDQUEBRA;
    const RFC_QTDQUEBRA_Name = 'RFC_QTDQUEBRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_QTDDEVOLVIDA', ftBCD, 1952867660, 2)]
    [Dictionary('RFC_QTDDEVOLVIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_QTDDEVOLVIDA: Double read FRFC_QTDDEVOLVIDA write FRFC_QTDDEVOLVIDA;
    const RFC_QTDDEVOLVIDA_Name = 'RFC_QTDDEVOLVIDA';

    [Restrictions([NoValidate])]
    [Column('RFC_VALORFALTA', ftBCD, 1146045279, 2)]
    [Dictionary('RFC_VALORFALTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_VALORFALTA: Double read FRFC_VALORFALTA write FRFC_VALORFALTA;
    const RFC_VALORFALTA_Name = 'RFC_VALORFALTA';

    [Restrictions([NoValidate])]
    [Column('RFC_VALORQUEBRA', ftBCD, 656419879, 2)]
    [Dictionary('RFC_VALORQUEBRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_VALORQUEBRA: Double read FRFC_VALORQUEBRA write FRFC_VALORQUEBRA;
    const RFC_VALORQUEBRA_Name = 'RFC_VALORQUEBRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_VALORDEVOLUCAO', ftBCD, 6881394, 2)]
    [Dictionary('RFC_VALORDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_VALORDEVOLUCAO: Double read FRFC_VALORDEVOLUCAO write FRFC_VALORDEVOLUCAO;
    const RFC_VALORDEVOLUCAO_Name = 'RFC_VALORDEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('RFC_OBSERVACAO', ftString, 1000)]
    [Dictionary('RFC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_OBSERVACAO: String read FRFC_OBSERVACAO write FRFC_OBSERVACAO;
    const RFC_OBSERVACAO_Name = 'RFC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('RFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('RFC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property RFC_DATAALTERACAO: TDateTime read FRFC_DATAALTERACAO write FRFC_DATAALTERACAO;
    const RFC_DATAALTERACAO_Name = 'RFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COR_CODIGO', ftString, 3)]
    [Dictionary('COR_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COR_CODIGO: String read FCOR_CODIGO write FCOR_CODIGO;
    const COR_CODIGO_Name = 'COR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RFC_02_ID_OLD', ftInteger)]
    [Dictionary('RFC_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_02_ID_OLD: Integer read FRFC_02_ID_OLD write FRFC_02_ID_OLD;
    const RFC_02_ID_OLD_Name = 'RFC_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('RFC_ID_OLD', ftInteger)]
    [Dictionary('RFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID_OLD: Integer read FRFC_ID_OLD write FRFC_ID_OLD;
    const RFC_ID_OLD_Name = 'RFC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_01_ID_OLD', ftInteger)]
    [Dictionary('FAT_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID_OLD: Integer read FFAT_01_ID_OLD write FFAT_01_ID_OLD;
    const FAT_01_ID_OLD_Name = 'FAT_01_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRFC_00_02)

end.
