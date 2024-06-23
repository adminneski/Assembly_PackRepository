unit express.dbo.VW_PSQ_GRP;

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
  [Table('VW_PSQ_GRP', '')]
  TDtoVW_PSQ_GRP = class
  private
    { Private declarations } 
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FGRP_TIPOPRODUTO: String;
    FGRP_DESATIVADO: String;
    FGRP_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_GRP';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_TIPOPRODUTO', ftString, 3)]
    [Dictionary('GRP_TIPOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_TIPOPRODUTO: String read FGRP_TIPOPRODUTO write FGRP_TIPOPRODUTO;
    const GRP_TIPOPRODUTO_Name = 'GRP_TIPOPRODUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_DESATIVADO', ftString, 1)]
    [Dictionary('GRP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESATIVADO: String read FGRP_DESATIVADO write FGRP_DESATIVADO;
    const GRP_DESATIVADO_Name = 'GRP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_DATAALTERACAO', ftDateTime)]
    [Dictionary('GRP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property GRP_DATAALTERACAO: TDateTime read FGRP_DATAALTERACAO write FGRP_DATAALTERACAO;
    const GRP_DATAALTERACAO_Name = 'GRP_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_GRP)

end.
