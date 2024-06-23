
{******************************************}
{                                          }
{             FastReport VCL               }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRegIntIO;

{$I frx.inc}
{$R *.dcr} //Repacked Version Line added
interface


procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, frxReg,
{$IFNDEF DELPHI6}
  DsgnIntf,
{$ELSE}
  DesignIntf, DesignEditors,
{$ENDIF}
  frxRes, frxIOTransportHelpers, frxIOTransportDropbox, frxIOTransportOneDrive,
  frxIOTransportBoxCom, frxIOTransportGoogleDrive, frxIOTransportGMail, frxIOTransportYandexDisk,
  frxIOTransportOutlook;

type
  TfrxHTTPSTransportsEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage + ' Internet Transports',
    [TfrxDropboxIOTransport, TfrxOneDriveIOTransport, TfrxBoxComIOTransport, TfrxGoogleDriveIOTransport,
    TfrxGMailIOTransport, TfrxYandexDiskIOTransport, TfrxOutlookIOTransport]);

  RegisterComponentEditor(TfrxDropboxIOTransport, TfrxHTTPSTransportsEditor);
  RegisterComponentEditor(TfrxOneDriveIOTransport, TfrxHTTPSTransportsEditor);
  RegisterComponentEditor(TfrxBoxComIOTransport, TfrxHTTPSTransportsEditor);
  RegisterComponentEditor(TfrxGoogleDriveIOTransport, TfrxHTTPSTransportsEditor);
  RegisterComponentEditor(TfrxGMailIOTransport, TfrxHTTPSTransportsEditor);
  RegisterComponentEditor(TfrxYandexDiskIOTransport, TfrxHTTPSTransportsEditor);
  RegisterComponentEditor(TfrxOutlookIOTransport, TfrxHTTPSTransportsEditor);
end;

{ TfrxHTTPSTransportsEditor }

procedure TfrxHTTPSTransportsEditor.ExecuteVerb(Index: Integer);
var
  LDialog: TfrxBaseTransportDialog;
  LTransport: TfrxInternetIOTransport;
begin
  if not (Component is TfrxInternetIOTransport) then Exit;
  LTransport := TfrxInternetIOTransport(Component);
  LDialog := TfrxBaseTransportDialog(LTransport.TransportDialogClass.NewInstance);
  LDialog.Create(nil);
  try
    LDialog.InitControlsFromFilter(LTransport);
    if LDialog.ShowModal = mrOK then
    begin
      LDialog.InitFilterFromDialog(LTransport);
    end;
  finally
    LDialog.Free;
  end;
end;

function TfrxHTTPSTransportsEditor.GetVerb(Index: Integer): String;
begin
  Result := 'Edit connection';
end;

function TfrxHTTPSTransportsEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

end.
