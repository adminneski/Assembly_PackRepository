unit Main;

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
  Vcl.ExtCtrls,
  Router4D,
  Vcl.StdCtrls;

type
  TfMain = class(TForm)
    pnlBackground: TPanel;
    pnlMain: TPanel;
    pnlEmbed: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    procedure RegisterRouters;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses
  View.Page.Main.Cadastro,
  View.Page.Customer,
  View.Page.Product;

procedure TfMain.FormCreate(Sender: TObject);
begin
  RegisterRouters;
  TRouter4D.Render<TfViewPageMainCadastro>.SetElement(pnlEmbed, pnlBackground);
end;

procedure TfMain.RegisterRouters;
begin
  TRouter4D.Switch.Router('Start', TfViewPageMainCadastro);
  TRouter4D.Switch.Router('Product', TfViewPageProduct);
  TRouter4D.Switch.Router('Customer', TfViewPageCustomer);
end;

end.

