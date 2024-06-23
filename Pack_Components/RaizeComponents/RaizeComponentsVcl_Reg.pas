{===============================================================================
  RaizeComponentsVcl_Reg Unit

  Raize Components - Registration Unit (Non-Data-Aware Components)

  Copyright © 1995-2015 by Raize Software, Inc.  All Rights Reserved.


  Modification History
  ------------------------------------------------------------------------------
  3.1    (04 Aug 2005)
    * Added code for displaying RC icon on Delphi 2005 Splash Screen.
  ------------------------------------------------------------------------------
  3.0.8  (29 Aug 2003)
    * Added registration code for new TRzStringGrid component.
  ------------------------------------------------------------------------------
  3.0    (20 Dec 2002)
    * Restructred registration process. Separate Register* procedures are called
      for each palette page.
===============================================================================}

{$I RzComps.inc}
{$WARN SYMBOL_DEPRECATED OFF}

unit RaizeComponentsVcl_Reg;

interface

{$IFDEF WIN32}
procedure Register;
{$ENDIF}

implementation

uses
  Forms,
  Classes,
  Controls,
  SysUtils,
  StdCtrls,
  Buttons,
  Dialogs,
  Graphics,
  ImgList,
  Registry,

  {$IFDEF WIN32}
  ToolsAPI,
  DesignIntf,
  TreeIntf,
  VCLEditors,
  FiltEdit,

  { Design Editors }
  RzDesignEditors,
  {$ENDIF}

  { Component Units }
  RzCommon,
  RzGrafx,
  RzTabs;


{$IFDEF WIN32}



{=======================================}
{== RegisterRaizeComponents Procedure ==}
{=======================================}

procedure RegisterRaizeComponents( R: TRegIniFile; const PalettePage: string );
begin
  if R.ReadBool( RegisterSection, 'TRzPageControl', True ) then
  begin
    RegisterComponents( PalettePage, [ TRzPageControl ] );
    RegisterComponentEditor( TRzPageControl, TRzPageControlEditor );
    RegisterComponentEditor( TRzTabSheet, TRzPageControlEditor );

    RegisterPropertyEditor( TypeInfo( TRzTabSheet ), TRzPageControl, 'ActivePage', TRzActivePageProperty );
    RegisterPropertyEditor( TypeInfo( TRzTabSheet ), TRzPageControl, 'ActivePageDefault', TRzActivePageProperty );

//    RegisterPropertyEditor( TypeInfo( TImageIndex ), TRzTabSheet, 'ImageIndex', TRzTabSheetImageIndexProperty );
//    RegisterPropertyEditor( TypeInfo( TImageIndex ), TRzTabSheet, 'DisabledIndex', TRzTabSheetImageIndexProperty );
//
//    RegisterPropertyEditor( TypeInfo( TImageIndex ), TRzTabData, 'ImageIndex', TRzImageIndexProperty );
//    RegisterPropertyEditor( TypeInfo( TImageIndex ), TRzTabData, 'DisabledIndex', TRzImageIndexProperty );

    RegisterSprigType( TRzPageControl, TRzPageControlSprig );
    RegisterSprigType( TRzTabSheet, TRzTabSheetSprig );
  end;

  if R.ReadBool( RegisterSection, 'TRzTabControl', True ) then
  begin
    RegisterComponents( PalettePage, [ TRzTabControl ] );
    RegisterComponentEditor( TRzTabControl, TRzTabControlEditor );
  end;

  if R.ReadBool( RegisterSection, 'TRzRegIniFile', True ) then
    RegisterComponents( PalettePage, [ TRzRegIniFile ] );

  if R.ReadBool( RegisterSection, 'TRzPropertyStore', True ) then
  begin
    RegisterComponents( PalettePage, [ TRzPropertyStore ] );
    RegisterComponentEditor( TRzPropertyStore, TRzPropertyStoreEditor );
    RegisterPropertyEditor( TypeInfo( string ), TRzPropertyItem, 'PropertyName', TRzPropertyItemPropNameProperty );
  end;


end;


{===================================}
{== RegisterRaizePanels Procedure ==}
{===================================}
procedure RegisterRaizePanels( R: TRegIniFile; const PalettePage: string );
begin
end; {= RegisterRaizePanels =}

{==================================}
{== RegisterRaizeEdits Procedure ==}
{==================================}
procedure RegisterRaizeEdits( R: TRegIniFile; const PalettePage: string );
begin

end; {= RegisterRaizeEdits =}


{==================================}
{== RegisterRaizeLists Procedure ==}
{==================================}
procedure RegisterRaizeLists( R: TRegIniFile; const PalettePage: string );
begin

end; {= RegisterRaizeLists =}


{====================================}
{== RegisterRaizeButtons Procedure ==}
{====================================}
procedure RegisterRaizeButtons( R: TRegIniFile; const PalettePage: string );
begin
end; {= RegisterRaizeButtons =}


{====================================}
{== RegisterRaizeDisplay Procedure ==}
{====================================}
procedure RegisterRaizeDisplay( R: TRegIniFile; const PalettePage: string );
begin
end; {= RegisterRaizeDisplay =}


