unit express.dbo.REL_V01_MFC;

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
  [Table('REL_V01_MFC', '')]
  TDtoREL_V01_MFC = class
  private
    { Private declarations } 
    FMFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_DATASAIDA: TDateTime;
    FMFC_DATARETORNO: TDateTime;
    FMFC_NUMERODOCTO: String;
    FMFC_NOTAFISCAL: String;
    FMFC_OBSERVACAO: String;
    FTRP_CODIGO: Integer;
    FFOR_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
    FCTR_ID: Integer;
    FCTR_NUMERODOCTO: String;
    FCTR_NOTAFISCAL: String;
    FMFC_ORDEMITEM: Integer;
    FMFC_TIPOFRETE: String;
    FMFC_VALORFRETE: Double;
    FMFC_VALORNOTAFISCAL: Double;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_NOMEREMETENTE: String;
    FPES_CIDADEREMETENTE: String;
    FPES_UFREMETENTE: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_NOMEDESTINATARIO: String;
    FPES_CIDADEDESTINATARIO: String;
    FPES_UFDESTINATARIO: String;
    FPES_CLIENTECONSIGNATARIO: Integer;
    FPES_NOMECONSIGNATARIO: String;
    FPES_CIDADECONSIGNATARIO: String;
    FPES_UFCONSIGNATARIO: String;
    FPES_CLIENTEREDESPACHO: Integer;
    FPES_NOMEREDESPACHO: String;
    FPES_CIDADEREDESPACHO: String;
    FPES_UFREDESPACHO: String;
    FCTR_TOTALQTDVOLUMES: Double;
    FCTR_TOTALPESO: Double;
    FPES_NOME: String;
    FMFC_TOTALFRETETRP: Double;
    FMFC_TOTALKM: Double;
    FCTR_NATUREZACARGA: String;
    FMFC_CANCELADO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_MFC';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATASAIDA', ftDateTime)]
    [Dictionary('MFC_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATASAIDA: TDateTime read FMFC_DATASAIDA write FMFC_DATASAIDA;
    const MFC_DATASAIDA_Name = 'MFC_DATASAIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATARETORNO', ftDateTime)]
    [Dictionary('MFC_DATARETORNO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATARETORNO: TDateTime read FMFC_DATARETORNO write FMFC_DATARETORNO;
    const MFC_DATARETORNO_Name = 'MFC_DATARETORNO';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMERODOCTO', ftString, 6)]
    [Dictionary('MFC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMERODOCTO: String read FMFC_NUMERODOCTO write FMFC_NUMERODOCTO;
    const MFC_NUMERODOCTO_Name = 'MFC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('MFC_NOTAFISCAL', ftString, 9)]
    [Dictionary('MFC_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NOTAFISCAL: String read FMFC_NOTAFISCAL write FMFC_NOTAFISCAL;
    const MFC_NOTAFISCAL_Name = 'MFC_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MFC_OBSERVACAO', ftString, 300)]
    [Dictionary('MFC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_OBSERVACAO: String read FMFC_OBSERVACAO write FMFC_OBSERVACAO;
    const MFC_OBSERVACAO_Name = 'MFC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MFC_ORDEMITEM', ftInteger)]
    [Dictionary('MFC_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ORDEMITEM: Integer read FMFC_ORDEMITEM write FMFC_ORDEMITEM;
    const MFC_ORDEMITEM_Name = 'MFC_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('MFC_TIPOFRETE', ftString, 1)]
    [Dictionary('MFC_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOFRETE: String read FMFC_TIPOFRETE write FMFC_TIPOFRETE;
    const MFC_TIPOFRETE_Name = 'MFC_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('MFC_VALORFRETE', ftBCD)]
    [Dictionary('MFC_VALORFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORFRETE: Double read FMFC_VALORFRETE write FMFC_VALORFRETE;
    const MFC_VALORFRETE_Name = 'MFC_VALORFRETE';

    [Restrictions([NoValidate])]
    [Column('MFC_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('MFC_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORNOTAFISCAL: Double read FMFC_VALORNOTAFISCAL write FMFC_VALORNOTAFISCAL;
    const MFC_VALORNOTAFISCAL_Name = 'MFC_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEREMETENTE: String read FPES_NOMEREMETENTE write FPES_NOMEREMETENTE;
    const PES_NOMEREMETENTE_Name = 'PES_NOMEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADEREMETENTE', ftString, 100)]
    [Dictionary('PES_CIDADEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADEREMETENTE: String read FPES_CIDADEREMETENTE write FPES_CIDADEREMETENTE;
    const PES_CIDADEREMETENTE_Name = 'PES_CIDADEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_UFREMETENTE', ftString, 2)]
    [Dictionary('PES_UFREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFREMETENTE: String read FPES_UFREMETENTE write FPES_UFREMETENTE;
    const PES_UFREMETENTE_Name = 'PES_UFREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEDESTINATARIO: String read FPES_NOMEDESTINATARIO write FPES_NOMEDESTINATARIO;
    const PES_NOMEDESTINATARIO_Name = 'PES_NOMEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_CIDADEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADEDESTINATARIO: String read FPES_CIDADEDESTINATARIO write FPES_CIDADEDESTINATARIO;
    const PES_CIDADEDESTINATARIO_Name = 'PES_CIDADEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UFDESTINATARIO', ftString, 2)]
    [Dictionary('PES_UFDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFDESTINATARIO: String read FPES_UFDESTINATARIO write FPES_UFDESTINATARIO;
    const PES_UFDESTINATARIO_Name = 'PES_UFDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTECONSIGNATARIO', ftInteger)]
    [Dictionary('PES_CLIENTECONSIGNATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTECONSIGNATARIO: Integer read FPES_CLIENTECONSIGNATARIO write FPES_CLIENTECONSIGNATARIO;
    const PES_CLIENTECONSIGNATARIO_Name = 'PES_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_NOMECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECONSIGNATARIO: String read FPES_NOMECONSIGNATARIO write FPES_NOMECONSIGNATARIO;
    const PES_NOMECONSIGNATARIO_Name = 'PES_NOMECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADECONSIGNATARIO', ftString, 100)]
    [Dictionary('PES_CIDADECONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADECONSIGNATARIO: String read FPES_CIDADECONSIGNATARIO write FPES_CIDADECONSIGNATARIO;
    const PES_CIDADECONSIGNATARIO_Name = 'PES_CIDADECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UFCONSIGNATARIO', ftString, 2)]
    [Dictionary('PES_UFCONSIGNATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFCONSIGNATARIO: String read FPES_UFCONSIGNATARIO write FPES_UFCONSIGNATARIO;
    const PES_UFCONSIGNATARIO_Name = 'PES_UFCONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREDESPACHO', ftInteger)]
    [Dictionary('PES_CLIENTEREDESPACHO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREDESPACHO: Integer read FPES_CLIENTEREDESPACHO write FPES_CLIENTEREDESPACHO;
    const PES_CLIENTEREDESPACHO_Name = 'PES_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEREDESPACHO', ftString, 100)]
    [Dictionary('PES_NOMEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEREDESPACHO: String read FPES_NOMEREDESPACHO write FPES_NOMEREDESPACHO;
    const PES_NOMEREDESPACHO_Name = 'PES_NOMEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADEREDESPACHO', ftString, 100)]
    [Dictionary('PES_CIDADEREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADEREDESPACHO: String read FPES_CIDADEREDESPACHO write FPES_CIDADEREDESPACHO;
    const PES_CIDADEREDESPACHO_Name = 'PES_CIDADEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_UFREDESPACHO', ftString, 2)]
    [Dictionary('PES_UFREDESPACHO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UFREDESPACHO: String read FPES_UFREDESPACHO write FPES_UFREDESPACHO;
    const PES_UFREDESPACHO_Name = 'PES_UFREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALQTDVOLUMES', ftBCD)]
    [Dictionary('CTR_TOTALQTDVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALQTDVOLUMES: Double read FCTR_TOTALQTDVOLUMES write FCTR_TOTALQTDVOLUMES;
    const CTR_TOTALQTDVOLUMES_Name = 'CTR_TOTALQTDVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CTR_TOTALPESO', ftBCD, 18, 4)]
    [Dictionary('CTR_TOTALPESO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPESO: Double read FCTR_TOTALPESO write FCTR_TOTALPESO;
    const CTR_TOTALPESO_Name = 'CTR_TOTALPESO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALFRETETRP', ftBCD, 66260064, 2)]
    [Dictionary('MFC_TOTALFRETETRP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALFRETETRP: Double read FMFC_TOTALFRETETRP write FMFC_TOTALFRETETRP;
    const MFC_TOTALFRETETRP_Name = 'MFC_TOTALFRETETRP';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TOTALKM', ftBCD)]
    [Dictionary('MFC_TOTALKM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_TOTALKM: Double read FMFC_TOTALKM write FMFC_TOTALKM;
    const MFC_TOTALKM_Name = 'MFC_TOTALKM';

    [Restrictions([NoValidate])]
    [Column('CTR_NATUREZACARGA', ftString, 15)]
    [Dictionary('CTR_NATUREZACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NATUREZACARGA: String read FCTR_NATUREZACARGA write FCTR_NATUREZACARGA;
    const CTR_NATUREZACARGA_Name = 'CTR_NATUREZACARGA';

    [Restrictions([NoValidate])]
    [Column('MFC_CANCELADO', ftString, 1)]
    [Dictionary('MFC_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CANCELADO: String read FMFC_CANCELADO write FMFC_CANCELADO;
    const MFC_CANCELADO_Name = 'MFC_CANCELADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_MFC)

end.
