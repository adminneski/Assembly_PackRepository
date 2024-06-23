unit express.dbo.REL_V01_CDV;

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
  [Table('REL_V01_CDV', '')]
  TDtoREL_V01_CDV = class
  private
    { Private declarations } 
    FCDV_ID: Integer;
    FCOM_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FVEI_DESCRICAO: String;
    FVEI_PLACA: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FCDV_DATALANCAMENTO: TDateTime;
    FCDV_NUMERODOCTO: String;
    FCDV_TIPOMOVTO: String;
    FCDV_HORASAIDA: String;
    FCDV_HORACHEGADA: String;
    FCDV_DATASAIDA: TDateTime;
    FCDV_DATACHEGADA: TDateTime;
    FCDV_KMHORIMETROSAIDA: Integer;
    FCDV_KMHORIMETROCHEGADA: Integer;
    FCDV_TOTALADIANTAMENTO: Double;
    FCDV_TOTALFRETE: Double;
    FCDV_OBSERVACAO: String;
    FPES_TIPOPESSOA: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FCDV_TOTALRECEITAS: Double;
    FCDV_TOTALDESPESAS: Double;
    FCDV_TOTALLIQUIDO: Double;
    FCDV_TOTALLIQUIDOTRANSPORTADOR: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CDV';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDV_ID', ftInteger)]
    [Dictionary('CDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_ID: Integer read FCDV_ID write FCDV_ID;
    const CDV_ID_Name = 'CDV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_DESCRICAO', ftString, 30)]
    [Dictionary('ROT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_DESCRICAO: String read FROT_DESCRICAO write FROT_DESCRICAO;
    const ROT_DESCRICAO_Name = 'ROT_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CDV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CDV_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CDV_DATALANCAMENTO: TDateTime read FCDV_DATALANCAMENTO write FCDV_DATALANCAMENTO;
    const CDV_DATALANCAMENTO_Name = 'CDV_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDV_NUMERODOCTO', ftString, 10)]
    [Dictionary('CDV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_NUMERODOCTO: String read FCDV_NUMERODOCTO write FCDV_NUMERODOCTO;
    const CDV_NUMERODOCTO_Name = 'CDV_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CDV_TIPOMOVTO', ftString, 1)]
    [Dictionary('CDV_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_TIPOMOVTO: String read FCDV_TIPOMOVTO write FCDV_TIPOMOVTO;
    const CDV_TIPOMOVTO_Name = 'CDV_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('CDV_HORASAIDA', ftString, 8)]
    [Dictionary('CDV_HORASAIDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_HORASAIDA: String read FCDV_HORASAIDA write FCDV_HORASAIDA;
    const CDV_HORASAIDA_Name = 'CDV_HORASAIDA';

    [Restrictions([NoValidate])]
    [Column('CDV_HORACHEGADA', ftString, 8)]
    [Dictionary('CDV_HORACHEGADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_HORACHEGADA: String read FCDV_HORACHEGADA write FCDV_HORACHEGADA;
    const CDV_HORACHEGADA_Name = 'CDV_HORACHEGADA';

    [Restrictions([NoValidate])]
    [Column('CDV_DATASAIDA', ftDateTime)]
    [Dictionary('CDV_DATASAIDA', 'Mensagem de validação', '', '', '', taCenter)]
    property CDV_DATASAIDA: TDateTime read FCDV_DATASAIDA write FCDV_DATASAIDA;
    const CDV_DATASAIDA_Name = 'CDV_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('CDV_DATACHEGADA', ftDateTime)]
    [Dictionary('CDV_DATACHEGADA', 'Mensagem de validação', '', '', '', taCenter)]
    property CDV_DATACHEGADA: TDateTime read FCDV_DATACHEGADA write FCDV_DATACHEGADA;
    const CDV_DATACHEGADA_Name = 'CDV_DATACHEGADA';

    [Restrictions([NoValidate])]
    [Column('CDV_KMHORIMETROSAIDA', ftInteger)]
    [Dictionary('CDV_KMHORIMETROSAIDA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_KMHORIMETROSAIDA: Integer read FCDV_KMHORIMETROSAIDA write FCDV_KMHORIMETROSAIDA;
    const CDV_KMHORIMETROSAIDA_Name = 'CDV_KMHORIMETROSAIDA';

    [Restrictions([NoValidate])]
    [Column('CDV_KMHORIMETROCHEGADA', ftInteger)]
    [Dictionary('CDV_KMHORIMETROCHEGADA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_KMHORIMETROCHEGADA: Integer read FCDV_KMHORIMETROCHEGADA write FCDV_KMHORIMETROCHEGADA;
    const CDV_KMHORIMETROCHEGADA_Name = 'CDV_KMHORIMETROCHEGADA';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALADIANTAMENTO', ftBCD)]
    [Dictionary('CDV_TOTALADIANTAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALADIANTAMENTO: Double read FCDV_TOTALADIANTAMENTO write FCDV_TOTALADIANTAMENTO;
    const CDV_TOTALADIANTAMENTO_Name = 'CDV_TOTALADIANTAMENTO';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALFRETE', ftBCD)]
    [Dictionary('CDV_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALFRETE: Double read FCDV_TOTALFRETE write FCDV_TOTALFRETE;
    const CDV_TOTALFRETE_Name = 'CDV_TOTALFRETE';

    [Restrictions([NoValidate])]
    [Column('CDV_OBSERVACAO', ftString, 300)]
    [Dictionary('CDV_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_OBSERVACAO: String read FCDV_OBSERVACAO write FCDV_OBSERVACAO;
    const CDV_OBSERVACAO_Name = 'CDV_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALRECEITAS', ftBCD)]
    [Dictionary('CDV_TOTALRECEITAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALRECEITAS: Double read FCDV_TOTALRECEITAS write FCDV_TOTALRECEITAS;
    const CDV_TOTALRECEITAS_Name = 'CDV_TOTALRECEITAS';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALDESPESAS', ftBCD, 48, 2)]
    [Dictionary('CDV_TOTALDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALDESPESAS: Double read FCDV_TOTALDESPESAS write FCDV_TOTALDESPESAS;
    const CDV_TOTALDESPESAS_Name = 'CDV_TOTALDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALLIQUIDO', ftBCD)]
    [Dictionary('CDV_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALLIQUIDO: Double read FCDV_TOTALLIQUIDO write FCDV_TOTALLIQUIDO;
    const CDV_TOTALLIQUIDO_Name = 'CDV_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALLIQUIDOTRANSPORTADOR', ftBCD)]
    [Dictionary('CDV_TOTALLIQUIDOTRANSPORTADOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALLIQUIDOTRANSPORTADOR: Double read FCDV_TOTALLIQUIDOTRANSPORTADOR write FCDV_TOTALLIQUIDOTRANSPORTADOR;
    const CDV_TOTALLIQUIDOTRANSPORTADOR_Name = 'CDV_TOTALLIQUIDOTRANSPORTADOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_CDV)

end.
