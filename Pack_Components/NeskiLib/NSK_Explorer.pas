unit NSK_Explorer;

interface

uses
   Messages, WinTypes, WinProcs, SysUtils, Classes, Graphics, Controls,
   Forms, Dialogs, Menus, stdctrls;

type
   //
   // TAXExplorer.
   //
   TNSKExplorer = class(TComponent)
   private
      { Private declarations }
      FMenuPrior: TPopupMenu;
      FMenuNext: TPopupMenu;
      FForms: TStringList;
//      procedure SetupMenuItem(IndexForm: Integer);
      procedure SetMenuPrior(Value: TPopupMenu);
      procedure SetMenuNext(Value: TPopupMenu);
      //    procedure MenuClick(Sender: TObject);
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create(Owner: TComponent); override;
      destructor Destroy; override;
      function AddForm(Sender: TObject): Boolean;
      function CloseForm(Sender: TObject): Boolean; overload;
      function CloseForm(Form: string): Boolean; overload;
      function ExistForm(Form: string): Boolean;
      //
      function ActiveForm(Index: Integer): Boolean;
      function PriorForm(Sender: TObject): Boolean;
      function NextForm(Sender: TObject): Boolean;
      property Forms: TStringList read FForms write FForms;
      property PopupMenuPrior: TPopupMenu read FMenuPrior write SetMenuPrior;
      property PopupMenuNext: TPopupMenu read FMenuNext write SetMenuNext;
   published
      { Published declarations }
   end;


implementation


// ***********************
// Componente TNSKExplorer.
// ***********************

function TNSKExplorer.CloseForm(Form: string): Boolean;
var
Index: Integer;
axO: Integer;
axI: Integer;
//axTag: Integer;
Chk: Boolean;
begin
//   Result  := True;

   Index := -1;
   { Controle Exclusivo do Neski Explorer }
   for axI := 0 to FForms.Count - 1 do
   begin
      if Form = TForm(FForms.Objects[axI]).Caption then Index := axI;
   end;
   if Index > -1 then FForms.Delete(Index);
   for axO := 0 to FForms.Count - 1 do TForm(FForms.Objects[axO]).Tag := axO;
end;

constructor TNSKExplorer.Create(Owner: TComponent);
begin
   inherited Create(Owner);
   FForms := TStringList.Create;
end;

destructor TNSKExplorer.Destroy;
begin
   FForms.Free;
   inherited Destroy;
end;

function TNSKExplorer.AddForm(Sender: TObject): Boolean;
var
Index: Integer;
Chk: Boolean;
begin
   Result := True;
   {Pesquisa se existe o Objeto e Carrega o Index do Mesmo}
   Chk := FForms.Find(TForm(Sender).Caption, Index);
   { Caso tenha lido todos os Forms e não encontrado Add na lista }
   if not Chk then
   begin
      // Inclui o Form na lista de Forms.
      FForms.AddObject(TForm(Sender).Caption, Sender);
//      TForm(Sender).Tag := FForms.Count -1;
   end
   else
   begin
      TForm(Sender).Tag := Index;
   end;
end;

function TNSKExplorer.CloseForm(Sender: TObject): Boolean;
var
Index: Integer;
axO: Integer;
axI: Integer;
//axTag: Integer;
Chk: Boolean;
begin
//   Result  := True;

   Index := -1;
   { Controle Exclusivo do Neski Explorer }
   for axI := 0 to FForms.Count - 1 do
   begin
      if TForm(Sender).Caption = TForm(FForms.Objects[axI]).Caption then Index := axI;
   end;
   if Index > -1 then FForms.Delete(Index);
   for axO := 0 to FForms.Count - 1 do TForm(FForms.Objects[axO]).Tag := axO;
end;


function TNSKExplorer.ExistForm(Form: string): Boolean;
var
axIndex: Integer;
begin
   Result := False;
   for axIndex := 0 to FForms.Count - 1 do
   begin
      if UpperCase(TForm(FForms.Objects[axIndex]).Name) = UpperCase(Form) then
      begin
         if TForm(FForms.Objects[axIndex]).BorderStyle = bsDialog then
            TForm(FForms.Objects[axIndex]).ShowModal
         else
           { Marcado Esses Linhas Abaixo por Jeickson Devido Quando Clicar no Botao da barra tinha que
           clicar 2 ou + Vezes para Executar o Show, e marcando essas Linhas Resolvel basta apenas clicar
           1 vez somente }
           //
//         if TForm(FForms.Objects[axIndex]).WindowState = wsMinimized then
//            TForm(FForms.Objects[axIndex]).WindowState := wsNormal
//         else
         begin
            TForm(FForms.Objects[axIndex]).WindowState := wsNormal;
            TForm(FForms.Objects[axIndex]).Show;
         end;
         //
         Result := True;
         break;
      end;
   end;
end;

