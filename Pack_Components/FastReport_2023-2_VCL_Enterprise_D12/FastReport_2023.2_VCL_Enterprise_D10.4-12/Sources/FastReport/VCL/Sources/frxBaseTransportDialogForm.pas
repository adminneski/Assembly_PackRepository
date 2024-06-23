
{******************************************}
{                                          }
{              FastReport v6.0             }
{            Save Filter Helpers           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBaseTransportDialogForm;

interface

{$I frx.inc}

uses
  frxClass, frxProgress, Classes, IniFiles, Controls, Forms, StdCtrls,
  frxBaseTransportConnection, frxBaseForm, frxProtocolFactory;

type
  TDirChangeEvent = procedure(Name, Id: String; DirItems: TStrings) of object;
  TDirCreateEvent = procedure(Name: String; DirItems: TStrings) of object;
  TDirDeleteEvent = TDirChangeEvent;
  TFileDeleteEvent = TDirChangeEvent;

  TfrxIOInternetDialogMode = (idmOpen, idmSave, idmDir);

  TfrxBaseTransportDialogForm = class(TfrxBaseForm)
  protected
    FDialogMode: TfrxIOInternetDialogMode;
    FOnFileDelete: TFileDeleteEvent;
    FOnDirChange: TDirChangeEvent;
    FOnDirCreate: TDirCreateEvent;
    FOnDirDelete: TDirDeleteEvent;
    FIOTransport: TComponent;

    procedure SetDialogMode(const Value: TfrxIOInternetDialogMode); virtual;
    function GetFileName: String; virtual; abstract;
    procedure SetFileName(const Value: String); virtual; abstract;
  public
    procedure DisableDelete; virtual;
    property DialogMode: TfrxIOInternetDialogMode read FDialogMode write SetDialogMode;
    property OnFileDelete: TFileDeleteEvent read FOnFileDelete write FOnFileDelete;
    property OnDirChange: TDirChangeEvent read FOnDirChange write FOnDirChange;
    property OnDirCreate: TDirCreateEvent read FOnDirCreate write FOnDirCreate;
    property OnDirDelete: TDirDeleteEvent read FOnDirDelete write FOnDirDelete;
    property IOTransport: TComponent read FIOTransport write FIOTransport;
    property DialogFileName: String read GetFileName write SetFileName;
end;

implementation

procedure TfrxBaseTransportDialogForm.SetDialogMode(const Value: TfrxIOInternetDialogMode);
begin
  FDialogMode := Value;
end;

procedure TfrxBaseTransportDialogForm.DisableDelete;
begin
end;

end.
