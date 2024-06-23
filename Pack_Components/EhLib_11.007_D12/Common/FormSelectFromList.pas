{*******************************************************}
{                                                       }
{                     EhLib 10.2                        }
{                                                       }
{               TfSelectFromList form                   }
{                                                       }
{     Copyright (c) 2004-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit FormSelectFromList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Variants,
  {$IFDEF FPC}
   EhLibLCL,
  {$ELSE}
   EhLibVCL,
  {$ENDIF}
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrlsEh, Mask, Contnrs, SQLDriverEditEh;

type
  TfSelectFromList = class(TForm)
    Bevel1: TBevel;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    cbEngine: TDBComboBoxEh;
    cbDBService: TDBComboBoxEh;
    eDataBaseName: TDBEditEh;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure ListBox1DblClick(Sender: TObject);
    procedure cbEngineChange(Sender: TObject);
  private
    FDBServiceEngineList: TObjectList;
    procedure SetDBServiceEngineList(const Value: TObjectList);
    { Private declarations }
  public
    procedure UpdateComboboxes;
    property DBServiceEngineList: TObjectList read FDBServiceEngineList write SetDBServiceEngineList;
  end;

var
  fSelectFromList: TfSelectFromList;

function SelectFromList(Items: TStrings): Integer;

implementation

{$R *.dfm}

function SelectFromList(Items: TStrings): Integer;
var
  f: TfSelectFromList;
begin
  Result := -1;
  f := TfSelectFromList.Create(Application);
  if f.ShowModal = mrOk then
  f.Free;
end;

procedure TfSelectFromList.ListBox1DblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfSelectFromList.SetDBServiceEngineList(
  const Value: TObjectList);
begin
  FDBServiceEngineList := Value;
  UpdateComboboxes();
end;

procedure TfSelectFromList.UpdateComboboxes;
var
  i: Integer;
  DBi: TDBServiceItem;
begin
  if FDBServiceEngineList = nil then Exit;
  cbDBService.Text := '';
  cbDBService.Items.Clear;
  for i := 0 to FDBServiceEngineList.Count-1 do
  begin
    DBi := TDBServiceItem(FDBServiceEngineList[i]);
    if DBi.AccessEngine.AccessEngineName = cbEngine.Text then
      cbDBService.Items.AddObject(DBi.DBService.GetDBServiceName, TObject(DBi.DBService));
  end;
  if cbDBService.Items.Count > 0 then
    cbDBService.ItemIndex := 0;
end;

procedure TfSelectFromList.cbEngineChange(Sender: TObject);
begin
  UpdateComboboxes;
end;

end.
