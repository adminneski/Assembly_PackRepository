unit Unit3;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  AX_TaskButton,
  AX_TaskDialog,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  System.ImageList;

type
  TForm3 = class(TForm)
    ImageList1: TImageList;
    axTaskButton1: TaxTaskButton;
    ImageList2: TImageList;
    axTaskDialog1: TaxTaskDialog;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Button8: TButton;
    Panel1: TPanel;
    procedure axTileControlItem1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure axTaskDialog1DialogProgress(Sender: TObject; var Pos: Integer;
      var State: TProgressBarState);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure axTaskDialog1DialogTimer(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.axTaskDialog1DialogProgress(Sender: TObject; var Pos: Integer;
  var State: TProgressBarState);
begin
   Pos := Pos + 1;
end;

procedure TForm3.axTaskDialog1DialogTimer(Sender: TObject);
begin
  Self.Tag := Self.Tag + 1;
  Caption := IntToStr(Self.Tag);
end;

procedure TForm3.axTileControlItem1Click(Sender: TObject);
begin
//   TCtrlSizer.Create(Self, axTileControlItem1);
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
   axTaskDialog1.Execute;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
   TaskShowMessage('Teste de Task Show Message');
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
TaskMessageBox('Teste de mensagem com dialogo', 'Atenção', [tcbYes, tcbNo], tdiQuestion);
end;

procedure TForm3.Button4Click(Sender: TObject);
var
  TskDlg: TAxTaskDialog;
begin
  TskDlg := TAxTaskDialog.Create(nil);
  try
    TskDlg.TitleColor := clRed;
    TskDlg.TitleFont.Color := clWhite;
    TskDlg.TitleFont.Style := [fsBold];
    TskDlg.FormWidth := 550;
    TskDlg.Caption := 'Sistemas Axial';
    TskDlg.Title := '......:::::: AXIAL GERENCIADOR DE ERRO INFORMA ::::::......';
    TskDlg.Text := 'Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros ' +
                   'Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros ' +
                   'Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros ' +
                   'Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros ' +
                   'Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros ' +
                   'Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros Mesnsage de Erros ';
    TskDlg.FooterText := 'A operação não pode ser concluída.';
    TskDlg.MemoText := TskDlg.Text;
    TskDlg.CommonButtons := [tcbOk];
    TskDlg.FooterIcon := tdiInformation;
    TskDlg.MainIcon := tdiError;
    // TskDlg.VerificationText := 'Enviar e-mail do erro ocorrido para ao suporte Axial.';
    TskDlg.URLText := '';
    TskDlg.URL := 'http://' + '';
    TskDlg.Flags := [tfEnableHyperlinks { , tfVerificationFlagChecked } ];
    TskDlg.MetroStyle.TaskDialogMetro := True;
    TskDlg.MetroStyle.TaskDialogColor := $002100C6;
    TskDlg.MetroStyle.TaskDialogFontColor := clWindow;
    TskDlg.Execute;
  finally
    TskDlg.Free;
  end;
end;

procedure TForm3.Button6Click(Sender: TObject);
var
TskDlg: TAxTaskDialog;
begin
      TskDlg := TAxTaskDialog.Create(nil);
      try
        TskDlg.TitleColor := clLime;
        TskDlg.TitleFont.Color := clBlack;
        TskDlg.Caption := 'Sistemas Axial';
        TskDlg.Title   := 'Tem certeza que deseja entrar no modo alteração ?';
        TskDlg.Text    := 'Esta opção entra no modo alteração do registro selecionado mostrado na tela, possibilitando que os dados possam ser modificados.';
        TskDlg.FooterText := 'Selecione uma opção ou cancele a operação se desejar.';
//        TskDlg.MemoText := TskDlg.Text;
        TskDlg.CommonButtons := [tcbNone];
        TskDlg.MainIcon := tdiQuestion;
        TskDlg.FooterIcon := tdiWarning;
        TskDlg.Flags := [tfUseCommandLinks];
        TskDlg.MetroStyle.TaskDialogMetro := True;
        TskDlg.MetroStyle.TaskDialogColor :=  $002D2D2D;  // $002100C6;// clGray;
        TskDlg.MetroStyle.TaskDialogFontColor := clWindow;

        with TaxTaskDialogButtonItem(TskDlg.Buttons.Add) do
        begin
           Caption := '&Sim';
           CommandLinkHint := 'Selecionando esta opção você entrará no modo de edição';
        end;
        with TaxTaskDialogButtonItem(TskDlg.Buttons.Add) do
        begin
           Caption := '&Não';
           CommandLinkHint := 'Selecionando esta opção você não entrará no modo edição';
        end;
        TskDlg.Execute;

        if TskDlg.ButtonResult <> 0 then
           Abort;
      finally
        TskDlg.Free;
      end;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  TaskShowAlert('Atenção!!!', 'Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta... Alerta...');
end;

end.
