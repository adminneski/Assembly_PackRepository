unit express.dbo.PES_00_03;

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
  [Table('PES_00_03', '')]
  [PrimaryKey('PES_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PES_CODIGO')]
  TDtoPES_00_03 = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FFOR_CODIGO: Integer;
    FPES_INSCRICAOINSS: String;
    FPES_HABILITACAO: String;
    FPES_UFHABILITACAO: String;
    FPES_REGISTROHABILITACAO: String;
    FPES_CATEGORIAHABILITACAO: String;
    FPES_DATAEMISSAOHABILITACAO: TDateTime;
    FPES_DATAVENCTOHABILITACAO: TDateTime;
    FPES_RASTREADOR: String;
    FPES_USUARIORASTREADOR: String;
    FPES_SENHARASTREADOR: String;
    FPES_SITUACAOFUNCIONAL: String;
    FPES_NUMEROMOPP: String;
    FPES_DATAEMISSAOMOPP: TDateTime;
    FPES_DATAVENCTOMOPP: TDateTime;
    FPES_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FCID_IBGEBANCO: String;
    FPES_CIDADEBANCO: String;
    FPES_UFBANCO: String;
    FPES_AGENCIA: String;
    FPES_CONTACORRENTE: String;
    FPES_EMITENTECONTA: String;
  public 
    { Public declarations } 
     const Table      = 'PES_00_03';
     const PrimaryKey = 'PES_CODIGO';
     const Sequence   = 'SEQ_PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_INSCRICAOINSS', ftString, 20)]
    [Dictionary('PES_INSCRICAOINSS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_INSCRICAOINSS: String read FPES_INSCRICAOINSS write FPES_INSCRICAOINSS;
    const PES_INSCRICAOINSS_Name = 'PES_INSCRICAOINSS';

    [Restrictions([NoValidate])]
    [Column('PES_HABILITACAO', ftString, 20)]
    [Dictionary('PES_HABILITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_HABILITACAO: String read FPES_HABILITACAO write FPES_HABILITACAO;
    const PES_HABILITACAO_Name = 'PES_HABILITACAO';

    [Restrictions([NoValidate])]
    [Column('PES_UFHABILITACAO', ftString, 2)]
    [Dictionary('PES_UFHABILITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFHABILITACAO: String read FPES_UFHABILITACAO write FPES_UFHABILITACAO;
    const PES_UFHABILITACAO_Name = 'PES_UFHABILITACAO';

    [Restrictions([NoValidate])]
    [Column('PES_REGISTROHABILITACAO', ftString, 15)]
    [Dictionary('PES_REGISTROHABILITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_REGISTROHABILITACAO: String read FPES_REGISTROHABILITACAO write FPES_REGISTROHABILITACAO;
    const PES_REGISTROHABILITACAO_Name = 'PES_REGISTROHABILITACAO';

    [Restrictions([NoValidate])]
    [Column('PES_CATEGORIAHABILITACAO', ftString, 2)]
    [Dictionary('PES_CATEGORIAHABILITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CATEGORIAHABILITACAO: String read FPES_CATEGORIAHABILITACAO write FPES_CATEGORIAHABILITACAO;
    const PES_CATEGORIAHABILITACAO_Name = 'PES_CATEGORIAHABILITACAO';

    [Restrictions([NoValidate])]
    [Column('PES_DATAEMISSAOHABILITACAO', ftDateTime)]
    [Dictionary('PES_DATAEMISSAOHABILITACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAEMISSAOHABILITACAO: TDateTime read FPES_DATAEMISSAOHABILITACAO write FPES_DATAEMISSAOHABILITACAO;
    const PES_DATAEMISSAOHABILITACAO_Name = 'PES_DATAEMISSAOHABILITACAO';

    [Restrictions([NoValidate])]
    [Column('PES_DATAVENCTOHABILITACAO', ftDateTime)]
    [Dictionary('PES_DATAVENCTOHABILITACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAVENCTOHABILITACAO: TDateTime read FPES_DATAVENCTOHABILITACAO write FPES_DATAVENCTOHABILITACAO;
    const PES_DATAVENCTOHABILITACAO_Name = 'PES_DATAVENCTOHABILITACAO';

    [Restrictions([NoValidate])]
    [Column('PES_RASTREADOR', ftString, 35)]
    [Dictionary('PES_RASTREADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_RASTREADOR: String read FPES_RASTREADOR write FPES_RASTREADOR;
    const PES_RASTREADOR_Name = 'PES_RASTREADOR';

    [Restrictions([NoValidate])]
    [Column('PES_USUARIORASTREADOR', ftString, 25)]
    [Dictionary('PES_USUARIORASTREADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_USUARIORASTREADOR: String read FPES_USUARIORASTREADOR write FPES_USUARIORASTREADOR;
    const PES_USUARIORASTREADOR_Name = 'PES_USUARIORASTREADOR';

    [Restrictions([NoValidate])]
    [Column('PES_SENHARASTREADOR', ftString, 15)]
    [Dictionary('PES_SENHARASTREADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_SENHARASTREADOR: String read FPES_SENHARASTREADOR write FPES_SENHARASTREADOR;
    const PES_SENHARASTREADOR_Name = 'PES_SENHARASTREADOR';

    [Restrictions([NoValidate])]
    [Column('PES_SITUACAOFUNCIONAL', ftString, 1)]
    [Dictionary('PES_SITUACAOFUNCIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_SITUACAOFUNCIONAL: String read FPES_SITUACAOFUNCIONAL write FPES_SITUACAOFUNCIONAL;
    const PES_SITUACAOFUNCIONAL_Name = 'PES_SITUACAOFUNCIONAL';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROMOPP', ftString, 20)]
    [Dictionary('PES_NUMEROMOPP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROMOPP: String read FPES_NUMEROMOPP write FPES_NUMEROMOPP;
    const PES_NUMEROMOPP_Name = 'PES_NUMEROMOPP';

    [Restrictions([NoValidate])]
    [Column('PES_DATAEMISSAOMOPP', ftDateTime)]
    [Dictionary('PES_DATAEMISSAOMOPP', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAEMISSAOMOPP: TDateTime read FPES_DATAEMISSAOMOPP write FPES_DATAEMISSAOMOPP;
    const PES_DATAEMISSAOMOPP_Name = 'PES_DATAEMISSAOMOPP';

    [Restrictions([NoValidate])]
    [Column('PES_DATAVENCTOMOPP', ftDateTime)]
    [Dictionary('PES_DATAVENCTOMOPP', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAVENCTOMOPP: TDateTime read FPES_DATAVENCTOMOPP write FPES_DATAVENCTOMOPP;
    const PES_DATAVENCTOMOPP_Name = 'PES_DATAVENCTOMOPP';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATAALTERACAO', ftDateTime)]
    [Dictionary('PES_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATAALTERACAO: TDateTime read FPES_DATAALTERACAO write FPES_DATAALTERACAO;
    const PES_DATAALTERACAO_Name = 'PES_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEBANCO', ftString, 7)]
    [Dictionary('CID_IBGEBANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEBANCO: String read FCID_IBGEBANCO write FCID_IBGEBANCO;
    const CID_IBGEBANCO_Name = 'CID_IBGEBANCO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADEBANCO', ftString, 100)]
    [Dictionary('PES_CIDADEBANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADEBANCO: String read FPES_CIDADEBANCO write FPES_CIDADEBANCO;
    const PES_CIDADEBANCO_Name = 'PES_CIDADEBANCO';

    [Restrictions([NoValidate])]
    [Column('PES_UFBANCO', ftString, 2)]
    [Dictionary('PES_UFBANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFBANCO: String read FPES_UFBANCO write FPES_UFBANCO;
    const PES_UFBANCO_Name = 'PES_UFBANCO';

    [Restrictions([NoValidate])]
    [Column('PES_AGENCIA', ftString, 10)]
    [Dictionary('PES_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_AGENCIA: String read FPES_AGENCIA write FPES_AGENCIA;
    const PES_AGENCIA_Name = 'PES_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('PES_CONTACORRENTE', ftString, 12)]
    [Dictionary('PES_CONTACORRENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CONTACORRENTE: String read FPES_CONTACORRENTE write FPES_CONTACORRENTE;
    const PES_CONTACORRENTE_Name = 'PES_CONTACORRENTE';

    [Restrictions([NoValidate])]
    [Column('PES_EMITENTECONTA', ftString, 50)]
    [Dictionary('PES_EMITENTECONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_EMITENTECONTA: String read FPES_EMITENTECONTA write FPES_EMITENTECONTA;
    const PES_EMITENTECONTA_Name = 'PES_EMITENTECONTA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPES_00_03)

end.
