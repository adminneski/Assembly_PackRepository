unit Frm_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, System.JSON,
  System.StrUtils, REST.Json, Vcl.ComCtrls;

type
  TFrmMain = class(TForm)
    MResponse: TMemo;
    PageControl: TPageControl;
    TabSheet_Instance: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    GroupBox1: TGroupBox;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel2: TPanel;
    Image1: TImage;
    Button1: TButton;
    Button6: TButton;
    Button10: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  GOX.WhatsZap.Singleton;


{$R *.dfm}

procedure TFrmMain.Button10Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text :=  TGOXWhatsZap.Get.Message_SendVideo('5527999842402','');
  Application.ProcessMessages;
end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text := TGOXWhatsZap.Get.Instance_QRCodeImage(Image1);
  Application.ProcessMessages;
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text :=  TGOXWhatsZap.Get.Instance_Status;
  Application.ProcessMessages;
end;

procedure TFrmMain.Button3Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text :=  TGOXWhatsZap.Get.Message_SendLink('5527999842402',
                                                             'Teste de link',
                                                             'https://blog.adicel.com.br/wp-content/uploads/2023/04/Balas-de-gelatina-como-aumentar-sua-durabilidade-2.jpg',
                                                             'https://www.docemalu.com.br/bala-mastigavel-frutas-sortidas-600g---dimbinho/p',
                                                             'Link de teste titulo',
                                                             'Integração com o whatsap');
  Application.ProcessMessages;
end;

procedure TFrmMain.Button4Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text :=  TGOXWhatsZap.Get.Instance_Restart;
  Application.ProcessMessages;
end;

procedure TFrmMain.Button5Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text :=  TGOXWhatsZap.Get.Instance_QrCodeBase64;
  Application.ProcessMessages;
end;

procedure TFrmMain.Button6Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text := TGOXWhatsZap.Get.Message_SendAudio('27999842402','');
  Application.ProcessMessages;
end;

procedure TFrmMain.Button7Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text :=  TGOXWhatsZap.Get.Message_SendText('5527999842402','Teste da class Whatszap para Z-Api. '+TGOXEmoji.ApertoDeMao+TGOXEmoji.Atencao);
  Application.ProcessMessages;
end;

procedure TFrmMain.Button8Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text := TGOXWhatsZap.Get.Message_SendContact('5527999842402','5527999840533','Cristiane');
  Application.ProcessMessages;

end;

procedure TFrmMain.Button9Click(Sender: TObject);
begin
  MResponse.Lines.Clear;
  MResponse.Lines.Text := TGOXWhatsZap.Get.Message_SendImage('27999842402','https://lh3.googleusercontent.com/p/AF1QipPI7K4D_xEBYPgLWA3W_IcP2HbcV0DILe9D5zT2=s680-w680-h510');
  Application.ProcessMessages;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  TGOXWhatsZap.Initialize;
end;

end.
