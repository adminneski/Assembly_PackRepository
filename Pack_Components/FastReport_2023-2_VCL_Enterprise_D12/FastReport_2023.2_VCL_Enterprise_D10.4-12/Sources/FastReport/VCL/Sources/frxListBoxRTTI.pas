
{******************************************}
{                                          }
{             FastReport VCL               }
{              ListBox RTTI                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxListBoxRTTI;

{$I frx.inc}

interface

implementation

uses
  fs_iinterpreter, frxClassRTTI, frxListControl, frxListBox, Classes, Types;

type
  TFunctions = class(TfsRTTIModule)
  private
    function GetProp(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure SetProp(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
  public
    constructor Create(AScript: TfsScript); override;
  end;

{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);

  with AScript do
  begin
    AddClass(TfrxCustomListControlView, 'TfrxView');

    with AddClass(TfrxListBoxView, 'TfrxCustomListControlView') do
    begin
      AddProperty('ItemIndex', 'Integer', GetProp, SetProp);
    end;
  end;
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxListBoxView then
    if      PropName = 'ITEMINDEX' then
      Result := Integer(TfrxListBoxView(Instance).ItemIndex);
end;

procedure TFunctions.SetProp(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if ClassType = TfrxListBoxView then
    if      PropName = 'ITEMINDEX' then
      TfrxListBoxView(Instance).ItemIndex := Value;
end;

initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.
