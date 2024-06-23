{******************************************}
{                                          }
{             FastReport VCL               }
{         Default open/save dialog         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportDialog;

interface

{$I frx.inc}

uses
  SysUtils, Classes, frxClass, Dialogs
{$IFDEF FPC}
    , LCLType, LazHelper, LCLProc
{$ENDIF}
{$IFDEF DELPHI6}
    , Variants
{$ENDIF};

type
  TfrxIOTransportFileDialog = class(TfrxIOTransportFile)
  private
    FSaveDialog: TOpenDialog;
    FFilter: TfrxCustomIOTransport;
  protected
    procedure SetVisibility(const Value: TfrxFilterVisibility); override;
  public
    function OpenFilter: Boolean; override;
    procedure CloseFilter; override;
    function GetStream(aFileName: String = ''): TStream; override;
    procedure FreeStream(aStream: TStream; const aFileName: String = ''); override;
    class function GetDescription: String; override;
    function DoFilterProcessStream(aStream: TStream; ProcesssingObject: TObject): Boolean; override;
  end;

implementation

uses frxUtils, frxRes, frxIOTransportIntf;

var
  DefaultFileDialogFilter: TfrxIOTransportFileDialog = nil;

{ TfrxIOTransportFileDialog }

procedure TfrxIOTransportFileDialog.CloseFilter;
begin
  Inherited;
  FreeAndNil(FFilter);
  if FSaveDialog <> nil then
    FreeAndNil(FSaveDialog);
end;

function TfrxIOTransportFileDialog.DoFilterProcessStream(aStream: TStream; ProcesssingObject: TObject): Boolean;
begin
  Result := inherited DoFilterProcessStream(aStream, ProcesssingObject);
  if FFilter <> nil then
    Result := FFilter.DoFilterProcessStream(aStream, ProcesssingObject);
end;

procedure TfrxIOTransportFileDialog.FreeStream(aStream: TStream;
  const aFileName: String);
begin
  if FFilter <> nil then
    FFilter.FreeStream(aStream, aFileName)
  else
    inherited;
end;

class function TfrxIOTransportFileDialog.GetDescription: String;
begin
  Result := frxGet(163);
end;

function TfrxIOTransportFileDialog.GetStream(aFileName: String): TStream;
begin
  if FFilter <> nil then
    Result := FFilter.GetStream(aFileName)
  else
    Result := Inherited GetStream(aFileName);
end;

function TfrxIOTransportFileDialog.OpenFilter: Boolean;
var
  FilterList: TStringList;
  i: Integer;
  fName: String;
begin
  Result := False;
  if FilterAccess = faRead then
    FSaveDialog := TOpenDialog.Create(nil)
  else
    FSaveDialog := TSaveDialog.Create(nil);
  if OverwritePrompt then
    FSaveDialog.Options := FSaveDialog.Options + [ofOverwritePrompt];
  FSaveDialog.DefaultExt := DefaultExt;

  // if (Report <> nil) and (frxCompressorClass <> nil) then
  // begin
  // FilterString := FilterString + '|' +
  // frxResources.Get('dsComprRepFilter');
  // //Inc(FilterCount);
  //
  // if Report.ReportOptions.Compressed then
  // FSaveDialog.FilterIndex := 2
  // else
  // FSaveDialog.FilterIndex := 1;
  //
  // end;

  if (FileName = '') and (Report <> nil) then
    FileName := ChangeFileExt
      (ExtractFileName(frxUnixPath2WinPath(Report.FileName)), DefaultExt);

  fName := ExtractFileName(FileName);
  i := LastDelimiter('.', fName);
  if i > 0 then fName := Copy(fName, 1, i - 1);
  FSaveDialog.FileName := fName;
  FilterList := TStringList.Create;
  try
    FillItemsList(FilterList, GetFilterDialogVisibility(FCreatedFrom));
    for i := 0 to FilterList.Count - 1 do
    begin
      FilterList.Objects[i] := TfrxCustomIOTransport(FilterList.Objects[i]).CreateFilterClone(FCreatedFrom);
      if FilterString <> '' then
        FilterString := FilterString + '|';

      FilterString := FilterString + TfrxCustomIOTransport(FilterList.Objects[i])
        .FilterString;

    end;
    FSaveDialog.Filter := FilterString;

    if ExtractFilePath(FileName) <> '' then
      FSaveDialog.InitialDir := ExtractFilePath(FileName)
    else if DefaultPath <> '' then
      FSaveDialog.InitialDir := DefaultPath;
    if FSaveDialog.Execute then
    begin
      FileName := FSaveDialog.FileName;
      BasePath := ExtractFilePath(FileName);
      // if Report <> nil then
      // Report.ReportOptions.Compressed := FSaveDialog.FilterIndex = 2;
      Result := True;
      i := FSaveDialog.FilterIndex - 2;
      if i >= 0 then
      begin
        FFilter := TfrxCustomIOTransport(FilterList.Objects[i]);
        FFilter.FilterAccess := FilterAccess;
        FFilter.Report := Report;
        FileName := ChangeFileExt(FileName, FFilter.DefaultExt);
        FFilter.BasePath := BasePath;
        FFilter.FileName := FileName;
        Result := FFilter.OpenFilter;
      end;
    end;
  finally
    for i := 0 to FilterList.Count - 1 do
      if FFilter <> FilterList.Objects[i] then
        FilterList.Objects[i].Free;
    FilterList.Free;
  end;
end;

procedure TfrxIOTransportFileDialog.SetVisibility
  (const Value: TfrxFilterVisibility);
begin
  FVisibility := Value;
end;

initialization
  if frxDefaultIODialogTransportClass = nil then
    frxDefaultIODialogTransportClass := TfrxIOTransportFileDialog;
  if DefaultFileDialogFilter = nil then
  begin
    DefaultFileDialogFilter := TfrxIOTransportFileDialog(frxDefaultIODialogTransportClass.CreateNoRegister);
    frxIOTransports.Register(DefaultFileDialogFilter);
  end;

finalization
  if DefaultFileDialogFilter <> nil then
    FreeAndNil(DefaultFileDialogFilter);

end.
