{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                    TPlannerDataModule                 }
{                                                       }
{   Copyright (c) 2015-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PlannerToolCtrlsEh;

interface

uses
  SysUtils, Classes, ImgList, Controls, Dialogs;

type
  TPlannerDataMod = class(TDataModule)
    PlannerImList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlannerDataMod: TPlannerDataMod;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

initialization
  PlannerDataMod := TPlannerDataMod.CreateNew(nil, -1);
  InitInheritedComponent(PlannerDataMod, TDataModule);
finalization
  FreeAndNil(PlannerDataMod);
end.
