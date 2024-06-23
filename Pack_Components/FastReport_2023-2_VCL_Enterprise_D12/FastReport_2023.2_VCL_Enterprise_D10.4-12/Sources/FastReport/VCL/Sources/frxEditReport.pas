
{******************************************}
{                                          }
{             FastReport VCL               }
{             Report options               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxEditReport;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, frxBaseForm
  {$IFDEF FPC}
  , LCLType, IniFiles
  {$ELSE}
  , frxCtrls, FileCtrl
  {$ENDIF}
{$IFDEF DELPHI6}
, Variants
{$ENDIF};
  

type
  TfrxReportEditorForm = class(TfrxBaseForm)
    OkB: TButton;
    CancelB: TButton;
    PageControl: TPageControl;
    GeneralTS: TTabSheet;
    DescriptionTS: TTabSheet;
    ReportSettingsL: TGroupBox;
    PrintersLB: TListBox;
    CopiesL: TLabel;
    CopiesE: TEdit;
    CollateCB: TCheckBox;
    GeneralL: TGroupBox;
    PasswordL: TLabel;
    DoublePassCB: TCheckBox;
    PrintIfEmptyCB: TCheckBox;
{$IFDEF FPC}
    DockTop : TCheckBox;
    DockSide: TCheckBox;
{$ENDIF}
    PasswordE: TEdit;
    DescriptionL: TGroupBox;
    Bevel3: TBevel;
    NameL: TLabel;
    PictureImg: TImage;
    Description1L: TLabel;
    PictureL: TLabel;
    AuthorL: TLabel;
    NameE: TEdit;
    DescriptionE: TMemo;
    PictureB: TButton;
    AuthorE: TEdit;
    VersionL: TGroupBox;
    MajorL: TLabel;
    MinorL: TLabel;
    ReleaseL: TLabel;
    BuildL: TLabel;
    CreatedL: TLabel;
    Created1L: TLabel;
    ModifiedL: TLabel;
    Modified1L: TLabel;
    MajorE: TEdit;
    MinorE: TEdit;
    ReleaseE: TEdit;
    BuildE: TEdit;
    InheritTS: TTabSheet;
    InheritGB: TGroupBox;
    InheritStateL: TLabel;
    DetachRB: TRadioButton;
    SelectL: TLabel;
    InheritRB: TRadioButton;
    DontChangeRB: TRadioButton;
    InheritLV: TListView;
    PathLB: TLabel;
    PathE: TEdit;
    BrowseB: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PictureBClick(Sender: TObject);
    procedure PrintersLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure BrowseBClick(Sender: TObject);
    procedure FillTemplatelist;
    procedure PathEKeyPress(Sender: TObject; var Key: Char);
    procedure PageControlChange(Sender: TObject);
{$IFDEF FPC}
    procedure TopSet();
    procedure SideSet();
    procedure DockSave();
    procedure DockLoad();
{$ENDIF}
  private
    { Private declarations }
    FTemplates: TStringList;
  public
    procedure UpdateResouces; override;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    { Public declarations }
  end;


implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses
  frxDesgn, frxEditPicture, frxPrinter, {$IFNDEF FPC}frxUtils,{$ENDIF} frxRes, frxClass;


procedure TfrxReportEditorForm.FormCreate(Sender: TObject);
begin
  FTemplates := TStringList.Create;
  FTemplates.Sorted := True;
  if UseRightToLeftAlignment then
    FlipChildren(True);
  {$IFDEF FPC}
  DockLoad();
  {$ENDIF}
end;

procedure TfrxReportEditorForm.FormDestroy(Sender: TObject);
begin
  FTemplates.Free;
end;

{$IFDEF FPC}
procedure TfrxReportEditorForm.TopSet();
var
  i: Integer;
  DrgKng: TDragKind;
begin
  if (DockTop.Checked) then
    DrgKng := dkDock
  else
    DrgKng := dkDrag;
  with TfrxDesignerForm(Owner) do
    for i:= 0 to ComponentCount-1 do
      if Components[i] is TToolBar then
        TToolBar(Components[i]).DragKind := DrgKng;
end;

procedure TfrxReportEditorForm.SideSet();
begin
  with TfrxDesignerForm(Owner) do
  begin
    if(DockSide.Checked) then
    begin
      RightDockSite.Anchors:= [akBottom, akTop, akLeft];
      RightDockSite.Align  := alLeft;
      LeftDockSite2.Anchors:= [akBottom, akTop, akRight];
      LeftDockSite2.Align  := alRight;
    end
    else
    begin
      RightDockSite.Anchors:= [akBottom, akTop, akRight];
      RightDockSite.Align  := alRight;
      LeftDockSite2.Anchors:= [akBottom, akTop, akLeft];
      LeftDockSite2.Align  := alLeft;
    end;
  end;
end;

procedure TfrxReportEditorForm.DockSave();
var
  MyIniFile: TCustomIniFile;
begin
  MyIniFile := TfrxDesignerForm(Owner).Report.GetIniFile;
  MyIniFile.WriteBool('TfrxReportEditorForm', 'DockTop',  DockTop .Checked);
  MyIniFile.WriteBool('TfrxReportEditorForm', 'DockSide', DockSide.Checked);
  FreeAndNil(MyIniFile);
end;

procedure TfrxReportEditorForm.DockLoad();
var
  MyIniFile: TCustomIniFile;
begin
  MyIniFile := TfrxDesignerForm(Owner).Report.GetIniFile;
  DockTop .Checked := MyIniFile.ReadBool('TfrxReportEditorForm', 'DockTop',  false);
  DockSide.Checked := MyIniFile.ReadBool('TfrxReportEditorForm', 'DockSide', false);
  TopSet ();
  SideSet();
  FreeAndNil(MyIniFile);
end;
{$ENDIF}

procedure TfrxReportEditorForm.FormShow(Sender: TObject);
begin
  with TfrxDesignerForm(Owner).Report do
  begin
    PrintersLB.Items := frxPrinters.Printers;
    PrintersLB.Items.Insert(0, frxResources.Get('prDefault'));
    PrintersLB.ItemIndex := PrintersLB.Items.IndexOf(PrintOptions.Printer);
    CollateCB.Checked := PrintOptions.Collate;
    CopiesE.Text := IntToStr(PrintOptions.Copies);
    DoublePassCB.Checked := EngineOptions.DoublePass;
    PrintIfEmptyCB.Checked := EngineOptions.PrintIfEmpty;
    if ReportOptions.HiddenPassword = '' then
      PasswordE.Text := ReportOptions.Password
    else
    begin
      PasswordE.Enabled := False;
      PasswordE.Color := clGray;
    end;

    if Trim(ParentReport) = '' then
    begin
      InheritStateL.Caption := frxResources.Get('riNotInherited');
      DetachRB.Enabled := False;
    end
    else
      InheritStateL.Caption := Format(frxResources.Get('riInherited'), [ParentReport]);

    FillTemplatelist;
    NameE.Text := ReportOptions.Name;
    AuthorE.Text := ReportOptions.Author;
    DescriptionE.Lines.Text := ReportOptions.Description.Text;
    PictureImg.Picture.Assign(ReportOptions.Picture);
    PictureImg.Stretch := (PictureImg.Picture.Width > PictureImg.Width) or
      (PictureImg.Picture.Height > PictureImg.Height);

    MajorE.Text := ReportOptions.VersionMajor;
    MinorE.Text := ReportOptions.VersionMinor;
    ReleaseE.Text := ReportOptions.VersionRelease;
    BuildE.Text := ReportOptions.VersionBuild;
    Created1L.Caption := DateTimeToStr(ReportOptions.CreateDate);
    Modified1L.Caption := DateTimeToStr(ReportOptions.LastChange);
  end;
end;

procedure TfrxReportEditorForm.FormHide(Sender: TObject);
var
  templ: String;
begin
  if ModalResult = mrOk then
    with TfrxDesignerForm(Owner).Report do
    begin
      if PrintersLB.ItemIndex <> -1 then
      begin
        PrintOptions.Printer := PrintersLB.Items[PrintersLB.ItemIndex];
        SelectPrinter;
      end;
      PrintOptions.Collate := CollateCB.Checked;
      PrintOptions.Copies := StrToInt(CopiesE.Text);
      EngineOptions.DoublePass := DoublePassCB.Checked;
      EngineOptions.PrintIfEmpty := PrintIfEmptyCB.Checked;

      if ReportOptions.HiddenPassword = '' then
        ReportOptions.Password := PasswordE.Text;

      if not DontChangeRB.Checked then
      begin
        Designer.Lock;
        try
          if DetachRB.Checked then
            ParentReport := ''
          else if InheritRB.Checked and (InheritLV.Selected <> nil) then
          begin
            ParentReport := '';
{$IFDEF FPC}
            templ := FTemplates[PtrInt(TObject(InheritLV.Selected.Data))];
{$ELSE}
            templ := FTemplates[Integer(InheritLV.Selected.Data)];
{$ENDIF}
            InheritFromTemplate(templ);
          end;
        finally
          Designer.ReloadReport;
        end;
      end;

      ReportOptions.Name := NameE.Text;
      ReportOptions.Author := AuthorE.Text;
      ReportOptions.Description.Text := DescriptionE.Lines.Text;
      ReportOptions.Picture.Assign(PictureImg.Picture);
      ReportOptions.VersionMajor := MajorE.Text;
      ReportOptions.VersionMinor := MinorE.Text;
      ReportOptions.VersionRelease := ReleaseE.Text;
      ReportOptions.VersionBuild := BuildE.Text;
    end;
end;

procedure TfrxReportEditorForm.PictureBClick(Sender: TObject);
begin
  with TfrxPictureEditorForm.Create(Owner) do
  begin
    Image.Picture.Assign(PictureImg.Picture);
    if ShowModal = mrOk then
    begin
      PictureImg.Picture.Assign(Image.Picture);
      PictureImg.Stretch := (PictureImg.Picture.Width > PictureImg.Width) or
        (PictureImg.Picture.Height > PictureImg.Height);
    end;
    Free;
  end;
end;

procedure TfrxReportEditorForm.PrintersLBDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  s: String;
begin
  with PrintersLB.Canvas do
  begin
    FillRect(ARect);
    frxImages.PreviewButtonImages.Draw(PrintersLB.Canvas, ARect.Left + 2, ARect.Top, 2);
    s := PrintersLB.Items[Index];
    if (Index <> 0) and (frxPrinters[Index - 1].Port <> '') then
      s := s + ' ' + frxResources.Get('rePrnOnPort') + ' ' + frxPrinters[Index - 1].Port;
    TextOut(ARect.Left + frxImages.PreviewButtonImages.Width + 8, ARect.Top + 1, s);
  end;
end;

procedure TfrxReportEditorForm.UpdateFormPPI(aNewPPI: Integer);
begin
  inherited;
  InheritLV.LargeImages := frxImages.WizardImages;
end;

procedure TfrxReportEditorForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(4700);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  GeneralTS.Caption := frxGet(4701);
  ReportSettingsL.Caption := frxGet(4702);
  CopiesL.Caption := frxGet(4703);
  GeneralL.Caption := frxGet(4704);
  PasswordL.Caption := frxGet(4705);
  CollateCB.Caption := frxGet(4706);
  DoublePassCB.Caption := frxGet(4707);
  PrintIfEmptyCB.Caption := frxGet(4708);
  DescriptionTS.Caption := frxGet(4709);
  NameL.Caption := frxGet(4710);
  Description1L.Caption := frxGet(4711);
  PictureL.Caption := frxGet(4712);
  AuthorL.Caption := frxGet(4713);
  MajorL.Caption := frxGet(4714);
  MinorL.Caption := frxGet(4715);
  ReleaseL.Caption := frxGet(4716);
  BuildL.Caption := frxGet(4717);
  CreatedL.Caption := frxGet(4718);
  ModifiedL.Caption := frxGet(4719);
  DescriptionL.Caption := frxGet(4720);
  VersionL.Caption := frxGet(4721);
  PictureB.Caption := frxGet(4722);
  InheritTS.Caption := frxGet(4728);
  InheritGB.Caption := frxGet(4723);
  SelectL.Caption := frxGet(4724);
  DontChangeRB.Caption := frxGet(4725);
  DetachRB.Caption := frxGet(4726);
  InheritRB.Caption := frxGet(4727);
  PathLB.Caption := frxGet(4729);
{$IFDEF FPC}
  DockTop.Caption := frxGet(5715);
  DockSide.Caption := frxGet(5716);
{$ENDIF}
end;

procedure TfrxReportEditorForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxReportEditorForm.BrowseBClick(Sender: TObject);
var
  FolderName: String;
begin
  if
    SelectDirectory('Select folder', PathE.Text, FolderName) then
  begin
    TfrxDesignerForm(Owner).TemplatePath := FolderName;
    FillTemplatelist;
  end;
end;

procedure TfrxReportEditorForm.FillTemplatelist;
var
{$IFDEF FPC}
  i: PtrInt;
{$ELSE}
  i: Integer;
{$ENDIF}
  lvItem: TListItem;
begin
  PathE.Text := TfrxDesignerForm(Owner).TemplatePath;
  TfrxDesignerForm(Owner).GetTemplateList(FTemplates);
  InheritLV.Items.Clear;
  for i := 0 to FTemplates.Count - 1 do
    begin
      lvItem := InheritLV.Items.Add;
      lvItem.Caption := ExtractFileName(FTemplates[i]);
{$IFDEF FPC}
      lvItem.Data := TObject(i);
{$ELSE}
      lvItem.Data := Pointer(i);
{$ENDIF}
      lvItem.ImageIndex := 5;
    end;
end;

procedure TfrxReportEditorForm.PathEKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    if DirectoryExists(PathE.Text) then
    begin
      TfrxDesignerForm(Owner).TemplatePath := PathE.Text;
      FillTemplatelist;
    end;
end;

procedure TfrxReportEditorForm.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = InheritTS then
    OkB.Default := False
  else OkB.Default := True;
end;

end.
