unit express.dbo.PALM_V01_NTO;

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
  [Table('PALM_V01_NTO', '')]
  TDtoPALM_V01_NTO = class
  private
    { Private declarations } 
    FNTO_CODIGO: Integer;
    FNTO_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_NTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_NTO)

end.
