{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frCoreReg;
{$ENDIF}

{$I frVer.inc}

interface

uses
  SysUtils,
{$IFNDEF FPC}
  DesignEditors, DesignIntf,
{$ELSE}
  PropEdits, ComponentEditors,
{$ENDIF}
{$IFNDEF FMX}
  Types, Classes,
  frCore,
  frCoreClasses;
{$ELSE}
  System.Types, System.Classes,
  FMX.frCore,
  FMX.frCoreClasses;
{$ENDIF}

const
  frCompanyName = 'Fast Reports, Inc.';
  frCompanyURL = 'www.fast-report.com';
{$IFDEF FMX}
  frDefaultLibraryProductPage = 'FastReport FMX Components';
{$ELSE}
  {$IFDEF FPC}
    frDefaultLibraryProductPage = 'FastReport Components';
  {$ELSE}
    frDefaultLibraryProductPage = 'FastReport VCL Components';
  {$ENDIF}
{$ENDIF}

type
  TfrCustomPropertyEditor = class(TPropertyEditor);
  TfrCustomStringPropertyEditor = class(TStringProperty);

  { TfrChooserStringPropertyEditor }

  TfrChooserStringPropertyEditor = class(TfrCustomStringPropertyEditor)
  protected
    function DoGetValues: TStringDynArray; virtual; abstract;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TfrComponentEditor }

  TfrComponentEditor = class(TComponentEditor)
  protected
    procedure DoExecuteVerb(AIndex: Integer); virtual;
    function DoGetVerb(AIndex: Integer): string; virtual;
    function DoGetVerbCount: Integer; virtual;
  public
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

procedure Register;

implementation

const
  {$EXTERNALSYM SW_SHOWMAXIMIZED}
  SW_SHOWMAXIMIZED = 3;

{ TfrChooserStringPropertyEditor }

function TfrChooserStringPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  Exclude(Result, paReadOnly);
  Include(Result, paValueList);
end;

procedure TfrChooserStringPropertyEditor.GetValues(Proc: TGetStrProc);
var
  AValues: TStringDynArray;
  I: Integer;
begin
  AValues := DoGetValues;
  for I := Low(AValues) to High(AValues) do
    Proc(AValues[I]);
end;

{ TfrComponentEditor }

function TfrComponentEditor.GetVerb(Index: Integer): string;
begin
  if Index < DoGetVerbCount then
    Result := DoGetVerb(Index)
  else
  begin
    Index := Index - DoGetVerbCount;
    case Index of
      0: Result := '-';
      1: Result := frCompanyName;
      2: Result := frCompanyURL;
    end;
  end;
end;

function TfrComponentEditor.GetVerbCount: Integer;
begin
  Result := 3 + DoGetVerbCount;
end;

procedure TfrComponentEditor.ExecuteVerb(Index: Integer);
begin
  if Index < DoGetVerbCount then
    DoExecuteVerb(Index)
  else
  begin
    Dec(Index, DoGetVerbCount);
    case Index of
      2: frShellExecute(Format('http://%s', [frCompanyURL]), SW_SHOWMAXIMIZED);
    end;
  end;
end;

procedure TfrComponentEditor.DoExecuteVerb(AIndex: Integer);
begin
end;

function TfrComponentEditor.DoGetVerb(AIndex: Integer): string;
begin
  Result := '';
end;

function TfrComponentEditor.DoGetVerbCount: Integer;
begin
  Result := 0;
end;

procedure Register;
begin
  frRegisterFrameworkComponentClass(TfrCustomComponent);
  RegisterComponentEditor(TfrCustomComponent, TfrComponentEditor);
end;

end.

