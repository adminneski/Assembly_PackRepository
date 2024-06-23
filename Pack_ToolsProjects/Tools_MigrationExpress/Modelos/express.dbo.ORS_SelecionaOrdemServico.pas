unit express.dbo.ORS_SELECIONAORDEMSERVICO;

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
  [Table('ORS_SelecionaOrdemServico', '')]
  TDtoORS_SelecionaOrdemServico = class
  private
    { Private declarations } 
    FORS_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_NUMEROOS: Integer;
    FPES_CODIGO: Integer;
    FORS_NOTAFISCAL: String;
    FORS_NUMERODOCTO: String;
    FORS_DATAEMISSAO: TDateTime;
    FORS_TOTALLIQUIDO: Double;
    FORS_TIPODOCUMENTO: String;
    FORS_MESCLADO: String;
    FVEI_CODIGO: Integer;
    FPES_NOME: String;
    FVEI_DESCRICAO: String;
    FVEI_PLACA: String;
    FVEI_NUMEROCHASSI: String;
    FVEI_NUMERORENAVAM: String;
    FVEI_ANO_MODELO: String;
    FMAR_NOME: String;
    FMAR_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FORS_NOTAFISCALSERVICO: String;
    FORS_BLOQUEADO: String;
    FORS_IDFATURAMENTOPRODUTOS: Integer;
    FORS_IDFATURAMENTOSERVICOS: Integer;
  public 
    { Public declarations } 
     const Table      = 'ORS_SelecionaOrdemServico';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID', ftInteger)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOS', ftInteger)]
    [Dictionary('ORS_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOS: Integer read FORS_NUMEROOS write FORS_NUMEROOS;
    const ORS_NUMEROOS_Name = 'ORS_NUMEROOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_NOTAFISCAL', ftString, 9)]
    [Dictionary('ORS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCAL: String read FORS_NOTAFISCAL write FORS_NOTAFISCAL;
    const ORS_NOTAFISCAL_Name = 'ORS_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_NUMERODOCTO', ftString, 10)]
    [Dictionary('ORS_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NUMERODOCTO: String read FORS_NUMERODOCTO write FORS_NUMERODOCTO;
    const ORS_NUMERODOCTO_Name = 'ORS_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_DATAEMISSAO', ftDateTime)]
    [Dictionary('ORS_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ORS_DATAEMISSAO: TDateTime read FORS_DATAEMISSAO write FORS_DATAEMISSAO;
    const ORS_DATAEMISSAO_Name = 'ORS_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALLIQUIDO', ftBCD)]
    [Dictionary('ORS_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALLIQUIDO: Double read FORS_TOTALLIQUIDO write FORS_TOTALLIQUIDO;
    const ORS_TOTALLIQUIDO_Name = 'ORS_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('ORS_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPODOCUMENTO: String read FORS_TIPODOCUMENTO write FORS_TIPODOCUMENTO;
    const ORS_TIPODOCUMENTO_Name = 'ORS_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_MESCLADO', ftString, 1)]
    [Dictionary('ORS_MESCLADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_MESCLADO: String read FORS_MESCLADO write FORS_MESCLADO;
    const ORS_MESCLADO_Name = 'ORS_MESCLADO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

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
    [Column('VEI_ANO_MODELO', ftString, 9)]
    [Dictionary('VEI_ANO_MODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_ANO_MODELO: String read FVEI_ANO_MODELO write FVEI_ANO_MODELO;
    const VEI_ANO_MODELO_Name = 'VEI_ANO_MODELO';

    [Restrictions([NoValidate])]
    [Column('MAR_NOME', ftString, 30)]
    [Dictionary('MAR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_NOME: String read FMAR_NOME write FMAR_NOME;
    const MAR_NOME_Name = 'MAR_NOME';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('ORS_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('ORS_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCALSERVICO: String read FORS_NOTAFISCALSERVICO write FORS_NOTAFISCALSERVICO;
    const ORS_NOTAFISCALSERVICO_Name = 'ORS_NOTAFISCALSERVICO';

    [Restrictions([NoValidate])]
    [Column('ORS_BLOQUEADO', ftString, 1)]
    [Dictionary('ORS_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_BLOQUEADO: String read FORS_BLOQUEADO write FORS_BLOQUEADO;
    const ORS_BLOQUEADO_Name = 'ORS_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('ORS_IDFATURAMENTOPRODUTOS', ftInteger)]
    [Dictionary('ORS_IDFATURAMENTOPRODUTOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_IDFATURAMENTOPRODUTOS: Integer read FORS_IDFATURAMENTOPRODUTOS write FORS_IDFATURAMENTOPRODUTOS;
    const ORS_IDFATURAMENTOPRODUTOS_Name = 'ORS_IDFATURAMENTOPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('ORS_IDFATURAMENTOSERVICOS', ftInteger)]
    [Dictionary('ORS_IDFATURAMENTOSERVICOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_IDFATURAMENTOSERVICOS: Integer read FORS_IDFATURAMENTOSERVICOS write FORS_IDFATURAMENTOSERVICOS;
    const ORS_IDFATURAMENTOSERVICOS_Name = 'ORS_IDFATURAMENTOSERVICOS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_SelecionaOrdemServico)

end.
