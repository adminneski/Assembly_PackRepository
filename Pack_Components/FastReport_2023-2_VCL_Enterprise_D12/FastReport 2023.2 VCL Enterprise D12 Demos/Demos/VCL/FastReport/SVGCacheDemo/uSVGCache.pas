unit uSVGCache;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls,
  frxClass, frSVGGraphic, frCoreClasses,
  uDemoMain;

type
  TfrmSVGCache = class(TfrmDemoMain)
    PreviewButton: TButton;
    frxReport1: TfrxReport;
    UserDataSet: TfrxUserDataSet;
    CachedPreviewButton: TButton;
    PreviewTimeLabel: TLabel;
    AutoCloseCheckBox: TCheckBox;
    CachedPreviewLabel: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PreviewButtonClick(Sender: TObject);
    procedure CachedPreviewButtonClick(Sender: TObject);
    procedure frxReport1ProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure frxReport1ProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);

    procedure UserDataSetGetValue(const VarName: string; var Value: Variant);
  protected
    FPictureView: TfrxPictureView;
    FSVGList: TStringList;
    FStartTick: Cardinal;
    FTimeStr: string;
    FSVGGraphicCache: TfrxSVGGraphicCache;
    FUseCache: Boolean;

    procedure LoadSVGImages;
    procedure ShowReport(TimeLabel: TLabel);
    function GetCaption: string; override;
  end;

var
  frmSVGCache: TfrmSVGCache;

implementation

uses
  frxExportHelpers, frxPreview;

{$R *.dfm}

procedure TfrmSVGCache.CachedPreviewButtonClick(Sender: TObject);
begin
  FUseCache := True;
  ShowReport(CachedPreviewLabel);
end;

procedure TfrmSVGCache.PreviewButtonClick(Sender: TObject);
begin
  FUseCache := False;
  ShowReport(PreviewTimeLabel);
end;

procedure TfrmSVGCache.ShowReport(TimeLabel: TLabel);
begin
  FPictureView := frxReport1.FindObject('PictureView') as TfrxPictureView;
  frxReport1.ShowReport;
  TimeLabel.Caption := FTimeStr;
end;

procedure TfrmSVGCache.LoadSVGImages;
var
  SearchRec: TSearchRec;
  Dir: TFileName;
  i: Integer;
  SVGStream: TMemoryStream;
  FileStream: TFileStream;
begin
  FSVGList.Clear;
  Dir := GetCurrentDir + '\SVG\';
  i := FindFirst(Dir + '*.SVG', faArchive, SearchRec);
  try
    while i = 0 do
    begin
      FileStream := TFileStream.Create(Dir + SearchRec.Name, fmOpenRead);
      SVGStream := TMemoryStream.Create;
      SVGStream.CopyFrom(FileStream, 0);
      FileStream.Free;

      FSVGList.AddObject(SearchRec.Name, SVGStream);
      i := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;
  UserDataSet.RangeEndCount := 3 * FSVGList.Count;
end;


procedure TfrmSVGCache.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  for i := 0 to FSVGList.Count - 1 do
    FSVGList.Objects[i].Free;
  FSVGList.Free;
  
  FSVGGraphicCache.Free;
end;

procedure TfrmSVGCache.FormCreate(Sender: TObject);
begin
  frxReport1.LoadFromFile('Test.fr3');

  FSVGList := TStringList.Create;
  FSVGGraphicCache := TfrxSVGGraphicCache.Create;
  LoadSVGImages;
end;

procedure TfrmSVGCache.frxReport1ProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  FStartTick := GetTickCount;
end;

procedure TfrmSVGCache.frxReport1ProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  FTimeStr := 'Time: ' + Float2Str((GetTickCount - FStartTick) / 1000, 3) + ' sec.';

  if AutoCloseCheckBox.Checked and not TfrxPreviewForm(frxReport1.PreviewForm).IsClosing then
    frxReport1.PreviewForm.Close;
end;

function TfrmSVGCache.GetCaption: string;
begin
  Result := 'SVG Cache Demo';
end;

procedure TfrmSVGCache.UserDataSetGetValue(const VarName: string; var Value: Variant);
var
  ItemLabel: string;
  SVGStream: TMemoryStream;
  RecNo: Integer;
begin
  if FSVGList.Count = 0 then
    Exit;

  RecNo := UserDataSet.RecNo mod FSVGList.Count;

  ItemLabel := FSVGList[RecNo];

  if CompareText(VarName, 'FileName') = 0 then
  begin
    Value := ItemLabel;

    SVGStream := TMemoryStream(FSVGList.Objects[RecNo]);
    SVGStream.Position := 0;

    if FUseCache then
      FPictureView.Picture.Graphic := FSVGGraphicCache.GraphicFromStream(SVGStream)
    else
      FPictureView.LoadPictureFromStream(SVGStream);
  end;
end;

end.
