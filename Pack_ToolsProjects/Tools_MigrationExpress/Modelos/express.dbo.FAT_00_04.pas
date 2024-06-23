unit express.dbo.FAT_00_04;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.fat_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('FAT_00_04', '')]
  [PrimaryKey('FAT_04_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FAT_04_ID')]
  TDtoFAT_00_04 = class
  private
    { Private declarations } 
    FFAT_04_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_ID: Integer;
    FVEI_CODIGO: Integer;
    FFAT_MACACO: String;
    FFAT_NUMEROOS: Integer;
    FFAT_KMVEICULO: Integer;
    FFAT_CHAVERODA: String;
    FFAT_DIASRETORNO: Integer;
    FFAT_CONDUTORENTRADA: String;
    FFAT_CONDUTORSAIDA: String;
    FFAT_HORAABERTURA: String;
    FFAT_DATAABERTURA: TDateTime;
    FFAT_DATAFECHAMENTO: TDateTime;
    FFAT_HORAFECHAMENTO: String;
    FFAT_OBSENTRADAVEICULO: String;
    FFAT_POSICAOTANQUEVEICULO: String;
    FFAT_OBSSOLICITACAOCLIENTE: String;
    FFAT_OBSFECHAMENTOORDEMSERVICO: String;
    FFAT_DATAALTERACAO: TDateTime;
    FFAT_04_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_NUMEROOC: Integer;
    FFAT_INTEGRACAOERP: String;
    FFAT_OSFECHADA: String;
    FFAT_STATUSFECHAMENTO: String;
  public
    { Public declarations }
    const Table      = 'FAT_00_04';
    const PrimaryKey = 'FAT_04_ID';
    const Sequence   = 'SEQ_FAT_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_04_ID', ftInteger)]
    [Dictionary('FAT_04_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_04_ID: Integer read FFAT_04_ID write FFAT_04_ID;
    const FAT_04_ID_Name = 'FAT_04_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [ForeignKey('FAT_00_04_fk', 'FAT_ID', 'FAT_00', 'FAT_ID', SetNull, SetNull)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_MACACO', ftString, 1)]
    [Dictionary('FAT_MACACO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_MACACO: String read FFAT_MACACO write FFAT_MACACO;
    const FAT_MACACO_Name = 'FAT_MACACO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROOS', ftInteger)]
    [Dictionary('FAT_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROOS: Integer read FFAT_NUMEROOS write FFAT_NUMEROOS;
    const FAT_NUMEROOS_Name = 'FAT_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('FAT_KMVEICULO', ftInteger)]
    [Dictionary('FAT_KMVEICULO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_KMVEICULO: Integer read FFAT_KMVEICULO write FFAT_KMVEICULO;
    const FAT_KMVEICULO_Name = 'FAT_KMVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_CHAVERODA', ftString, 1)]
    [Dictionary('FAT_CHAVERODA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CHAVERODA: String read FFAT_CHAVERODA write FFAT_CHAVERODA;
    const FAT_CHAVERODA_Name = 'FAT_CHAVERODA';

    [Restrictions([NoValidate])]
    [Column('FAT_DIASRETORNO', ftInteger)]
    [Dictionary('FAT_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_DIASRETORNO: Integer read FFAT_DIASRETORNO write FFAT_DIASRETORNO;
    const FAT_DIASRETORNO_Name = 'FAT_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('FAT_CONDUTORENTRADA', ftString, 30)]
    [Dictionary('FAT_CONDUTORENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CONDUTORENTRADA: String read FFAT_CONDUTORENTRADA write FFAT_CONDUTORENTRADA;
    const FAT_CONDUTORENTRADA_Name = 'FAT_CONDUTORENTRADA';

    [Restrictions([NoValidate])]
    [Column('FAT_CONDUTORSAIDA', ftString, 30)]
    [Dictionary('FAT_CONDUTORSAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CONDUTORSAIDA: String read FFAT_CONDUTORSAIDA write FFAT_CONDUTORSAIDA;
    const FAT_CONDUTORSAIDA_Name = 'FAT_CONDUTORSAIDA';

    [Restrictions([NoValidate])]
    [Column('FAT_HORAABERTURA', ftString, 8)]
    [Dictionary('FAT_HORAABERTURA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_HORAABERTURA: String read FFAT_HORAABERTURA write FFAT_HORAABERTURA;
    const FAT_HORAABERTURA_Name = 'FAT_HORAABERTURA';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAABERTURA', ftDateTime)]
    [Dictionary('FAT_DATAABERTURA', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAABERTURA: TDateTime read FFAT_DATAABERTURA write FFAT_DATAABERTURA;
    const FAT_DATAABERTURA_Name = 'FAT_DATAABERTURA';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('FAT_DATAFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAFECHAMENTO: TDateTime read FFAT_DATAFECHAMENTO write FFAT_DATAFECHAMENTO;
    const FAT_DATAFECHAMENTO_Name = 'FAT_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_HORAFECHAMENTO', ftString, 8)]
    [Dictionary('FAT_HORAFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_HORAFECHAMENTO: String read FFAT_HORAFECHAMENTO write FFAT_HORAFECHAMENTO;
    const FAT_HORAFECHAMENTO_Name = 'FAT_HORAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSENTRADAVEICULO', ftString, 5000)]
    [Dictionary('FAT_OBSENTRADAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSENTRADAVEICULO: String read FFAT_OBSENTRADAVEICULO write FFAT_OBSENTRADAVEICULO;
    const FAT_OBSENTRADAVEICULO_Name = 'FAT_OBSENTRADAVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_POSICAOTANQUEVEICULO', ftString, 1)]
    [Dictionary('FAT_POSICAOTANQUEVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_POSICAOTANQUEVEICULO: String read FFAT_POSICAOTANQUEVEICULO write FFAT_POSICAOTANQUEVEICULO;
    const FAT_POSICAOTANQUEVEICULO_Name = 'FAT_POSICAOTANQUEVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSSOLICITACAOCLIENTE', ftString, 5000)]
    [Dictionary('FAT_OBSSOLICITACAOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSSOLICITACAOCLIENTE: String read FFAT_OBSSOLICITACAOCLIENTE write FFAT_OBSSOLICITACAOCLIENTE;
    const FAT_OBSSOLICITACAOCLIENTE_Name = 'FAT_OBSSOLICITACAOCLIENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSFECHAMENTOORDEMSERVICO', ftString, 5000)]
    [Dictionary('FAT_OBSFECHAMENTOORDEMSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSFECHAMENTOORDEMSERVICO: String read FFAT_OBSFECHAMENTOORDEMSERVICO write FFAT_OBSFECHAMENTOORDEMSERVICO;
    const FAT_OBSFECHAMENTOORDEMSERVICO_Name = 'FAT_OBSFECHAMENTOORDEMSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAALTERACAO', ftDateTime)]
    [Dictionary('FAT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAALTERACAO: TDateTime read FFAT_DATAALTERACAO write FFAT_DATAALTERACAO;
    const FAT_DATAALTERACAO_Name = 'FAT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_04_ID_OLD', ftInteger)]
    [Dictionary('FAT_04_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_04_ID_OLD: Integer read FFAT_04_ID_OLD write FFAT_04_ID_OLD;
    const FAT_04_ID_OLD_Name = 'FAT_04_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROOC', ftInteger)]
    [Dictionary('FAT_NUMEROOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROOC: Integer read FFAT_NUMEROOC write FFAT_NUMEROOC;
    const FAT_NUMEROOC_Name = 'FAT_NUMEROOC';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAOERP', ftString, 50)]
    [Dictionary('FAT_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAOERP: String read FFAT_INTEGRACAOERP write FFAT_INTEGRACAOERP;
    const FAT_INTEGRACAOERP_Name = 'FAT_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('FAT_OSFECHADA', ftString, 1)]
    [Dictionary('FAT_OSFECHADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OSFECHADA: String read FFAT_OSFECHADA write FFAT_OSFECHADA;
    const FAT_OSFECHADA_Name = 'FAT_OSFECHADA';

    [Restrictions([NoValidate])]
    [Column('FAT_STATUSFECHAMENTO', ftString, 1)]
    [Dictionary('FAT_STATUSFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_STATUSFECHAMENTO: String read FFAT_STATUSFECHAMENTO write FFAT_STATUSFECHAMENTO;
    const FAT_STATUSFECHAMENTO_Name = 'FAT_STATUSFECHAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_00_04)

end.
