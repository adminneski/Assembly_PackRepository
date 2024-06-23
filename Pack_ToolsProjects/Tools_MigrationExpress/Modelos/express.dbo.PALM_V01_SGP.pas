unit express.dbo.PALM_V01_SGP;

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
  [Table('PALM_V01_SGP', '')]
  TDtoPALM_V01_SGP = class
  private
    { Private declarations } 
    FSGP_CODIGO: Integer;
    FSGP_SUBGRUPO: String;
    FSGP_DESCRICAO: String;
    FSGP_NOMEAPELIDO: String;
    FSGP_GERARPALM: String;
    FSGP_DATAALTERACAO: TDateTime;
    FSGP_DESATIVADO: String;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_SGP';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_SUBGRUPO', ftString, 4)]
    [Dictionary('SGP_SUBGRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_SUBGRUPO: String read FSGP_SUBGRUPO write FSGP_SUBGRUPO;
    const SGP_SUBGRUPO_Name = 'SGP_SUBGRUPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_NOMEAPELIDO', ftString, 10)]
    [Dictionary('SGP_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_NOMEAPELIDO: String read FSGP_NOMEAPELIDO write FSGP_NOMEAPELIDO;
    const SGP_NOMEAPELIDO_Name = 'SGP_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_GERARPALM', ftString, 3)]
    [Dictionary('SGP_GERARPALM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_GERARPALM: String read FSGP_GERARPALM write FSGP_GERARPALM;
    const SGP_GERARPALM_Name = 'SGP_GERARPALM';

    [Restrictions([NoValidate])]
    [Column('SGP_DATAALTERACAO', ftDateTime)]
    [Dictionary('SGP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property SGP_DATAALTERACAO: TDateTime read FSGP_DATAALTERACAO write FSGP_DATAALTERACAO;
    const SGP_DATAALTERACAO_Name = 'SGP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_DESATIVADO', ftString, 1)]
    [Dictionary('SGP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESATIVADO: String read FSGP_DESATIVADO write FSGP_DESATIVADO;
    const SGP_DESATIVADO_Name = 'SGP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_SGP)

end.
