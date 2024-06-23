
{******************************************}
{                                          }
{             FastReport VCL               }
{      Language resources management       }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRes;

interface

{$I frx.inc}

uses
  SysUtils, Classes, TypInfo,
  {$IFDEF FR_COM}
  ComObj, FastReport_TLB, DispatchablePersistent,
  {$ENDIF}
  Controls, Buttons, Graphics,
  frResources, frCore, frGraphics;

type
  { TfrxImageResources }

  TfrxImageResources = class(TfrImageResources)
  private
    FDisabledButtonImages: TImageList;
    FMainButtonImages: TImageList;
    FPreviewButtonImages: TImageList;
    FObjectImages: TImageList;
    FWizardImages: TImageList;
    function GetDisabledButtonImages: TImageList;
    function GetMainButtonImages: TImageList;
    function GetPreviewButtonImages: TImageList;
    function GetObjectImages: TImageList;
    function GetWizardImages: TImageList;
  protected
    procedure ClearFields; override;
  public
    procedure SetButtonImages(Images: TBitmap; Clear: Boolean = False);
    procedure SetObjectImages(Images: TBitmap; Clear: Boolean = False);
    procedure SetPreviewButtonImages(Images: TBitmap; Clear: Boolean = False);
    procedure SetSpeedButtonGlyph(AButton: TSpeedButton; AIndex: Integer);  //delete fix for Transperent when WinLaz fix it.
    procedure SetWizardImages(Images: TBitmap; Clear: Boolean = False);

    property DisabledButtonImages: TImageList read GetDisabledButtonImages;
    property MainButtonImages: TImageList read GetMainButtonImages;
    property PreviewButtonImages: TImageList read GetPreviewButtonImages;
    property ObjectImages: TImageList read GetObjectImages;
    property WizardImages: TImageList read GetWizardImages;
    property ImagesPPI;
  end;


function frxImages: TfrxImageresources;
function frxGet(ID: Integer): String;
function frxResources: TfrStringResources;

implementation

uses
  frLocalization,
  fs_iconst;

const
  FHelpTopics: array[0..16] of TfrHelpTopic = (
    (Sender: 'TfrxDesignerForm'; Topic: 'Designer.htm'),
    (Sender: 'TfrxOptionsEditor'; Topic: 'Designer_options.htm'),
    (Sender: 'TfrxReportEditorForm'; Topic: 'Report_options.htm'),
    (Sender: 'TfrxPageEditorForm'; Topic: 'Page_options.htm'),
    (Sender: 'TfrxCrossEditorForm'; Topic: 'Cross_tab_reports.htm'),
    (Sender: 'TfrxChartEditorForm'; Topic: 'Diagrams.htm'),
    (Sender: 'TfrxSyntaxMemo'; Topic: 'Script.htm'),
    (Sender: 'TfrxDialogPage'; Topic: 'Dialogue_forms.htm'),
    (Sender: 'TfrxDialogComponent'; Topic: 'Data_access_components.htm'),
    (Sender: 'TfrxVarEditorForm'; Topic: 'Variables.htm'),
    (Sender: 'TfrxHighlightEditorForm'; Topic: 'Conditional_highlighting.htm'),
    (Sender: 'TfrxSysMemoEditorForm'; Topic: 'Inserting_aggregate_function.htm'),
    (Sender: 'TfrxFormatEditorForm'; Topic: 'Values_formatting.htm'),
    (Sender: 'TfrxGroupEditorForm'; Topic: 'Report_with_groups.htm'),
    (Sender: 'TfrxPictureEditorForm'; Topic: 'Picture_object.htm'),
    (Sender: 'TfrxMemoEditorForm'; Topic: 'Text_object.htm'),
    (Sender: 'TfrxSQLEditorForm'; Topic: 'TfrxADOQuery.htm'));

type
  TfrStringResourcesAccess = class(TfrStringResources);

  { TfrxStringResourcesChangedListener }

  TfrxStringResourcesChangedListener = class(TfrStringResourcesChangedListener)
  protected
    procedure ResourcesChanged(AResources: TfrStringResources); override;
  end;

var
  FImages: TfrxImageresources;
  FListener: TfrxStringResourcesChangedListener;

{ TfrxStringResourcesChangedListener }