function TNSKExplorer.PriorForm(Sender: TObject): Boolean;
begin
   Result := True;
   if TForm(Sender).Tag > 0 then
   begin
      if TForm(FForms.Objects[TForm(Sender).Tag - 1]).WindowState = wsMinimized then
         TForm(FForms.Objects[TForm(Sender).Tag - 1]).WindowState := wsNormal
      else
         TForm(FForms.Objects[TForm(Sender).Tag - 1]).Show; // SetFocus;
   end;
   { Atualiza os PopupMenus de Valtar e Avançar }
//   SetupMenuItem((Imes.Objects[(Sender as TForm).Tag -1] as TForm).Tag);
end;

function TNSKExplorer.NextForm(Sender: TObject): Boolean;
begin
   Result := True;
   if TForm(Sender).Tag < FForms.Count - 1 then
   begin
      if TForm(FForms.Objects[TForm(Sender).Tag + 1]).WindowState = wsMinimized then
         TForm(FForms.Objects[TForm(Sender).Tag + 1]).WindowState := wsNormal
      else
         TForm(FForms.Objects[TForm(Sender).Tag + 1]).Show; // SetFocus;
   end;
   { Atualiza os PopupMenus de Valtar e Avançar }
//   SetupMenuItem((Imes.Objects[(Sender as TForm).Tag +1] as TForm).Tag);
end;


function TNSKExplorer.ActiveForm(Index: Integer): Boolean;
begin
   Result := True;
   if TForm(FForms.Objects[Index]).BorderStyle = bsDialog then
      TForm(FForms.Objects[Index]).ShowModal
   else if TForm(FForms.Objects[Index]).WindowState = wsMinimized then
      TForm(FForms.Objects[Index]).WindowState := wsNormal
   else
      TForm(FForms.Objects[Index]).Show; //SetFocus;

   { Atualiza os PopupMenus de Valtar e Avançar }
//   SetupMenuItem((Imes.Objects[Index] as TForm).Tag);
end;


procedure TNSKExplorer.SetMenuPrior(Value: TPopupMenu);
begin
   FMenuPrior := Value;
   if Value <> nil then
      Value.FreeNotification(Self);
end;

procedure TNSKExplorer.SetMenuNext(Value: TpopupMenu);
begin
   FMenuNext := Value;
   if Value <> nil then
      Value.FreeNotification(Self);
end;
{
procedure TNSKExplorer.SetupMenuItem(IndexForm: Integer);
var
axMenuItem: TMenuItem;
axP: Integer;
axN: Integer;
axY: Integer;
axZ: Integer;
begin
   // Limpa os itens do popupmenu Prior.
   if Self.PopupMenuPrior.Items.Count > 0 then
      for axP := Self.PopupMenuPrior.Items.Count -1 downto 0 do
          Self.PopupMenuPrior.Items.Delete(axP);

   // Limpa os itens do popupmenu Next.
   if Self.PopupMenuNext.Items.Count > 0 then
      for axN := Self.PopupMenuNext.Items.Count -1 downto 0 do
          Self.PopupMenuNext.Items.Delete(axN);

   for axY := 0 to IndexForm -1 do
   begin
      if Self.FindComponent('Mnu' + (Self.Imes.Objects[axY] as TForm).Caption) = nil then
      begin
         axMenuItem         := TMenuItem.Create(Self);
         axMenuItem.Name    := 'Mnu' + (Self.Imes.Objects[axY] as TForm).Caption;
         axMenuItem.Caption := (Self.Imes.Objects[axY] as TForm).Caption;
         axMenuItem.OnClick := MenuClick;
         Self.PopupMenuPrior.Items.Add(axMenuItem);
      end
      else
      begin
         Self.PopupMenuPrior.Items.Add((Self.FindComponent('Mnu' + (Self.Imes.Objects[axY] as TForm).Caption) as TMenuItem));
      end;
   end;
   for axZ := IndexForm +1 to Self.Imes.Count -1 do
   begin
      if Self.FindComponent('Mnu' + (Self.Imes.Objects[axZ] as TForm).Caption) = nil then
      begin
         axMenuItem         := TMenuItem.Create(Self);
         axMenuItem.Name    := 'Mnu' + (Self.Imes.Objects[axZ] as TForm).Caption;
         axMenuItem.Caption := (Self.Imes.Objects[axZ] as TForm).Caption;
         axMenuItem.OnClick := MenuClick;
         Self.PopupMenuNext.Items.Add(axMenuItem);
      end
      else
      begin
         Self.PopupMenuNext.Items.Add((Self.FindComponent('Mnu' + (Self.Imes.Objects[axZ] as TForm).Caption) as TMenuItem));
      end;
   end;
end;

procedure TNSKExplorer.MenuClick(Sender: TObject);
begin
   Self.ExistForm(Copy((Sender as TMenuItem).Name,4,Length((Sender as TMenuItem).Name) -3));
end;
}

end.