{==================================}
{== RegisterRaizeShell Procedure ==}
{==================================}
procedure RegisterRaizeShell( R: TRegIniFile; const PalettePage: string );
begin
end; {= RegisterRaizeShell =}

{====================================}
{== RegisterRaizeWidgets Procedure ==}
{====================================}
procedure RegisterRaizeWidgets( R: TRegIniFile; const PalettePage: string );
begin
end; {= RegisterRaizeWidgets =}


{======================================}
{== RegisterGeneralEditors Procedure ==}
{======================================}
procedure RegisterGeneralEditors( R: TRegIniFile );
begin
//  if R.ReadBool( RegisterSection, 'Form Editor', True ) then
//    RegisterComponentEditor( TForm, TRzFormEditor );
//
//  if R.ReadBool( RegisterSection, 'Frame Editor', True ) then
//    RegisterComponentEditor( TFrame, TRzFrameEditor );
//
//  if R.ReadBool( RegisterSection, 'ImageList Editor', True ) then
//  begin
//    RegisterComponentEditor( TCustomImageList, TRzImageListEditor );
//    RegisterComponentEditor( TImageList, TRzImageListEditor );
//  end;
//
//  if R.ReadBool( RegisterSection, 'String List Editor', True ) then
//    RegisterPropertyEditor( TypeInfo(TStrings), nil, '', TRzStringListProperty );
//
//  if R.ReadBool( RegisterSection, 'Align Property Editor', True ) then
//    RegisterPropertyEditor( TypeInfo( TAlign ), nil, '', TRzAlignProperty );
//
//  {$IFNDEF VCL140_OR_HIGHER}
//  if R.ReadBool( RegisterSection, 'Boolean Property Editor', True ) then
//    RegisterPropertyEditor( TypeInfo( Boolean ), nil, '', TRzBooleanProperty );
//  {$ENDIF}
//
//  if R.ReadBool( RegisterSection, 'Caption Property Editor', True ) then
//    RegisterPropertyEditor( TypeInfo( TCaption ), TCustomLabel, 'Caption', TRzCaptionProperty );
//
//  if R.ReadBool( RegisterSection, 'Hint Property Editor', True ) then
//    RegisterPropertyEditor( TypeInfo( string ), TComponent, 'Hint', TRzHintProperty );
//
//  if R.ReadBool( RegisterSection, 'GroupItem Caption Property Editor', True ) then
//  begin
//    RegisterPropertyEditor( TypeInfo( TCaption ), TRzGroupItem, 'Caption', TRzGroupItemCaptionProperty );
//    RegisterPropertyEditor( TypeInfo( TCaption ), TRzGroupTemplateItem, 'Caption', TRzGroupTemplateItemCaptionProperty );
//  end;

  // Always Register the About Box & Frame Style Property Editor

//  RegisterPropertyEditor( TypeInfo( TRzAboutInfo ), nil, 'About', TRzAboutBoxProperty );
//  RegisterPropertyEditor( TypeInfo( TFrameStyle ), nil, '', TRzFrameStyleProperty );
//  RegisterPropertyEditor( TypeInfo( TFrameStyleEx ), nil, '', TRzFrameStyleProperty );
end; {= RegisterGeneralEditors =}


{================================================}
{== RegisterCustomPropertyCategories Procedure ==}
{================================================}

