unit express.dbo.CTR_ETIQUETAS;

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
  [Table('CTR_Etiquetas', '')]
  TDtoCTR_Etiquetas = class
  private
    { Private declarations } 
    FCTR_NOTAFISCAL: String;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FCTR_SERIE: String;
    FMNF_CODIGO: String;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_ORDEMITEM: Integer;
    FCTR_NOTAFISCAL_01: String;
    FCTR_VALORNOTAFISCAL: Double;
    FCTR_VALORSEMIPI: Double;
    FCTR_VALORCOMIPI: Double;
    FCTR_PESOBRUTO: Double;
    FCTR_PESOLIQUIDO: Double;
    FCTR_NUMEROVOLUMES: Double;
    FCTR_BAIXADO: String;
    FPES_CODIGOCLIENTEREMETENTE: Integer;
    FPES_NOMECLIENTEREMETENTE: String;
    FPES_ENDERECOCLIENTEREMETENTE: String;
    FPES_NUMEROENDERECOCLIENTEREMETENTE: String;
    FPES_BAIRROCLIENTEREMETENTE: String;
    FPES_CEPCLIENTEREMETENTE: String;
    FPES_CIDADECLIENTEREMETENTE: String;
    FPES_UFCLIENTEREMETENTE: String;
    FPES_TELEFONECLIENTEREMETENTE: String;
    FPES_CODIGOROTACLIENTEREMETENTE: Integer;
    FPES_DESCRICAOROTACLIENTEREMETENTE: String;
    FPES_CODIGOCLIENTEDESTINATARIO: Integer;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FPES_ENDERECOCLIENTEDESTINATARIO: String;
    FPES_NUMEROENDERECOCLIENTEDESTINATARIO: String;
    FPES_BAIRROCLIENTEDESTINATARIO: String;
    FPES_CEPCLIENTEDESTINATARIO: String;
    FPES_CIDADECLIENTEDESTINATARIO: String;
    FPES_UFCLIENTEDESTINATARIO: String;
    FPES_TELEFONECLIENTEDESTINATARIO: String;
    FPES_CODIGOROTACLIENTEDESTINATARIO: Integer;
    FPES_DESCRICAOROTACLIENTEDESTINATARIO: String;
    FPES_CODIGOTRANSPORTADOR: Integer;
    FPES_NOMETRANSPORTADOR: String;
    FCTR_PROCESSADO: String;
    FCTR_CANCELADO: String;
    FCTR_ETIQUETAIMPRESSA: String;
  public 
    { Public declarations } 
     const Table      = 'CTR_Etiquetas';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ORDEMITEM', ftInteger)]
    [Dictionary('CTR_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ORDEMITEM: Integer read FCTR_ORDEMITEM write FCTR_ORDEMITEM;
    const CTR_ORDEMITEM_Name = 'CTR_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL_01', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL_01', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL_01: String read FCTR_NOTAFISCAL_01 write FCTR_NOTAFISCAL_01;
    const CTR_NOTAFISCAL_01_Name = 'CTR_NOTAFISCAL_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_VALORNOTAFISCAL', ftBCD, 10, 2)]
    [Dictionary('CTR_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORNOTAFISCAL: Double read FCTR_VALORNOTAFISCAL write FCTR_VALORNOTAFISCAL;
    const CTR_VALORNOTAFISCAL_Name = 'CTR_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORSEMIPI', ftBCD)]
    [Dictionary('CTR_VALORSEMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORSEMIPI: Double read FCTR_VALORSEMIPI write FCTR_VALORSEMIPI;
    const CTR_VALORSEMIPI_Name = 'CTR_VALORSEMIPI';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORCOMIPI', ftBCD)]
    [Dictionary('CTR_VALORCOMIPI', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORCOMIPI: Double read FCTR_VALORCOMIPI write FCTR_VALORCOMIPI;
    const CTR_VALORCOMIPI_Name = 'CTR_VALORCOMIPI';

    [Restrictions([NoValidate])]
    [Column('CTR_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOBRUTO: Double read FCTR_PESOBRUTO write FCTR_PESOBRUTO;
    const CTR_PESOBRUTO_Name = 'CTR_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOLIQUIDO: Double read FCTR_PESOLIQUIDO write FCTR_PESOLIQUIDO;
    const CTR_PESOLIQUIDO_Name = 'CTR_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROVOLUMES', ftBCD)]
    [Dictionary('CTR_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_NUMEROVOLUMES: Double read FCTR_NUMEROVOLUMES write FCTR_NUMEROVOLUMES;
    const CTR_NUMEROVOLUMES_Name = 'CTR_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CTR_BAIXADO', ftString, 1)]
    [Dictionary('CTR_BAIXADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_BAIXADO: String read FCTR_BAIXADO write FCTR_BAIXADO;
    const CTR_BAIXADO_Name = 'CTR_BAIXADO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CODIGOCLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCLIENTEREMETENTE: Integer read FPES_CODIGOCLIENTEREMETENTE write FPES_CODIGOCLIENTEREMETENTE;
    const PES_CODIGOCLIENTEREMETENTE_Name = 'PES_CODIGOCLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEREMETENTE: String read FPES_NOMECLIENTEREMETENTE write FPES_NOMECLIENTEREMETENTE;
    const PES_NOMECLIENTEREMETENTE_Name = 'PES_NOMECLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECOCLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_ENDERECOCLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECOCLIENTEREMETENTE: String read FPES_ENDERECOCLIENTEREMETENTE write FPES_ENDERECOCLIENTEREMETENTE;
    const PES_ENDERECOCLIENTEREMETENTE_Name = 'PES_ENDERECOCLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECOCLIENTEREMETENTE', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECOCLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECOCLIENTEREMETENTE: String read FPES_NUMEROENDERECOCLIENTEREMETENTE write FPES_NUMEROENDERECOCLIENTEREMETENTE;
    const PES_NUMEROENDERECOCLIENTEREMETENTE_Name = 'PES_NUMEROENDERECOCLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRROCLIENTEREMETENTE', ftString, 50)]
    [Dictionary('PES_BAIRROCLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRROCLIENTEREMETENTE: String read FPES_BAIRROCLIENTEREMETENTE write FPES_BAIRROCLIENTEREMETENTE;
    const PES_BAIRROCLIENTEREMETENTE_Name = 'PES_BAIRROCLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CEPCLIENTEREMETENTE', ftString, 8)]
    [Dictionary('PES_CEPCLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEPCLIENTEREMETENTE: String read FPES_CEPCLIENTEREMETENTE write FPES_CEPCLIENTEREMETENTE;
    const PES_CEPCLIENTEREMETENTE_Name = 'PES_CEPCLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADECLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_CIDADECLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADECLIENTEREMETENTE: String read FPES_CIDADECLIENTEREMETENTE write FPES_CIDADECLIENTEREMETENTE;
    const PES_CIDADECLIENTEREMETENTE_Name = 'PES_CIDADECLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_UFCLIENTEREMETENTE', ftString, 2)]
    [Dictionary('PES_UFCLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFCLIENTEREMETENTE: String read FPES_UFCLIENTEREMETENTE write FPES_UFCLIENTEREMETENTE;
    const PES_UFCLIENTEREMETENTE_Name = 'PES_UFCLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_TELEFONECLIENTEREMETENTE', ftString, 11)]
    [Dictionary('PES_TELEFONECLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TELEFONECLIENTEREMETENTE: String read FPES_TELEFONECLIENTEREMETENTE write FPES_TELEFONECLIENTEREMETENTE;
    const PES_TELEFONECLIENTEREMETENTE_Name = 'PES_TELEFONECLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOROTACLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CODIGOROTACLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOROTACLIENTEREMETENTE: Integer read FPES_CODIGOROTACLIENTEREMETENTE write FPES_CODIGOROTACLIENTEREMETENTE;
    const PES_CODIGOROTACLIENTEREMETENTE_Name = 'PES_CODIGOROTACLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_DESCRICAOROTACLIENTEREMETENTE', ftString, 30)]
    [Dictionary('PES_DESCRICAOROTACLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DESCRICAOROTACLIENTEREMETENTE: String read FPES_DESCRICAOROTACLIENTEREMETENTE write FPES_DESCRICAOROTACLIENTEREMETENTE;
    const PES_DESCRICAOROTACLIENTEREMETENTE_Name = 'PES_DESCRICAOROTACLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CODIGOCLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCLIENTEDESTINATARIO: Integer read FPES_CODIGOCLIENTEDESTINATARIO write FPES_CODIGOCLIENTEDESTINATARIO;
    const PES_CODIGOCLIENTEDESTINATARIO_Name = 'PES_CODIGOCLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEDESTINATARIO: String read FPES_NOMECLIENTEDESTINATARIO write FPES_NOMECLIENTEDESTINATARIO;
    const PES_NOMECLIENTEDESTINATARIO_Name = 'PES_NOMECLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECOCLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_ENDERECOCLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECOCLIENTEDESTINATARIO: String read FPES_ENDERECOCLIENTEDESTINATARIO write FPES_ENDERECOCLIENTEDESTINATARIO;
    const PES_ENDERECOCLIENTEDESTINATARIO_Name = 'PES_ENDERECOCLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECOCLIENTEDESTINATARIO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECOCLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECOCLIENTEDESTINATARIO: String read FPES_NUMEROENDERECOCLIENTEDESTINATARIO write FPES_NUMEROENDERECOCLIENTEDESTINATARIO;
    const PES_NUMEROENDERECOCLIENTEDESTINATARIO_Name = 'PES_NUMEROENDERECOCLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRROCLIENTEDESTINATARIO', ftString, 50)]
    [Dictionary('PES_BAIRROCLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRROCLIENTEDESTINATARIO: String read FPES_BAIRROCLIENTEDESTINATARIO write FPES_BAIRROCLIENTEDESTINATARIO;
    const PES_BAIRROCLIENTEDESTINATARIO_Name = 'PES_BAIRROCLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CEPCLIENTEDESTINATARIO', ftString, 8)]
    [Dictionary('PES_CEPCLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CEPCLIENTEDESTINATARIO: String read FPES_CEPCLIENTEDESTINATARIO write FPES_CEPCLIENTEDESTINATARIO;
    const PES_CEPCLIENTEDESTINATARIO_Name = 'PES_CEPCLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADECLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_CIDADECLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADECLIENTEDESTINATARIO: String read FPES_CIDADECLIENTEDESTINATARIO write FPES_CIDADECLIENTEDESTINATARIO;
    const PES_CIDADECLIENTEDESTINATARIO_Name = 'PES_CIDADECLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UFCLIENTEDESTINATARIO', ftString, 2)]
    [Dictionary('PES_UFCLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFCLIENTEDESTINATARIO: String read FPES_UFCLIENTEDESTINATARIO write FPES_UFCLIENTEDESTINATARIO;
    const PES_UFCLIENTEDESTINATARIO_Name = 'PES_UFCLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_TELEFONECLIENTEDESTINATARIO', ftString, 11)]
    [Dictionary('PES_TELEFONECLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TELEFONECLIENTEDESTINATARIO: String read FPES_TELEFONECLIENTEDESTINATARIO write FPES_TELEFONECLIENTEDESTINATARIO;
    const PES_TELEFONECLIENTEDESTINATARIO_Name = 'PES_TELEFONECLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOROTACLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CODIGOROTACLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOROTACLIENTEDESTINATARIO: Integer read FPES_CODIGOROTACLIENTEDESTINATARIO write FPES_CODIGOROTACLIENTEDESTINATARIO;
    const PES_CODIGOROTACLIENTEDESTINATARIO_Name = 'PES_CODIGOROTACLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_DESCRICAOROTACLIENTEDESTINATARIO', ftString, 30)]
    [Dictionary('PES_DESCRICAOROTACLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DESCRICAOROTACLIENTEDESTINATARIO: String read FPES_DESCRICAOROTACLIENTEDESTINATARIO write FPES_DESCRICAOROTACLIENTEDESTINATARIO;
    const PES_DESCRICAOROTACLIENTEDESTINATARIO_Name = 'PES_DESCRICAOROTACLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOTRANSPORTADOR', ftInteger)]
    [Dictionary('PES_CODIGOTRANSPORTADOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOTRANSPORTADOR: Integer read FPES_CODIGOTRANSPORTADOR write FPES_CODIGOTRANSPORTADOR;
    const PES_CODIGOTRANSPORTADOR_Name = 'PES_CODIGOTRANSPORTADOR';

    [Restrictions([NoValidate])]
    [Column('PES_NOMETRANSPORTADOR', ftString, 100)]
    [Dictionary('PES_NOMETRANSPORTADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMETRANSPORTADOR: String read FPES_NOMETRANSPORTADOR write FPES_NOMETRANSPORTADOR;
    const PES_NOMETRANSPORTADOR_Name = 'PES_NOMETRANSPORTADOR';

    [Restrictions([NoValidate])]
    [Column('CTR_PROCESSADO', ftString, 1)]
    [Dictionary('CTR_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_PROCESSADO: String read FCTR_PROCESSADO write FCTR_PROCESSADO;
    const CTR_PROCESSADO_Name = 'CTR_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('CTR_CANCELADO', ftString, 1)]
    [Dictionary('CTR_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CANCELADO: String read FCTR_CANCELADO write FCTR_CANCELADO;
    const CTR_CANCELADO_Name = 'CTR_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ETIQUETAIMPRESSA', ftString, 1)]
    [Dictionary('CTR_ETIQUETAIMPRESSA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_ETIQUETAIMPRESSA: String read FCTR_ETIQUETAIMPRESSA write FCTR_ETIQUETAIMPRESSA;
    const CTR_ETIQUETAIMPRESSA_Name = 'CTR_ETIQUETAIMPRESSA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTR_Etiquetas)

end.
