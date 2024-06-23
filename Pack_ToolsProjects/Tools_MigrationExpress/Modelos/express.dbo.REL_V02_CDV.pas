unit express.dbo.REL_V02_CDV;

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
  [Table('REL_V02_CDV', '')]
  TDtoREL_V02_CDV = class
  private
    { Private declarations } 
    FCDV_ID: Integer;
    FCOM_CODIGO: Integer;
    FCDV_DATALANCAMENTO: TDateTime;
    FCDV_NUMERODOCTO: String;
    FCDV_TIPOMOVTO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVEI_CODIGO: Integer;
    FVEI_DESCRICAO: String;
    FVEI_PLACA: String;
    FCDV_TOTALLIQUIDO: Double;
    FDSP_CODIGO: Integer;
    FCDV_VALORDESPESAS: Double;
    FCDV_KMHORIMETRO: Integer;
    FCDV_DATADOCTO: TDateTime;
    FCDV_NUMERODOCTODESP: String;
    FCDV_ROTA: String;
    FCDV_TIPOBOMBA: String;
    FDSP_DESCRICAO: String;
    FDSP_TIPODESPESA: Integer;
    FCDV_QTDLITROS: Double;
    FCDV_RECEITAS: Double;
    FCDV_ABASTECIMENTO: Double;
    FCDV_VIAGEM: Double;
    FCDV_PEDAGIO: Double;
    FCDV_OFICINA: Double;
    FCDV_TROCAPNEUS: Double;
    FCDV_BORRACHARIA: Double;
    FCDV_SALARIOS: Double;
    FCDV_SEGURO: Double;
    FCDV_ADMINISTRATIVO: Double;
    FCDV_QTDBOMBAPROPRIA: Double;
    FCDV_QTDBOMBATERCEIRO: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_CDV';

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
    [Column('CDV_TOTALLIQUIDO', ftBCD)]
    [Dictionary('CDV_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALLIQUIDO: Double read FCDV_TOTALLIQUIDO write FCDV_TOTALLIQUIDO;
    const CDV_TOTALLIQUIDO_Name = 'CDV_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('DSP_CODIGO', ftInteger)]
    [Dictionary('DSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property DSP_CODIGO: Integer read FDSP_CODIGO write FDSP_CODIGO;
    const DSP_CODIGO_Name = 'DSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CDV_VALORDESPESAS', ftBCD, 18, 4)]
    [Dictionary('CDV_VALORDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_VALORDESPESAS: Double read FCDV_VALORDESPESAS write FCDV_VALORDESPESAS;
    const CDV_VALORDESPESAS_Name = 'CDV_VALORDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CDV_KMHORIMETRO', ftInteger)]
    [Dictionary('CDV_KMHORIMETRO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_KMHORIMETRO: Integer read FCDV_KMHORIMETRO write FCDV_KMHORIMETRO;
    const CDV_KMHORIMETRO_Name = 'CDV_KMHORIMETRO';

    [Restrictions([NoValidate])]
    [Column('CDV_DATADOCTO', ftDateTime)]
    [Dictionary('CDV_DATADOCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CDV_DATADOCTO: TDateTime read FCDV_DATADOCTO write FCDV_DATADOCTO;
    const CDV_DATADOCTO_Name = 'CDV_DATADOCTO';

    [Restrictions([NoValidate])]
    [Column('CDV_NUMERODOCTODESP', ftString, 10)]
    [Dictionary('CDV_NUMERODOCTODESP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_NUMERODOCTODESP: String read FCDV_NUMERODOCTODESP write FCDV_NUMERODOCTODESP;
    const CDV_NUMERODOCTODESP_Name = 'CDV_NUMERODOCTODESP';

    [Restrictions([NoValidate])]
    [Column('CDV_ROTA', ftString, 100)]
    [Dictionary('CDV_ROTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_ROTA: String read FCDV_ROTA write FCDV_ROTA;
    const CDV_ROTA_Name = 'CDV_ROTA';

    [Restrictions([NoValidate])]
    [Column('CDV_TIPOBOMBA', ftString, 1)]
    [Dictionary('CDV_TIPOBOMBA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_TIPOBOMBA: String read FCDV_TIPOBOMBA write FCDV_TIPOBOMBA;
    const CDV_TIPOBOMBA_Name = 'CDV_TIPOBOMBA';

    [Restrictions([NoValidate])]
    [Column('DSP_DESCRICAO', ftString, 300)]
    [Dictionary('DSP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DSP_DESCRICAO: String read FDSP_DESCRICAO write FDSP_DESCRICAO;
    const DSP_DESCRICAO_Name = 'DSP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('DSP_TIPODESPESA', ftInteger)]
    [Dictionary('DSP_TIPODESPESA', 'Mensagem de validação', '0', '', '', taCenter)]
    property DSP_TIPODESPESA: Integer read FDSP_TIPODESPESA write FDSP_TIPODESPESA;
    const DSP_TIPODESPESA_Name = 'DSP_TIPODESPESA';

    [Restrictions([NoValidate])]
    [Column('CDV_QTDLITROS', ftBCD)]
    [Dictionary('CDV_QTDLITROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_QTDLITROS: Double read FCDV_QTDLITROS write FCDV_QTDLITROS;
    const CDV_QTDLITROS_Name = 'CDV_QTDLITROS';

    [Restrictions([NoValidate])]
    [Column('CDV_RECEITAS', ftBCD, 18, 4)]
    [Dictionary('CDV_RECEITAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_RECEITAS: Double read FCDV_RECEITAS write FCDV_RECEITAS;
    const CDV_RECEITAS_Name = 'CDV_RECEITAS';

    [Restrictions([NoValidate])]
    [Column('CDV_ABASTECIMENTO', ftBCD, 18, 4)]
    [Dictionary('CDV_ABASTECIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_ABASTECIMENTO: Double read FCDV_ABASTECIMENTO write FCDV_ABASTECIMENTO;
    const CDV_ABASTECIMENTO_Name = 'CDV_ABASTECIMENTO';

    [Restrictions([NoValidate])]
    [Column('CDV_VIAGEM', ftBCD, 18, 4)]
    [Dictionary('CDV_VIAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_VIAGEM: Double read FCDV_VIAGEM write FCDV_VIAGEM;
    const CDV_VIAGEM_Name = 'CDV_VIAGEM';

    [Restrictions([NoValidate])]
    [Column('CDV_PEDAGIO', ftBCD, 18, 4)]
    [Dictionary('CDV_PEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_PEDAGIO: Double read FCDV_PEDAGIO write FCDV_PEDAGIO;
    const CDV_PEDAGIO_Name = 'CDV_PEDAGIO';

    [Restrictions([NoValidate])]
    [Column('CDV_OFICINA', ftBCD, 18, 4)]
    [Dictionary('CDV_OFICINA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_OFICINA: Double read FCDV_OFICINA write FCDV_OFICINA;
    const CDV_OFICINA_Name = 'CDV_OFICINA';

    [Restrictions([NoValidate])]
    [Column('CDV_TROCAPNEUS', ftBCD, 18, 4)]
    [Dictionary('CDV_TROCAPNEUS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TROCAPNEUS: Double read FCDV_TROCAPNEUS write FCDV_TROCAPNEUS;
    const CDV_TROCAPNEUS_Name = 'CDV_TROCAPNEUS';

    [Restrictions([NoValidate])]
    [Column('CDV_BORRACHARIA', ftBCD, 18, 4)]
    [Dictionary('CDV_BORRACHARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_BORRACHARIA: Double read FCDV_BORRACHARIA write FCDV_BORRACHARIA;
    const CDV_BORRACHARIA_Name = 'CDV_BORRACHARIA';

    [Restrictions([NoValidate])]
    [Column('CDV_SALARIOS', ftBCD, 18, 4)]
    [Dictionary('CDV_SALARIOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_SALARIOS: Double read FCDV_SALARIOS write FCDV_SALARIOS;
    const CDV_SALARIOS_Name = 'CDV_SALARIOS';

    [Restrictions([NoValidate])]
    [Column('CDV_SEGURO', ftBCD, 18, 4)]
    [Dictionary('CDV_SEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_SEGURO: Double read FCDV_SEGURO write FCDV_SEGURO;
    const CDV_SEGURO_Name = 'CDV_SEGURO';

    [Restrictions([NoValidate])]
    [Column('CDV_ADMINISTRATIVO', ftBCD, 18, 4)]
    [Dictionary('CDV_ADMINISTRATIVO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_ADMINISTRATIVO: Double read FCDV_ADMINISTRATIVO write FCDV_ADMINISTRATIVO;
    const CDV_ADMINISTRATIVO_Name = 'CDV_ADMINISTRATIVO';

    [Restrictions([NoValidate])]
    [Column('CDV_QTDBOMBAPROPRIA', ftBCD)]
    [Dictionary('CDV_QTDBOMBAPROPRIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_QTDBOMBAPROPRIA: Double read FCDV_QTDBOMBAPROPRIA write FCDV_QTDBOMBAPROPRIA;
    const CDV_QTDBOMBAPROPRIA_Name = 'CDV_QTDBOMBAPROPRIA';

    [Restrictions([NoValidate])]
    [Column('CDV_QTDBOMBATERCEIRO', ftBCD, 48, 3)]
    [Dictionary('CDV_QTDBOMBATERCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_QTDBOMBATERCEIRO: Double read FCDV_QTDBOMBATERCEIRO write FCDV_QTDBOMBATERCEIRO;
    const CDV_QTDBOMBATERCEIRO_Name = 'CDV_QTDBOMBATERCEIRO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_CDV)

end.
