unit Frm_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
   GOX.Code.RESTRequest;

type
  TFrmMain = class(TForm)
    Memo_Response: TMemo;
    Panel1: TPanel;
    ButtonGET: TButton;
    procedure ButtonGETClick(Sender: TObject);
  private
    function JSONFormat(AJSON: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  System.JSON;

{$R *.dfm}


function TFrmMain.JSONFormat(AJSON: String): String;
const
 DEF_INDENT = 2;
var
 JO : TJSONObject;
begin
 try
   try
    JO := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
    Result := JO.Format(DEF_INDENT);
   finally
     FreeAndNil(JO);
   end;
 except
  on E:Exception do
   begin
    Result := AJSON;
    MessageDlg('Erro na sintaxe do JSON para Formatar.', mtError, [mbOK], 0);
   end;
 end;
end;



procedure TFrmMain.ButtonGETClick(Sender: TObject);
var
  LResponse: IGOXResponse;
begin
  LResponse := TGOXRequest
                .New
                 .BaseURL('http://localhost:5500/rest/api')
                  .Accept('application/json')
                  .Resource('account')
                   .Get;
  Memo_Response.Text :=  JSONFormat(LResponse.Content);
end;

end.

