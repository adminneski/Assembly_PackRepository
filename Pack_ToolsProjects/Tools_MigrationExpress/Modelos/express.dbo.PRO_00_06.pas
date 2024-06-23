unit express.dbo.PRO_00_06;

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
  [Table('PRO_00_06', '')]
  [PrimaryKey('PRO_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_CODIGO')]
  TDtoPRO_00_06 = class
  private
    { Private declarations } 
    FPRO_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FPRO_TIPOMERCADORIA: String;
    FPRI_CODIGO: Integer;
    FPRO_NIVELCONTA: String;
    FPRO_TIPOCONTA: String;
    FPRO_CODIGOCONTA: String;
    FPRO_NOMECONTA: String;
    FPRO_TOTALNUMEROPARCELAS: Integer;
    FPRO_CODIGONATUREZACONTA: String;
    FPRO_CODIGOCENTROCUSTO: String;
    FPRO_NOMECENTROCUSTO: String;
    FPRO_VIDAUTILBEM: Integer;
    FPRO_FUNCAOBEM: String;
    FPRO_TIPOEMITENTE: String;
    FPES_CODIGO: Integer;
    FMNF_CODIGO: String;
    FPRO_SERIE: String;
    FPRO_NOTAFISCAL: String;
    FPRO_CHAVEACESSONF: String;
    FPRO_DATAEMISSAONF: TDateTime;
    FPRO_DATAINCLUSAOCONTA: TDateTime;
    FPRO_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'PRO_00_06';
     const PrimaryKey = 'PRO_CODIGO';
     const Sequence   = 'SEQ_PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_TIPOMERCADORIA', ftString, 1)]
    [Dictionary('PRO_TIPOMERCADORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_TIPOMERCADORIA: String read FPRO_TIPOMERCADORIA write FPRO_TIPOMERCADORIA;
    const PRO_TIPOMERCADORIA_Name = 'PRO_TIPOMERCADORIA';

    [Restrictions([NoValidate])]
    [Column('PRI_CODIGO', ftInteger)]
    [Dictionary('PRI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRI_CODIGO: Integer read FPRI_CODIGO write FPRI_CODIGO;
    const PRI_CODIGO_Name = 'PRI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_NIVELCONTA', ftString, 1)]
    [Dictionary('PRO_NIVELCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NIVELCONTA: String read FPRO_NIVELCONTA write FPRO_NIVELCONTA;
    const PRO_NIVELCONTA_Name = 'PRO_NIVELCONTA';

    [Restrictions([NoValidate])]
    [Column('PRO_TIPOCONTA', ftString, 1)]
    [Dictionary('PRO_TIPOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_TIPOCONTA: String read FPRO_TIPOCONTA write FPRO_TIPOCONTA;
    const PRO_TIPOCONTA_Name = 'PRO_TIPOCONTA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOCONTA', ftString, 60)]
    [Dictionary('PRO_CODIGOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOCONTA: String read FPRO_CODIGOCONTA write FPRO_CODIGOCONTA;
    const PRO_CODIGOCONTA_Name = 'PRO_CODIGOCONTA';

    [Restrictions([NoValidate])]
    [Column('PRO_NOMECONTA', ftString, 60)]
    [Dictionary('PRO_NOMECONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NOMECONTA: String read FPRO_NOMECONTA write FPRO_NOMECONTA;
    const PRO_NOMECONTA_Name = 'PRO_NOMECONTA';

    [Restrictions([NoValidate])]
    [Column('PRO_TOTALNUMEROPARCELAS', ftInteger)]
    [Dictionary('PRO_TOTALNUMEROPARCELAS', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_TOTALNUMEROPARCELAS: Integer read FPRO_TOTALNUMEROPARCELAS write FPRO_TOTALNUMEROPARCELAS;
    const PRO_TOTALNUMEROPARCELAS_Name = 'PRO_TOTALNUMEROPARCELAS';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGONATUREZACONTA', ftString, 2)]
    [Dictionary('PRO_CODIGONATUREZACONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGONATUREZACONTA: String read FPRO_CODIGONATUREZACONTA write FPRO_CODIGONATUREZACONTA;
    const PRO_CODIGONATUREZACONTA_Name = 'PRO_CODIGONATUREZACONTA';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGOCENTROCUSTO', ftString, 60)]
    [Dictionary('PRO_CODIGOCENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CODIGOCENTROCUSTO: String read FPRO_CODIGOCENTROCUSTO write FPRO_CODIGOCENTROCUSTO;
    const PRO_CODIGOCENTROCUSTO_Name = 'PRO_CODIGOCENTROCUSTO';

    [Restrictions([NoValidate])]
    [Column('PRO_NOMECENTROCUSTO', ftString, 60)]
    [Dictionary('PRO_NOMECENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NOMECENTROCUSTO: String read FPRO_NOMECENTROCUSTO write FPRO_NOMECENTROCUSTO;
    const PRO_NOMECENTROCUSTO_Name = 'PRO_NOMECENTROCUSTO';

    [Restrictions([NoValidate])]
    [Column('PRO_VIDAUTILBEM', ftInteger)]
    [Dictionary('PRO_VIDAUTILBEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_VIDAUTILBEM: Integer read FPRO_VIDAUTILBEM write FPRO_VIDAUTILBEM;
    const PRO_VIDAUTILBEM_Name = 'PRO_VIDAUTILBEM';

    [Restrictions([NoValidate])]
    [Column('PRO_FUNCAOBEM', ftString, 60)]
    [Dictionary('PRO_FUNCAOBEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_FUNCAOBEM: String read FPRO_FUNCAOBEM write FPRO_FUNCAOBEM;
    const PRO_FUNCAOBEM_Name = 'PRO_FUNCAOBEM';

    [Restrictions([NoValidate])]
    [Column('PRO_TIPOEMITENTE', ftString, 1)]
    [Dictionary('PRO_TIPOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_TIPOEMITENTE: String read FPRO_TIPOEMITENTE write FPRO_TIPOEMITENTE;
    const PRO_TIPOEMITENTE_Name = 'PRO_TIPOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_SERIE', ftString, 3)]
    [Dictionary('PRO_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_SERIE: String read FPRO_SERIE write FPRO_SERIE;
    const PRO_SERIE_Name = 'PRO_SERIE';

    [Restrictions([NoValidate])]
    [Column('PRO_NOTAFISCAL', ftString, 9)]
    [Dictionary('PRO_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_NOTAFISCAL: String read FPRO_NOTAFISCAL write FPRO_NOTAFISCAL;
    const PRO_NOTAFISCAL_Name = 'PRO_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('PRO_CHAVEACESSONF', ftString, 44)]
    [Dictionary('PRO_CHAVEACESSONF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_CHAVEACESSONF: String read FPRO_CHAVEACESSONF write FPRO_CHAVEACESSONF;
    const PRO_CHAVEACESSONF_Name = 'PRO_CHAVEACESSONF';

    [Restrictions([NoValidate])]
    [Column('PRO_DATAEMISSAONF', ftDateTime)]
    [Dictionary('PRO_DATAEMISSAONF', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAEMISSAONF: TDateTime read FPRO_DATAEMISSAONF write FPRO_DATAEMISSAONF;
    const PRO_DATAEMISSAONF_Name = 'PRO_DATAEMISSAONF';

    [Restrictions([NoValidate])]
    [Column('PRO_DATAINCLUSAOCONTA', ftDateTime)]
    [Dictionary('PRO_DATAINCLUSAOCONTA', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAINCLUSAOCONTA: TDateTime read FPRO_DATAINCLUSAOCONTA write FPRO_DATAINCLUSAOCONTA;
    const PRO_DATAINCLUSAOCONTA_Name = 'PRO_DATAINCLUSAOCONTA';

    [Restrictions([NoValidate])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_00_06)

end.
