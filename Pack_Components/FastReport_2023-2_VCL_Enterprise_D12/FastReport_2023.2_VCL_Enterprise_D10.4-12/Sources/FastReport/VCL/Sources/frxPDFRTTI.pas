
{******************************************}
{                                          }
{             FastReport VCL               }
{          PDF components RTTI             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPDFRTTI;

interface

{$I frx.inc}

implementation

uses
  fs_iinterpreter, frxPDFViewer, frxClassRTTI, Graphics, Classes, Types, frCore;

type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance :TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper) :Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;

{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);

  with AScript do
  begin
    AddClass(TfrxDrawOptions, 'TfrxStretcheable');
    with AddClass(TfrxPDFView, 'TfrxStretcheable') do
    begin
      AddMethod('procedure LoadPDFFromStream(AStream: TStream; const APassword: String = '')', CallMethod);
      AddMethod('procedure LoadFromFile(const AFileName: string)', CallMethod);
      AddMethod('procedure ClearPDF', CallMethod);
    end;
  end;
end;

function TFunctions.CallMethod(Instance :TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper) :Variant;
begin
  Result := 0;

  if ClassType = TfrxPDFView then
  begin
    if MethodName = 'LOADPDFFROMSTREAM' then
      TfrxPDFView(Instance).LoadPDFFromStream(TStream(frInteger(Caller.Params[0])), Caller.Params[1])
    else
    if MethodName = 'LOADFROMFILE' then
      TfrxPDFView(Instance).LoadFromFile(Caller.Params[0])
    else
    if MethodName = 'CLEARPDF' then
      TfrxPDFView(Instance).ClearPDF;
  end;
end;

initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.
