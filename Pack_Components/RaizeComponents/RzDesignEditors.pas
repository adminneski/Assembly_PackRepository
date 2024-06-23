
{$I RzComps.inc}

unit RzDesignEditors;

interface

uses
  {$IFDEF USE_CS}
  CodeSiteLogging,
  {$ENDIF}
  Windows,
  Classes,
  Controls,
  Graphics,
  ImgList,
  Menus,
  Forms,
  ExtCtrls,
  ActnList,
  DesignIntf,
  DesignEditors,
  VCLEditors,
  VCLSprigs,
  DesignMenus,
  TreeIntf,
  RzCommon,
  RzTabs;

const
  ppRaizeComponents  = 'Raize Components';
  ppRaizePanels      = 'Raize Panels';
  ppRaizeEdits       = 'Raize Edits';
  ppRaizeLists       = 'Raize Lists';
  ppRaizeButtons     = 'Raize Buttons';
  ppRaizeDisplay     = 'Raize Display';
  ppRaizeShell       = 'Raize Shell';
  ppRaizeWidgets     = 'Raize Widgets';

  RC_SettingsKey = 'Software\Raize\Raize Components\5.0';
  RegisterSection = 'Register';

type
  {== Base Component Editors ==================================================}

  {==========================================}
  {== TRzComponentEditor Class Declaration ==}
  {==========================================}

  TRzComponentEditor = class( TComponentEditor )
  private
    FPropName: string;
    FContinue: Boolean;
    FPropEditor: IProperty;
    procedure EnumPropertyEditors( const PropertyEditor: IProperty );
    procedure TestPropertyEditor( const PropertyEditor: IProperty;
                                  var Continue: Boolean );
    procedure AlignMenuHandler( Sender: TObject );
    procedure ImageListMenuHandler( Sender: TObject );
    procedure RegIniFileMenuHandler( Sender: TObject );
  protected
    procedure DesignerModified;
    procedure EditPropertyByName( const APropName: string );
    function AlignMenuIndex: Integer; virtual;
    function GetCompRefData( Index: Integer; var CompRefClass: TComponentClass;
                             var CompRefPropName: string;
                             var CompRefMenuHandler: TNotifyEvent ): Boolean; virtual;
    procedure PrepareMenuItem( Index: Integer; const Item: TMenuItem ); virtual;
  public
    procedure PrepareItem( Index: Integer; const AItem: IMenuItem ); override;
  end;


  {========================================}
  {== TRzDefaultEditor Class Declaration ==}
  {========================================}

  TRzDefaultEditor = class( TDefaultEditor )
  private
    FPropName: string;
    FContinue: Boolean;
    FPropEditor: IProperty;
    procedure EnumPropertyEditors( const PropertyEditor: IProperty );
    procedure TestPropertyEditor( const PropertyEditor: IProperty;
                                  var Continue: Boolean );
    procedure AlignMenuHandler( Sender: TObject );
    procedure ImageListMenuHandler( Sender: TObject );
    procedure RegIniFileMenuHandler( Sender: TObject );
  protected
    procedure DesignerModified;
    procedure EditPropertyByName( const APropName: string );
    function AlignMenuIndex: Integer; virtual;
    function GetCompRefData( Index: Integer; var CompRefClass: TComponentClass;
                             var CompRefPropName: string;
                             var CompRefMenuHandler: TNotifyEvent ): Boolean; virtual;
    procedure PrepareMenuItem( Index: Integer; const Item: TMenuItem ); virtual;
  public
    procedure PrepareItem( Index: Integer; const AItem: IMenuItem ); override;
  end;


  {== Component Editors =======================================================}

  {================================================}
  {== TRzFrameControllerEditor Class Declaration ==}
  {================================================}

  TRzFrameControllerEditor = class( TRzComponentEditor )
  protected
    function FrameController: TRzFrameController;
    function GetCompRefData( Index: Integer; var CompRefClass: TComponentClass;
                             var CompRefPropName: string;
                             var CompRefMenuHandler: TNotifyEvent ): Boolean; override;
  public
    function GetVerbCount: Integer; override;
    function GetVerb( Index: Integer ) : string; override;
    procedure ExecuteVerb( Index: Integer ); override;
  end;

  {============================================}
  {== TRzPageControlEditor Class Declaration ==}
  {============================================}

  TRzPageControlEditor = class( TRzDefaultEditor )
  protected
    function PageControl: TRzPageControl;
    procedure PrepareMenuItem( Index: Integer; const Item: TMenuItem ); override;
    procedure PageMenuHandler( Sender: TObject );
    procedure StyleMenuHandler( Sender: TObject );
    procedure OrientationMenuHandler( Sender: TObject );
    procedure ImageListMenuHandler( Sender: TObject );
    procedure AlignMenuHandler( Sender: TObject );
  public
    function GetVerbCount: Integer; override;
    function GetVerb( Index: Integer ): string; override;
    procedure ExecuteVerb( Index: Integer ); override;
  end;


  TRzPageControlSprig = class( TWinControlSprig )
  public
    constructor Create( AItem: TPersistent ); override;
    function SortByIndex: Boolean; override;
  end;


  TRzTabSheetSprig = class( TWinControlSprig )
  public
    constructor Create( AItem: TPersistent ); override;
    function Caption: string; override;
    function ItemIndex: Integer; override;
    function Hidden: Boolean; override;
  end;


  {===========================================}
  {== TRzTabControlEditor Class Declaration ==}
  {===========================================}

  TRzTabControlEditor = class( TRzDefaultEditor )
  protected
    function TabControl: TRzTabControl;
    function AlignMenuIndex: Integer; override;
    function GetCompRefData( Index: Integer; var CompRefClass: TComponentClass;
                             var CompRefPropName: string;
                             var CompRefMenuHandler: TNotifyEvent ): Boolean; override;
    procedure PrepareMenuItem( Index: Integer; const Item: TMenuItem ); override;
    procedure TabMenuHandler( Sender: TObject );
    procedure StyleMenuHandler( Sender: TObject );
    procedure OrientationMenuHandler( Sender: TObject );
  public
    function GetVerbCount: Integer; override;
    function GetVerb( Index: Integer ): string; override;
    procedure ExecuteVerb( Index: Integer ); override;
  end;

  {=======================================================}
  {== TRzPropertyItemPropNameProperty Class Declaration ==}
  {=======================================================}


  TRzPropertyItemPropNameProperty = class( TStringProperty )
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues( Proc: TGetStrProc ); override;
  end;


  {==============================================}
  {== TRzPropertyStoreEditor Class Declaration ==}
  {==============================================}

  TRzPropertyStoreEditor = class( TRzComponentEditor )
  protected
    function PropertyStore: TRzPropertyStore;
    function GetCompRefData( Index: Integer; var CompRefClass: TComponentClass;
                             var CompRefPropName: string;
                             var CompRefMenuHandler: TNotifyEvent ): Boolean; override;
  public
    function GetVerbCount: Integer; override;
    function GetVerb( Index: Integer ) : string; override;
    procedure ExecuteVerb( Index: Integer ); override;
  end;


  {== Property Editors ========================================================}

  {=============================================}
  {== TRzFrameStyleProperty Class Declaration ==}
  {=============================================}

  TRzFrameStyleProperty = class( TEnumProperty, ICustomPropertyDrawing, ICustomPropertyListDrawing, ICustomPropertyDrawing80 )
  private
    FDrawingPropertyValue: Boolean;

    function PaintFrameStyleGlyph( const Value: string; ACanvas: TCanvas;
                                   const ARect: TRect; ASelected: Boolean ): TRect;
  public
    // ICustomPropertyListDrawing
    procedure ListMeasureHeight( const Value: string; ACanvas: TCanvas;
                                 var AHeight: Integer );
    procedure ListMeasureWidth( const Value: string; ACanvas: TCanvas;
                                var AWidth: Integer );
    procedure ListDrawValue( const Value: string; ACanvas: TCanvas;
                             const ARect: TRect; ASelected: Boolean );

    // ICustomPropertyDrawing
    procedure PropDrawName( ACanvas: TCanvas; const ARect: TRect;
                            ASelected: Boolean );
    procedure PropDrawValue( ACanvas: TCanvas; const ARect: TRect;
                             ASelected: Boolean );
    // ICustomPropertyDrawing80
    function PropDrawNameRect( const ARect: TRect ): TRect;
    function PropDrawValueRect( const ARect: TRect ): TRect;
  end;


  TRzAlignChangedEvent = procedure( Sender: TObject; AlignValue: TAlign ) of object;

  {=============================================}
  {== TRzActivePageProperty Class Declaration ==}
  {=============================================}

  TRzActivePageProperty = class( TComponentProperty )
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues( Proc: TGetStrProc ); override;
  end;


  {===========================================}
  {== TRzFileNameProperty Class Declaration ==}
  {===========================================}

  TRzFileNameProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;


  {=========================================}
  {== TRzActionProperty Class Declaration ==}
  {=========================================}

  TRzActionProperty = class( TStringProperty )
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues( Proc: TGetStrProc ); override;
  end;


  {===============================================}
  {== TRzCustomColorsProperty Class Declaration ==}
  {===============================================}

  TRzCustomColorsProperty = class( TClassProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;


  {== Designer Guidelines =====================================================}

  TRzCustomButtonGuidelines = class( TControlGuidelines )
  protected
    function GetCount: Integer; override;
    function GetDesignerGuideType(Index: Integer): TDesignerGuideType; override;
    function GetDesignerGuideOffset(Index: Integer): Integer; override;
  end;

  TRzPageControlGuidelines = class( TControlGuidelines )
    function GetDesignerGuideOffset(Index: Integer): Integer; override;
  end;

  TRzTabControlGuidelines = class( TControlGuidelines )
    function GetDesignerGuideOffset(Index: Integer): Integer; override;
  end;


resourcestring
  sRzCustomFramingCategoryName = 'Custom Framing';
  sRzHotSpotCategoryName = 'HotSpot';
  sRzBorderStyleCategoryName = 'Border Style';
  sRzCustomGlyphsCategoryName = 'Custom Glyphs';
  sRzTextStyleCategoryName = 'Text Style';
  sRzTrackStyleCategoryName = 'Track Style';
  sRzPrimaryButtonCategoryName = 'Button - Primary';
  sRzAlternateButtonCategoryName = 'Button - Alternate';
  sRzSplitterCategoryName = 'Splitter Style';


type
  TRzPaletteSep = class( TComponent )
  public
    constructor Create( AOwner: TComponent ); override;
  end;

  TRzPaletteSep_Panels  = class( TRzPaletteSep );
  TRzPaletteSep_Edits   = class( TRzPaletteSep );
  TRzPaletteSep_Lists   = class( TRzPaletteSep );
  TRzPaletteSep_Buttons = class( TRzPaletteSep );
  TRzPaletteSep_Display = class( TRzPaletteSep );
  TRzPaletteSep_Shell   = class( TRzPaletteSep );
  TRzPaletteSep_Widgets = class( TRzPaletteSep );


function UniqueName( AComponent: TComponent ): string;

procedure CreateVisualStyleMenuItem( Item: TMenuItem;
                                     VisualStyle, CurrentVisualStyle: TRzVisualStyle;
                                     EventHandler: TNotifyEvent );

procedure CreateGradientColorStyleMenuItem( Item: TMenuItem;
                                            GradientColorStyle, CurrentGradientColorStyle: TRzGradientColorStyle;
                                            EventHandler: TNotifyEvent );

//procedure CreateGroupStyleMenuItem( Item: TMenuItem;
//                                    GroupStyle, CurrentGroupStyle: TRzGroupBoxStyle;
//                                    EventHandler: TNotifyEvent );

implementation

uses
  SysUtils,
  TypInfo,
  StdCtrls,
  ComCtrls,
  Dialogs,
  RzGrafx;

{$R RzDesignEditors.res}    // Link in  bitmaps for component editors


{=====================}
{== Support Methods ==}
{=====================}

// There is no UniqueName method for TFormDesigner in Delphi 1, so we need our
// own equivalent.  The local UniqueName function is also used for Delphi 2/3
// because it makes the names nicer by removing the 'cs' prefix normally
// included (by TFormDesigner.UniqueName) for objects of type TRzTabSheet.

// Test a component name for uniqueness and return True if it is unique or False
// if there is another component with the same name.

function TryName( const AName: string; AComponent: TComponent ): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to AComponent.ComponentCount - 1 do
  begin
    if CompareText( AComponent.Components[ I ].Name, AName ) = 0 then
      Exit;
  end;
  Result := True;
end;


// Generate a unique name for a component.  Use the standard Delphi rules,
// e.g., <type><number>, where <type> is the component's class name without
// a leading 'T', and <number> is an integer to make the name unique.

function UniqueName( AComponent: TComponent ): string;
var
  I: Integer;
  Fmt: string;
begin
  // Create a Format string to use as a name template.
  if CompareText( Copy( AComponent.ClassName, 1, 3 ), 'TRz' ) = 0 then
    Fmt := Copy( AComponent.ClassName, 4, 255 ) + '%d'
  else
    Fmt := AComponent.ClassName + '%d';

  if AComponent.Owner = nil then
  begin
    // No owner; any name is unique. Use 1.
    Result := Format( Fmt, [ 1 ] );
    Exit;
  end
  else
  begin
    // Try all possible numbers until we find a unique name.
    for I := 1 to High( Integer ) do
    begin
      Result := Format( Fmt, [ I ] );
      if TryName( Result, AComponent.Owner ) then
        Exit;
    end;
  end;

  // This should never happen, but just in case...
  raise Exception.CreateFmt('Cannot create unique name for %s.', [ AComponent.ClassName ] );
end;


{======================================}
{== CreateVisualStyleMenuItem Method ==}
{======================================}

procedure CreateVisualStyleMenuItem( Item: TMenuItem;
                                     VisualStyle, CurrentVisualStyle: TRzVisualStyle;
                                     EventHandler: TNotifyEvent );
var
  NewItem: TMenuItem;
begin
  NewItem := TMenuItem.Create( Item );
  case VisualStyle of
    vsClassic:  NewItem.Caption := 'Classic';
    vsWinXP:    NewItem.Caption := 'WinXP';
    vsGradient: NewItem.Caption := 'Gradient';
  end;
  NewItem.Tag := Ord( VisualStyle );
  NewItem.Checked := CurrentVisualStyle = VisualStyle;
  NewItem.OnClick := EventHandler;
  Item.Add( NewItem );
end;


{=============================================}
{== CreateGradientColorStyleMenuItem Method ==}
{=============================================}

procedure CreateGradientColorStyleMenuItem( Item: TMenuItem;
                                            GradientColorStyle, CurrentGradientColorStyle: TRzGradientColorStyle;
                                            EventHandler: TNotifyEvent );
var
  NewItem: TMenuItem;
begin
  NewItem := TMenuItem.Create( Item );
  case GradientColorStyle of
    gcsSystem:   NewItem.Caption := 'System';
    gcsMSOffice: NewItem.Caption := 'MS Office';
    gcsCustom:   NewItem.Caption := 'Custom';
  end;
  NewItem.Tag := Ord( GradientColorStyle );
  NewItem.Checked := CurrentGradientColorStyle = GradientColorStyle;
  NewItem.OnClick := EventHandler;
  Item.Add( NewItem );
end;


{== Base Component Editors ====================================================}

{================================}
{== TRzComponentEditor Methods ==}
{================================}

procedure TRzComponentEditor.EnumPropertyEditors( const PropertyEditor: IProperty );
begin
  if FContinue then
    TestPropertyEditor( PropertyEditor, FContinue );
end;


procedure TRzComponentEditor.TestPropertyEditor( const PropertyEditor: IProperty;
                                                 var Continue: Boolean );
begin
  if not Assigned( FPropEditor ) and
     ( CompareText( PropertyEditor.GetName, FPropName ) = 0 ) then
  begin
    Continue := False;
    FPropEditor := PropertyEditor;
  end;
end;


procedure TRzComponentEditor.EditPropertyByName( const APropName: string );
var
  Components: IDesignerSelections;
begin
  Components := TDesignerSelections.Create;
  FContinue := True;
  FPropName := APropName;
  Components.Add( Component );
  FPropEditor := nil;
  try
    GetComponentProperties( Components, tkAny, Designer, EnumPropertyEditors );
    if Assigned( FPropEditor ) then
      FPropEditor.Edit;
  finally
    FPropEditor := nil;
  end;
end;


procedure TRzComponentEditor.DesignerModified;
begin
  if Designer <> nil then
    Designer.Modified;
end;


function TRzComponentEditor.AlignMenuIndex: Integer;
begin
  Result := -1;
end;


function TRzComponentEditor.GetCompRefData( Index: Integer;
                                            var CompRefClass: TComponentClass;
                                            var CompRefPropName: string;
                                            var CompRefMenuHandler: TNotifyEvent ): Boolean;
begin
  Result := False;
end;


procedure TRzComponentEditor.PrepareMenuItem( Index: Integer;
                                              const Item: TMenuItem );
var
  I, CompRefCount: Integer;
  CompOwner: TComponent;
  CompRefClass: TComponentClass;
  CompRefPropName: string;
  CompRefMenuHandler: TNotifyEvent;

  procedure CreateAlignItem( AlignValue: TAlign; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Ord( AlignValue );
    NewItem.Checked := TControl( Component ).Align = AlignValue;
    NewItem.OnClick := AlignMenuHandler;
    Item.Add( NewItem );
  end;

  procedure CreateCompRefMenu( CompRef: TComponent; const CompRefPropName: string; CompRefMenuHandler: TNotifyEvent );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.AutoHotkeys := maManual;
    NewItem.Caption := CompRef.Name;
    NewItem.Checked := GetObjectProp( Component, CompRefPropName ) = CompRef;
    NewItem.OnClick := CompRefMenuHandler;
    Item.Add( NewItem );
  end;

begin {= TRzComponentEditor.PrepareMenuItem =}
  // Descendant classes override this method to consistently handle preparing 
  // menu items.

  if Index = AlignMenuIndex then
  begin
    CreateAlignItem( alClient, 'Client' );
    CreateAlignItem( alLeft, 'Left' );
    CreateAlignItem( alTop, 'Top' );
    CreateAlignItem( alRight, 'Right' );
    CreateAlignItem( alBottom, 'Bottom' );
    CreateAlignItem( alNone, 'None' );
  end;

  if GetCompRefData( Index, CompRefClass, CompRefPropName, CompRefMenuHandler ) then
  begin
    Item.AutoHotkeys := maManual;
    CompRefCount := 0;
    CompOwner := Designer.GetRoot;

    if not Assigned( CompRefMenuHandler ) then
    begin
      if CompRefClass = TCustomImageList then
        CompRefMenuHandler := ImageListMenuHandler
      else if CompRefClass = TRzRegIniFile then
        CompRefMenuHandler := RegIniFileMenuHandler;
    end;

    if CompOwner <> nil then
    begin
      for I := 0 to CompOwner.ComponentCount - 1 do
      begin
        if CompOwner.Components[ I ] is CompRefClass then
        begin
          Inc( CompRefCount );
          CreateCompRefMenu( CompOwner.Components[ I ], CompRefPropName,
                             CompRefMenuHandler );
        end;
      end;
    end;
    Item.Enabled := CompRefCount > 0;
  end;

end; {= TRzComponentEditor.PrepareMenuItem =}


procedure TRzComponentEditor.PrepareItem( Index: Integer; const AItem: IMenuItem );
var
  CompRef: IInterfaceComponentReference;
  MenuItem: TMenuItem;
begin
  CompRef := AItem as IInterfaceComponentReference;
  MenuItem := CompRef.GetComponent as TMenuItem;
  PrepareMenuItem( Index, MenuItem );
end;


procedure TRzComponentEditor.AlignMenuHandler( Sender: TObject );
begin
  TControl( Component ).Align := TAlign( TMenuItem( Sender ).Tag );
  DesignerModified;
end;


procedure TRzComponentEditor.ImageListMenuHandler( Sender: TObject );
var
  S: string;
  ImageList: TCustomImageList;
begin
  if Designer.GetRoot <> nil then
  begin
    S := TMenuItem( Sender ).Caption;
    ImageList := Designer.GetRoot.FindComponent( S ) as TCustomImageList;
    SetObjectProp( Component, 'Images', ImageList );
    DesignerModified;
  end;
end;


procedure TRzComponentEditor.RegIniFileMenuHandler( Sender: TObject );
var
  S: string;
  RegIniFile: TRzRegIniFile;
begin
  if Designer.GetRoot <> nil then
  begin
    S := TMenuItem( Sender ).Caption;
    RegIniFile := Designer.GetRoot.FindComponent( S ) as TRzRegIniFile;
    SetObjectProp( Component, 'RegIniFile', RegIniFile );
    DesignerModified;
  end;
end;


{==============================}
{== TRzDefaultEditor Methods ==}
{==============================}

procedure TRzDefaultEditor.EnumPropertyEditors( const PropertyEditor: IProperty );
begin
  if FContinue then
    TestPropertyEditor( PropertyEditor, FContinue );
end;


procedure TRzDefaultEditor.TestPropertyEditor( const PropertyEditor: IProperty;
                                               var Continue: Boolean );
begin
  if not Assigned( FPropEditor ) and
     ( CompareText( PropertyEditor.GetName, FPropName ) = 0 ) then
  begin
    Continue := False;
    FPropEditor := PropertyEditor;
  end;
end;


procedure TRzDefaultEditor.EditPropertyByName( const APropName: string );
var
  Components: IDesignerSelections;
begin
  Components := TDesignerSelections.Create;
  FContinue := True;
  FPropName := APropName;
  Components.Add( Component );
  FPropEditor := nil;
  try
    GetComponentProperties( Components, tkAny, Designer, EnumPropertyEditors );
    if Assigned( FPropEditor ) then
      FPropEditor.Edit;
  finally
    FPropEditor := nil;
  end;
end;


procedure TRzDefaultEditor.DesignerModified;
begin
  if Designer <> nil then
    Designer.Modified;
end;


function TRzDefaultEditor.AlignMenuIndex: Integer;
begin
  Result := -1;
end;


function TRzDefaultEditor.GetCompRefData( Index: Integer;
                                          var CompRefClass: TComponentClass;
                                          var CompRefPropName: string;
                                          var CompRefMenuHandler: TNotifyEvent ): Boolean;
begin
  Result := False;
end;


procedure TRzDefaultEditor.PrepareMenuItem( Index: Integer;
                                            const Item: TMenuItem );
var
  I, CompRefCount: Integer;
  CompOwner: TComponent;
  CompRefClass: TComponentClass;
  CompRefPropName: string;
  CompRefMenuHandler: TNotifyEvent;

  procedure CreateAlignItem( AlignValue: TAlign; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Ord( AlignValue );
    NewItem.Checked := TControl( Component ).Align = AlignValue;
    NewItem.OnClick := AlignMenuHandler;
    Item.Add( NewItem );
  end;

  procedure CreateCompRefMenu( CompRef: TComponent; const CompRefPropName: string;
                               CompRefMenuHandler: TNotifyEvent );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.AutoHotkeys := maManual;
    NewItem.Caption := CompRef.Name;
    NewItem.Checked := GetObjectProp( Component, CompRefPropName ) = CompRef;
    NewItem.OnClick := CompRefMenuHandler;
    Item.Add( NewItem );
  end;

begin {= TRzDefaultEditor.PrepareMenuItem =}
  // Descendant classes override this method to consistently handle preparing
  // menu items.
                                    
  if Index = AlignMenuIndex then
  begin
    CreateAlignItem( alClient, 'Client' );
    CreateAlignItem( alLeft, 'Left' );
    CreateAlignItem( alTop, 'Top' );
    CreateAlignItem( alRight, 'Right' );
    CreateAlignItem( alBottom, 'Bottom' );
    CreateAlignItem( alNone, 'None' );
  end;

  if GetCompRefData( Index, CompRefClass, CompRefPropName, CompRefMenuHandler ) then
  begin
    Item.AutoHotkeys := maManual;
    CompRefCount := 0;
    CompOwner := Designer.GetRoot;

    if not Assigned( CompRefMenuHandler ) then
    begin
      if CompRefClass = TCustomImageList then
        CompRefMenuHandler := ImageListMenuHandler
      else if CompRefClass = TRzRegIniFile then
        CompRefMenuHandler := RegIniFileMenuHandler;
    end;

    if CompOwner <> nil then
    begin
      for I := 0 to CompOwner.ComponentCount - 1 do
      begin
        if CompOwner.Components[ I ] is CompRefClass then
        begin
          Inc( CompRefCount );
          CreateCompRefMenu( CompOwner.Components[ I ], CompRefPropName,
                             CompRefMenuHandler );
        end;
      end;
    end;
    Item.Enabled := CompRefCount > 0;
  end;

end;


procedure TRzDefaultEditor.PrepareItem( Index: Integer; const AItem: IMenuItem );
var
  CompRef: IInterfaceComponentReference;
  MenuItem: TMenuItem;
begin
  CompRef := AItem as IInterfaceComponentReference;
  MenuItem := CompRef.GetComponent as TMenuItem;
  PrepareMenuItem( Index, MenuItem );
end;


procedure TRzDefaultEditor.AlignMenuHandler( Sender: TObject );
begin
  TControl( Component ).Align := TAlign( TMenuItem( Sender ).Tag );
  DesignerModified;
end;


procedure TRzDefaultEditor.ImageListMenuHandler( Sender: TObject );
var
  S: string;
  ImageList: TCustomImageList;
begin
  if Designer.GetRoot <> nil then
  begin
    S := TMenuItem( Sender ).Caption;
    ImageList := Designer.GetRoot.FindComponent( S ) as TCustomImageList;
    SetObjectProp( Component, 'Images', ImageList );
    DesignerModified;
  end;
end;


procedure TRzDefaultEditor.RegIniFileMenuHandler( Sender: TObject );
var
  S: string;
  RegIniFile: TRzRegIniFile;
begin
  if Designer.GetRoot <> nil then
  begin
    S := TMenuItem( Sender ).Caption;
    RegIniFile := Designer.GetRoot.FindComponent( S ) as TRzRegIniFile;
    SetObjectProp( Component, 'RegIniFile', RegIniFile );
    DesignerModified;
  end;
end;


{== Component Editors =========================================================}


{======================================}
{== TRzFrameControllerEditor Methods ==}
{======================================}

function TRzFrameControllerEditor.FrameController: TRzFrameController;
begin
  Result := Component as TRzFrameController;
end;


function TRzFrameControllerEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;


function TRzFrameControllerEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Frame Visible';
    1: Result := 'Underline Controls';
    2: Result := '-';
    3: Result := 'Set RegIniFile';
  end;
end;


function TRzFrameControllerEditor.GetCompRefData( Index: Integer;
                                                  var CompRefClass: TComponentClass;
                                                  var CompRefPropName: string;
                                                  var CompRefMenuHandler: TNotifyEvent ): Boolean;
begin
  Result := False;
  if Index = 3 then
  begin
    CompRefClass := TRzRegIniFile;
    CompRefPropName := 'RegIniFile';
    CompRefMenuHandler := nil;
    Result := True;
  end
end;


procedure TRzFrameControllerEditor.ExecuteVerb( Index: Integer );
begin
  case Index of
    0:
    begin
      FrameController.FrameVisible := True;
      DesignerModified;
    end;

    1:
    begin
      FrameController.FrameVisible := True;
      FrameController.FrameSides := [ sdBottom ];
      DesignerModified;
    end;

  end;
end;

{==================================}
{== TRzPageControlEditor Methods ==}
{==================================}

function TRzPageControlEditor.PageControl: TRzPageControl;
begin
  if Component is TRzPageControl then
    Result := TRzPageControl( Component )
  else if Component is TRzTabSheet then
    Result := TRzTabSheet( Component ).PageControl
  else
    raise Exception.Create( 'Invalid Component type for editor' );
end;


function TRzPageControlEditor.GetVerbCount: Integer;
begin
  if Component is TRzTabSheet then
    Result := 16
  else
    Result := 14;
end;


function TRzPageControlEditor.GetVerb( Index: Integer ): string;
begin
  case Index of
    0: Result := 'New Page';
    1: Result := '-';
    2: Result := 'Switch to Page';
    3: Result := '-';
    4: Result := 'Style';
    5: Result := 'Orientation';
    6: Result := '-';
    7: Result := 'Hide All Tabs';
    8: Result := 'Show All Tabs';
    9: Result := '-';
    10: Result := 'Align';
    11: Result := 'XP Colors';
    12: Result := '-';
    13: Result := 'Set ImageList';
    14: Result := 'Select Image...';
    15: Result := 'Select Disabled Image...';
  end;
end;


procedure TRzPageControlEditor.PrepareMenuItem( Index: Integer;
                                                const Item: TMenuItem );
var
  I, ImageListCount: Integer;
  CompOwner: TComponent;

  procedure CreatePageMenu( Index: Integer; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Index;
    NewItem.Checked := PageControl.ActivePageIndex = Index;
    NewItem.OnClick := PageMenuHandler;
    Item.Add( NewItem );
  end;


  procedure CreateStyleMenu( Style: TRzTabStyle; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Ord( Style );
    NewItem.Checked := PageControl.TabStyle = Style;
    NewItem.OnClick := StyleMenuHandler;
    Item.Add( NewItem );
  end;


  procedure CreateOrientationMenu( Orientation: TRzTabOrientation;
                                   const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Ord( Orientation );
    NewItem.Checked := PageControl.TabOrientation = Orientation;
    NewItem.OnClick := OrientationMenuHandler;
    Item.Add( NewItem );
  end;

  procedure CreateImageListMenu( ImageList: TCustomImageList );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.AutoHotkeys := maManual;
    NewItem.Caption := ImageList.Name;
    NewItem.Checked := GetObjectProp( PageControl, 'Images' ) = ImageList;
    NewItem.OnClick := ImageListMenuHandler;
    Item.Add( NewItem );
  end;

  procedure CreateAlignItem( AlignValue: TAlign; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Ord( AlignValue );
    NewItem.Checked := PageControl.Align = AlignValue;
    NewItem.OnClick := AlignMenuHandler;
    Item.Add( NewItem );
  end;

begin
  inherited;

  case Index of
    0:
    begin
      // Only allow user to add new pages if the page control is NOT being edited in an inline frame
      // (i.e. a frame instance).
      Item.Enabled := not IsInInlined;
    end;

    2: // Switch To Page
    begin
      for I := 0 to PageControl.PageCount - 1 do
        CreatePageMenu( I, PageControl.Pages[ I ].Caption );
    end;

    4:
    begin
      CreateStyleMenu( tsSingleSlant, 'Single Slant' );
      CreateStyleMenu( tsBackSlant, 'Back Slant' );
      CreateStyleMenu( tsDoubleSlant, 'Double Slant' );
      CreateStyleMenu( tsCutCorner, 'Cut Corner' );
      CreateStyleMenu( tsRoundCorners, 'Round Corners' );
      CreateStyleMenu( tsSquareCorners, 'Square Corners' );
    end;

    5:
    begin
      CreateOrientationMenu( toTop, 'Top' );
      CreateOrientationMenu( toBottom, 'Bottom' );
      CreateOrientationMenu( toLeft, 'Left' );
      CreateOrientationMenu( toRight, 'Right' );
    end;

    10:
    begin
      CreateAlignItem( alClient, 'Client' );
      CreateAlignItem( alLeft, 'Left' );
      CreateAlignItem( alTop, 'Top' );
      CreateAlignItem( alRight, 'Right' );
      CreateAlignItem( alBottom, 'Bottom' );
      CreateAlignItem( alNone, 'None' );
    end;

    13:
    begin
      Item.AutoHotkeys := maManual;
      ImageListCount := 0;
      CompOwner := Designer.GetRoot;
      if CompOwner <> nil then
      begin
        for I := 0 to CompOwner.ComponentCount - 1 do
        begin
          if CompOwner.Components[ I ] is TCustomImageList then
          begin
            Inc( ImageListCount );
            CreateImageListMenu( TCustomImageList( CompOwner.Components[ I ] ) );
          end;
        end;
      end;
      Item.Enabled := ImageListCount > 0;
    end;
  end;
end;


procedure TRzPageControlEditor.ExecuteVerb( Index: Integer );
var
  APageControl: TRzPageControl;
  Page: TRzTabSheet;
  Designer: IDesigner;
begin
  if Component is TRzTabSheet then
    APageControl := TRzTabSheet( Component ).PageControl
  else
    APageControl := TRzPageControl( Component );

  if APageControl <> nil then
  begin
    Designer := Self.Designer;

    case Index of
      0:                                    // New Page
      begin
        Page := TRzTabSheet.Create( Designer.Root );
        try
          // Generate unique name
          Page.Name := UniqueName( Page );
          Page.PageControl := APageControl;
        except
          Page.Free;
          raise;
        end;

        APageControl.ActivePage := Page;
        Designer.SelectComponent( Page );
        DesignerModified;
      end;

      7: // Hide All Tabs
      begin
        APageControl.HideAllTabs;
        APageControl.ShowShadow := False;
        DesignerModified;
      end;

      8: // Show All Tabs
      begin
        APageControl.ShowAllTabs;
        DesignerModified;
      end;

      11: // XP Colors
      begin
        APageControl.HotTrackColorType := htctActual;
        APageControl.HotTrackColor := xpHotTrackColor;
        APageControl.TabColors.HighlightBar := xpHotTrackColor;
        APageControl.FlatColor := xpTabControlFrameColor;
        APageControl.Color := xpTabControlColor;
        APageControl.ShowShadow := True;
        DesignerModified;
      end;

      14:
      begin
        // This will only get used if we are on a TRzTabSheet
        EditPropertyByName( 'ImageIndex' );
      end;

      15:
      begin
        // This will only get used if we are on a TRzTabSheet
        EditPropertyByName( 'DisabledIndex' );
      end;
    end;
  end;
end; {= TRzPageControlEditor.ExecuteVerb =}


procedure TRzPageControlEditor.PageMenuHandler( Sender: TObject );
begin
  PageControl.ActivePageIndex := TMenuItem( Sender ).Tag;
  DesignerModified;
  if PageControl.ActivePage <> nil then
    Designer.SelectComponent( PageControl.ActivePage );
end;


procedure TRzPageControlEditor.StyleMenuHandler( Sender: TObject );
begin
  PageControl.TabStyle := TRzTabStyle( TMenuItem( Sender ).Tag );
  DesignerModified;
end;


procedure TRzPageControlEditor.OrientationMenuHandler( Sender: TObject );
begin
  PageControl.TabOrientation := TRzTabOrientation( TMenuItem( Sender ).Tag );
  case PageControl.TabOrientation of
    toTop, toBottom:
    begin
      PageControl.TextOrientation := orHorizontal;
      PageControl.ImagePosition := ipLeft;
    end;

    toLeft, toRight:
    begin
      PageControl.TextOrientation := orVertical;
      if PageControl.TabOrientation = toRight then
        PageControl.ImagePosition := ipTop
      else
        PageControl.ImagePosition := ipBottom;
    end;
  end;
  DesignerModified;
end;



procedure TRzPageControlEditor.ImageListMenuHandler( Sender: TObject );
var
  S: string;
begin
  if Designer.GetRoot <> nil then
  begin
    S := TMenuItem( Sender ).Caption;
    PageControl.Images := Designer.GetRoot.FindComponent( S ) as TCustomImageList;
    DesignerModified;
  end;
end;


procedure TRzPageControlEditor.AlignMenuHandler( Sender: TObject );
begin
  PageControl.Align := TAlign( TMenuItem( Sender ).Tag );
  DesignerModified;
end;


{=================================}
{== TRzPageControlSprig Methods ==}
{=================================}

constructor TRzPageControlSprig.Create( AItem: TPersistent );
begin
  inherited;
  ImageIndex := CUIControlSprigImage;
end;


function TRzPageControlSprig.SortByIndex: Boolean;
begin
  Result := True;
end;


{==============================}
{== TRzTabSheetSprig Methods ==}
{==============================}

constructor TRzTabSheetSprig.Create( AItem: TPersistent );
begin
  inherited;
  ImageIndex := CUIContainerSprigImage;
end;


function TRzTabSheetSprig.Caption: string;
begin
  Result := CaptionFor( TRzTabSheet( Item ).Caption, TRzTabSheet( Item ).Name );
end;


function TRzTabSheetSprig.ItemIndex: Integer;
begin
  Result := TRzTabSheet( Item ).PageIndex;
end;


function TRzTabSheetSprig.Hidden: Boolean;
begin
  Result := True;
end;


{=================================}
{== TRzTabControlEditor Methods ==}
{=================================}

function TRzTabControlEditor.TabControl: TRzTabControl;
begin
  Result := Component as TRzTabControl;
end;


function TRzTabControlEditor.GetVerbCount: Integer;
begin
  Result := 14;
end;


function TRzTabControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit Tabs...';
    1: Result := '-';
    2: Result := 'Switch to Tab';
    3: Result := '-';
    4: Result := 'Style';
    5: Result := 'Orientation';
    6: Result := '-';
    7: Result := 'Hide All Tabs';
    8: Result := 'Show All Tabs';
    9: Result := '-';
    10: Result := 'Align';
    11: Result := 'XP Colors';
    12: Result := '-';
    13: Result := 'Set ImageList';
  end;
end;


function TRzTabControlEditor.AlignMenuIndex: Integer;
begin
  Result := 10;
end;


function TRzTabControlEditor.GetCompRefData( Index: Integer; var CompRefClass: TComponentClass;
                                             var CompRefPropName: string;
                                             var CompRefMenuHandler: TNotifyEvent ): Boolean;
begin
  Result := False;
  if Index = 13 then
  begin
    CompRefClass := TCustomImageList;
    CompRefPropName := 'Images';
    CompRefMenuHandler := nil;
    Result := True;
  end
end;


procedure TRzTabControlEditor.PrepareMenuItem( Index: Integer; const Item: TMenuItem );
var
  I: Integer;
  
  procedure CreateTabMenu( Index: Integer; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Index;
    NewItem.Checked := TabControl.TabIndex = Index;
    NewItem.OnClick := TabMenuHandler;
    Item.Add( NewItem );
  end;


  procedure CreateStyleMenu( Style: TRzTabStyle; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Ord( Style );
    NewItem.Checked := TabControl.TabStyle = Style;
    NewItem.OnClick := StyleMenuHandler;
    Item.Add( NewItem );
  end;


  procedure CreateOrientationMenu( Orientation: TRzTabOrientation; const Caption: string );
  var
    NewItem: TMenuItem;
  begin
    NewItem := TMenuItem.Create( Item );
    NewItem.Caption := Caption;
    NewItem.Tag := Ord( Orientation );
    NewItem.Checked := TabControl.TabOrientation = Orientation;
    NewItem.OnClick := OrientationMenuHandler;
    Item.Add( NewItem );
  end;


begin
  inherited;

  if Index = 0 then
  begin
    // Only allow user to edit tabs if the tab control is NOT being edited in an inline frame (i.e. a frame instance).
    Item.Enabled := not IsInInlined;
  end;

  if Index = 2 then // Switch To Page
  begin
    for I := 0 to TabControl.Tabs.Count - 1 do
      CreateTabMenu( I, TabControl.Tabs[ I ].Caption );
  end;

  if Index = 4 then
  begin
    CreateStyleMenu( tsSingleSlant, 'Single Slant' );
    CreateStyleMenu( tsBackSlant, 'Back Slant' );
    CreateStyleMenu( tsDoubleSlant, 'Double Slant' );
    CreateStyleMenu( tsCutCorner, 'Cut Corner' );
    CreateStyleMenu( tsRoundCorners, 'Round Corners' );
    CreateStyleMenu( tsSquareCorners, 'Square Corners' );
  end;

  if Index = 5 then
  begin
    CreateOrientationMenu( toTop, 'Top' );
    CreateOrientationMenu( toBottom, 'Bottom' );
    CreateOrientationMenu( toLeft, 'Left' );
    CreateOrientationMenu( toRight, 'Right' );
  end;
end;


procedure TRzTabControlEditor.ExecuteVerb( Index: Integer );
begin
  case Index of
    0: EditPropertyByName( 'Tabs' );

    7: // Hide All Tabs;
    begin
      TabControl.HideAllTabs;
      TabControl.ShowShadow := False;
      DesignerModified;
    end;

    8: // Show All Tabs;
    begin
      TabControl.ShowAllTabs;
      DesignerModified;
    end;

    11: // XP Colors
    begin
      TabControl.HotTrackColorType := htctActual;
      TabControl.HotTrackColor := xpHotTrackColor;
      TabControl.TabColors.HighlightBar := xpHotTrackColor;
      TabControl.FlatColor := xpTabControlFrameColor;
      TabControl.Color := xpTabControlColor;
      TabControl.ShowShadow := True;
      DesignerModified;
    end;
  end;
end;


procedure TRzTabControlEditor.TabMenuHandler( Sender: TObject );
begin
  TabControl.TabIndex := TMenuItem( Sender ).Tag;
  DesignerModified;
end;


procedure TRzTabControlEditor.StyleMenuHandler( Sender: TObject );
begin
  TabControl.TabStyle := TRzTabStyle( TMenuItem( Sender ).Tag );
  DesignerModified;
end;


procedure TRzTabControlEditor.OrientationMenuHandler( Sender: TObject );
begin
  TabControl.TabOrientation := TRzTabOrientation( TMenuItem( Sender ).Tag );
  case TabControl.TabOrientation of
    toTop, toBottom:
      TabControl.TextOrientation := orHorizontal;

    toLeft, toRight:
      TabControl.TextOrientation := orVertical;
  end;
  DesignerModified;
end;


{=============================================}
{== TRzPropertyItemPropNameProperty Methods ==}
{=============================================}

function TRzPropertyItemPropNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paValueList, paSortList ];
end;


procedure TRzPropertyItemPropNameProperty.GetValues( Proc: TGetStrProc );
var
  I: Integer;
  L: PPropList;
  D: PTypeData;
  PropInfo: PPropInfo;
  PropName: string;
  Item: TRzPropertyItem;
  Obj, PropObj: TObject;
begin
  Item := TRzPropertyItem( GetComponent( 0 ) );
  Obj := Item.Component;

  if Obj <> nil then
  begin
    D := GetTypeData( Obj.ClassInfo );

    GetMem( L, D^.PropCount * SizeOf( TPropInfo ) );
    try
      GetPropList( Obj.ClassInfo, tkAny, L );

      for I := 0 to D^.PropCount - 1 do
      begin
        PropName := string( L^[ I ]^.Name );
        PropInfo := TypInfo.GetPropInfo( Obj.ClassInfo, PropName );

        // Check to make sure property is not write-only
        if PropInfo^.GetProc <> nil then
        begin
          case PropInfo^.PropType^.Kind of
            tkInteger, tkChar, tkWChar, tkEnumeration,
            tkSet, tkFloat, tkString, tkLString, tkWString{$IFDEF UNICODE}, tkUString{$ENDIF}:
            begin
              Proc( PropName );
            end;

            tkClass:
            begin
              PropObj := TObject( TypInfo.GetOrdProp( Obj, PropInfo ) );
              if ( PropObj <> nil ) and not ( PropObj is TComponent ) then
              begin
                // Skip component reference properties -
                // Persistent class such as TFont and Collections will be handled
                Proc( PropName );
              end;
            end;
          end;
        end;
      end;

    finally
      FreeMem( L, D^.PropCount * SizeOf( TPropInfo ) );
    end;
  end;
end;

{====================================}
{== TRzPropertyStoreEditor Methods ==}
{====================================}

function TRzPropertyStoreEditor.PropertyStore: TRzPropertyStore;
begin
  Result := Component as TRzPropertyStore;
end;


function TRzPropertyStoreEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;


function TRzPropertyStoreEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Edit Items Collection';
    1: Result := '-';
    2: Result := 'Set RegIniFile';
  end;
end;


function TRzPropertyStoreEditor.GetCompRefData( Index: Integer; var CompRefClass: TComponentClass;
                                                var CompRefPropName: string;
                                                var CompRefMenuHandler: TNotifyEvent ): Boolean;
begin
  Result := False;
  if Index = 2 then
  begin
    CompRefClass := TRzRegIniFile;
    CompRefPropName := 'RegIniFile';
    CompRefMenuHandler := nil;
    Result := True;
  end
end;


procedure TRzPropertyStoreEditor.ExecuteVerb( Index: Integer );
begin
  case Index of
    0: EditPropertyByName( 'Properties' );
  end;
end;

{== Property Editors ==========================================================}

{===================================}
{== TRzFrameStyleProperty Methods ==}
{===================================}

procedure TRzFrameStyleProperty.PropDrawName( ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean );
begin
  DefaultPropertyDrawName( Self, ACanvas, ARect );
end;


procedure TRzFrameStyleProperty.PropDrawValue( ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean );
begin
  if GetVisualValue <> '' then
  begin
    FDrawingPropertyValue := True;
    try
      PaintFrameStyleGlyph( GetVisualValue, ACanvas, ARect, ASelected );
    finally
      FDrawingPropertyValue := False;
    end;
  end
  else
  begin
    DefaultPropertyDrawValue( Self, ACanvas, ARect );
  end;
end;


function TRzFrameStyleProperty.PropDrawNameRect( const ARect: TRect ): TRect;
begin
  Result := ARect;
end;


function TRzFrameStyleProperty.PropDrawValueRect( const ARect: TRect ): TRect;
begin
  Result := Rect( ARect.Left, ARect.Top, ( ARect.Bottom - ARect.Top ) + ARect.Left, ARect.Bottom );
end;


procedure TRzFrameStyleProperty.ListMeasureHeight( const Value: string; ACanvas: TCanvas; var AHeight: Integer );
begin
  AHeight := Max( ACanvas.TextHeight( 'Yy' ), 28 );
end;


procedure TRzFrameStyleProperty.ListMeasureWidth( const Value: string; ACanvas: TCanvas; var AWidth: Integer );
begin
  AWidth := AWidth + 28;
end;


procedure TRzFrameStyleProperty.ListDrawValue( const Value: string; ACanvas: TCanvas;
                                               const ARect: TRect; ASelected: Boolean );
var
  ValueRect: TRect;
begin
  ValueRect := PaintFrameStyleGlyph( Value, ACanvas, ARect, ASelected );
  DefaultPropertyListDrawValue( Value, ACanvas, ValueRect, ASelected );
end;


function TRzFrameStyleProperty.PaintFrameStyleGlyph( const Value: string; ACanvas: TCanvas;
                                                     const ARect: TRect; ASelected: Boolean ): TRect;
var
  R: TRect;
  TextStart: Integer;
  OldBrushColor: TColor;
  FrameStyleEx: TFrameStyleEx;
begin
  R := ARect;
  R.Right := R.Left + ( R.Bottom - R.Top );

  TextStart := R.Right;
  with ACanvas do
  begin
    OldBrushColor := Brush.Color;
    Brush.Color := clBtnFace;
    FillRect( R );

    if FDrawingPropertyValue then
      InflateRect( R, -1, -1 )
    else
      InflateRect( R, -2, -2 );

    FrameStyleEx := TFrameStyleEx( GetEnumValue( GetPropInfo^.PropType^, Value ) );
    if FrameStyleEx <> fsFlatRounded then
      DrawBorder( ACanvas, R, TFrameStyle( FrameStyleEx ) )
    else
      DrawRoundedFlatBorder( ACanvas, R, clBtnShadow, sdAllSides );


    // Restore Canvas Settings
    Brush.Color := OldBrushColor;
  end;
  Result := Rect( TextStart, ARect.Top, ARect.Right, ARect.Bottom );
end;





{$IFNDEF VCL140_OR_HIGHER}
{================================}
{== TRzBooleanProperty Methods ==}
{================================}

procedure TRzBooleanProperty.ListMeasureHeight( const Value: string; ACanvas: TCanvas; var AHeight: Integer );
begin
  AHeight := Max( AHeight, 15 );
end;

procedure TRzBooleanProperty.ListMeasureWidth( const Value: string; ACanvas: TCanvas; var AWidth: Integer );
begin
  AWidth := AWidth + 15;
end;


procedure TRzBooleanProperty.PropDrawName( ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean );
begin
  DefaultPropertyDrawName( Self, ACanvas, ARect );
end;


procedure TRzBooleanProperty.PropDrawValue( ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean );
begin
  if GetVisualValue <> '' then
    ListDrawValue( GetVisualValue, ACanvas, ARect, ASelected )
  else
    DefaultPropertyDrawValue( Self, ACanvas, ARect );
end;


procedure TRzBooleanProperty.ListDrawValue( const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean );
var
  R: TRect;
  TextStart: Integer;
  BoolValue: Boolean;
  Bmp, CheckBoxBmp: TBitmap;
  TransparentColor: TColor;
  DestRct, SrcRct: TRect;
  BmpOffset: Integer;
begin
  R := ARect;
  R.Right := R.Left + ( R.Bottom - R.Top );
  TextStart := R.Right;
  with ACanvas do
  begin
    Bmp := TBitmap.Create;
    CheckBoxBmp := TBitmap.Create;
    try
      FillRect( R );

      DestRct := Classes.Rect( 0, 0, 11, 11 );
      SrcRct := DestRct;
      BmpOffset := ( ( R.Bottom - R.Top ) - 11 ) div 2;

      { Don't Forget to Set the Width and Height of Destination Bitmap }
      Bmp.Width := 11;
      Bmp.Height := 11;

      Bmp.Canvas.Brush.Color := ACanvas.Brush.Color;

      TransparentColor := clOlive;

      BoolValue := Boolean( GetEnumValue( GetPropInfo^.PropType^, Value ) );
      case BoolValue of
        False:
          CheckBoxBmp.Handle := LoadBitmap( HInstance, 'RZDESIGNEDITORS_BOOLEAN_FALSE' );

        True:
          CheckBoxBmp.Handle := LoadBitmap( HInstance, 'RZDESIGNEDITORS_BOOLEAN_TRUE' );
      end;
      Bmp.Canvas.BrushCopy( DestRct, CheckBoxBmp, SrcRct, TransparentColor );
      Draw( R.Left + 2, R.Top + BmpOffset, Bmp );
    finally
      Bmp.Free;
      CheckBoxBmp.Free;

      DefaultPropertyListDrawValue( Value, ACanvas, Rect( TextStart, ARect.Top, ARect.Right, ARect.Bottom ), ASelected );
    end;
  end;
end;
{$ENDIF}


{===================================}
{== TRzActivePageProperty Methods ==}
{===================================}

function TRzActivePageProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paValueList ];
end;


procedure TRzActivePageProperty.GetValues( Proc: TGetStrProc );
var
  I: Integer;
  APageControl: TRzPageControl;
begin
  APageControl := TRzPageControl( GetComponent( 0 ) );
  for I := 0 to APageControl.PageCount - 1 do
  begin
    if APageControl.Pages[ I ].Name <> '' then
      Proc( APageControl.Pages[ I ].Name );
  end;
end;

{=================================}
{== TRzFileNameProperty Methods ==}
{=================================}

procedure TRzFileNameProperty.Edit;
var
  DlgOpen: TOpenDialog;
begin
  DlgOpen := TOpenDialog.Create( Application );
  DlgOpen.FileName := GetValue;
  DlgOpen.Filter := 'Executables|*.EXE;*.BAT;*.COM;*.PIF|All Files|*.*';
  DlgOpen.Options := DlgOpen.Options + [ofPathMustExist, ofFileMustExist];
  try
    if DlgOpen.Execute then
      SetValue( DlgOpen.FileName );
  finally
    DlgOpen.Free;
  end;
end;


function TRzFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paDialog, paRevertable ];
end;


{===============================}
{== TRzActionProperty Methods ==}
{===============================}

function TRzActionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paValueList, paMultiSelect ];
end;


procedure TRzActionProperty.GetValues( Proc: TGetStrProc );
begin
  Proc( 'Open' );
  Proc( 'Print' );
  Proc( 'Explore' );
end;



{=====================================}
{== TRzCustomColorsProperty Methods ==}
{=====================================}

procedure TRzCustomColorsProperty.Edit;
var
  DlgColor: TColorDialog;
begin
  DlgColor := TColorDialog.Create( Application );
  try
    DlgColor.CustomColors := TStrings( GetOrdValue );
    DlgColor.Options := [ cdFullOpen ];
    if DlgColor.Execute then
      SetOrdValue( Longint( DlgColor.CustomColors ) );
  finally
    DlgColor.Free;
  end;
end;


function TRzCustomColorsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paDialog ];
end;



{===========================}
{== TRzPaletteSep Methods ==}
{===========================}

constructor TRzPaletteSep.Create( AOwner: TComponent );
begin
  raise Exception.Create( 'Palette Separator - Only for use on Component Palette' );
end;


{== Designer Guidelines =======================================================}


type
  TRzOpenCustomButton = class( TCustomButton )
  end;

  TRzOpenButton = class( TButton )
  end;


{=======================================}
{== TRzCustomButtonGuidelines Methods ==}
{=======================================}

function TRzCustomButtonGuidelines.GetCount: Integer;
begin
  Result := inherited GetCount + 1;
end;

//
function TRzCustomButtonGuidelines.GetDesignerGuideOffset( Index: Integer ): Integer;
var
  Button: TCustomButton;
  TextLayout: TTextLayout;
begin
  if Index >= inherited GetCount then
  begin
//    Button := Component as TRzCustomButton;
//    TextLayout := TTextLayout( Ord( TRzOpenCustomButton( Button ).AlignmentVertical ) );

    Button := Component as TCustomButton;
//    TextLayout := TTextLayout( Ord( TRzOpenCustomButton( Button ).AlignmentVertical ) );

    Result := GetTextBaseline( Button, TextLayout );
    case TextLayout of
      tlTop:    Inc( Result );
      tlBottom: Dec( Result, 2 );
    end;
  end
  else
  begin
    Result := inherited GetDesignerGuideOffset( Index )
  end;
end;
//

function TRzCustomButtonGuidelines.GetDesignerGuideType( Index: Integer ): TDesignerGuideType;
begin
  if Index >= inherited GetCount then
    Result := gtBaseline
  else
    Result := inherited GetDesignerGuideType( Index );
end;


{======================================}
{== TRzPageControlGuidelines Methods ==}
{======================================}

function TRzPageControlGuidelines.GetDesignerGuideOffset( Index: Integer ): Integer;
var
  PC: TRzPageControl;
begin
  Result := inherited GetDesignerGuideOffset( Index );

  case Index of
    2, 3:
    begin
      PC := Component as TRzPageControl;
      if PC.ShowShadow then
        Result := Result - 2;
    end;
  end;
end;


{=====================================}
{== TRzTabControlGuidelines Methods ==}
{=====================================}

function TRzTabControlGuidelines.GetDesignerGuideOffset( Index: Integer ): Integer;
var
  TC: TRzTabControl;
begin
  Result := inherited GetDesignerGuideOffset( Index );

  case Index of
    2, 3:
    begin
      TC := Component as TRzTabControl;
      if TC.ShowShadow then
        Result := Result - 2;
    end;
  end;
end;


end.
