unit NSK_DBLocalizaPlus;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Dialogs, Forms, DB, DBClient,Graphics, Data.SqlExpr;

type
//
// Componente TNSKDBLocaliza.
//
  TNSKDBLocalizaPlus = class(TComponent)
  private
    { Private declarations }
    FColorForm : TColor;
    FColorGrid : TColor;
    FLocate: Boolean;
    FMostraTodosRegistrosAbrir : Boolean;
    FReordenarColunas: Boolean;
    FMemo: Boolean;
    FMemoField: String;
    FLocateField: String;
    FFieldsLabel: TStringList;
    FFieldsMask: TStringList;
    FBorderStyle: TFormBorderStyle;
    FAscDescOrderByField: String;
    FFixOrderPSQ: TSQLquery;
    FSQLConnection: TSQLConnection;
  protected
    { Protected declarations }
  public
    { Public declarations }
    FPathNameTemplateGridUser: String;
    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;

    function Execute(pFIND: TClientDataset; pPSQ: TClientDataset;pSelect,pWhere,pKeyRetorno:String; pCoordinates: Array of Integer; pValorPesquisa : String = ''): Variant;
    property AscDescOrderByField      : String  read FAscDescOrderByField       write FAscDescOrderByField;

  published
    { Published declarations }
    property Locate: Boolean read FLocate write FLocate;
    property LocateField: String read FLocateField write FLocateField;
    property FieldsLabel: TStringList read FFieldsLabel write FFieldsLabel;
    property FieldsMask: TStringList read FFieldsMask write FFieldsMask;
    property Memo: Boolean read FMemo write FMemo;
    property ColorForm: TColor read FColorForm write FColorForm default clInfoBk;
    property ColorGrid: TColor read FColorGrid write FColorGrid default clInfoBk;
    property BorderStyle: TFormBorderStyle read FBorderStyle write FBorderStyle default bsDialog;
    property MemoField: String read FMemoField write FMemoField;

    property ReordenarColunas         : Boolean read FReordenarColunas write FReordenarColunas;
    property MostraTodosRegistrosAbrir: Boolean read FMostraTodosRegistrosAbrir write FMostraTodosRegistrosAbrir;
    property SQLConnection            : TSQLConnection  read FSQLConnection       write FSQLConnection;


  end;


implementation

uses DlgNSK_DBLocalizaPlus;


//******************************************************************************
// Componente TNSKDBLocaliza.
//******************************************************************************
constructor TNSKDBLocalizaPlus.Create(Owner: TComponent);
begin
   inherited Create(Owner);
   FLocate := False;
   FMemo := False;
   FMostraTodosRegistrosAbrir := false;
   FReordenarColunas          := False;
   FAscDescOrderByField := '';
   FLocateField := '';
   FMemoField := '';
   FFieldsLabel := TStringList.Create;
   FFieldsMask := TStringList.Create;
   FColorForm := clWhite;
   FColorGrid := clWhite;
   FBorderStyle := bsDialog;
end;

destructor TNSKDBLocalizaPlus.Destroy;
begin
   FFieldsLabel.Free;
   FFieldsMask.Free;
   FMostraTodosRegistrosAbrir := false;
   FReordenarColunas          := false;
   FAscDescOrderByField       := '';
   inherited Destroy;
end;

