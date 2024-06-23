{ --------------------------------------------------------------------------- }
{ FireDAC FastReport v 6.0 enduser components                                 }
{                                                                             }
{ (c)opyright DA-SOFT Technologies 2004-2013.                                 }
{ All rights reserved.                                                        }
{                                                                             }
{ Initially created by: Serega Glazyrin <glserega@mezonplus.ru>               }
{ Extended by: Francisco Armando Duenas Rodriguez <fduenas@gmail.com>         }
{                                                                             }
{         Copyright (c) 1998-2021          }
{ --------------------------------------------------------------------------- }
{$I frx.inc}
{$IF CompilerVersion <= 24} //XE3 or older
    {$DEFINE ANYDAC}
{$IFEND} 
unit frxFDRTTI;

interface

implementation

uses
  Windows, Classes, Types, SysUtils, Forms, Variants, DB,
  {$IFDEF ANYDAC}
    uADCompClient, uADCompDataset,
  {$ELSE}
  FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  {$ENDIF}
  fs_iinterpreter, fs_idbrtti, fs_ifdrtti, frxFDComponents, frCore;

type
  TfrxFDFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance :TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper) :Variant;
    function GetProp(Instance :TObject; ClassType: TClass; const PropName :String) :Variant;
    procedure SetProp(Instance :TObject; ClassType: TClass; const PropName :String; Value :Variant);
  public
    constructor Create(AScript :TfsScript); override;
  end;

{-------------------------------------------------------------------------------}
constructor TfrxFDFunctions.Create(AScript: TfsScript);
begin

 inherited Create(AScript);

 with AScript do begin
   AddClass(TFDManager, 'TComponent');
   AddClass(TFDConnection, 'TComponent');
   AddClass(TFDDataSet, 'TDataSet');
   AddClass(TFDAdaptedDataSet, 'TFDDataSet');
   AddClass(TFDRdbmsDataSet, 'TFDAdaptedDataSet');
   AddClass(TFDCustomQuery, 'TFDRdbmsDataSet');
   AddClass(TFDTable, 'TFDCustomQuery');

   with AddClass(TfrxFDDatabase, 'TfrxCustomDatabase') do
     AddProperty('Database', 'TFDConnection', GetProp, nil);

   with AddClass(TfrxFDTable, 'TfrxCustomTable') do
     AddProperty('Table', 'TFDTable', GetProp, nil);

   with AddClass(TfrxFDQuery, 'TfrxCustomQuery') do begin
     AddMethod('procedure ExecSQL', CallMethod);
     AddMethod('procedure FetchParams', CallMethod);
     AddMethod('function MacroByName(const MacroName :String) :TfrxParamItem', CallMethod);
     AddMethod('function LocateEx(const AKeyFields :String; const AKeyValues :Variant; AOptions :TFDDataSetLocateOptions) :Boolean', CallMethod);
     AddMethod('function LocateExpr(const AExpression :String; AOptions :TFDDataSetLocateOptions) :Boolean', CallMethod);
     AddMethod('procedure FetchAll', CallMethod);
     AddMethod('procedure EnableControls', CallMethod);
     AddMethod('procedure DisableControls', CallMethod);
     AddMethod('function CreateBlobStream(Field :TField; Mode :TBlobStreamMode) :TStream', CallMethod);
     AddMethod('function FindField(const FieldName :String): TField', CallMethod);
     AddMethod('procedure SetChangeFieldEvent(cFieldName, cEventName :String)', CallMethod);
     AddMethod('procedure SetGetTextFieldEvent(cFieldName, cEventName :String)', CallMethod);
     AddMethod('function OpenOrExecute: Boolean', CallMethod); {added by fduenas}     
     AddMethod('procedure Prepare', CallMethod);  {added by fduenas}
     AddMethod('function ParamByName(const AValue: String): TfrxParamItem', CallMethod);  {added by fduenas}
     AddProperty('Query', 'TFDQuery', GetProp, nil);
     AddProperty('FDRecNo', 'LongInt', GetProp, SetProp);
   end;

   with AddClass(TfrxFDMemTable, 'TfrxCustomDataset') do begin
     AddMethod('procedure CreateDataSet', CallMethod);
     AddMethod('procedure EnableControls', CallMethod);
     AddMethod('procedure DisableControls', CallMethod);
     AddMethod('function LocateEx(const AKeyFields :String; const AKeyValues :Variant; AOptions :TFDDataSetLocateOptions) :Boolean', CallMethod);
     AddMethod('function LocateExpr(const AExpression :String; AOptions :TFDDataSetLocateOptions) :Boolean', CallMethod);
     AddMethod('function FindField(const FieldName :String) :TField', CallMethod);
     AddMethod('procedure SetChangeFieldEvent(cFieldName, cEventName :String)', CallMethod);
     AddMethod('procedure SetGetTextFieldEvent(cFieldName, cEventName :String)', CallMethod);
     AddMethod('procedure Refresh', CallMethod);
     AddMethod('procedure CopyDataSet(ASource :TDataset; AOptions :TFDCopyDataSetOptions)', CallMethod);
     AddMethod('procedure SetFDData(ASource :TFDDataSet)', CallMethod);
     AddProperty('MemTable', 'TFDMemTable', GetProp, nil);
     AddProperty('FieldDefs', 'TFieldDefs', GetProp, SetProp);
     AddProperty('FDRecNo', 'LongInt', GetProp, SetProp);
   end;

   with AddClass(TfrxCustomStoredProc, 'TfrxCustomDataset') do begin
    AddMethod('procedure ExecProc', CallMethod);
    AddMethod('procedure FetchParams', CallMethod);
    AddMethod('function ParamByName(const AValue: String): TfrxParamItem', CallMethod);
    AddMethod('procedure Prepare', CallMethod);
    AddMethod('procedure UpdateParams', CallMethod);
    AddMethod('function ExecFunc: Variant', CallMethod); {added by fduenas}
    AddMethod('function OpenOrExecute: Boolean', CallMethod); {added by fduenas}         
   end;

   with AddClass(TfrxFDStoredProc, 'TfrxCustomStoredProc') do
     AddProperty('StoredProc', 'TFDStoredProc', GetProp, nil);

 end;