procedure RegisterCustomPropertyCategories;
begin
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzFrameController, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzCustomEdit, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzMemo, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzCustomComboBox, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzCustomListBox, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzCustomTreeView, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzCustomListView, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzDirectoryListBox, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzFileListBox, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzDriveComboBox, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzDateTimePicker, 'Color' );
//  RegisterPropertyInCategory( sRzCustomFramingCategoryName, TRzRichEdit, 'Color' );
//  RegisterPropertiesInCategory( sRzCustomFramingCategoryName, [ 'Frame*', 'FlatButtons', 'FlatButtonColor',
//                                                                'FocusColor', 'DisabledColor', 'FramingPreference' ] );
//
//  RegisterPropertiesInCategory( sRzHotSpotCategoryName, [ 'HotSpot*' ] );
//
//  RegisterPropertiesInCategory( sRzBorderStyleCategoryName,
//                                [ 'Border*', 'FlatColor', 'BevelWidth' ] );
//
//  RegisterPropertiesInCategory( sRzCustomGlyphsCategoryName,
//                                [ 'CustomGlyphs', 'TransparentColor', 'WinMaskColor', 'GlyphDownLeft', 'GlyphUpRight',
//                                  'NumGlyphsDownLeft', 'NumGlyphsUpRight', 'UseCustomGlyphs' ] );
//
//  RegisterPropertiesInCategory( sRzTextStyleCategoryName,
//                                [ 'TextStyle', 'Alignment', 'AlignmentVertical', 'Blink*', 'LightTextStyle', 'Rotation',
//                                  'CenterPoint', 'FlyByEnabled', 'FlyByColor', 'Transparent', 'ShadowDepth', 'Layout',
//                                  'Angle', 'HighlightColor', 'ShadowColor', 'ShowAccelChar', 'WordWrap' ] );
//
//  RegisterPropertiesInCategory( sRzTrackStyleCategoryName,
//                                [ 'CustomThumb', 'Track*', 'Thumb*', 'TickStyle', 'ShowTicks', 'ShowFocusRect' ] );
//
//  RegisterPropertiesInCategory( sRzPrimaryButtonCategoryName, TRzButtonEdit, [ 'Button*' ] );
//  RegisterPropertiesInCategory( sRzAlternateButtonCategoryName, TRzButtonEdit, [ 'AltBtn*' ] );
//
//  RegisterPropertiesInCategory( sRzSplitterCategoryName, TRzSplitter,
//                                [ 'FixedPane', 'LowerRight', 'Orientation', 'Position', 'RealTimeDrag', 'SelectedPane',
//                                  'SplitterStyle', 'SplitterWidth', 'UpperLeft', 'UsePercent' ] );
//
//  RegisterPropertyInCategory( sInputCategoryName, TRzTrackBar, 'Position' );
//  RegisterPropertiesInCategory( sInputCategoryName,
//                                [ 'AllowKeyEdit', 'AllowEdit', 'AllowDeleteByKbd', 'TabOnEnter', 'Text', 'Percent',
//                                  'PercentMin', 'PercentMax', 'Min', 'Max', 'MinValue', 'MaxValue', 'PartsComplete',
//                                  'TotalParts', 'MarginMin', 'MarginMax', 'Value' ] );
//
//  RegisterPropertiesInCategory( sVisualCategoryName, TComponent,
//                                [ 'NumSegments', 'InteriorOffset', 'Orientation', 'BarStyle',
//                                  'ThemeAware', 'UseGradients', 'GroupBorderSize', 'FlatColor', 'FlatColorAdjustment' ] );
//
//  RegisterPropertyInCategory( sDragNDropCategoryName, 'ShowDockClientCaptions' );
//
//  RegisterPropertyInCategory( sActionCategoryName, 'IgnoreActionCaption' );
//
//  // Localizable Properties
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzRadioGroup,
//                                [ 'Items', 'Columns' ] );
//
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzColorEdit,
//                                [ 'CustomColorCaption', 'DefaultColorCaption', 'NoColorCaption' ] );
//
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzColorPicker,
//                                [ 'CustomColorCaption', 'DefaultColorCaption', 'NoColorCaption' ] );
//
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzTimePicker,
//                                [ 'CaptionAM', 'CaptionPM', 'CaptionSet' ] );
//
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzCalendar,
//                                [ 'CaptionClearBtn', 'CaptionTodayBtn', 'NoColorCaption' ] );
//
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzDateTimeEdit,
//                                [ 'CaptionAM', 'CaptionPM', 'CaptionSet', 'CaptionClearBtn', 'CaptionTodayBtn',
//                                  'NoColorCaption' ] );
//
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzDialogButtons,
//                                [ 'CaptionCancel', 'CaptionHelp', 'CaptionOK', 'WidthCancel', 'WidthHelp', 'WidthOK' ] );
//
//  RegisterPropertiesInCategory( sLocalizableCategoryName, TRzLookupDialog,
//                                [ 'Caption', 'CaptionCancel', 'CaptionHelp', 'CaptionOK', 'Prompt' ] );
end; {= RegisterCustomPropertyCategories =}



procedure RegisterWithSplashScreen;
var
  Bmp: TBitmap;
begin
//  // Register TestSplash Icon on Delphi Splash Screen
//  Bmp := TBitmap.Create;
//  Bmp.LoadFromResourceName( HInstance, 'RAIZECOMPONENTSSPLASH' );
//
//  try
//    SplashScreenServices.AddPluginBitmap( sProductName,
//                                          Bmp.Handle, False, '', '' );
//  finally
//    Bmp.Free;
//  end;

end;


procedure RegisterGuidelines;
begin
  RegisterComponentGuidelines( TRzPageControl, TRzPageControlGuidelines );
  RegisterComponentGuidelines( TRzTabControl, TRzTabControlGuidelines );
end;



{========================}
{== Register Procedure ==}
{========================}

procedure Register;
var
  R: TRegIniFile;
begin
 // RegisterWithSplashScreen;

  R := TRegIniFile.Create( RC_SettingsKey );
  try
    RegisterRaizeComponents( R, ppRaizeComponents );
//    RegisterRaizePanels( R, ppRaizePanels );
//    RegisterRaizeEdits( R, ppRaizeEdits );
//    RegisterRaizeLists( R, ppRaizeLists );
//    RegisterRaizeButtons( R, ppRaizeButtons );
//    RegisterRaizeDisplay( R, ppRaizeDisplay );
//    RegisterRaizeShell( R, ppRaizeShell );
//    RegisterRaizeWidgets( R, ppRaizeWidgets );

//    RegisterGeneralEditors( R );

    RegisterGuidelines;

  //  RegisterCustomPropertyCategories;
  finally
    R.Free;
  end;

end; {= Register =}

{$ENDIF}

end.
