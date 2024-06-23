unit express.dbo.VW_PSQ_CCC;

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
  [Table('VW_PSQ_CCC', '')]
  TDtoVW_PSQ_CCC = class
  private
    { Private declarations } 
    FCCC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FVND_NOME: String;
    FCCC_STATUSLIGACAO: Integer;
    FCCC_DATALANCAMENTO: TDateTime;
    FCCC_DIASRETORNO: Integer;
    FTOT_QTDPEDIDOS: Integer;
    FVND_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CCC';

    [Restrictions([NoValidate])]
    [Column('CCC_ID', ftInteger)]
    [Dictionary('CCC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_ID: Integer read FCCC_ID write FCCC_ID;
    const CCC_ID_Name = 'CCC_ID';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('CCC_STATUSLIGACAO', ftInteger)]
    [Dictionary('CCC_STATUSLIGACAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_STATUSLIGACAO: Integer read FCCC_STATUSLIGACAO write FCCC_STATUSLIGACAO;
    const CCC_STATUSLIGACAO_Name = 'CCC_STATUSLIGACAO';

    [Restrictions([NoValidate])]
    [Column('CCC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CCC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCC_DATALANCAMENTO: TDateTime read FCCC_DATALANCAMENTO write FCCC_DATALANCAMENTO;
    const CCC_DATALANCAMENTO_Name = 'CCC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CCC_DIASRETORNO', ftInteger)]
    [Dictionary('CCC_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_DIASRETORNO: Integer read FCCC_DIASRETORNO write FCCC_DIASRETORNO;
    const CCC_DIASRETORNO_Name = 'CCC_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('TOT_QTDPEDIDOS', ftInteger)]
    [Dictionary('TOT_QTDPEDIDOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property TOT_QTDPEDIDOS: Integer read FTOT_QTDPEDIDOS write FTOT_QTDPEDIDOS;
    const TOT_QTDPEDIDOS_Name = 'TOT_QTDPEDIDOS';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CCC)

end.