function TNSKDBLocalizaPlus.Execute(pFIND: TClientDataset; pPSQ: TClientDataset;pSelect,pWhere,pKeyRetorno:String; pCoordinates: Array of Integer; pValorPesquisa : String = ''): Variant;
var
DlgLocalizaPlus: TDlgDBLocalizaPlus;
intFor: Integer;
begin
   if (not FLocate) then FLocateField := '';
   //
   DlgLocalizaPlus := TDlgDBLocalizaPlus.Create(Self);
   //
   DlgLocalizaPlus.Color := ColorForm;
   DlgLocalizaPlus.DBGPesquise.Color := ColorGrid;
   DlgLocalizaPlus.BorderStyle := BorderStyle;
   DlgLocalizaPlus.FPathNameTemplateGridUser := FPathNameTemplateGridUser;
   //
   //CARREGA CAMPOS DA TABELA PESQUISA
   DlgLocalizaPlus.PSQ.ProviderName := pPSQ.ProviderName;
   if (pPSQ.RemoteServer <> nil)     then
     DlgLocalizaPlus.PSQ.RemoteServer     := pPSQ.RemoteServer;

   if (pPSQ.ConnectionBroker <> nil) then
     DlgLocalizaPlus.PSQ.ConnectionBroker := pPSQ.ConnectionBroker;

   if SQLConnection <> nil then
     DlgLocalizaPlus.SQLConnection := SQLConnection;


   DlgLocalizaPlus.PSQ.Active := True;
   //
   DlgLocalizaPlus.FIND.ProviderName := pFIND.ProviderName;
   //
   if (pFIND.RemoteServer <> nil)     then DlgLocalizaPlus.FIND.RemoteServer     := pFIND.RemoteServer;
   if (pFIND.ConnectionBroker <> nil) then DlgLocalizaPlus.FIND.ConnectionBroker := pFIND.ConnectionBroker;
   //
   DlgLocalizaPlus.axSELECT := pSelect;
   DlgLocalizaPlus.axWHERE  := pWhere;

   // Interliga propriedades
   DlgLocalizaPlus.FIND.CommandText   := pFIND.CommandText;
   DlgLocalizaPlus.FIND.PacketRecords := pFIND.PacketRecords;
   DlgLocalizaPlus.FIND.Params.Clear;
   DlgLocalizaPlus.FIND.Params        := pFIND.Params;
   //
   DlgLocalizaPlus.axLocate      := FLocate;
   DlgLocalizaPlus.axLocateField := FLocateField;
   DlgLocalizaPlus.axMemoField   := FMemoField;
   DlgLocalizaPlus.axMostraTodosRegistrosAbrir  := FMostraTodosRegistrosAbrir;
   DlgLocalizaPlus.axReordenarColunas           := FReordenarColunas;
   DlgLocalizaPlus.axAscDescOrderByField        := FAscDescOrderByField;

   // Posição do form na tela.
   if (pCoordinates[0] > 0) or (pCoordinates[1] > 0) then
   begin
      if pCoordinates[0] >= 0 then DlgLocalizaPlus.Top  := pCoordinates[0];
      if pCoordinates[1] >= 0 then DlgLocalizaPlus.Left := pCoordinates[1];
   end;
   if (pCoordinates[2] > 0) or (pCoordinates[3] > 0) then
   begin
      if pCoordinates[2] > 0 then DlgLocalizaPlus.Height := pCoordinates[2];
      if pCoordinates[3] > 0 then DlgLocalizaPlus.Width  := pCoordinates[3];
   end;
   DlgLocalizaPlus.axTitles.Clear;
   DlgLocalizaPlus.axMask.Clear;

   // Monta o FIELDS no DBGrid com os MASK definidos.
   for intFor := 0 to FFieldsLabel.Count -1 do
   begin
      if (intFor <= FFieldsLabel.Count -1) then
         DlgLocalizaPlus.axTitles.Add(FFieldsLabel.Strings[intFor])
      else
         DlgLocalizaPlus.axTitles.Add('');
   end;
   //
   for intFor := 0 to FFieldsMask.Count -1 do
   begin
      if (intFor <= FFieldsMask.Count -1) then
         DlgLocalizaPlus.axMask.Add(FFieldsMask.Strings[intFor])
      else
         DlgLocalizaPlus.axMask.Add('');
   end;
   // Definição do field MEMO.
   DlgLocalizaPlus.memOBS.Visible := FMemo;
   if (FMemo) and (Length(FMemoField) > 0) then DlgLocalizaPlus.memOBS.DataField := FMemoField;
   //
   try
     if pValorPesquisa.Length > 0 then
     begin
       var Enter : Word;
       Enter := VK_RETURN;

       DlgLocalizaPlus.EDTPesquise.Text := pValorPesquisa;
       DlgLocalizaPlus.EDTPesquise.Modified := True;
       DlgLocalizaPlus.FormKeyDown(DlgLocalizaPlus,Enter,[]);
     end
     else
       DlgLocalizaPlus.EDTPesquise.Text := '';

     DlgLocalizaPlus.ShowModal;
   finally
     if (DlgLocalizaPlus.ModalResult = mrOK) and (DlgLocalizaPlus.FIND.Active) then
     begin
        if Length(Trim(pKeyRetorno)) > 0 then
        Result := DlgLocalizaPlus.FIND.FieldByName(pKeyRetorno).AsString
        else
        Result := '';
     end
     else
     begin
        Result := '';
     end;
     //
     if (DlgLocalizaPlus.FIND.Active) then DlgLocalizaPlus.FIND.Close;

     //
     FreeAndNil(DlgLocalizaPlus);
   end;
end;


end.