end;

{-------------------------------------------------------------------------------}
function TfrxFDFunctions.CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; Caller: TfsMethodHelper): Variant;
begin

 Result := 0;

 if ClassType = TfrxFDQuery then begin

   if MethodName = 'EXECSQL' then
     TfrxFDQuery(Instance).ExecSQL()
   else
   if MethodName = 'FETCHPARAMS' then
     TfrxFDQuery(Instance).FetchParams()
   else
   if MethodName = 'MACROBYNAME' then
     Result := frInteger(TfrxFDQuery(Instance).MacroByName(Caller.Params[0]))
   else
   if MethodName = 'FETCHALL' then
     TfrxFDQuery(Instance).FetchAll()
   else
   if MethodName = 'ENABLECONTROLS' then
     TfrxFDQuery(Instance).EnableControls()
   else
   if MethodName = 'DISABLECONTROLS' then
     TfrxFDQuery(Instance).DisableControls()
   else
   if MethodName = 'CREATEBLOBSTREAM' then
     Result := frInteger(TfrxFDQuery(Instance).CreateBlobStream(TField(frInteger(Caller.Params[0])), Caller.Params[1]))
   else
   if MethodName = 'FINDFIELD' then
     Result := frInteger(TfrxFDQuery(Instance).FindField(Caller.Params[0]))
   else
   if MethodName = 'SETCHANGEFIELDEVENT' then
     TfrxFDQuery(Instance).SetChangeFieldEvent(Caller.Params[0], Caller.Params[1])
   else
   if MethodName = 'SETGETTEXTFIELDEVENT' then
     TfrxFDQuery(Instance).SetGetTextFieldEvent(Caller.Params[0], Caller.Params[1])
   else
   if MethodName = 'LOCATEEX' then
     Result := TfrxFDQuery(Instance).LocateEx(Caller.Params[0], Caller.Params[1], IntToFDDataSetLocateOptions(Caller.Params[2]))
   else
   if MethodName = 'LOCATEEXPR' then
     Result := TfrxFDQuery(Instance).LocateEx(Caller.Params[0], IntToFDDataSetLocateOptions(Caller.Params[1]))
   else if MethodName = 'PREPARE' then
     TfrxFDQuery(Instance).Prepare {added by fduenas}
   else if MethodName = 'OPENOREXECUTE' then
     Result := TfrxFDQuery(Instance).OpenOrExecute {added by fduenas}
   else if MethodName = 'PARAMBYNAME' then
     Result := frInteger(TfrxFDQuery(Instance).ParamByName(Caller.Params[0])) {added by fduenas}    
   else if MethodName = 'FETCHPARAMS' then
     TfrxFDQuery(Instance).FetchParams;

 end else
 if ClassType = TfrxFDMemTable then begin

   if MethodName = 'ENABLECONTROLS' then
     TfrxFDMemTable(Instance).EnableControls()
   else
   if MethodName = 'DISABLECONTROLS' then
     TfrxFDMemTable(Instance).DisableControls()
   else
   if MethodName = 'FINDFIELD' then
     Result := frInteger(TfrxFDMemTable(Instance).FindField(Caller.Params[0]))
   else
   if MethodName = 'SETCHANGEFIELDEVENT' then
     TfrxFDMemTable(Instance).SetChangeFieldEvent(Caller.Params[0], Caller.Params[1])
   else
   if MethodName = 'SETGETTEXTFIELDEVENT' then
     TfrxFDMemTable(Instance).SetGetTextFieldEvent(Caller.Params[0], Caller.Params[1])
   else
   if MethodName = 'LOCATEEX' then
     Result := TfrxFDMemTable(Instance).LocateEx(Caller.Params[0], Caller.Params[1], IntToFDDataSetLocateOptions(Caller.Params[2]))
   else
   if MethodName = 'LOCATEEXPR' then
     Result := TfrxFDMemTable(Instance).LocateEx(Caller.Params[0], IntToFDDataSetLocateOptions(Caller.Params[1]))
   else
   if MethodName = 'CREATEDATASET' then
     TfrxFDMemTable(Instance).CreateDataSet()
   else
   if MethodName = 'REFRESH' then
     TfrxFDMemTable(Instance).Refresh()
   else
   if MethodName = 'COPYDATASET' then
     TfrxFDMemTable(Instance).CopyDataSet(TDataSet(frInteger(Caller.Params[0])), IntToFDCopyDataSetOptions(Caller.Params[1]))
   else
   if MethodName = 'SETFDDATA' then
     TfrxFDMemTable(Instance).SetFDData(TFDDataSet(frInteger(Caller.Params[0])))

 end else
 if ClassType = TfrxCustomStoredProc then begin

   if MethodName = 'EXECPROC' then
     TfrxCustomStoredProc(Instance).ExecProc()
   else
   if MethodName = 'FETCHPARAMS' then
     TfrxCustomStoredProc(Instance).FetchParams()
   else
   if MethodName = 'PARAMBYNAME' then
     Result := frInteger(TfrxCustomStoredProc(Instance).ParamByName(Caller.Params[0]))
   else
   if MethodName = 'PREPARE' then
     TfrxCustomStoredProc(Instance).Prepare()
   else if MethodName = 'OPENOREXECUTE' then
      Result := TfrxCustomStoredProc(Instance).OpenOrExecute {added by fduenas}
    else if MethodName = 'EXECFUNC' then
      Result := TfrxCustomStoredProc(Instance).ExecFunc {added by fduenas}
   else
   if MethodName = 'UPDATEPARAMS' then
     TfrxCustomStoredProc(Instance).FetchParams();

 end

