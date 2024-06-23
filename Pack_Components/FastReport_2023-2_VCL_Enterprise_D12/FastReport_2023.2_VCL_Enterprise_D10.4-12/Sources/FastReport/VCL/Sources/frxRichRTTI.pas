
{******************************************}
{                                          }
{             FastReport VCL               }
{                Rich RTTI                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRichRTTI;

interface

{$I frx.inc}

implementation

uses
  Windows, Classes, Types, SysUtils, Forms, fs_iinterpreter, fs_iformsrtti, frxRich,
{$IFNDEF WIN64}
  frxRichEdit,
{$ELSE}
  ExtCtrls,
  ComCtrls,
{$ENDIF}
 frxClassRTTI, Variants, frCore;


type
  TFunctions = class(TfsRTTIModule)
  private
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
{$IFNDEF WIN64}
    AddClass(TrxRichEdit, 'TWinControl');
    with AddClass(TfrxRichView, 'TfrxView') do
      AddProperty('RichEdit', 'TrxRichEdit', GetProp, nil);
{$ELSE}
    AddClass(TRichEdit, 'TWinControl');
    with AddClass(TfrxRichView, 'TfrxView') do
      AddProperty('RichEdit', 'TRichEdit', GetProp, nil);
{$ENDIF}
  end;
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxRichView then
  begin
    if PropName = 'RICHEDIT' then
      Result := frInteger(TfrxRichView(Instance).RichEdit)
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.
