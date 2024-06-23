
{******************************************}
{                                          }
{             FastReport VCL               }
{              Tool controls               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

/// <summary>
///   This unit contains classes of the base dialog form used for every form in
///   FastReport. This form handles save and load state, HIDPI messages,
///   localization messages.
/// </summary>
unit frxBaseForm;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}Windows, Messages, {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, IniFiles, frBaseForm
{$IFDEF FPC}
  , LResources, LCLType, LMessages, LCLIntf, LCLProc, LazarusPackageIntf, LazHelper
{$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

type
  /// <summary>
  ///   The base class for dialog forms used in FastReport. This class handles
  ///   save and load state, HIDPI messages,localization messages.
  /// </summary>
  TfrxBaseForm = class(TfrBaseForm)
  public
    procedure UpdateFormPPI(aNewPPI: Integer); override;
  end;

  /// <summary>
  ///   The base class for the forms which should save position and sized by
  ///   default to setting storage(registry).
  /// </summary>
  TfrxBaseLoadSavePrefForm = class(TfrxBaseForm)
  protected
    function GetAvailablePreferences: TfrxPreferencesTypes; override;
  end;

implementation

uses
  frxRes;

{ TfrxBaseForm }

procedure TfrxBaseForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited UpdateFormPPI(aNewPPI);
  frxImages.ImagesPPI := aNewPPI;
end;

{ TfrxBaseLoadSavePrefForm }

function TfrxBaseLoadSavePrefForm.GetAvailablePreferences: TfrxPreferencesTypes;
begin
  Result := [frPtFormPos, frPtFormSize, frPtFormCustom];
end;

end.
