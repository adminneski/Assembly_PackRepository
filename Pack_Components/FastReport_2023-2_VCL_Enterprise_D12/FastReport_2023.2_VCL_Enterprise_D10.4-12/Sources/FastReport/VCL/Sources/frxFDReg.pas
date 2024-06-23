{ --------------------------------------------------------------------------- }
{ AnyDAC FastReport v 6.0 enduser components                                  }
{                                                                             }
{ (c)opyright DA-SOFT Technologies 2004-2013.                                 }
{ All rights reserved.                                                        }
{                                                                             }
{ Initially created by: Serega Glazyrin <glserega@mezonplus.ru>               }
{ Extended by: Francisco Armando Duenas Rodriguez <fduenas@gmail.com>         }
{ --------------------------------------------------------------------------- }
{$I frx.inc}

unit frxFDReg;
{$R *.dcr} //Repacked Version Line added
interface

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, DesignIntf, DesignEditors, frxReg,
  frxFDComponents;

procedure Register;
begin
 RegisterComponents(frxDefaultProductPage, [TfrxFDComponents]);
end;

end.
