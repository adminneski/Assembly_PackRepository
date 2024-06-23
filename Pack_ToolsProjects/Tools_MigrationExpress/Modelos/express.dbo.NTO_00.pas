unit express.dbo.NTO_00;

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
  [Table('NTO_00', '')]
  [PrimaryKey('NTO_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_NTO_CODIGO')]
  TDtoNTO_00 = class
  private
    { Private declarations } 
    FNTO_CODIGO: Integer;
    FNTO_TIPOMOVTO: String;
    FNTO_DESCRICAO: String;
    FNTO_DESCRICAOADICIONAL: String;
    FNTO_PARAMETROS: String;
    FNTO_MODELOOPERACAO: String;
    FCFOP_CODIGODENTRO: String;
    FCFOP_CODIGOFORA: String;
    FNTO_DESATIVADO: String;
    FNTO_DATAALTERACAO: TDateTime;
    FNTO_TIPOPOSSE: String;
    FNTO_NAOENVIARSPEDPC: String;
    FNTO_NAOENVIARSPED: String;
    FNTO_NAOENVIAREXPCONTABIL: String;
    FNTO_ENVIARDIFAL: String;
    FNTO_PERCENTUALPOBREZADIFAL: Double;
    FTDC_CODIGO: String;
    FNTO_ENVIARDIFALZERADO: String;
    FNTO_DESCONTOCONDICIONAL: String;
    FNTO_CODIGONATUREZACONTASPEDPC: String;
    FNTO_TIPOCONTASPEDPC: String;
    FNTO_NIVELCONTASPEDPC: String;
    FNTO_CODIGOCONTASPEDPC: String;
    FNTO_NOMECONTASPEDPC: String;
    FNTO_CODIGOCENTROCUSTOSPEDPC: String;
    FNTO_NOMECENTROCUSTOSPEDPC: String;
    FNTO_DATAINCLUSAOCONTASPEDPC: TDateTime;
    FNTO_NAOGERARLIVROFISCAL: String;
    FNTO_CODIGONATUREZASERVICO: String;
    FNTO_ISSRETIDO: String;
    FCOM_CODIGO: Integer;
    FNTO_ADOTARLEIFEDERAL: String;
  public 
    { Public declarations } 
     const Table      = 'NTO_00';
     const PrimaryKey = 'NTO_CODIGO';
     const Sequence   = 'SEQ_NTO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_TIPOMOVTO', ftString, 1)]
    [Dictionary('NTO_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_TIPOMOVTO: String read FNTO_TIPOMOVTO write FNTO_TIPOMOVTO;
    const NTO_TIPOMOVTO_Name = 'NTO_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('NTO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAOADICIONAL: String read FNTO_DESCRICAOADICIONAL write FNTO_DESCRICAOADICIONAL;
    const NTO_DESCRICAOADICIONAL_Name = 'NTO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('NTO_PARAMETROS', ftString, 50)]
    [Dictionary('NTO_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_PARAMETROS: String read FNTO_PARAMETROS write FNTO_PARAMETROS;
    const NTO_PARAMETROS_Name = 'NTO_PARAMETROS';

    [Restrictions([NoValidate])]
    [Column('NTO_MODELOOPERACAO', ftString, 1)]
    [Dictionary('NTO_MODELOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_MODELOOPERACAO: String read FNTO_MODELOOPERACAO write FNTO_MODELOOPERACAO;
    const NTO_MODELOOPERACAO_Name = 'NTO_MODELOOPERACAO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGODENTRO', ftString, 4)]
    [Dictionary('CFOP_CODIGODENTRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGODENTRO: String read FCFOP_CODIGODENTRO write FCFOP_CODIGODENTRO;
    const CFOP_CODIGODENTRO_Name = 'CFOP_CODIGODENTRO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGOFORA', ftString, 4)]
    [Dictionary('CFOP_CODIGOFORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGOFORA: String read FCFOP_CODIGOFORA write FCFOP_CODIGOFORA;
    const CFOP_CODIGOFORA_Name = 'CFOP_CODIGOFORA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_DESATIVADO', ftString, 1)]
    [Dictionary('NTO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESATIVADO: String read FNTO_DESATIVADO write FNTO_DESATIVADO;
    const NTO_DESATIVADO_Name = 'NTO_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_DATAALTERACAO', ftDateTime)]
    [Dictionary('NTO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property NTO_DATAALTERACAO: TDateTime read FNTO_DATAALTERACAO write FNTO_DATAALTERACAO;
    const NTO_DATAALTERACAO_Name = 'NTO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('NTO_TIPOPOSSE', ftString, 1)]
    [Dictionary('NTO_TIPOPOSSE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_TIPOPOSSE: String read FNTO_TIPOPOSSE write FNTO_TIPOPOSSE;
    const NTO_TIPOPOSSE_Name = 'NTO_TIPOPOSSE';

    [Restrictions([NoValidate])]
    [Column('NTO_NAOENVIARSPEDPC', ftString, 1)]
    [Dictionary('NTO_NAOENVIARSPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NAOENVIARSPEDPC: String read FNTO_NAOENVIARSPEDPC write FNTO_NAOENVIARSPEDPC;
    const NTO_NAOENVIARSPEDPC_Name = 'NTO_NAOENVIARSPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_NAOENVIARSPED', ftString, 1)]
    [Dictionary('NTO_NAOENVIARSPED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NAOENVIARSPED: String read FNTO_NAOENVIARSPED write FNTO_NAOENVIARSPED;
    const NTO_NAOENVIARSPED_Name = 'NTO_NAOENVIARSPED';

    [Restrictions([NoValidate])]
    [Column('NTO_NAOENVIAREXPCONTABIL', ftString, 1)]
    [Dictionary('NTO_NAOENVIAREXPCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NAOENVIAREXPCONTABIL: String read FNTO_NAOENVIAREXPCONTABIL write FNTO_NAOENVIAREXPCONTABIL;
    const NTO_NAOENVIAREXPCONTABIL_Name = 'NTO_NAOENVIAREXPCONTABIL';

    [Restrictions([NoValidate])]
    [Column('NTO_ENVIARDIFAL', ftString, 1)]
    [Dictionary('NTO_ENVIARDIFAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ENVIARDIFAL: String read FNTO_ENVIARDIFAL write FNTO_ENVIARDIFAL;
    const NTO_ENVIARDIFAL_Name = 'NTO_ENVIARDIFAL';

    [Restrictions([NoValidate])]
    [Column('NTO_PERCENTUALPOBREZADIFAL', ftBCD)]
    [Dictionary('NTO_PERCENTUALPOBREZADIFAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NTO_PERCENTUALPOBREZADIFAL: Double read FNTO_PERCENTUALPOBREZADIFAL write FNTO_PERCENTUALPOBREZADIFAL;
    const NTO_PERCENTUALPOBREZADIFAL_Name = 'NTO_PERCENTUALPOBREZADIFAL';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_ENVIARDIFALZERADO', ftString, 1)]
    [Dictionary('NTO_ENVIARDIFALZERADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ENVIARDIFALZERADO: String read FNTO_ENVIARDIFALZERADO write FNTO_ENVIARDIFALZERADO;
    const NTO_ENVIARDIFALZERADO_Name = 'NTO_ENVIARDIFALZERADO';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCONTOCONDICIONAL', ftString, 1)]
    [Dictionary('NTO_DESCONTOCONDICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCONTOCONDICIONAL: String read FNTO_DESCONTOCONDICIONAL write FNTO_DESCONTOCONDICIONAL;
    const NTO_DESCONTOCONDICIONAL_Name = 'NTO_DESCONTOCONDICIONAL';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGONATUREZACONTASPEDPC', ftString, 2)]
    [Dictionary('NTO_CODIGONATUREZACONTASPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_CODIGONATUREZACONTASPEDPC: String read FNTO_CODIGONATUREZACONTASPEDPC write FNTO_CODIGONATUREZACONTASPEDPC;
    const NTO_CODIGONATUREZACONTASPEDPC_Name = 'NTO_CODIGONATUREZACONTASPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_TIPOCONTASPEDPC', ftString, 1)]
    [Dictionary('NTO_TIPOCONTASPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_TIPOCONTASPEDPC: String read FNTO_TIPOCONTASPEDPC write FNTO_TIPOCONTASPEDPC;
    const NTO_TIPOCONTASPEDPC_Name = 'NTO_TIPOCONTASPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_NIVELCONTASPEDPC', ftString, 2)]
    [Dictionary('NTO_NIVELCONTASPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NIVELCONTASPEDPC: String read FNTO_NIVELCONTASPEDPC write FNTO_NIVELCONTASPEDPC;
    const NTO_NIVELCONTASPEDPC_Name = 'NTO_NIVELCONTASPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOCONTASPEDPC', ftString, 60)]
    [Dictionary('NTO_CODIGOCONTASPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_CODIGOCONTASPEDPC: String read FNTO_CODIGOCONTASPEDPC write FNTO_CODIGOCONTASPEDPC;
    const NTO_CODIGOCONTASPEDPC_Name = 'NTO_CODIGOCONTASPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_NOMECONTASPEDPC', ftString, 60)]
    [Dictionary('NTO_NOMECONTASPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NOMECONTASPEDPC: String read FNTO_NOMECONTASPEDPC write FNTO_NOMECONTASPEDPC;
    const NTO_NOMECONTASPEDPC_Name = 'NTO_NOMECONTASPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGOCENTROCUSTOSPEDPC', ftString, 60)]
    [Dictionary('NTO_CODIGOCENTROCUSTOSPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_CODIGOCENTROCUSTOSPEDPC: String read FNTO_CODIGOCENTROCUSTOSPEDPC write FNTO_CODIGOCENTROCUSTOSPEDPC;
    const NTO_CODIGOCENTROCUSTOSPEDPC_Name = 'NTO_CODIGOCENTROCUSTOSPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_NOMECENTROCUSTOSPEDPC', ftString, 60)]
    [Dictionary('NTO_NOMECENTROCUSTOSPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NOMECENTROCUSTOSPEDPC: String read FNTO_NOMECENTROCUSTOSPEDPC write FNTO_NOMECENTROCUSTOSPEDPC;
    const NTO_NOMECENTROCUSTOSPEDPC_Name = 'NTO_NOMECENTROCUSTOSPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_DATAINCLUSAOCONTASPEDPC', ftDateTime)]
    [Dictionary('NTO_DATAINCLUSAOCONTASPEDPC', 'Mensagem de validação', '', '', '', taCenter)]
    property NTO_DATAINCLUSAOCONTASPEDPC: TDateTime read FNTO_DATAINCLUSAOCONTASPEDPC write FNTO_DATAINCLUSAOCONTASPEDPC;
    const NTO_DATAINCLUSAOCONTASPEDPC_Name = 'NTO_DATAINCLUSAOCONTASPEDPC';

    [Restrictions([NoValidate])]
    [Column('NTO_NAOGERARLIVROFISCAL', ftString, 1)]
    [Dictionary('NTO_NAOGERARLIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NAOGERARLIVROFISCAL: String read FNTO_NAOGERARLIVROFISCAL write FNTO_NAOGERARLIVROFISCAL;
    const NTO_NAOGERARLIVROFISCAL_Name = 'NTO_NAOGERARLIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGONATUREZASERVICO', ftString, 3)]
    [Dictionary('NTO_CODIGONATUREZASERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_CODIGONATUREZASERVICO: String read FNTO_CODIGONATUREZASERVICO write FNTO_CODIGONATUREZASERVICO;
    const NTO_CODIGONATUREZASERVICO_Name = 'NTO_CODIGONATUREZASERVICO';

    [Restrictions([NoValidate])]
    [Column('NTO_ISSRETIDO', ftString, 1)]
    [Dictionary('NTO_ISSRETIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ISSRETIDO: String read FNTO_ISSRETIDO write FNTO_ISSRETIDO;
    const NTO_ISSRETIDO_Name = 'NTO_ISSRETIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_ADOTARLEIFEDERAL', ftString, 1)]
    [Dictionary('NTO_ADOTARLEIFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_ADOTARLEIFEDERAL: String read FNTO_ADOTARLEIFEDERAL write FNTO_ADOTARLEIFEDERAL;
    const NTO_ADOTARLEIFEDERAL_Name = 'NTO_ADOTARLEIFEDERAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoNTO_00)

end.
