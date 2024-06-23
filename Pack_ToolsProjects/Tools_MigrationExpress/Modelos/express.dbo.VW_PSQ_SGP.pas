unit express.dbo.VW_PSQ_SGP;

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
  [Table('VW_PSQ_SGP', '')]
  TDtoVW_PSQ_SGP = class
  private
    { Private declarations } 
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FSGP_SUBGRUPO: String;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FSGP_DESATIVADO: String;
    FSGP_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_SGP';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_SUBGRUPO', ftString, 4)]
    [Dictionary('SGP_SUBGRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_SUBGRUPO: String read FSGP_SUBGRUPO write FSGP_SUBGRUPO;
    const SGP_SUBGRUPO_Name = 'SGP_SUBGRUPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SGP_DESATIVADO', ftString, 1)]
    [Dictionary('SGP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESATIVADO: String read FSGP_DESATIVADO write FSGP_DESATIVADO;
    const SGP_DESATIVADO_Name = 'SGP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('SGP_DATAALTERACAO', ftDateTime)]
    [Dictionary('SGP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property SGP_DATAALTERACAO: TDateTime read FSGP_DATAALTERACAO write FSGP_DATAALTERACAO;
    const SGP_DATAALTERACAO_Name = 'SGP_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_SGP)

end.
