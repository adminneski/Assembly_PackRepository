unit express.dbo.VEI_00;

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
  [Table('VEI_00', '')]
  [PrimaryKey('VEI_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_VEI_CODIGO')]
  TDtoVEI_00 = class
  private
    { Private declarations } 
    FVEI_CODIGO: Integer;
    FVEI_COR: String;
    FVEI_PLACA: String;
    FPES_CODIGO: Integer;
    FFOR_CODIGO: Integer;
    FMAR_CODIGO: Integer;
    FCID_IBGE: String;
    FVEI_DESCRICAO: String;
    FVEI_ANO_MODELO: String;
    FVEI_TIPOCOMBUSTIVEL: String;
    FVEI_NUMEROCHASSI: String;
    FVEI_NUMERORENAVAM: String;
    FVEI_DATAVENCTODER: TDateTime;
    FVEI_DATAVENCTOSEGURO: TDateTime;
    FVEI_DATAVENCTODETRAN: TDateTime;
    FVEI_REGISTRORENAVAM: String;
    FVEI_NUMEROREFERENCIA: String;
    FVEI_NUMEROCAPACITACAO: String;
    FVEI_DATAVENCTOCAPACITACAO: TDateTime;
    FVEI_DESATIVADO: String;
    FVEI_OBSERVACAO: String;
    FVEI_DATAALTERACAO: TDateTime;
    FVEI_RNTRC: String;
    FVEI_CAPACIDADEM3: Double;
    FVEI_CAPACIDADEKG: Double;
    FVEI_TARAKG: Double;
    FVEI_TIPORODADO: String;
    FVEI_TIPOCARROCERIA: String;
    FVEI_TIPODOCUMENTO: String;
    FVEI_CIDADE: String;
    FVEI_UF: String;
    FCOM_CODIGO: Integer;
    FVEI_MATRICULA: String;
  public 
    { Public declarations } 
     const Table      = 'VEI_00';
     const PrimaryKey = 'VEI_CODIGO';
     const Sequence   = 'SEQ_VEI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_COR', ftString, 15)]
    [Dictionary('VEI_COR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_COR: String read FVEI_COR write FVEI_COR;
    const VEI_COR_Name = 'VEI_COR';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_ANO_MODELO', ftString, 9)]
    [Dictionary('VEI_ANO_MODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_ANO_MODELO: String read FVEI_ANO_MODELO write FVEI_ANO_MODELO;
    const VEI_ANO_MODELO_Name = 'VEI_ANO_MODELO';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPOCOMBUSTIVEL', ftString, 1)]
    [Dictionary('VEI_TIPOCOMBUSTIVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPOCOMBUSTIVEL: String read FVEI_TIPOCOMBUSTIVEL write FVEI_TIPOCOMBUSTIVEL;
    const VEI_TIPOCOMBUSTIVEL_Name = 'VEI_TIPOCOMBUSTIVEL';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMEROCHASSI', ftString, 30)]
    [Dictionary('VEI_NUMEROCHASSI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMEROCHASSI: String read FVEI_NUMEROCHASSI write FVEI_NUMEROCHASSI;
    const VEI_NUMEROCHASSI_Name = 'VEI_NUMEROCHASSI';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMERORENAVAM', ftString, 15)]
    [Dictionary('VEI_NUMERORENAVAM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMERORENAVAM: String read FVEI_NUMERORENAVAM write FVEI_NUMERORENAVAM;
    const VEI_NUMERORENAVAM_Name = 'VEI_NUMERORENAVAM';

    [Restrictions([NoValidate])]
    [Column('VEI_DATAVENCTODER', ftDateTime)]
    [Dictionary('VEI_DATAVENCTODER', 'Mensagem de validação', '', '', '', taCenter)]
    property VEI_DATAVENCTODER: TDateTime read FVEI_DATAVENCTODER write FVEI_DATAVENCTODER;
    const VEI_DATAVENCTODER_Name = 'VEI_DATAVENCTODER';

    [Restrictions([NoValidate])]
    [Column('VEI_DATAVENCTOSEGURO', ftDateTime)]
    [Dictionary('VEI_DATAVENCTOSEGURO', 'Mensagem de validação', '', '', '', taCenter)]
    property VEI_DATAVENCTOSEGURO: TDateTime read FVEI_DATAVENCTOSEGURO write FVEI_DATAVENCTOSEGURO;
    const VEI_DATAVENCTOSEGURO_Name = 'VEI_DATAVENCTOSEGURO';

    [Restrictions([NoValidate])]
    [Column('VEI_DATAVENCTODETRAN', ftDateTime)]
    [Dictionary('VEI_DATAVENCTODETRAN', 'Mensagem de validação', '', '', '', taCenter)]
    property VEI_DATAVENCTODETRAN: TDateTime read FVEI_DATAVENCTODETRAN write FVEI_DATAVENCTODETRAN;
    const VEI_DATAVENCTODETRAN_Name = 'VEI_DATAVENCTODETRAN';

    [Restrictions([NoValidate])]
    [Column('VEI_REGISTRORENAVAM', ftString, 15)]
    [Dictionary('VEI_REGISTRORENAVAM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_REGISTRORENAVAM: String read FVEI_REGISTRORENAVAM write FVEI_REGISTRORENAVAM;
    const VEI_REGISTRORENAVAM_Name = 'VEI_REGISTRORENAVAM';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMEROREFERENCIA', ftString, 25)]
    [Dictionary('VEI_NUMEROREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMEROREFERENCIA: String read FVEI_NUMEROREFERENCIA write FVEI_NUMEROREFERENCIA;
    const VEI_NUMEROREFERENCIA_Name = 'VEI_NUMEROREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMEROCAPACITACAO', ftString, 25)]
    [Dictionary('VEI_NUMEROCAPACITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMEROCAPACITACAO: String read FVEI_NUMEROCAPACITACAO write FVEI_NUMEROCAPACITACAO;
    const VEI_NUMEROCAPACITACAO_Name = 'VEI_NUMEROCAPACITACAO';

    [Restrictions([NoValidate])]
    [Column('VEI_DATAVENCTOCAPACITACAO', ftDateTime)]
    [Dictionary('VEI_DATAVENCTOCAPACITACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property VEI_DATAVENCTOCAPACITACAO: TDateTime read FVEI_DATAVENCTOCAPACITACAO write FVEI_DATAVENCTOCAPACITACAO;
    const VEI_DATAVENCTOCAPACITACAO_Name = 'VEI_DATAVENCTOCAPACITACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_DESATIVADO', ftString, 1)]
    [Dictionary('VEI_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESATIVADO: String read FVEI_DESATIVADO write FVEI_DESATIVADO;
    const VEI_DESATIVADO_Name = 'VEI_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('VEI_OBSERVACAO', ftString, 300)]
    [Dictionary('VEI_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_OBSERVACAO: String read FVEI_OBSERVACAO write FVEI_OBSERVACAO;
    const VEI_OBSERVACAO_Name = 'VEI_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_DATAALTERACAO', ftDateTime)]
    [Dictionary('VEI_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property VEI_DATAALTERACAO: TDateTime read FVEI_DATAALTERACAO write FVEI_DATAALTERACAO;
    const VEI_DATAALTERACAO_Name = 'VEI_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('VEI_RNTRC', ftString, 14)]
    [Dictionary('VEI_RNTRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_RNTRC: String read FVEI_RNTRC write FVEI_RNTRC;
    const VEI_RNTRC_Name = 'VEI_RNTRC';

    [Restrictions([NoValidate])]
    [Column('VEI_CAPACIDADEM3', ftBCD, 7274723, 3)]
    [Dictionary('VEI_CAPACIDADEM3', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_CAPACIDADEM3: Double read FVEI_CAPACIDADEM3 write FVEI_CAPACIDADEM3;
    const VEI_CAPACIDADEM3_Name = 'VEI_CAPACIDADEM3';

    [Restrictions([NoValidate])]
    [Column('VEI_CAPACIDADEKG', ftBCD, 1329808717, 3)]
    [Dictionary('VEI_CAPACIDADEKG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_CAPACIDADEKG: Double read FVEI_CAPACIDADEKG write FVEI_CAPACIDADEKG;
    const VEI_CAPACIDADEKG_Name = 'VEI_CAPACIDADEKG';

    [Restrictions([NoValidate])]
    [Column('VEI_TARAKG', ftBCD, 1281455136, 3)]
    [Dictionary('VEI_TARAKG', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEI_TARAKG: Double read FVEI_TARAKG write FVEI_TARAKG;
    const VEI_TARAKG_Name = 'VEI_TARAKG';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPORODADO', ftString, 2)]
    [Dictionary('VEI_TIPORODADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPORODADO: String read FVEI_TIPORODADO write FVEI_TIPORODADO;
    const VEI_TIPORODADO_Name = 'VEI_TIPORODADO';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPOCARROCERIA', ftString, 2)]
    [Dictionary('VEI_TIPOCARROCERIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPOCARROCERIA: String read FVEI_TIPOCARROCERIA write FVEI_TIPOCARROCERIA;
    const VEI_TIPOCARROCERIA_Name = 'VEI_TIPOCARROCERIA';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('VEI_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPODOCUMENTO: String read FVEI_TIPODOCUMENTO write FVEI_TIPODOCUMENTO;
    const VEI_TIPODOCUMENTO_Name = 'VEI_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('VEI_CIDADE', ftString, 100)]
    [Dictionary('VEI_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_CIDADE: String read FVEI_CIDADE write FVEI_CIDADE;
    const VEI_CIDADE_Name = 'VEI_CIDADE';

    [Restrictions([NoValidate])]
    [Column('VEI_UF', ftString, 2)]
    [Dictionary('VEI_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_UF: String read FVEI_UF write FVEI_UF;
    const VEI_UF_Name = 'VEI_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_MATRICULA', ftString, 20)]
    [Dictionary('VEI_MATRICULA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_MATRICULA: String read FVEI_MATRICULA write FVEI_MATRICULA;
    const VEI_MATRICULA_Name = 'VEI_MATRICULA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVEI_00)

end.
