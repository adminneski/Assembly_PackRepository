unit express.dbo.RFC_00_01;

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
  [Table('RFC_00_01', '')]
  [PrimaryKey('RFC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RFC_01_ID')]
  TDtoRFC_00_01 = class
  private
    { Private declarations } 
    FRFC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FRFC_ID: Integer;
    FFAT_ID: Integer;
    FMDV_ID: Integer;
    FRFC_STATUS: String;
    FPES_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FFAT_NUMERODOCTO: String;
    FFAT_TOTALFATURADO: Double;
    FFAT_DATALANCAMENTO: TDateTime;
    FRFC_TOTALPARCELAMENTO: Double;
    FRFC_OBSERVACAOAVARIA: String;
    FRFC_TOTALAVARIA: Double;
    FRFC_TOTALFALTA: Double;
    FRFC_TOTALLIQUIDO: Double;
    FRFC_TOTALQUEBRA: Double;
    FRFC_TOTALDEVOLUCAO: Double;
    FRFC_FALTA: String;
    FRFC_AVARIA: String;
    FRFC_QUEBRA: String;
    FRFC_DEVOLUCAO: String;
    FRFC_CANCELADO: String;
    FRFC_REPARCELADO: String;
    FRFC_DATACANCELAMENTO: TDateTime;
    FRFC_OBSERVACAOCANCELAMENTO: String;
    FRFC_DATAALTERACAO: TDateTime;
    FRFC_01_ID_OLD: Integer;
    FRFC_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'RFC_00_01';
    const PrimaryKey = 'RFC_01_ID';
    const Sequence   = 'SEQ_RFC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_01_ID', ftInteger)]
    [Dictionary('RFC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_01_ID: Integer read FRFC_01_ID write FRFC_01_ID;
    const RFC_01_ID_Name = 'RFC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_ID', ftInteger)]
    [ForeignKey('RFC_00_01_fk', 'RFC_ID', 'RFC_00', 'RFC_ID', SetNull, SetNull)]
    [Dictionary('RFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_ID: Integer read FRFC_ID write FRFC_ID;
    const RFC_ID_Name = 'RFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('MDV_ID', ftInteger)]
    [Dictionary('MDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDV_ID: Integer read FMDV_ID write FMDV_ID;
    const MDV_ID_Name = 'MDV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_STATUS', ftString, 5)]
    [Dictionary('RFC_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_STATUS: String read FRFC_STATUS write FRFC_STATUS;
    const RFC_STATUS_Name = 'RFC_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMERODOCTO', ftString, 10)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALFATURADO', ftBCD, 659507017, 2)]
    [Dictionary('FAT_TOTALFATURADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFATURADO: Double read FFAT_TOTALFATURADO write FFAT_TOTALFATURADO;
    const FAT_TOTALFATURADO_Name = 'FAT_TOTALFATURADO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALPARCELAMENTO', ftBCD, 1869770784, 2)]
    [Dictionary('RFC_TOTALPARCELAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALPARCELAMENTO: Double read FRFC_TOTALPARCELAMENTO write FRFC_TOTALPARCELAMENTO;
    const RFC_TOTALPARCELAMENTO_Name = 'RFC_TOTALPARCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('RFC_OBSERVACAOAVARIA', ftString, 1000)]
    [Dictionary('RFC_OBSERVACAOAVARIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_OBSERVACAOAVARIA: String read FRFC_OBSERVACAOAVARIA write FRFC_OBSERVACAOAVARIA;
    const RFC_OBSERVACAOAVARIA_Name = 'RFC_OBSERVACAOAVARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALAVARIA', ftBCD, 1529377646, 2)]
    [Dictionary('RFC_TOTALAVARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALAVARIA: Double read FRFC_TOTALAVARIA write FRFC_TOTALAVARIA;
    const RFC_TOTALAVARIA_Name = 'RFC_TOTALAVARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALFALTA', ftBCD, 4522064, 2)]
    [Dictionary('RFC_TOTALFALTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALFALTA: Double read FRFC_TOTALFALTA write FRFC_TOTALFALTA;
    const RFC_TOTALFALTA_Name = 'RFC_TOTALFALTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALLIQUIDO', ftBCD, 1952867660, 2)]
    [Dictionary('RFC_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALLIQUIDO: Double read FRFC_TOTALLIQUIDO write FRFC_TOTALLIQUIDO;
    const RFC_TOTALLIQUIDO_Name = 'RFC_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALQUEBRA', ftBCD, 1146045279, 2)]
    [Dictionary('RFC_TOTALQUEBRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALQUEBRA: Double read FRFC_TOTALQUEBRA write FRFC_TOTALQUEBRA;
    const RFC_TOTALQUEBRA_Name = 'RFC_TOTALQUEBRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_TOTALDEVOLUCAO', ftBCD, 656419879, 2)]
    [Dictionary('RFC_TOTALDEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RFC_TOTALDEVOLUCAO: Double read FRFC_TOTALDEVOLUCAO write FRFC_TOTALDEVOLUCAO;
    const RFC_TOTALDEVOLUCAO_Name = 'RFC_TOTALDEVOLUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_FALTA', ftString, 1)]
    [Dictionary('RFC_FALTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_FALTA: String read FRFC_FALTA write FRFC_FALTA;
    const RFC_FALTA_Name = 'RFC_FALTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_AVARIA', ftString, 1)]
    [Dictionary('RFC_AVARIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_AVARIA: String read FRFC_AVARIA write FRFC_AVARIA;
    const RFC_AVARIA_Name = 'RFC_AVARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_QUEBRA', ftString, 1)]
    [Dictionary('RFC_QUEBRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_QUEBRA: String read FRFC_QUEBRA write FRFC_QUEBRA;
    const RFC_QUEBRA_Name = 'RFC_QUEBRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_DEVOLUCAO', ftString, 1)]
    [Dictionary('RFC_DEVOLUCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_DEVOLUCAO: String read FRFC_DEVOLUCAO write FRFC_DEVOLUCAO;
    const RFC_DEVOLUCAO_Name = 'RFC_DEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('RFC_CANCELADO', ftString, 1)]
    [Dictionary('RFC_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_CANCELADO: String read FRFC_CANCELADO write FRFC_CANCELADO;
    const RFC_CANCELADO_Name = 'RFC_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RFC_REPARCELADO', ftString, 1)]
    [Dictionary('RFC_REPARCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_REPARCELADO: String read FRFC_REPARCELADO write FRFC_REPARCELADO;
    const RFC_REPARCELADO_Name = 'RFC_REPARCELADO';

    [Restrictions([NoValidate])]
    [Column('RFC_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('RFC_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RFC_DATACANCELAMENTO: TDateTime read FRFC_DATACANCELAMENTO write FRFC_DATACANCELAMENTO;
    const RFC_DATACANCELAMENTO_Name = 'RFC_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('RFC_OBSERVACAOCANCELAMENTO', ftString, 1000)]
    [Dictionary('RFC_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RFC_OBSERVACAOCANCELAMENTO: String read FRFC_OBSERVACAOCANCELAMENTO write FRFC_OBSERVACAOCANCELAMENTO;
    const RFC_OBSERVACAOCANCELAMENTO_Name = 'RFC_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('RFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('RFC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property RFC_DATAALTERACAO: TDateTime read FRFC_DATAALTERACAO write FRFC_DATAALTERACAO;
    const RFC_DATAALTERACAO_Name = 'RFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('RFC_01_ID_OLD', ftInteger)]
    [Dictionary('RFC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RFC_01_ID_OLD: Integer read FRFC_01_ID_OLD write FRFC_01_ID_OLD;
    const RFC_01_ID_OLD_Name = 'RFC_01_ID_OLD';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRFC_00_01)

end.
