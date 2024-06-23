
{******************************************}
{                                          }
{             FastReport VCL               }
{              Tool controls               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBaseFormEditorDataTree;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}Windows, {$ENDIF}
  Messages, Classes, Controls, IniFiles, frxBaseForm, frxDataTree, ExtCtrls, StdCtrls
{$IFDEF FPC}
  , LCLType, LCLIntf, LCLProc
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

type
  TDataClick = procedure(str: string);

  TfrxBaseFormEditorDataTree = class(TfrxBaseLoadSavePrefForm)
  protected
    FDataTree: TfrxDataTreeForm;
    FRPanel, FLPanel: TPanel;
    FSplitter: TSplitter;

    procedure OnDataTreeDblClick(Sender: TObject); virtual; abstract;
    procedure LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure ExprMemoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SplitterMoved(Sender: TObject);
  end;

procedure MemoDragDrop(mem: TMemo; DataTree: TfrxDataTreeForm; X, Y: Integer; const ExpressionDelimiters: String);
function GetExpText(const Expr: String; const Line, Delim: String; StopAt: Integer): String;

implementation

uses frxClass, frxDock, Types;

{ frxBaseFormEditorDataTree }

constructor TfrxBaseFormEditorDataTree.Create(AOwner: TComponent);
var
  FReport: TfrxReport;
  i: Integer;
begin
  FDataTree := nil;
  inherited;

  FRPanel := TPanel.Create(Self);
  FRPanel.parent := Self;
  FRPanel.Name := 'FRPanel';
  FRPanel.Align := alClient;
  FRPanel.BevelOuter := bvNone;

  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TControl) then
      if (TControl(Components[i]).Parent = Self) and (Components[i] <> FRPanel) then
        TControl(Components[i]).Parent := FRPanel;

  FLPanel := TPanel.Create(Self);
  FLPanel.parent := Self;
  FLPanel.Name := 'FLPanel';
  FLPanel.Align := alRight;

  FSplitter := TSplitter.Create(Self);
  FSplitter.parent := Self;
  FSplitter.Name := 'FSplitter';
  FSplitter.Left := 113;
  FSplitter.Top := 31;
  FSplitter.Height := 383;
  FSplitter.Align := alRight;
  FSplitter.OnMoved := SplitterMoved;

  FReport := TfrxCustomDesigner(Owner).Report;

  FDataTree := TfrxDataTreeForm.Create(FLPanel);
  FDataTree.parent := FLPanel;
  FDataTree.Name := 'FDataTreeEditors';
  FDataTree.Report := FReport;
  FDataTree.SetControlsParent(FLPanel);//ManualDock
  FDataTree.HintPanel.Height := 64;
  FDataTree.UpdateItems;
  FDataTree.OnDblClick := OnDataTreeDblClick;
end;

procedure TfrxBaseFormEditorDataTree.LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  FLPanel.Width := Ini.ReadInteger(lName, 'FLPanelWidth', 300);
  FDataTree.UpdateSize;
end;

procedure TfrxBaseFormEditorDataTree.SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;
  Ini.WriteInteger(lName, 'FLPanelWidth', FLPanel.Width);
end;

procedure TfrxBaseFormEditorDataTree.ExprMemoDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (FDataTree.GetFieldName <> '');
end;

procedure TfrxBaseFormEditorDataTree.Resize;
begin
  inherited;
  if (FDataTree <> nil) then
    FDataTree.UpdateSize;
end;

procedure TfrxBaseFormEditorDataTree.SplitterMoved(Sender: TObject);
begin
  FDataTree.UpdateSize;
end;

 { Support }

function GetExpText(const Expr: String; const Line, Delim: String; StopAt: Integer): String;
var
  i, cnt: Integer;
  IsExpr: Boolean;
  dc1, dc2: String;

  function CheckExpr(const ADelim: String; Index: Integer): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    if Index - Length(ADelim) < 0 then Exit;
    for i := Length(ADelim) downto 1 do
      if ADelim[i] <> Line[Index - (i - 1)] then Exit;
    Result := True;
  end;

begin
  Result := Expr;
  cnt := 0;
  if Delim = '' then Exit;
  dc2 := Copy(Delim, Pos(',', Delim) + 1, 255);
  dc1 := Copy(Delim, 1, Pos(',', Delim) - 1);
  for i := StopAt downto 1 do
  begin
    if CheckExpr(dc1, i) then Inc(cnt)
    else if CheckExpr(dc2, i) then Dec(cnt);
  end;
  IsExpr :=  (cnt > 0);
  if not IsExpr and (Length(Result) > 0) and (Result[1] = '<') then
  begin
    Delete(Result, 1, 1);
    Delete(Result, Length(Result), 1);
    Insert(dc1, Result, 1);
    Result := Result + dc2;
  end
end;

procedure MemoDragDrop(mem: TMemo; DataTree: TfrxDataTreeForm; X, Y: Integer; const ExpressionDelimiters: String);
begin
 {$IFNDEF Linux}
  mem.SelStart := LoWord(mem.Perform(EM_CHARFROMPOS,0,MakeLParam(X, Y)));
 {$ENDIF}
  mem.SelText := GetExpText(DataTree.GetFieldName, mem.Lines[mem.CaretPos.Y], ExpressionDelimiters, mem.CaretPos.X);;
  mem.SetFocus;
end;

end.