procedure TfrxStringResourcesChangedListener.ResourcesChanged(AResources: TfrStringResources);
begin
  SLangNotFound := AResources.Get('SLangNotFound');
  SInvalidLanguage := AResources.Get('SInvalidLanguage');
  SIdRedeclared := AResources.Get('SIdRedeclared');
  SUnknownType := AResources.Get('SUnknownType');
  SIncompatibleTypes := AResources.Get('SIncompatibleTypes');
  SIdUndeclared := AResources.Get('SIdUndeclared');
  SClassRequired := AResources.Get('SClassRequired');
  SIndexRequired := AResources.Get('SIndexRequired');
  SStringError := AResources.Get('SStringError');
  SClassError := AResources.Get('SClassError');
  SArrayRequired := AResources.Get('SArrayRequired');
  SVarRequired := AResources.Get('SVarRequired');
  SNotEnoughParams := AResources.Get('SNotEnoughParams');
  STooManyParams := AResources.Get('STooManyParams');
  SLeftCantAssigned := AResources.Get('SLeftCantAssigned');
  SForError := AResources.Get('SForError');
  SEventError := AResources.Get('SEventError');
end;

{ TfrxImageResources }

procedure TfrxImageResources.SetButtonImages(Images: TBitmap; Clear: Boolean = False);
begin
  AssignImages(Images, DefaultToolBarImageWidth, DefaultToolBarImageHeight, MainButtonImages, DisabledButtonImages, Clear);
end;

procedure TfrxImageResources.SetObjectImages(Images: TBitmap; Clear: Boolean = False);
begin
  AssignImages(Images, DefaultToolBarImageWidth, DefaultToolBarImageHeight, ObjectImages, nil, Clear);
end;

procedure TfrxImageResources.SetPreviewButtonImages(Images: TBitmap; Clear: Boolean = False);
begin
  AssignImages(Images, DefaultToolBarImageWidth, DefaultToolBarImageHeight, PreviewButtonImages, nil, Clear);
end;

procedure TfrxImageResources.SetSpeedButtonGlyph(AButton: TSpeedButton; AIndex: Integer);
begin
  SetSpeedButtonGlyphFromImageList(AButton, AIndex, MainButtonImages, DisabledButtonImages);
end;

procedure TfrxImageResources.SetWizardImages(Images: TBitmap; Clear: Boolean = False);
begin
  AssignImages(Images, DefaultLargeImageWidth, DefaultLargeImageHeight, WizardImages, nil, Clear);
end;

function TfrxImageResources.GetDisabledButtonImages: TImageList;
begin
  Result := CheckImageList(HInstance, FDisabledButtonImages, 'DisabledImages', '');
end;

function TfrxImageResources.GetMainButtonImages: TImageList;
begin
  Result := CheckImageList(HInstance, FMainButtonImages,
    'MainButton', 'DesgnButtons', SetButtonImages);
end;

function TfrxImageResources.GetPreviewButtonImages: TImageList;
begin
  Result := CheckImageList(HInstance, FPreviewButtonImages,
    'PreviewImages', 'PreviewButtons', SetPreviewButtonImages);
end;

function TfrxImageResources.GetObjectImages: TImageList;
begin
  Result := CheckImageList(HInstance, FObjectImages,
    'ObjectImages', 'ObjectButtons', SetObjectImages);
end;

function TfrxImageResources.GetWizardImages: TImageList;
begin
  Result := CheckImageList(HInstance, FWizardImages,
   'WizardImages', 'WizardButtons', SetWizardImages, 32, 32);
end;

procedure TfrxImageResources.ClearFields;
begin
  FDisabledButtonImages := nil;
  FMainButtonImages := nil;
  FPreviewButtonImages := nil;
  FObjectImages := nil;
  FWizardImages := nil;
end;

//
function frxImages: TfrxImageResources;
begin
  if FImages = nil then
    FImages := TfrxImageResources.Create;
  Result := FImages;
end;

function frxResources: TfrStringResources;
begin
  Result := frStringResources;
end;

function frxGet(ID: Integer): String;
begin
  Result := frxResources.Get(IntToStr(ID));
end;

procedure RegisterHelpTopics;
var
  I: Integer;
begin
  for I := 0 to Length(FHelpTopics) - 1 do
    TfrStringResourcesAccess(frxResources).RegisterHelpTopic(FHelpTopics[I]);
end;

procedure UnregisterHelpTopics;
var
  I: Integer;
begin
  for I := 0 to Length(FHelpTopics) - 1 do
    TfrStringResourcesAccess(frxResources).UnregisterHelpTopic(FHelpTopics[I].Sender);
end;

initialization
  FListener := TfrxStringResourcesChangedListener.Create;
  frxResources.AddListener(FListener);
  RegisterHelpTopics;

finalization
  UnregisterHelpTopics;
  frxResources.RemoveListener(FListener);
  FreeAndNil(FListener);
  FreeAndNil(FImages);
end.
