unit Core.Logtxt;

interface

uses
  {$IFDEF MSWINDOWS}
  Vcl.ExtCtrls,
  {$ENDIF}
  System.SysUtils,
  System.IOUtils,
  Classes,
  System.StrUtils;

type

  TLogTxt = class
   strict private
    constructor CreatePrivate;
  private
   class var
     FInstance : TLogTxt;
     FLine:Integer;
     procedure ZeraArquivo;
     procedure CriarArquivoLog;
     procedure OnTimerTimer(Sender: TObject);
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    class function Get: TLogTxt;
    procedure AddLog(AMSGLog:String);
  end;
implementation

uses
  Frm_MainServer;


procedure TLogTxt.AddLog(AMSGLog: String);
begin
  Inc(FLine,1);
  FrmMainServer.Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS',Date + Time) + ' ::'+FLine.ToString+': ' + AMSGLog);
end;

constructor TLogTxt.Create;
begin
  raise Exception.Create('Para Obter uma Instância de '+Self.ClassName+', use Get');
end;

constructor TLogTxt.CreatePrivate;
begin
  CriarArquivoLog;
end;

procedure TLogTxt.CriarArquivoLog;
begin
  FrmMainServer.Log.Lines.Add(FormatDateTime('DD/MM/YYYY HH:MM:SS', Date+Time) + ' ::: Arquivo de Log Inicializado.');
end;

destructor TLogTxt.Destroy;
begin
  inherited;
end;

class function TLogTxt.Get: TLogTxt;
begin
  if not Assigned(FInstance) then
  begin
    FLine := -1;
    FInstance := TLogTxt.CreatePrivate;
  end;
  Result := FInstance;
end;

procedure TLogTxt.OnTimerTimer(Sender: TObject);
begin
end;

procedure TLogTxt.ZeraArquivo;
begin
  FrmMainServer.Log.Clear;
end;

initialization

finalization
 if Assigned(TLogTxt.FInstance) then
   FreeAndNil(TLogTxt.FInstance);

end.
