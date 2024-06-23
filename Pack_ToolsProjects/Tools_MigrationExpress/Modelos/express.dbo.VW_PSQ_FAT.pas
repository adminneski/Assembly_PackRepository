unit express.dbo.VW_PSQ_FAT;

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
  [Table('VW_PSQ_FAT', '')]
  TDtoVW_PSQ_FAT = class
  private
    { Private declarations } 
    FFAT_ID: Integer;
    FFAT_NSV: Integer;
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_NOTAFISCAL: String;
    FFAT_NOTAFISCALSERVICO: String;
    FFAT_TIPOMOVTO: String;
    FFAT_RESERVARESTOQUE: String;
    FFAT_NUMERODOCTO: String;
    FFAT_DESATIVADO: String;
    FFAT_PROCESSADO: String;
    FFAT_CANCELADA: String;
    FFAT_LIVROFISCAL: String;
    FFAT_DATALACRE: TDateTime;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_TOTALLIQUIDO: Double;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FCCU_CODIGO: Integer;
    FFAT_NUMEROOS: Integer;
    FVEI_CODIGO: Integer;
    FVEI_DESCRICAO: String;
    FVEI_PLACA: String;
    FFAT_BLOQUEADO: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FFAT_INTEGRACAO: String;
    FNTO_CODIGO: Integer;
    FNTO_DESCRICAO: String;
    FNTO_NAOGERARLIVROFISCAL: String;
    FFAT_STATUS: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_FAT';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('FAT_NSV', ftInteger)]
    [Dictionary('FAT_NSV', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NSV: Integer read FFAT_NSV write FFAT_NSV;
    const FAT_NSV_Name = 'FAT_NSV';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('FAT_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCALSERVICO: String read FFAT_NOTAFISCALSERVICO write FFAT_NOTAFISCALSERVICO;
    const FAT_NOTAFISCALSERVICO_Name = 'FAT_NOTAFISCALSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOMOVTO', ftString, 3)]
    [Dictionary('FAT_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOMOVTO: String read FFAT_TIPOMOVTO write FFAT_TIPOMOVTO;
    const FAT_TIPOMOVTO_Name = 'FAT_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('FAT_RESERVARESTOQUE', ftString, 1)]
    [Dictionary('FAT_RESERVARESTOQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_RESERVARESTOQUE: String read FFAT_RESERVARESTOQUE write FFAT_RESERVARESTOQUE;
    const FAT_RESERVARESTOQUE_Name = 'FAT_RESERVARESTOQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DESATIVADO', ftString, 1)]
    [Dictionary('FAT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESATIVADO: String read FFAT_DESATIVADO write FFAT_DESATIVADO;
    const FAT_DESATIVADO_Name = 'FAT_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PROCESSADO', ftString, 1)]
    [Dictionary('FAT_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_PROCESSADO: String read FFAT_PROCESSADO write FFAT_PROCESSADO;
    const FAT_PROCESSADO_Name = 'FAT_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('FAT_LIVROFISCAL', ftString, 1)]
    [Dictionary('FAT_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_LIVROFISCAL: String read FFAT_LIVROFISCAL write FFAT_LIVROFISCAL;
    const FAT_LIVROFISCAL_Name = 'FAT_LIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALACRE', ftDateTime)]
    [Dictionary('FAT_DATALACRE', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALACRE: TDateTime read FFAT_DATALACRE write FFAT_DATALACRE;
    const FAT_DATALACRE_Name = 'FAT_DATALACRE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALLIQUIDO', ftBCD, 10, 2)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
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
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROOS', ftInteger)]
    [Dictionary('FAT_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROOS: Integer read FFAT_NUMEROOS write FFAT_NUMEROOS;
    const FAT_NUMEROOS_Name = 'FAT_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('FAT_BLOQUEADO', ftString, 1)]
    [Dictionary('FAT_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_BLOQUEADO: String read FFAT_BLOQUEADO write FFAT_BLOQUEADO;
    const FAT_BLOQUEADO_Name = 'FAT_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO', ftString, 20)]
    [Dictionary('FAT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO: String read FFAT_INTEGRACAO write FFAT_INTEGRACAO;
    const FAT_INTEGRACAO_Name = 'FAT_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('NTO_NAOGERARLIVROFISCAL', ftString, 1)]
    [Dictionary('NTO_NAOGERARLIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NAOGERARLIVROFISCAL: String read FNTO_NAOGERARLIVROFISCAL write FNTO_NAOGERARLIVROFISCAL;
    const NTO_NAOGERARLIVROFISCAL_Name = 'NTO_NAOGERARLIVROFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_STATUS', ftString, 1)]
    [Dictionary('FAT_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_STATUS: String read FFAT_STATUS write FFAT_STATUS;
    const FAT_STATUS_Name = 'FAT_STATUS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_FAT)

end.
