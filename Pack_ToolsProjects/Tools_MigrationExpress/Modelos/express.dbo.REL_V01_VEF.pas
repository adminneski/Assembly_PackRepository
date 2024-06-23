unit express.dbo.REL_V01_VEF;

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
  [Table('REL_V01_VEF', '')]
  TDtoREL_V01_VEF = class
  private
    { Private declarations } 
    FVEF_TIPO: String;
    FVEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FVEF_NUMERODOCTO: String;
    FVEF_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FGRP_GRUPO: String;
    FGRP_DESCRICAO: String;
    FVEF_QTDPEDIDA: Double;
    FVEF_QTDFATURADA: Double;
    FVEF_PRECOLIQUIDO: Double;
    FVEF_TOTALPRECOLIQUIDO: Double;
    FVEF_TOTALCANCELAMENTO: Double;
    FVEF_PROCESSADO: String;
    FVEF_CANCELADA: String;
    FCON_CODIGO: Integer;
    FPES_NOMECONTATO: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FVEF_STATUS: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_VEF';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TIPO', ftString, 3)]
    [Dictionary('VEF_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_TIPO: String read FVEF_TIPO write FVEF_TIPO;
    const VEF_TIPO_Name = 'VEF_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_NUMERODOCTO', ftString, 10)]
    [Dictionary('VEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_NUMERODOCTO: String read FVEF_NUMERODOCTO write FVEF_NUMERODOCTO;
    const VEF_NUMERODOCTO_Name = 'VEF_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('VEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('VEF_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property VEF_DATALANCAMENTO: TDateTime read FVEF_DATALANCAMENTO write FVEF_DATALANCAMENTO;
    const VEF_DATALANCAMENTO_Name = 'VEF_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('VEF_QTDPEDIDA', ftBCD)]
    [Dictionary('VEF_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDPEDIDA: Double read FVEF_QTDPEDIDA write FVEF_QTDPEDIDA;
    const VEF_QTDPEDIDA_Name = 'VEF_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('VEF_QTDFATURADA', ftBCD)]
    [Dictionary('VEF_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDFATURADA: Double read FVEF_QTDFATURADA write FVEF_QTDFATURADA;
    const VEF_QTDFATURADA_Name = 'VEF_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('VEF_PRECOLIQUIDO', ftBCD)]
    [Dictionary('VEF_PRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PRECOLIQUIDO: Double read FVEF_PRECOLIQUIDO write FVEF_PRECOLIQUIDO;
    const VEF_PRECOLIQUIDO_Name = 'VEF_PRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('VEF_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECOLIQUIDO: Double read FVEF_TOTALPRECOLIQUIDO write FVEF_TOTALPRECOLIQUIDO;
    const VEF_TOTALPRECOLIQUIDO_Name = 'VEF_TOTALPRECOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALCANCELAMENTO', ftBCD)]
    [Dictionary('VEF_TOTALCANCELAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALCANCELAMENTO: Double read FVEF_TOTALCANCELAMENTO write FVEF_TOTALCANCELAMENTO;
    const VEF_TOTALCANCELAMENTO_Name = 'VEF_TOTALCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('VEF_PROCESSADO', ftString, 1)]
    [Dictionary('VEF_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_PROCESSADO: String read FVEF_PROCESSADO write FVEF_PROCESSADO;
    const VEF_PROCESSADO_Name = 'VEF_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('VEF_CANCELADA', ftString, 1)]
    [Dictionary('VEF_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_CANCELADA: String read FVEF_CANCELADA write FVEF_CANCELADA;
    const VEF_CANCELADA_Name = 'VEF_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CON_CODIGO', ftInteger)]
    [Dictionary('CON_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CON_CODIGO: Integer read FCON_CODIGO write FCON_CODIGO;
    const CON_CODIGO_Name = 'CON_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECONTATO', ftString, 100)]
    [Dictionary('PES_NOMECONTATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECONTATO: String read FPES_NOMECONTATO write FPES_NOMECONTATO;
    const PES_NOMECONTATO_Name = 'PES_NOMECONTATO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('VEF_STATUS', ftString, 1)]
    [Dictionary('VEF_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_STATUS: String read FVEF_STATUS write FVEF_STATUS;
    const VEF_STATUS_Name = 'VEF_STATUS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_VEF)

end.
