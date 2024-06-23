unit Neski_Registrar;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ColRegIni,NSK_DataSet, NSK_DBLocaliza,
  NSK_DBLocalizaPlus, NSK_DBNavigator, NSK_Encryp, NSK_Explorer;


procedure Register;

implementation



// Tutil32;

procedure Register;
begin
  RegisterComponents('Neski Lib ', [TColRegIni,
                                    TNSKDataSet,
                                    TNSKDBLocaliza,
                                    TNSKDBLocalizaPlus,
                                    TNSKDBNavigator,
                                    TNSKEncryp,
                                    TNSKExplorer
                                    ]);
end;

end.
