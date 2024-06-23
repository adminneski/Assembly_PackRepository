unit express.dbo.MEG_SELECIONAITENSNOTAFISCAL;

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
  [Table('MEG_SelecionaItensNotaFiscal', '')]
  TDtoMEG_SelecionaItensNotaFiscal = class
  private
    { Private declarations } 
    FNFE_TIPOMOVTO: String;
    FNFE_SIGLA: String;
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FNFE_QTDENTRADA: Double;
  public 
    { Public declarations } 
     const Table      = 'MEG_SelecionaItensNotaFiscal';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TIPOMOVTO', ftString, 25)]
    [Dictionary('NFE_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOMOVTO: String read FNFE_TIPOMOVTO write FNFE_TIPOMOVTO;
    const NFE_TIPOMOVTO_Name = 'NFE_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_SIGLA', ftString, 3)]
    [Dictionary('NFE_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SIGLA: String read FNFE_SIGLA write FNFE_SIGLA;
    const NFE_SIGLA_Name = 'NFE_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('NFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_QTDENTRADA: Double read FNFE_QTDENTRADA write FNFE_QTDENTRADA;
    const NFE_QTDENTRADA_Name = 'NFE_QTDENTRADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMEG_SelecionaItensNotaFiscal)

end.
