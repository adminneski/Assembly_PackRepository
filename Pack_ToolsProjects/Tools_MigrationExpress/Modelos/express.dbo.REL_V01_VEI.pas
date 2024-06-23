unit express.dbo.REL_V01_VEI;

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
  [Table('REL_V01_VEI', '')]
  TDtoREL_V01_VEI = class
  private
    { Private declarations } 
    FVEI_CODIGO: Integer;
    FVEI_COR: String;
    FVEI_PLACA: String;
    FPES_CODIGO: Integer;
    FFOR_CODIGO: Integer;
    FFOR_NOME: String;
    FFOR_DDD_TELEFONE_1: String;
    FFOR_DDD_TELEFONE_2: String;
    FFOR_DDD_TELEFONE_3: String;
    FFOR_DDD_CELULAR_1: String;
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
    FVEI_PLACAREBOQUE_1: String;
    FVEI_PLACAREBOQUE_2: String;
    FVEI_PLACAREBOQUE_3: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_VEI';

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
    [Column('FOR_NOME', ftString, 100)]
    [Dictionary('FOR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_NOME: String read FFOR_NOME write FFOR_NOME;
    const FOR_NOME_Name = 'FOR_NOME';

    [Restrictions([NoValidate])]
    [Column('FOR_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('FOR_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_DDD_TELEFONE_1: String read FFOR_DDD_TELEFONE_1 write FFOR_DDD_TELEFONE_1;
    const FOR_DDD_TELEFONE_1_Name = 'FOR_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('FOR_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('FOR_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_DDD_TELEFONE_2: String read FFOR_DDD_TELEFONE_2 write FFOR_DDD_TELEFONE_2;
    const FOR_DDD_TELEFONE_2_Name = 'FOR_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('FOR_DDD_TELEFONE_3', ftString, 11)]
    [Dictionary('FOR_DDD_TELEFONE_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_DDD_TELEFONE_3: String read FFOR_DDD_TELEFONE_3 write FFOR_DDD_TELEFONE_3;
    const FOR_DDD_TELEFONE_3_Name = 'FOR_DDD_TELEFONE_3';

    [Restrictions([NoValidate])]
    [Column('FOR_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('FOR_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FOR_DDD_CELULAR_1: String read FFOR_DDD_CELULAR_1 write FFOR_DDD_CELULAR_1;
    const FOR_DDD_CELULAR_1_Name = 'FOR_DDD_CELULAR_1';

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

    [Restrictions([NoValidate])]
    [Column('VEI_PLACAREBOQUE_1', ftString, 7)]
    [Dictionary('VEI_PLACAREBOQUE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACAREBOQUE_1: String read FVEI_PLACAREBOQUE_1 write FVEI_PLACAREBOQUE_1;
    const VEI_PLACAREBOQUE_1_Name = 'VEI_PLACAREBOQUE_1';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACAREBOQUE_2', ftString, 7)]
    [Dictionary('VEI_PLACAREBOQUE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACAREBOQUE_2: String read FVEI_PLACAREBOQUE_2 write FVEI_PLACAREBOQUE_2;
    const VEI_PLACAREBOQUE_2_Name = 'VEI_PLACAREBOQUE_2';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACAREBOQUE_3', ftString, 7)]
    [Dictionary('VEI_PLACAREBOQUE_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACAREBOQUE_3: String read FVEI_PLACAREBOQUE_3 write FVEI_PLACAREBOQUE_3;
    const VEI_PLACAREBOQUE_3_Name = 'VEI_PLACAREBOQUE_3';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_VEI)

end.
