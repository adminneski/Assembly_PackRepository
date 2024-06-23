
{******************************************}
{                                          }
{             FastScript v1.9              }
{            Registration unit             }
{                                          }
{  (c) 2003-2019 by Alexander Tzyganenko,  }
{             Fast Reports Inc             }
{                                          }
{******************************************}

unit fs_ifdreg;

{$i fs.inc}
{$R *.dcr}  //Repacked Version Line added

interface


procedure Register;

implementation

uses
  Classes, DesignIntf, Controls, fs_ifdrtti, fs_ireg;

{-----------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(fsDefaultProductPage, [TfsFDRTTI]);
end;

end.
