unit frxHelperCS;

{$I frx.inc}

interface
uses
  Classes, Masks;

type
  TfrxStringListMask = class(TStringList)
  public
    function IndexOf(const S: string): Integer; override;
  end;

implementation

uses
  frxUtils;

function TfrxStringListMask.IndexOf(const S: string): Integer;
begin
  for Result := 0 to GetCount - 1 do
    if (MatchesMask(S, Get(Result))) then Exit;
  Result := -1;
end;

end.
