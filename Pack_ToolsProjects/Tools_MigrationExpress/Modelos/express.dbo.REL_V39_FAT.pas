unit express.dbo.REL_V39_FAT;

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
  [Table('REL_V39_FAT', '')]
  TDtoREL_V39_FAT = class
  private
    { Private declarations } 
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVND_CODIGO: Integer;
    FROT_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_EMBALAGEM: String;
    FSGM_CODIGO: String;
    FGRP_CODIGO: Integer;
    FGRP_GRUPO: String;
    FGRP_DESCRICAO: String;
    FSGP_CODIGO: Integer;
    FSGP_SUBGRUPO: String;
    FSGP_DESCRICAO: String;
    FFAT_CANCELADA: String;
    FFAT_DESATIVADO: String;
    FNTO_MODELOOPERACAO: String;
    FFAT_QTDFATURADA: Double;
    FFAT_TOTALPRECOVENDA: Double;
    FFAT_TOTALPRECOCUSTO: Double;
    FFAT_TOTALPRECOLIQUIDO: Double;
    FFAT_QTDTROCA: Double;
    FFAT_TOTALPRECOLIQUIDOTROCA: Double;
    FFAT_TOTALPRECOVENDATROCA: Double;
    FFAT_TOTALPRECOCUSTOTROCA: Double;
    FPRO_REFERENCIAINTERNA: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V39_FAT';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

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
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_GRUPO', ftString, 4)]
    [Dictionary('GRP_GRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_GRUPO: String read FGRP_GRUPO write FGRP_GRUPO;
    const GRP_GRUPO_Name = 'GRP_GRUPO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_SUBGRUPO', ftString, 4)]
    [Dictionary('SGP_SUBGRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_SUBGRUPO: String read FSGP_SUBGRUPO write FSGP_SUBGRUPO;
    const SGP_SUBGRUPO_Name = 'SGP_SUBGRUPO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('FAT_DESATIVADO', ftString, 1)]
    [Dictionary('FAT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESATIVADO: String read FFAT_DESATIVADO write FFAT_DESATIVADO;
    const FAT_DESATIVADO_Name = 'FAT_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('NTO_MODELOOPERACAO', ftString, 1)]
    [Dictionary('NTO_MODELOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_MODELOOPERACAO: String read FNTO_MODELOOPERACAO write FNTO_MODELOOPERACAO;
    const NTO_MODELOOPERACAO_Name = 'NTO_MODELOOPERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Double read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOVENDA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOVENDA: Double read FFAT_TOTALPRECOVENDA write FFAT_TOTALPRECOVENDA;
    const FAT_TOTALPRECOVENDA_Name = 'FAT_TOTALPRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOCUSTO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOCUSTO: Double read FFAT_TOTALPRECOCUSTO write FFAT_TOTALPRECOCUSTO;
    const FAT_TOTALPRECOCUSTO_Name = 'FAT_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOLIQUIDO: Double read FFAT_TOTALPRECOLIQUIDO write FFAT_TOTALPRECOLIQUIDO;
    const FAT_TOTALPRECOLIQUIDO_Name = 'FAT_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDTROCA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDTROCA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDTROCA: Double read FFAT_QTDTROCA write FFAT_QTDTROCA;
    const FAT_QTDTROCA_Name = 'FAT_QTDTROCA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOLIQUIDOTROCA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOLIQUIDOTROCA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOLIQUIDOTROCA: Double read FFAT_TOTALPRECOLIQUIDOTROCA write FFAT_TOTALPRECOLIQUIDOTROCA;
    const FAT_TOTALPRECOLIQUIDOTROCA_Name = 'FAT_TOTALPRECOLIQUIDOTROCA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOVENDATROCA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOVENDATROCA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOVENDATROCA: Double read FFAT_TOTALPRECOVENDATROCA write FFAT_TOTALPRECOVENDATROCA;
    const FAT_TOTALPRECOVENDATROCA_Name = 'FAT_TOTALPRECOVENDATROCA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOCUSTOTROCA', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALPRECOCUSTOTROCA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOCUSTOTROCA: Double read FFAT_TOTALPRECOCUSTOTROCA write FFAT_TOTALPRECOCUSTOTROCA;
    const FAT_TOTALPRECOCUSTOTROCA_Name = 'FAT_TOTALPRECOCUSTOTROCA';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V39_FAT)

end.
