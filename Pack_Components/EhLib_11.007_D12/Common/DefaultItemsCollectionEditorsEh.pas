{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{              Design window for TDBGridEh              }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}


unit DefaultItemsCollectionEditorsEh;

{$I EhLib.Inc}

interface

uses
  SysUtils,
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
  Graphics, Controls, Forms, ToolCtrlsEh,
  Classes, TypInfo;

{$IFDEF FPC}
{$ELSE}

type

  TDefaultItemsCollectionEditorEh = class(TCollectionEditor)
    N1: TMenuItem;
    AddAllFields1: TMenuItem;
    RestoreDefaults1: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    AddAllFieldsCmd: TAction;
    RestoreDefaultsCmd: TAction;
    procedure AddAllFieldsCmdExecute(Sender: TObject);
    procedure RestoreDefaultsCmdExecute(Sender: TObject);
    procedure AddAllFieldsCmdUpdate(Sender: TObject);
    procedure RestoreDefaultsCmdUpdate(Sender: TObject);
  private
  protected
    function CanAdd(Index: Integer): Boolean; override;
  public
  end;

{ TDefaultItemsCollectionProperty }

  TDefaultItemsCollectionProperty = class(TCollectionProperty)
  public
    function GetEditorClass: TCollectionEditorClass; override;
  end;

{$ENDIF}

{$IFDEF FPC}
{$ELSE}
var
  DefaultItemsCollectionEditor: TDefaultItemsCollectionEditorEh;
{$ENDIF}

implementation

{$R *.dfm}

uses
{$IFDEF DESIGNTIME}

{$IFDEF CIL}
  Borland.Vcl.Design.ComponentDesigner,
{$ELSE}
  {$IFDEF FPC}
  {$ELSE}
  ComponentDesigner,
  Registry, Db, EhLibDesignAbout,
  {$ENDIF}
{$ENDIF}

{$ELSE}
{$ENDIF}
  Dialogs;

{$IFDEF FPC}
{$ELSE}

{ TFieldsRelevantCollectionEditorEh }

procedure TDefaultItemsCollectionEditorEh.AddAllFieldsCmdExecute(Sender: TObject);
var
  ADefaultItemsCollectionItfs: IDefaultItemsCollectionEh;
  msgValue: Word;
begin
  if Supports(Collection, IDefaultItemsCollectionEh, ADefaultItemsCollectionItfs) then
  begin
    if not ADefaultItemsCollectionItfs.CanAddDefaultItems then Exit;

    try
      if (Collection.Count > 0) then
      begin
        msgValue := MessageDlg('Delete existing columns?',
          mtConfirmation, [mbYes, mbNo, mbCancel], 0);
        case msgValue of
          mrYes:
            begin
              SelectNone(True);
              Collection.Clear;
            end;
          mrCancel:
            Exit;
        end;
      end;
      ADefaultItemsCollectionItfs.AddAllItems(False);
    finally
      UpdateListbox;
    end;
  Designer.Modified;
  end;
end;

procedure TDefaultItemsCollectionEditorEh.RestoreDefaultsCmdExecute(Sender: TObject);
begin
end;

procedure TDefaultItemsCollectionEditorEh.AddAllFieldsCmdUpdate(Sender: TObject);
var
  AFieldsRelevantCollectionItfs: IDefaultItemsCollectionEh;
begin
  if Supports(Collection, IDefaultItemsCollectionEh, AFieldsRelevantCollectionItfs) then
    AddAllFieldsCmd.Enabled := AFieldsRelevantCollectionItfs.CanAddDefaultItems
  else
    AddAllFieldsCmd.Enabled := False;
end;

procedure TDefaultItemsCollectionEditorEh.RestoreDefaultsCmdUpdate(Sender: TObject);
begin
  RestoreDefaultsCmd.Enabled := ListView1.Items.Count > 0;
end;

function TDefaultItemsCollectionEditorEh.CanAdd(Index: Integer): Boolean;
begin
  Result := True;
end;

{ TDefaultItemsCollectionProperty }

function TDefaultItemsCollectionProperty.GetEditorClass: TCollectionEditorClass;
begin
  Result := TDefaultItemsCollectionEditorEh;
end;

{$ENDIF}

procedure Init;
begin
end;

{ DoFinalize }

procedure DoFinalize;
begin
end;

initialization
  Init;
finalization
  DoFinalize;
end.