end;

{-------------------------------------------------------------------------------}
function TfrxFDFunctions.GetProp(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin

 Result := 0;

 if ClassType = TfrxFDDatabase then begin

   if PropName = 'DATABASE' then
     Result := frInteger(TfrxFDDatabase(Instance).Database);

 end else
 if ClassType = TfrxFDQuery then begin

   if PropName = 'QUERY' then
     Result := frInteger(TfrxFDQuery(Instance).Query)
   else
   if PropName = 'FDRECNO' then
     Result := TfrxFDQuery(Instance).FDRecNo
   else
   if PropName = 'PARAMCOUNT' then
      Result := TFDQuery(Instance).ParamCount;
 end else
 if ClassType = TfrxFDMemTable then begin

   if PropName = 'MEMTABLE' then
     Result := frInteger(TfrxFDMemTable(Instance).FDMemTable)
   else
   if PropName = 'FDRECNO' then
     Result := TfrxFDMemTable(Instance).FDRecNo
   else
   if PropName = 'FIELDDEFS' then
     Result := frInteger(TfrxFDMemTable(Instance).FieldDefs)

 end else
 if ClassType = TfrxFDStoredProc then begin

   if PropName = 'STOREDPROC' then
     Result := frInteger(TfrxFDStoredProc(Instance).StoredProc);
   if PropName = 'PARAMCOUNT' then
      Result := TFDStoredProc(Instance).ParamCount;
 end else
 if ClassType = TfrxFDTable then begin

   if PropName = 'TABLE' then
     Result := frInteger(TfrxFDTable(Instance).Table);

 end;

end;

{-------------------------------------------------------------------------------}
procedure TfrxFDFunctions.SetProp(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin

 if ClassType = TfrxFDQuery then begin

   if PropName = 'SDRECNO' then
     TfrxFDQuery(Instance).FDRecNo := Value

 end else
 if ClassType = TfrxFDMemTable then begin

   if PropName = 'FIELDDEFS' then
     TfrxFDMemTable(Instance).FieldDefs := TFieldDefs(frInteger(Value))

 end;

end;

{-------------------------------------------------------------------------------}
initialization
  fsRTTIModules.Add(TfrxFDFunctions);

finalization
  if fsRTTIModules <> nil then
     fsRTTIModules.Remove(TfrxFDFunctions);

end.
