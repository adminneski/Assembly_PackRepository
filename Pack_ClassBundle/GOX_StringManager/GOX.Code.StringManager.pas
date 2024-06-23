unit GOX.Code.StringManager;

interface

uses
  System.SysUtils,
  System.Classes;


type
  IGOXStringManager = Interface
  ['{DD88A847-8B2B-4BC5-9EDF-1D7A9EFCB3A6}']
   {$REGION 'Property GetSet Methods'}
      function getText: TStringBuilder;
      procedure setText(const Value: TStringBuilder);
   {$ENDREGION}
    property Text: TStringBuilder read getText write setText;
  End;

  TGOXStringManager = class (TInterfacedObject,IGOXStringManager)
  private
    { private declarations }
    FStringBuilder : TStringBuilder;
    {$REGION 'Property GetSet Methods'}
      function getText: TStringBuilder;
      procedure setText(const Value: TStringBuilder);
    {$ENDREGION}
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
    property Text: TStringBuilder read getText write setText;
    class function New: IGOXStringManager;
  end;

implementation

{ TGOXStringManager }

constructor TGOXStringManager.Create;
begin
  FStringBuilder := TStringBuilder.Create;
end;

class function TGOXStringManager.New: IGOXStringManager;
begin
  Result := TGOXStringManager.Create;
end;

destructor TGOXStringManager.Destroy;
begin
  FreeAndNil(FStringBuilder);
  inherited;
end;

function TGOXStringManager.getText: TStringBuilder;
begin
  Result := FStringBuilder;
end;

procedure TGOXStringManager.setText(const Value: TStringBuilder);
begin
  FStringBuilder := Value;
end;

end.
