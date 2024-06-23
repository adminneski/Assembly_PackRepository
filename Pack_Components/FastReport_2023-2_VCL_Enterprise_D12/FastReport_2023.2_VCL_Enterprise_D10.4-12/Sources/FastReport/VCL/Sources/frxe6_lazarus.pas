{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit frxe_lazarus;

{$warn 5023 off : no warning about unused units}
interface

uses
  frxExportMatrix, frxExportHTMLDiv, frxExportODF, frxExportImage, 
  frxExportText, frxPreProgramClass, frxImageConverter, frxeReg, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('frxeReg', @frxeReg.Register);
end;

initialization
  RegisterPackage('frxe_lazarus', @Register);
end.
