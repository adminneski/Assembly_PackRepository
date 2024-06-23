
{******************************************}
{                                          }
{             FastReport VCL               }
{            Registration unit             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRegIntIOIndy;

{$I frx.inc}
{$R *.dcr}  //Repacked Version Line added
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
  frxIOTransportFTP, frxIOTransportDropboxIndy, frxIOTransportOneDriveIndy, 
  frxIOTransportBoxComIndy, frxIOTransportGoogleDriveIndy, frxIOTransportGMailIndy,
  frxIOTransportYandexDiskIndy, frxIOTransportOutlookIndy;

procedure Register;
begin
  RegisterComponents(frxDefaultProductPage + ' Internet Transports',
    [TfrxFTPIOTransport, TfrxDropboxIOTransportIndy, TfrxOneDriveIOTransportIndy, TfrxBoxComIOTransportIndy, TfrxGoogleDriveIOTransportIndy, TfrxGMailIOTransportIndy, TfrxYandexDiskIOTransportIndy, TfrxOutlookIOTransportIndy]);
end;

end.
