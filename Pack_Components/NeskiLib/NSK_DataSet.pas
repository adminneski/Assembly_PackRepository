unit NSK_DataSet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Variants,dbclient;

type
  TNSKDataSet = class(TClientDataset)
  private
    { Private declarations }
    FEdit: Boolean;
    FClose: Boolean;
    FDelete: Boolean;
    FCancel: Boolean;
    procedure SetConfirmEdit(Value: Boolean);
    procedure SetConfirmDelete(Value: Boolean);
    procedure SetConfirmClose(Value: Boolean);
    procedure SetConfirmCancel(Value: Boolean);
  protected
    { Protected declarations }
    procedure DoBeforeEdit; override;
    procedure DoBeforeDelete; override;
    procedure DoBeforeClose; override;
    procedure DoBeforeCancel; override;
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;
  published
    { Published declarations }
    property BeforeEditConfirm: Boolean read FEdit write SetConfirmEdit;
    property BeforeDeleteConfirm: Boolean read FDelete write SetConfirmDelete;
    property BeforeCloseConfirm: Boolean read FClose write SetConfirmClose;
    property BeforeCancelConfirm: Boolean read FCancel write SetConfirmCancel;
  end;


implementation


{ *********************** Conponente TNSKDataSet ************************* }

constructor TNSKDataSet.Create(Owner: TComponent);
begin
   inherited Create(Owner);
end;

destructor TNSKDataSet.Destroy;
begin
   inherited Destroy;
end;

procedure TNSKDataSet.DoBeforeEdit;
begin
   if BeforeEditConfirm then
   begin
      if Application.MessageBox('Tem certeza que deseja entrar no modo alteração ?',
                                'Atenção!!!',MB_DEFBUTTON2+MB_YESNO+MB_ICONQUESTION) = idNo then
      begin
         Abort;
      end;
   end;
   inherited DoBeforeEdit;
end;

procedure TNSKDataSet.DoBeforeDelete;
begin
   if BeforeDeleteConfirm then
   begin
      { Exije do usuario uma confirmação da exclusão do registro }
      if Application.MessageBox('Tem certeza que deseja excluir o registro selecionado ?',
                                'Atenção !!!', MB_DEFBUTTON2+MB_YESNO+MB_ICONSTOP) = IdNo then
      begin
         Abort;
      end;
   end;
   inherited DoBeforeDelete;
end;

procedure TNSKDataSet.DoBeforeCancel;
begin
   if BeforeCancelConfirm then
   begin
      { Exije do usuario uma confirmação da exclusão do registro }
      if Application.MessageBox('Tem certeza que deseja Cancelar ?',
                                'Atenção !!!', MB_DEFBUTTON2+MB_YESNO+MB_ICONSTOP) = IdNo then
      begin
         Abort;
      end;
   end;
   inherited DoBeforeCancel;

end;

procedure TNSKDataSet.DoBeforeClose;
//var
//Msg: Integer;
begin
(*
   if BeforeCloseConfirm then
   begin
      { Antes de fechar a tabela verifaca se a mesma está em modo de Edição }
      if Self.State in [dsEdit, dsInsert] then
      begin
         Msg := Application.MessageBox('Deseja gravar as alterações ou inclusões feitas no banco de dados?',
                                       'Atenção!!!', MB_DEFBUTTON3+MB_YESNOCANCEL+MB_ICONQUESTION);
         if      Msg = idYes    then  Post
         else if Msg = idNo     then  Cancel
         else if Msg = idCancel then  Abort;
      end;
   end;
*)
   inherited DoBeforeClose;
end;

procedure TNSKDataSet.SetConfirmEdit(Value: Boolean);
begin
   if FEdit <> Value then FEdit := Value;
end;

procedure TNSKDataSet.SetConfirmCancel(Value: Boolean);
begin
   if FCancel <> Value then FCancel := Value;
end;

procedure TNSKDataSet.SetConfirmClose(Value: Boolean);
begin
   if FClose <> Value then FClose := Value;
end;

procedure TNSKDataSet.SetConfirmDelete(Value: Boolean);
begin
   if FDelete <> Value then FDelete := Value;
end;

end.

