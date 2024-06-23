{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{              Design window for TDBGridEh              }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit DataSetImpExpDesignEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Dialogs,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignEditors,
  Borland.Vcl.Design.ColnEdit,
  Variants, Types,
  EhLibVCLNET,
{$ELSE}

  {$IFDEF FPC}
  EhLibLCL,
  PropEdits, ComponentEditors,
  {$ELSE}
  Windows, Messages,
  ColnEdit, DesignMenus,
  Variants, DesignEditors, DesignIntf,
  EhLibVCL, PSAPI, ToolsAPI,
  ImgList, Menus, ActnList, ExtCtrls, ComCtrls,
  ToolWin,
  {$ENDIF}

{$ENDIF}
  Graphics, Controls, Forms, ToolCtrlsEh, Db,
  Classes, TypInfo,
  DefaultItemsCollectionEditorsEh, DataSetImpExpEh, EhLibReg, EhLibDesignAbout;

type

{ TDataSetTextImpExpEditorEh  }

  TDataSetTextImpExpEditorEh = class(TComponentEditor)
    function  GetVerbCount: Integer; override;
    function  GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

type

{ TDataSetTextImpExpListFieldProperty }

  TDataSetTextImpExpListFieldProperty = class(TListFieldProperty)
  public
    function GetDataSet: TDataSet; override;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('EhLib Components', [TDataSetTextExporterEh, TDataSetTextImporterEh]);

  RegisterComponentEditor(TDataSetTextExporterEh, TDataSetTextImpExpEditorEh);
  RegisterComponentEditor(TDataSetTextImporterEh, TDataSetTextImpExpEditorEh);

  {$IFDEF FPC}
  {$ELSE}
  RegisterPropertyEditor(TypeInfo(TFieldsMapCollectionEh), TDataSetTextExporterEh, 'FieldsMap', TDefaultItemsCollectionProperty);
  RegisterPropertyEditor(TypeInfo(TFieldsMapCollectionEh), TDataSetTextImporterEh, 'FieldsMap', TDefaultItemsCollectionProperty);
  {$ENDIF}

  RegisterPropertyEditor(TypeInfo(string), TFieldsMapItemEh, 'DataSetFieldName', TDataSetTextImpExpListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TFieldsMapItemEh, 'FileFieldName', TDataSetTextImpExpListFieldProperty);

end;

{ TDataSetTextImpExpEditorEh }

procedure TDataSetTextImpExpEditorEh.ExecuteVerb(Index: Integer);
{$IFDEF FPC}
{$ELSE}
var
  Collection: TCollection;
{$ENDIF}
begin
{$IFDEF FPC}
{$ELSE}
  if Component is TDataSetTextExporterEh then
    Collection := (Component as TDataSetTextExporterEh).FieldsMap
  else if Component is TDataSetTextImporterEh then
    Collection := (Component as TDataSetTextImporterEh).FieldsMap
  else
    Collection := nil;
{$ENDIF}
  case Index of
    0 :
    {$IFDEF FPC}
      ;
    {$ELSE}
      if Collection <> nil then
        ShowCollectionEditorClass(Designer, TDefaultItemsCollectionEditorEh, Component,
          Collection, 'FieldsMap', [coAdd, coDelete, coMove]);
    {$ENDIF}
    2:
      ShowAboutForm;
  end;
end;

function TDataSetTextImpExpEditorEh.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit FieldsMap collection';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TDataSetTextImpExpEditorEh.GetVerbCount: Integer;
begin
  Result := 3;
end;

{ TDataSetTextImpExpListFieldProperty }

function TDataSetTextImpExpListFieldProperty.GetDataSet: TDataSet;
var
  AnOwner: TPersistent;
begin
  AnOwner := (GetComponent(0) as TFieldsMapItemEh).Collection.Owner;
  if AnOwner is TDataSetTextExporterEh then
    Result := (AnOwner as TDataSetTextExporterEh).DataSet
  else if AnOwner is TDataSetTextImporterEh then
    Result := (AnOwner as TDataSetTextImporterEh).DataSet
  else
    Result := nil;
end;

end.
