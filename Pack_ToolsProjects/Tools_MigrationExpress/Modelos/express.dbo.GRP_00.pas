unit express.dbo.GRP_00;

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
  [Table('GRP_00', '')]
  [PrimaryKey('GRP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_GRP_CODIGO')]
  TDtoGRP_00 = class
  private
    { Private declarations } 
    FGRP_CODIGO: Integer;
    FGRP_GRUPO: String;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FGRP_NOMEAPELIDO: String;
    FGRP_IMAGEM: Integer;
    FGRP_TIPOPRODUTO: String;
    FGRP_DATAALTERACAO: TDateTime;
    FGRP_DESATIVADO: String;
    FGRP_PERCENTUALADMINISTRATIVOMKP: Double;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'GRP_00';
     const PrimaryKey = 'GRP_CODIGO';
     const Sequence   = 'SEQ_GRP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_GRUPO', ftString, 4)]
    [Dictionary('GRP_GRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_GRUPO: String read FGRP_GRUPO write FGRP_GRUPO;
    const GRP_GRUPO_Name = 'GRP_GRUPO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('GRP_NOMEAPELIDO', ftString, 10)]
    [Dictionary('GRP_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_NOMEAPELIDO: String read FGRP_NOMEAPELIDO write FGRP_NOMEAPELIDO;
    const GRP_NOMEAPELIDO_Name = 'GRP_NOMEAPELIDO';

    [Restrictions([NoValidate])]
    [Column('GRP_IMAGEM', ftInteger)]
    [Dictionary('GRP_IMAGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_IMAGEM: Integer read FGRP_IMAGEM write FGRP_IMAGEM;
    const GRP_IMAGEM_Name = 'GRP_IMAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_TIPOPRODUTO', ftString, 3)]
    [Dictionary('GRP_TIPOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_TIPOPRODUTO: String read FGRP_TIPOPRODUTO write FGRP_TIPOPRODUTO;
    const GRP_TIPOPRODUTO_Name = 'GRP_TIPOPRODUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_DATAALTERACAO', ftDateTime)]
    [Dictionary('GRP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property GRP_DATAALTERACAO: TDateTime read FGRP_DATAALTERACAO write FGRP_DATAALTERACAO;
    const GRP_DATAALTERACAO_Name = 'GRP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRP_DESATIVADO', ftString, 1)]
    [Dictionary('GRP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESATIVADO: String read FGRP_DESATIVADO write FGRP_DESATIVADO;
    const GRP_DESATIVADO_Name = 'GRP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('GRP_PERCENTUALADMINISTRATIVOMKP', ftBCD)]
    [Dictionary('GRP_PERCENTUALADMINISTRATIVOMKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property GRP_PERCENTUALADMINISTRATIVOMKP: Double read FGRP_PERCENTUALADMINISTRATIVOMKP write FGRP_PERCENTUALADMINISTRATIVOMKP;
    const GRP_PERCENTUALADMINISTRATIVOMKP_Name = 'GRP_PERCENTUALADMINISTRATIVOMKP';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGRP_00)

end.
