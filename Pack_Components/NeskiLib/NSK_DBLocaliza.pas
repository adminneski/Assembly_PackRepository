unit NSK_DBLocaliza;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Dialogs, Forms, DB, DBClient,Graphics;

type
//
// Componente TNSKDBLocaliza.
//
  TResultLocaliza = record
    FieldValue_1 : String;
    FieldValue_2 : String;
    FieldValue_3 : String;
    FieldValue_4 : String;
  end;

  TNSKDBLocaliza = class(TComponent)
  private
    { Private declarations }
    FColorForm : TColor;
    FColorGrid : TColor;
    FLocate: Boolean;
    FMostraTodosRegistrosAbrir : Boolean;
    FMemo: Boolean;
    FMemoField: String;
    FLocateField: String;
    FFieldsLabel: TStringList;
    FFieldsMask: TStringList;
    FBorderStyle: TFormBorderStyle;
    FResultFields: TResultLocaliza;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;

    function  Execute(pFIND: TClientDataset; pCoordinates: Array of Integer; pMultiSelecao: Boolean = False; pValueFieldReturn:String = ''): Variant;


    property ResultFields: TResultLocaliza read FResultFields write FResultFields;
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
    property MostraTodosRegistrosAbrir: Boolean read FMostraTodosRegistrosAbrir write FMostraTodosRegistrosAbrir;

  end;


implementation

uses DlgNSK_DBLocaliza;


//******************************************************************************
// Componente TNSKDBLocaliza.
//******************************************************************************
constructor TNSKDBLocaliza.Create(Owner: TComponent);
begin
   inherited Create(Owner);
   FLocate                    := False;
   FMemo                      := False;
   FMostraTodosRegistrosAbrir := false;
   FLocateField               := '';
   FMemoField                 := '';
   FFieldsLabel               := TStringList.Create;
   FFieldsMask                := TStringList.Create;
   FColorForm                 := clWhite;
   FColorGrid                 := clWhite;
   FBorderStyle               := bsDialog;
end;

destructor TNSKDBLocaliza.Destroy;
begin
   FFieldsLabel.Free;
   FFieldsMask.Free;
   FMostraTodosRegistrosAbrir := false;
   inherited Destroy;
end;

function TNSKDBLocaliza.Execute(pFIND: TClientDataset; pCoordinates: Array of Integer; pMultiSelecao: Boolean;pValueFieldReturn:String): Variant;
var
  DlgLocaliza: TDlgDBLocaliza;
  intFor: Integer;
begin
   if (not FLocate) then FLocateField := '';
   //
   DlgLocaliza := TDlgDBLocaliza.Create(Self);
   //
   DlgLocaliza.Color             := ColorForm;
   DlgLocaliza.DBGPesquise.Color := ColorGrid;
   DlgLocaliza.BorderStyle       := BorderStyle;
   //
   DlgLocaliza.FIND.ProviderName := pFIND.ProviderName;
   //
   if (pFIND.RemoteServer <> nil)     then DlgLocaliza.FIND.RemoteServer     := pFIND.RemoteServer;
   if (pFIND.ConnectionBroker <> nil) then DlgLocaliza.FIND.ConnectionBroker := pFIND.ConnectionBroker;
   //
   DlgLocaliza.FIND.CommandText   := pFIND.CommandText;
   DlgLocaliza.FIND.PacketRecords := pFIND.PacketRecords;
   DlgLocaliza.FIND.Params.Clear;
   DlgLocaliza.FIND.Params        := pFIND.Params;
   //
   DlgLocaliza.LValueFieldReturn := pValueFieldReturn; //Carrega o Nome do Field que deve ser usado para retorno de valor
   DlgLocaliza.axLocate          := FLocate;
   DlgLocaliza.axLocateField     := FLocateField;
   DlgLocaliza.axMemoField       := FMemoField;
   DlgLocaliza.axMostraTodosRegistrosAbrir  := FMostraTodosRegistrosAbrir;
   // Posição do form na tela.
   if (pCoordinates[0] > 0) or (pCoordinates[1] > 0) then
   begin
      if pCoordinates[0] >= 0 then DlgLocaliza.Top  := pCoordinates[0];
      if pCoordinates[1] >= 0 then DlgLocaliza.Left := pCoordinates[1];
   end;
   if (pCoordinates[2] > 0) or (pCoordinates[3] > 0) then
   begin
      if pCoordinates[2] > 0 then DlgLocaliza.Height := pCoordinates[2];
      if pCoordinates[3] > 0 then DlgLocaliza.Width  := pCoordinates[3];
   end;
   DlgLocaliza.axTitles.Clear;
   DlgLocaliza.axMask.Clear;
   // Monta o FIELDS no DBGrid com os MASK definidos.
   for intFor := 0 to FFieldsLabel.Count -1 do
   begin
      if (intFor <= FFieldsLabel.Count -1) then
         DlgLocaliza.axTitles.Add(FFieldsLabel.Strings[intFor])
      else
         DlgLocaliza.axTitles.Add('');
   end;
   //
   for intFor := 0 to FFieldsMask.Count -1 do
   begin
      if (intFor <= FFieldsMask.Count -1) then
         DlgLocaliza.axMask.Add(FFieldsMask.Strings[intFor])
      else
         DlgLocaliza.axMask.Add('');
   end;
   // Definição do field MEMO.
   DlgLocaliza.memOBS.Visible := FMemo;

   if (FMemo) and (Length(FMemoField) > 0) then
     DlgLocaliza.memOBS.DataField := FMemoField;
   //

   DlgLocaliza.memOBS.Visible         := pMultiSelecao;
   DlgLocaliza.lblInformativo.Visible := pMultiSelecao;

   if pMultiSelecao then
   begin
     DlgLocaliza.memOBS.Font.Size := 10;
     DlgLocaliza.memOBS.Font.Style :=  [fsBold];
   end;
   try
     DlgLocaliza.ShowModal;
   finally
     if (DlgLocaliza.ModalResult = mrOK) and (DlgLocaliza.FIND.Active) then
     begin
       if (DlgLocaliza.memOBS.Visible) and (Length(Trim(DlgLocaliza.memOBS.Lines.Text)) > 0) then
       begin
         Result := Trim(DlgLocaliza.memOBS.Lines.Text);
       end
       else
       begin
         Result := DlgLocaliza.FIND.Fields[0].AsString;
         //
         if DlgLocaliza.FIND.Fields.Count >= 1 then
         FResultFields.FieldValue_1 := DlgLocaliza.FIND.Fields[0].AsString;
         if DlgLocaliza.FIND.Fields.Count >= 2 then
         FResultFields.FieldValue_2 := DlgLocaliza.FIND.Fields[1].AsString;
         if DlgLocaliza.FIND.Fields.Count >= 3 then
         FResultFields.FieldValue_2 := DlgLocaliza.FIND.Fields[2].AsString;
         if DlgLocaliza.FIND.Fields.Count >= 4 then
         FResultFields.FieldValue_2 := DlgLocaliza.FIND.Fields[3].AsString;
       end;
     end
     else
        Result := '';
     //
     if (DlgLocaliza.FIND.Active) then DlgLocaliza.FIND.Close;
     //
     FreeAndNil(DlgLocaliza);
   end;
end;
end.
