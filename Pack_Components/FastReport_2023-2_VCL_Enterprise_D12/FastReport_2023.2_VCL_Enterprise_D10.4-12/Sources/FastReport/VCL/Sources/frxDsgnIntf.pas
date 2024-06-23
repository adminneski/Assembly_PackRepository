
{******************************************}
{                                          }
{             FastReport VCL               }
{             Design interface             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxDsgnIntf;

interface

{$I frx.inc}

uses
  SysUtils, Types,
{$IFNDEF FPC}
  Windows, Messages,
{$ENDIF}
  Classes, Graphics, Controls, StdCtrls, Menus, TypInfo, Variants,
{$IFDEF FPC}
  LCLType, LazHelper, LCLProc,
{$ENDIF}  
  frxClass, frCore;
  

type
  /// <summary>
  ///   Property editor attributes.
  /// </summary>
  TfrxPropertyAttribute = (
    /// <summary>
    ///   The property represents the dropdown list of values. (This function
    ///   is exemplified in the "Color" property). If this attribute is
    ///   presented, the "GetValues" method should be overridden. <br />
    /// </summary>
    paValueList,
    /// <summary>
    ///   Sorts the list's elements. It is used together with paValueList.
    /// </summary>
    paSortList,
    /// <summary>
    ///   The property has an editor. If this attribute is presented, the ...
    ///   button is displayed in the right part of the editing line. The Edit
    ///   method is called on by clicking on it.
    /// </summary>
    paDialog,
    /// <summary>
    ///   Allow editing of the given property in some objects selected at the
    ///   same time. Some properties (such as "Name", etc) do not have this
    ///   attribute.
    /// </summary>
    paMultiSelect,
    /// <summary>
    ///   The property is an object of the TPersistent type and has its own
    ///   properties, which are also should be displayed. (This function is
    ///   exemplified in the "Font" property)
    /// </summary>
    paSubProperties,
    /// <summary>
    ///   It is impossible to modify a value in the editor line. Some
    ///   properties, being the "Class" or "Set" types, possess this attribute.
    /// </summary>
    paReadOnly,
    /// <summary>
    ///   Drawing of the property's value is performed via the "OnDrawItem"
    ///   method. If the "paValueList" attribute is defined, then drawing of
    ///   the drop-down list is performed via the OnDrawLBItem method.
    /// </summary>
    paOwnerDraw);
  /// <summary>
  ///   Property editor attributes.
  /// </summary>
  TfrxPropertyAttributes = set of TfrxPropertyAttribute;

  /// <summary>
  ///   The TfrxPropertyEditor class is the base class for all property
  ///   editors.
  /// </summary>
  TfrxPropertyEditor = class(TObject)
  private
    FDesigner: TfrxCustomDesigner;
    FPropList: TList;
    FItemHeight: Integer;
    FValues: TStrings;
    function GetPropInfo: PPropInfo;
    function GetComponent: TPersistent;
    function GetfrComponent: TfrxComponent;
  protected
    FCompList: TList;
    procedure GetStrProc(const s: String);
    /// <summary>
    ///   Method get a property value of type Extended.
    /// </summary>
    function GetFloatValue: Extended;
    /// <summary>
    ///   Method get a property value of type Integer.
    /// </summary>
    function GetOrdValue: frInteger;
    /// <summary>
    ///   Method get a property value of type Integer.
    /// </summary>
    function GetInt64Value: Int64;
    /// <summary>
    ///   Method get a property value of type String.
    /// </summary>
    function GetStrValue: String;
    /// <summary>
    ///   Method get a property value of type Variant.
    /// </summary>
    function GetVarValue: Variant;
    /// <summary>
    ///   Method sets a property value of type Extended.
    /// </summary>
    procedure SetFloatValue(Value: Extended);
    /// <summary>
    ///   Method sets a property value of type Integer.
    /// </summary>
    procedure SetOrdValue(Value: Int64);
    /// <summary>
    ///   Method sets a property value of type String.
    /// </summary>
    procedure SetStrValue(const Value: String);
    /// <summary>
    ///   Method sets a property value of type Variant.
    /// </summary>
    procedure SetVarValue(Value: Variant);
  public
    /// <summary>
    ///   The constructor.
    /// </summary>
    constructor Create(Designer: TfrxCustomDesigner); virtual;
    destructor Destroy; override;
    /// <summary>
    ///   Method is called in two cases: either by selecting a property, by
    ///   double-clicking its value, or (if a property has the paDialog
    ///   attribute) by clicking the ... button. The method should return
    ///   "True," if the property's value was modified.
    /// </summary>
    function Edit: Boolean; virtual;
    /// <summary>
    ///   The "GetAttributes" method is to return a set of the property's
    ///   attributes. You should override this method in most cases.
    /// </summary>
    function GetAttributes: TfrxPropertyAttributes; virtual;
    /// <summary>
    ///   Method returns the name of the property.
    /// </summary>
    function GetName: String; virtual;
    /// <summary>
    ///   The "GetExtraLBSize" method is called in case you defined the
    ///   "paValueList" attribute. The method returns the number of pixels, by
    ///   which the width of the drop-down list should be adjusted in order to
    ///   find room for the displayed picture. By default, this method returns
    ///   the value corresponding to the cell's height for property's
    ///   enveloping. If you need to deduce a picture, width of which is larger
    ///   than its height, the given method should be overridden.
    /// </summary>
    function GetExtraLBSize: Integer; virtual;
    /// <summary>
    ///   The "GetValue" method should return the property's value as a string
    ///   (it will be displayed in the object inspector). If you inherit from
    ///   the TfrxPropertyEditor basic class, it is necessary to override the
    ///   method.
    /// </summary>
    function GetValue: String; virtual;
    /// <summary>
    ///   The "GetValues" method should be overridden in case you defined the
    ///   "paValueList" attribute. This method should fill the "Values"
    ///   property with values.
    /// </summary>
    procedure GetValues; virtual;
    /// <summary>
    ///   The "SetValue" method is to set the property's value transferred as a
    ///   string. If you inherit from the TfrxPropertyEditor basic class, it is
    ///   necessary to override the method.
    /// </summary>
    procedure SetValue(const Value: String); virtual;
    /// <summary>
    ///   The "OnDrawLBItem" method is called when drawing a string in the
    ///   drop-down list, if you defined the paValueList attribute. In fact,
    ///   this method is the TListBox.OnDrawItem event's handler and has the
    ///   same set of parameters.
    /// </summary>
    procedure OnDrawLBItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState); virtual;
    /// <summary>
    ///   The "OnDrawItem" method is called when drawing the property's value
    ///   in the object inspector (when the property is not selected; otherwise
    ///   its value is simply displayed in the editing line). For example, the
    ///   Color property's editor draws a rectangle, filled with the color
    ///   according to the value, at the left of the property's value.
    /// </summary>
    procedure OnDrawItem(Canvas: TCanvas; ARect: TRect); virtual;
    /// <summary>
    ///   Reference to the parent component (not to the property itself!), to
    ///   which the given property belongs.
    /// </summary>
    property Component: TPersistent read GetComponent;
    /// <summary>
    ///   Reference to the parent component (not to the property itself!), to
    ///   which the given property belongs. Cast to the TfrxComponent type (for
    ///   convenience of use in some cases).
    /// </summary>
    property frComponent: TfrxComponent read GetfrComponent;
    /// <summary>
    ///   Reference to the report's designer.
    /// </summary>
    property Designer: TfrxCustomDesigner read FDesigner;
    /// <summary>
    ///   Height of the item, in which the property is displayed. It can be
    ///   useful in the OnDrawXXX methods.
    /// </summary>
    property ItemHeight: Integer read FItemHeight write FItemHeight;
    /// <summary>
    ///   Link to the PPropInfo structure, which contains information about the
    ///   edited property.
    /// </summary>
    property PropInfo: PPropInfo read GetPropInfo;
    /// <summary>
    ///   Property's value displayed as a string.
    /// </summary>
    property Value: String read GetValue write SetValue;
    /// <summary>
    ///   The list of values. This property is to be filled in the "GetValue"
    ///   method, if the "paValueList" attribute is defined.
    /// </summary>
    property Values: TStrings read FValues;
  end;

  TfrxPropertyEditorClass = class of TfrxPropertyEditor;

  /// <summary>
  ///   The TfrxComponentEditor class is the base class for all component
  ///   editors.
  /// </summary>
  TfrxComponentEditor = class(TObject)
  private
    FComponent: TfrxComponent;
    FDesigner: TfrxCustomDesigner;
    FMenu: TMenu;
  protected
    /// <summary>
    ///   Adds a menu item to the context menu of the edited component.
    /// </summary>
    function AddItem(const Caption: String; Tag: Integer;
      Checked: Boolean = False; Own: TMenuItem = nil): TMenuItem;
  public
    /// <summary>
    ///   The constructor.
    /// </summary>
    constructor Create(Component: TfrxComponent; Designer: TfrxCustomDesigner;
      Menu: TMenu); virtual;
    /// <summary>
    ///   Method should perform necessary actions (for example, display a
    ///   dialogue box) and returns "True," if the component's state was
    ///   modified.
    /// </summary>
    function Edit: Boolean; virtual;
    /// <summary>
    ///   The "HasEditor" method should return "True" if your component has an
    ///   editor. If it either returns "False" or you do not override this
    ///   method, the editor will not be called.
    /// </summary>
    function HasEditor: Boolean; virtual;
    /// <summary>
    ///   You should override this method if you need to add items in the
    ///   component's context menu. Items should be added by AddItem method.
    /// </summary>
    procedure GetMenuItems; virtual;
    /// <summary>
    ///   Method is called, when you select one of your items in the
    ///   component's menu; response to the selected menu item should be
    ///   described here.
    /// </summary>
    function Execute(Tag: Integer; Checked: Boolean): Boolean; virtual;
    /// <summary>
    ///   Link to the edited component.
    /// </summary>
    property Component: TfrxComponent read FComponent write FComponent;
    /// <summary>
    ///   Link to the designer.
    /// </summary>
    property Designer: TfrxCustomDesigner read FDesigner;
  end;

  TfrxComponentEditorClass = class of TfrxComponentEditor;

  /// <summary>
  ///   The standard editor of properties of type Integer.
  /// </summary>
  TfrxIntegerProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxInt64Property = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type Extended.
  /// </summary>
  TfrxFloatProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type Char.
  /// </summary>
  TfrxCharProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type String.
  /// </summary>
  TfrxStringProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type Enum.
  /// </summary>
  TfrxEnumProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type Set.
  /// </summary>
  TfrxSetProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
  end;

  /// <summary>
  ///   The standard editor of properties of type Set element.
  /// </summary>
  TfrxSetElementProperty = class(TfrxPropertyEditor)
  private
    FElement: Integer;
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetName: String; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
   end;

  /// <summary>
  ///   The standard editor of properties of type TObject.
  /// </summary>
  TfrxClassProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TComponent.
  /// </summary>
  TfrxComponentProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TComponentName.
  /// </summary>
  TfrxNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TClass.
  /// </summary>
  TfrxClassNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TColor.
  /// </summary>
  TfrxColorProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
    procedure OnDrawLBItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState); override;
    procedure OnDrawItem(Canvas: TCanvas; ARect: TRect); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TFont.
  /// </summary>
  TfrxFontProperty = class(TfrxClassProperty)
  public
    function Edit: Boolean; override;
    function GetAttributes: TfrxPropertyAttributes; override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TFont.Name.
  /// </summary>
  TfrxFontNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TFont.Charset.
  /// </summary>
  TfrxFontCharsetProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TModalResult.
  /// </summary>
  TfrxModalResultProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TShortCut.
  /// </summary>
  TfrxShortCutProperty = class(TfrxPropertyEditor)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  /// <summary>
  ///   The standard editor of properties of type TCursor.
  /// </summary>
  TfrxCursorProperty = class(TfrxIntegerProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function GetValue: String; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxDateTimeProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxDateProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxTimeProperty = class(TfrxPropertyEditor)
  public
    function GetValue: String; override;
    procedure SetValue(const Value: String); override;
  end;

{ Internal classes used by Object Inspector }

  TfrxPropertyList = class;

  TfrxPropertyItem = class(TCollectionItem)
  private
    FEditor: TfrxPropertyEditor;
    FExpanded: Boolean;
    FSubProperty: TfrxPropertyList;
  public
    destructor Destroy; override;
    property Editor: TfrxPropertyEditor read FEditor;
    property Expanded: Boolean read FExpanded write FExpanded;
    property SubProperty: TfrxPropertyList read FSubProperty;
  end;

  TfrxPropertyList = class(TCollection)
  private
    FComponent: TPersistent;
    FDesigner: TfrxCustomDesigner;
    FParent: TfrxPropertyList;
    FFilter: String;
    procedure AddProperties(PropertyList: TfrxPropertyList);
    procedure FillProperties(AClass: TPersistent);
    procedure FillCommonProperties(PropertyList: TfrxPropertyList);
    procedure SetComponent(Value: TPersistent);
    function GetPropertyItem(Index: Integer): TfrxPropertyItem;
    procedure SetFilter(const Value: String);
  public
    constructor Create(Designer: TfrxCustomDesigner);
    function Add: TfrxPropertyItem;
    function FindSame(const AToFind: TfrxPropertyItem): TfrxPropertyItem;
    property Component: TPersistent read FComponent write SetComponent;
    property Items[Index: Integer]: TfrxPropertyItem read GetPropertyItem; default;
    property Parent: TfrxPropertyList read FParent;
    property Filter: String read FFilter write SetFilter;
  end;


{ registered items }

  TfrxObjectCategory = (ctData, ctReport, ctDialog, ctDMP, ctNone);
  TfrxObjectCategories = set of TfrxObjectCategory;

  TfrxObjectItem = class(TCollectionItem)
  public
    ClassRef: TfrxComponentClass;
    ButtonBmp: TBitmap;
    ButtonImageIndex: Integer;
    ButtonHint: String;
    CategoryName: String;
    Flags: Word;
    Category: TfrxObjectCategories;
  end;

  TfrxComponentEditorItem = class(TCollectionItem)
  public
    ComponentClass: TfrxComponentClass;
    ComponentEditor: TfrxComponentEditorClass;
  end;

  TfrxPropertyEditorItem = class(TCollectionItem)
  public
    PropertyType: PTypeInfo;
    ComponentClass: TClass;
    PropertyName: String;
    EditorClass: TfrxPropertyEditorClass;
  end;

  TfrxExportFilterItem = class(TCollectionItem)
  public
    Filter: TfrxCustomExportFilter;
  end;

  TfrxWizardItem = class(TCollectionItem)
  public
    ClassRef: TfrxWizardClass;
    ButtonBmp: TBitmap;
    WizardButtonBmp: TBitmap;
    ButtonImageIndex: Integer;
    ToolBarButtonImageIndex: Integer;
    IsToolbarWizard: Boolean;
  end;

  /// <summary>
  ///   The TfrxObjectCollection class represents list of objects registered in
  ///   the FastReport. frxObjects global object contains an instance of this
  ///   class.
  /// </summary>
  TfrxObjectCollection = class(TCollection)
  private
    function GetObjectItem(Index: Integer): TfrxObjectItem;
  public
    constructor Create;
    /// <summary>
    ///   Registers a category. <br />
    /// </summary>
    /// <param name="CategoryName">
    ///   Name of the category.This name is used for identification of the
    ///   category only and does not appear anywhere else. It should also be
    ///   used when calling the "frxObjects.RegisterObject" procedure, if you
    ///   want to place the registered object inside the given category.
    /// </param>
    /// <param name="ButtonBmp">
    ///   Category bitmap of size 16x16.
    /// </param>
    /// <param name="ButtonHint">
    ///   Category hint. It is displayed as a hint, if the button with a
    ///   category is selected by the cursor.
    /// </param>
    /// <param name="ImageIndex">
    ///   Index of the bitmap from standard set of bitmaps if the ButtonBmp
    ///   parameter is nil.
    /// </param>
    procedure RegisterCategory(const CategoryName: String; ButtonBmp: TBitmap;
      const ButtonHint: String; ImageIndex: Integer = -1);
    /// <summary>
    ///   Registers an add-in object. During registration, you should specify
    ///   control class' name, its picture, and the name of a category, to
    ///   which it should be placed. If the name of a category is not
    ///   specified, the control is placed in the basic component palette. The
    ///   ButtonBmp size should be 16x16 pixels.
    /// </summary>
    /// <param name="ClassRef">
    ///   Component class reference.
    /// </param>
    /// <param name="ButtonBmp">
    ///   Component image.
    /// </param>
    /// <param name="CategoryName">
    ///   Category name.
    /// </param>
    procedure RegisterObject(ClassRef: TfrxComponentClass; ButtonBmp: TBitmap;
      const CategoryName: String = '');
    /// <summary>
    ///   Method is used for registration of internal FastReport objects.
    /// </summary>
    procedure RegisterObject1(ClassRef: TfrxComponentClass; ButtonBmp: TBitmap;
      const ButtonHint: String = ''; const CategoryName: String = '';
      Flags: Integer = 0; ImageIndex: Integer = -1;
      Category: TfrxObjectCategories = []);
    /// <summary>
    ///   Deletes the object from registered object's list.
    /// </summary>
    procedure Unregister(ClassRef: TfrxComponentClass);
    /// <summary>
    ///   list of registered components.
    /// </summary>
    property Items[Index: Integer]: TfrxObjectItem read GetObjectItem; default;
  end;

  /// <summary>
  ///   The TfrxComponentEditorCollection class represents a list of component
  ///   editors registered in the FastReport. frxComponentEditors global object
  ///   contains an instance of this class.
  /// </summary>
  TfrxComponentEditorCollection = class(TCollection)
  private
    function GetComponentEditorItem(Index: Integer): TfrxComponentEditorItem;
  public
    constructor Create;
    /// <summary>
    ///   Registers a component editor. The first parameter is the class' name,
    ///   for which the editor is to be created. The second parameter is the
    ///   name of the editor's class.
    /// </summary>
    /// <param name="ComponentClass">
    ///   Component class reference.
    /// </param>
    /// <param name="ComponentEditor">
    ///   Editor class reference.
    /// </param>
    procedure Register(ComponentClass: TfrxComponentClass;
      ComponentEditor: TfrxComponentEditorClass);
    /// <summary>
    ///   Remove editor class from registered list.
    /// </summary>
    procedure UnRegister(ComponentEditor: TfrxComponentEditorClass);
    /// <summary>
    ///   Creates new instance of component editor.
    /// </summary>
    function GetComponentEditor(Component: TfrxComponent;
      Designer: TfrxCustomDesigner; Menu: TMenu): TfrxComponentEditor;
    /// <summary>
    ///   List of registered component editors.
    /// </summary>
    property Items[Index: Integer]: TfrxComponentEditorItem
      read GetComponentEditorItem; default;
  end;

  /// <summary>
  ///   The TfrxPropertyEditorCollection class represents a list of property
  ///   editors registered in the FastReport. frxPropertyEditors global object
  ///   contains an instance of this class.
  /// </summary>
  TfrxPropertyEditorCollection = class(TCollection)
  private
    FEventEditorItem: Integer;
    function GetPropertyEditorItem(Index: Integer): TfrxPropertyEditorItem;
  public
    constructor Create;
    /// <summary>
    ///   Registers a property editor.
    /// </summary>
    /// <param name="PropertyType">
    ///   Information about the property's type, transferred via the "TypeInfo"
    ///   system function, for example TypeInfo(String).
    /// </param>
    /// <param name="ComponentClass">
    ///   Name of the component, the property of which you want to edit (may be
    ///   nil).
    /// </param>
    /// <param name="PropertyName">
    ///   Name of the property you want to edit (may be a blank string).
    /// </param>
    /// <param name="EditorClass">
    ///   Name of the property's editor.
    /// </param>
    procedure Register(PropertyType: PTypeInfo; ComponentClass: TClass;
      const PropertyName: String; EditorClass: TfrxPropertyEditorClass);
    procedure RegisterEventEditor(EditorClass: TfrxPropertyEditorClass);
    procedure UnRegister(EditorClass: TfrxPropertyEditorClass);
    function GetPropertyEditor(PropertyType: PTypeInfo; Component: TPersistent;
      PropertyName: String): Integer;
    property Items[Index: Integer]: TfrxPropertyEditorItem
      read GetPropertyEditorItem; default;
  end;

  /// <summary>
  ///   The TfrxExportFilterCollection class represents a list of export
  ///   filters registered in the FastReport. frxExportFilters global object
  ///   contains an instance of this class.
  /// </summary>
  TfrxExportFilterCollection = class(TCollection)
  private
    function GetExportFilterItem(Index: Integer): TfrxExportFilterItem;
  public
    constructor Create;
    /// <summary>
    ///   Registers an export filter.
    /// </summary>
    procedure Register(Filter: TfrxCustomExportFilter);
    /// <summary>
    ///   Deletes an export filter from the list of registered items.
    /// </summary>
    procedure Unregister(Filter: TfrxCustomExportFilter);
    property Items[Index: Integer]: TfrxExportFilterItem
      read GetExportFilterItem; default;
  end;

  TfrxSaveFilterItem = class(TCollectionItem)
  public
    SaveFilter: TfrxCustomIOTransport;
  end;

  TfrxSaveFiltersCollection = class(TCollection)
  private
    function GetSaveFilterItem(Index: Integer): TfrxSaveFilterItem;
  public
    constructor Create;
    procedure Register(Filter: TfrxCustomIOTransport);
    procedure Unregister(Filter: TfrxCustomIOTransport);
    property Items[Index: Integer]: TfrxSaveFilterItem
      read GetSaveFilterItem; default;
  end;

  /// <summary>
  ///   The TfrxWizardCollection class represents a list of wizards registered
  ///   in the FastReport. frxWizards global object contains an instance of
  ///   this class.
  /// </summary>
  TfrxWizardCollection = class(TCollection)
  private
    function GetWizardItem(Index: Integer): TfrxWizardItem;
  public
    constructor Create;
    /// <summary>
    ///   Registers a wizard. At registration, one enters the name of the
    ///   wizard's class, its picture, and specifies if the wizard is placed in
    ///   the "Wizards" toolbar. If the wizard should be placed in the toolbar,
    ///   the ButtonBmp size must be either 16x16 pixels, or 32x32 pixels
    ///   otherwise.
    /// </summary>
    procedure Register(ClassRef: TfrxWizardClass; ButtonBmp: TBitmap;
      IsToolbarWizard: Boolean = False; Bmp32x32: TBitmap = nil);
    procedure Register1(ClassRef: TfrxWizardClass; ImageIndex: Integer);
    /// <summary>
    ///   Deletes a wizard from the list of registered items.
    /// </summary>
    procedure Unregister(ClassRef: TfrxWizardClass);
    property Items[Index: Integer]: TfrxWizardItem read GetWizardItem; default;
  end;


{ internal methods }

function frxCreatePropertyList(ComponentList: TList; Designer: TfrxCustomDesigner; aFilter: String = ''): TfrxPropertyList;
procedure frxHideProperties(ComponentClass: TClass; const Properties: String);
function frxIsHiddenProperty(ComponentClass: TClass; const PropName: String): Boolean;


/// <summary>
///   List of add-in objects registered in the FastReport.
/// </summary>
function frxObjects: TfrxObjectCollection;
/// <summary>
///   List of component editors registered in the FastReport.
/// </summary>
function frxComponentEditors: TfrxComponentEditorCollection;
/// <summary>
///   List of property editors registered in the FastReport.
/// </summary>
function frxPropertyEditors: TfrxPropertyEditorCollection;
/// <summary>
///   List of export filters registered in the FastReport.
/// </summary>
function frxExportFilters: TfrxExportFilterCollection;
/// <summary>
///   List of wizards registered in the FastReport.
/// </summary>
function frxWizards: TfrxWizardCollection;


implementation

uses
{$IFNDEF FPC}
  Consts,
{$ENDIF}
  Forms, Dialogs, frxUtils, frxRes, frDPIAwareUtils;

type
  TIntegerSet = set of 0..31;

var
  FObjects: TfrxObjectCollection = nil;
  FComponentEditors: TfrxComponentEditorCollection = nil;
  FPropertyEditors: TfrxPropertyEditorCollection = nil;
  FExportFilters: TfrxExportFilterCollection = nil;
  FSaveFilters: TfrxSaveFiltersCollection = nil;
  FWizards: TfrxWizardCollection = nil;

{ Routines }

procedure frxHideProperties(ComponentClass: TClass; const Properties: String);
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  frxSetCommaText(Properties, sl);

  for i := 0 to sl.Count - 1 do
    frxPropertyEditors.Register(nil, ComponentClass, sl[i], nil);

  sl.Free;
end;

function frxIsHiddenProperty(ComponentClass: TClass; const PropName: String): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to frxPropertyEditors.Count - 1 do
  begin
   Result := (frxPropertyEditors.Items[i].PropertyType = nil) and (frxPropertyEditors.Items[i].EditorClass = nil)
    and (frxPropertyEditors.Items[i].ComponentClass = ComponentClass) and SameText(frxPropertyEditors.Items[i].PropertyName, PropName);
   if Result then
      Exit;
  end;
end;

function frxCreatePropertyList(ComponentList: TList;
  Designer: TfrxCustomDesigner; aFilter: String): TfrxPropertyList;
var
  i: Integer;
  p: TfrxPropertyList;
  l: TList;
begin
  if ComponentList.Count = 0 then
  begin
    Result := nil;
    Exit;
  end;

  l := TList.Create;
  for i := 0 to ComponentList.Count - 1 do
  begin
    p := TfrxPropertyList.Create(Designer);
    p.Filter := aFilter;
    l.Add(p);
    p.Component := ComponentList[i];
  end;

  Result := l[0];
  for i := 1 to ComponentList.Count - 1 do
    Result.FillCommonProperties(TfrxPropertyList(l[i]));

  for i := 1 to ComponentList.Count - 1 do
  begin
    TfrxPropertyList(l[i]).FillCommonProperties(Result);
    Result.AddProperties(TfrxPropertyList(l[i]));
    TfrxPropertyList(l[i]).Free;
  end;

  l.Free;
end;

function frStrToFloat(s: String): Extended;
var
  i: Integer;
begin
  for i := 1 to Length(s) do
{$IFDEF DELPHI12}
    if CharInSet(s[i], [',', '.']) then
{$ELSE}
    if s[i] in [',', '.'] then
{$ENDIF}
{$IFDEF DELPHI16}
      s[i] := FormatSettings.DecimalSeparator;
{$ELSE}
      s[i] := DecimalSeparator;
{$ENDIF}
  Result := StrToFloat(Trim(s));
end;


{ TfrxPropertyEditor }

constructor TfrxPropertyEditor.Create(Designer: TfrxCustomDesigner);
begin
  FDesigner := Designer;
  FCompList := TList.Create;
  FPropList := TList.Create;
  FValues := TStringList.Create;
end;

destructor TfrxPropertyEditor.Destroy;
begin
  FCompList.Free;
  FPropList.Free;
  FValues.Free;
  inherited;
end;

function TfrxPropertyEditor.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect];
end;

function TfrxPropertyEditor.GetName: String;
begin
  Result := String(PropInfo.Name);
end;

function TfrxPropertyEditor.GetComponent: TPersistent;
begin
  Result := FCompList[0];
end;

function TfrxPropertyEditor.GetfrComponent: TfrxComponent;
begin
  if TObject(FCompList[0]) is TfrxComponent then
    Result := FCompList[0] else
    Result := nil;
end;

function TfrxPropertyEditor.GetPropInfo: PPropInfo;
begin
  Result := FPropList[0];
end;

function TfrxPropertyEditor.GetValue: String;
begin
  Result := '(Unknown)';
end;

procedure TfrxPropertyEditor.SetValue(const Value: String);
begin
  { empty method }
end;

function TfrxPropertyEditor.GetFloatValue: Extended;
begin
  Result := GetFloatProp(Component, PropInfo);
end;

function TfrxPropertyEditor.GetOrdValue: frInteger;
begin
  Result := GetOrdProp(Component, PropInfo);
end;

function TfrxPropertyEditor.GetInt64Value: Int64;
begin
  Result := GetInt64Prop(Component, PropInfo);
end;

function TfrxPropertyEditor.GetStrValue: String;
begin
  Result := GetStrProp(Component, PropInfo);
end;

function TfrxPropertyEditor.GetVarValue: Variant;
begin
  Result := GetVariantProp(Component, PropInfo);
end;

procedure TfrxPropertyEditor.SetFloatValue(Value: Extended);
var
  i: Integer;
begin
  for i := 0 to FCompList.Count - 1 do
    if (PPropInfo(FPropList[i]).SetProc <> nil) then
      SetFloatProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value);
end;

procedure TfrxPropertyEditor.SetOrdValue(Value: Int64);
var
  i: Integer;
begin
  { need to lock inspector for update for all objects except last }
  { otherwise this code generate AV during update designer like with FillType property }
  if (FDesigner <> nil) and (FCompList.Count > 0) then
    FDesigner.DisableInspectorUpdate;
  for i := 0 to FCompList.Count - 1 do
  begin
    if (FDesigner <> nil) and (FCompList.Count - 1 = i) then
      FDesigner.EnableInspectorUpdate;

    if (PPropInfo(FPropList[i]).SetProc <> nil) then
    begin
      if PPropInfo(FPropList[i]).PropType^.Kind = tkInt64 then
        SetInt64Prop(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value)
      else
        SetOrdProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), frInteger(Value));
    end;
  end;
end;

procedure TfrxPropertyEditor.SetStrValue(const Value: String);
var
  i: Integer;
begin
  for i := 0 to FCompList.Count - 1 do
    if (PPropInfo(FPropList[i]).SetProc <> nil) then
      SetStrProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value);
end;

procedure TfrxPropertyEditor.SetVarValue(Value: Variant);
var
  i: Integer;
begin
  for i := 0 to FCompList.Count - 1 do
    if (PPropInfo(FPropList[i]).SetProc <> nil) then
      SetVariantProp(TObject(FCompList[i]), PPropInfo(FPropList[i]), Value);
end;

procedure TfrxPropertyEditor.GetValues;
begin
  FValues.Clear;
  TStringList(FValues).Sorted := paSortList in GetAttributes;
end;

procedure TfrxPropertyEditor.GetStrProc(const s: String);
begin
  FValues.Add(s);
end;

function TfrxPropertyEditor.Edit: Boolean;
var
  i: Integer;
begin
  Result := False;
  GetValues;
  if FValues.Count > 0 then
  begin
    i := FValues.IndexOf(Value) + 1;
    if i = FValues.Count then
      i := 0;
    Value := FValues[i];
    Result := True;
  end;
end;

procedure TfrxPropertyEditor.OnDrawLBItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  with TListBox(Control).Canvas do
  begin
    FillRect(ARect);
    TextOut(ARect.Left + FItemHeight + 4, ARect.Top + 1, TListBox(Control).Items[Index]);
    Pen.Color := clGray;
  end;
end;

procedure TfrxPropertyEditor.OnDrawItem(Canvas: TCanvas; ARect: TRect);
begin
  Canvas.TextOut(ARect.Left + FItemHeight - 2, ARect.Top, Value);
  Canvas.Pen.Color := clGray;
end;

function TfrxPropertyEditor.GetExtraLBSize: Integer;
begin
  Result := FItemHeight + 2;
end;


{ TfrxComponentEditor }

function TfrxComponentEditor.Edit: Boolean;
begin
  Result := False;
end;

procedure TfrxComponentEditor.GetMenuItems;
begin
// empty method
end;

function TfrxComponentEditor.Execute(Tag: Integer; Checked: Boolean): Boolean;
begin
  Result := False;
end;

function TfrxComponentEditor.HasEditor: Boolean;
begin
  Result := False;
end;

function TfrxComponentEditor.AddItem(const Caption: String; Tag: Integer;
  Checked: Boolean; Own: TMenuItem): TMenuItem;
begin
  Result := TMenuItem.Create(FMenu);
  Result.Caption := Caption;
  Result.Tag := Tag;
  Result.Checked := Checked;
  if Own = nil then
    FMenu.Items.Add(Result)
  else
    Own.Add(Result);
end;


constructor TfrxComponentEditor.Create(Component: TfrxComponent;
  Designer: TfrxCustomDesigner; Menu: TMenu);
begin
  FComponent := Component;
  FDesigner := Designer;
  FMenu := Menu;
end;


{ TfrxPropertyList }

constructor TfrxPropertyList.Create(Designer: TfrxCustomDesigner);
begin
  inherited Create(TfrxPropertyItem);
  FDesigner := Designer;
end;

function TfrxPropertyList.GetPropertyItem(Index: Integer): TfrxPropertyItem;
begin
  Result := TfrxPropertyItem(inherited Items[Index]);
end;

function TfrxPropertyList.Add: TfrxPropertyItem;
begin
  Result := TfrxPropertyItem(inherited Add);
end;

procedure TfrxPropertyList.SetComponent(Value: TPersistent);
begin
  FComponent := Value;
  Clear;
  FillProperties(FComponent);
end;

procedure TfrxPropertyList.SetFilter(const Value: String);
begin
  FFilter := UpperCase(Value);
end;

procedure TfrxPropertyList.FillProperties(AClass: TPersistent);
var
  Item, Item1: TfrxPropertyItem;
  TypeInfo: PTypeInfo;
  PropertyCount: Integer;
  PropertyList: PPropList;
  i, j: Integer;
  FClass: TClass;
  aObj: TPersistent;
  bIsFiltred: Boolean;
  PropIntf: IInspectedProperties;
  AddPropList: TfrxExtPropList;

  function CreateEditor(EditorClass: TfrxPropertyEditorClass; AClass: TPersistent;
    PropInfo: PPropInfo): TfrxPropertyEditor;
  var
    Item: TfrxPropertyEditorItem;
    e: Integer;
  begin
    Result := nil;
    {$IFDEF FPC}
    e := frxPropertyEditors.GetPropertyEditor(PropInfo^.PropType, AClass, String(PropInfo^.Name));
    {$ELSE}
    e := frxPropertyEditors.GetPropertyEditor(PropInfo.PropType^, AClass, String(PropInfo.Name));
    {$ENDIF}
    if e <> -1 then
    begin
      Item := frxPropertyEditors[e];
      if Item.EditorClass <> nil then
        Result := TfrxPropertyEditor(Item.EditorClass.NewInstance) else
        Exit;
    end
    else
      Result := TfrxPropertyEditor(EditorClass.NewInstance);

    Result.Create(FDesigner);
    Result.FCompList.Add(AClass);
    Result.FPropList.Add(PropInfo);
  end;

begin
  if AClass = nil then exit;
  AddPropList := nil;
  if Supports(AClass, IInspectedProperties, PropIntf) then
    AddPropList := PropIntf.GetProperies;

  TypeInfo := AClass.ClassInfo;

  PropertyCount := GetPropList(TypeInfo, tkProperties, nil);
  if Assigned(AddPropList) then
    Inc(PropertyCount, AddPropList.Count);
  GetMem(PropertyList, PropertyCount * SizeOf(PPropInfo));
  FillMemory(PropertyList, PropertyCount * SizeOf(PPropInfo), 0);
  GetPropList(TypeInfo, tkProperties, PropertyList);
  if Assigned(AddPropList) then
    for i := 0 to AddPropList.Count - 1 do
      PropertyList[PropertyCount - AddPropList.Count + i] := AddPropList.TypInfo[i];

  for i := 0 to PropertyCount - 1 do
  begin
    // TODO
    bIsFiltred := (FFilter <> '') and (Pos(FFilter, UpperCase(String(PropertyList[i].Name))) <= 0);
    if (PropertyList[i].GetProc = nil) or bIsFiltred and (PropertyList[i].PropType^.Kind <> tkClass) then Continue;
    Item := Add;
    case PropertyList[i].PropType^.Kind of
      tkInteger:
        Item.FEditor := CreateEditor(TfrxIntegerProperty, AClass, PropertyList[i]);

      tkInt64:
        Item.FEditor := CreateEditor(TfrxInt64Property, AClass, PropertyList[i]);

      tkChar, tkWChar{$IFDEF FPC}, tkUChar{$ENDIF}:
        Item.FEditor := CreateEditor(TfrxCharProperty, AClass, PropertyList[i]);

      tkFloat:
        Item.FEditor := CreateEditor(TfrxFloatProperty, AClass, PropertyList[i]);

      tkString, tkLString, tkWString{$IFDEF DEL12ORFPC}, tkUString{$ENDIF}
      {$IFDEF FPC}, tkAString{$ENDIF}:
        Item.FEditor := CreateEditor(TfrxStringProperty, AClass, PropertyList[i]);

      tkEnumeration{$IFDEF FPC}, tkBool{$ENDIF}:
        Item.FEditor := CreateEditor(TfrxEnumProperty, AClass, PropertyList[i]);

      tkSet:
        begin
          Item.FSubProperty := TfrxPropertyList.Create(FDesigner);
          Item.FSubProperty.FParent := Self;
          Item.FEditor := CreateEditor(TfrxSetProperty, AClass, PropertyList[i]);
          with GetTypeData(GetTypeData(PropertyList[i].PropType^).CompType^)^ do
            for j := MinValue to MaxValue do
            begin
              Item1 := Item.FSubProperty.Add;
              Item1.FEditor := CreateEditor(TfrxSetElementProperty, AClass, PropertyList[i]);
              if Item1.FEditor <> nil then
                TfrxSetElementProperty(Item1.FEditor).FElement := j;
            end;
        end;

      tkClass:
        begin
          FClass := GetTypeData(PropertyList[i].PropType^)^.ClassType;
          aObj := TPersistent(GetOrdProp(AClass, PropertyList[i]));
          if FClass.InheritsFrom(TComponent) and
            ((aObj = nil) or not(csSubComponent in TComponent(aObj).ComponentStyle)) then
          begin
            if not bIsFiltred then
              Item.FEditor := CreateEditor(TfrxComponentProperty, AClass, PropertyList[i])
          end
          else if FClass.InheritsFrom(TPersistent) then
          begin
            Item.FEditor := CreateEditor(TfrxClassProperty, AClass, PropertyList[i]);
            Item.FSubProperty := TfrxPropertyList.Create(FDesigner);
            if bIsFiltred then
              Item.FSubProperty.Filter := FFilter;
            Item.FSubProperty.FParent := Self;
            Item.FSubProperty.Component := TPersistent(GetOrdProp(AClass, PropertyList[i]));
            if Item.SubProperty.Count = 0 then
            begin
              Item.FSubProperty.Free;
              Item.FSubProperty := nil;
              if (FFilter <> '') then
                FreeAndNil(Item.FEditor);
            end;
          end;
        end;
    end;
    if Item.FEditor = nil then
      Item.Free;
  end;

  FreeMem(PropertyList, PropertyCount * SizeOf(PPropInfo));
end;

function TfrxPropertyList.FindSame(const AToFind: TfrxPropertyItem): TfrxPropertyItem;
var
  i: Integer;
begin
  Result := nil;
  if Assigned(AToFind.Editor) then
    for i := 0 to Count - 1 do
      if Assigned(Items[i].Editor) and AnsiSameText(Items[i].Editor.GetName, AToFind.Editor.GetName) then
      begin
        Result := Items[i];
        break;
      end;
end;

procedure TfrxPropertyList.FillCommonProperties(PropertyList: TfrxPropertyList);
var
  i, j: Integer;
  p, p1: TfrxPropertyItem;
  Found: Boolean;
begin
  i := 0;
  while i < Count do
  begin
    p := Items[i];
    Found := False;
    if paMultiSelect in p.Editor.GetAttributes then
      for j := 0 to PropertyList.Count - 1 do
      begin
        p1 := PropertyList.Items[j];

        if (p1.Editor.GetPropInfo.PropType^.Kind = p.Editor.GetPropInfo.PropType^.Kind) and
           (p1.Editor.GetPropInfo.PropType^.Name = p.Editor.GetPropInfo.PropType^.Name) and
           (p1.Editor.GetPropInfo.Name = p.Editor.GetPropInfo.Name) then
        begin
          if ((p.SubProperty <> nil) and (p1.SubProperty <> nil) and
              (p.SubProperty.Component <> nil) and (p1.SubProperty.Component <> nil) and
              (p.SubProperty.Component.ClassType <> p1.SubProperty.Component.ClassType)) then
            continue;

          Found := True;
          break;
        end;
      end;

    if not Found then
      p.Free else
      Inc(i);
  end;
end;

procedure TfrxPropertyList.AddProperties(PropertyList: TfrxPropertyList);

  procedure EnumProperties(p1, p2: TfrxPropertyList);
  var
    i: Integer;
    LPropertyItem: TfrxPropertyItem;
    LSamePropCount: Boolean;
  begin
    LSamePropCount := p1.Count = p2.Count;
    for i := 0 to p1.Count - 1 do
    begin
      if LSamePropCount then
        LPropertyItem := p2[i]
      else
        LPropertyItem := p2.FindSame(p1[i]);
      if Assigned(LPropertyItem) then
      begin
        p1[i].Editor.FCompList.Add(LPropertyItem.Editor.FCompList[0]);
        p1[i].Editor.FPropList.Add(LPropertyItem.Editor.FPropList[0]);
        if (p1[i].SubProperty <> nil) then
          EnumProperties(p1[i].SubProperty, LPropertyItem.SubProperty);
      end;
    end;
  end;

begin
  EnumProperties(Self, PropertyList);
end;


{ TfrxPropertyItem }

destructor TfrxPropertyItem.Destroy;
begin
  if Editor <> nil then
    Editor.Free;
  if SubProperty <> nil then
    SubProperty.Free;
  inherited;
end;


{ TfrIntegerProperty }

function TfrxIntegerProperty.GetValue: String;
begin
  Result := IntToStr(GetOrdValue);
end;

procedure TfrxIntegerProperty.SetValue(const Value: String);
begin
  {$IFDEF CPU64}
  SetOrdValue(StrToInt64(Value));
  {$ELSE}
  SetOrdValue(StrToInt(Value));
  {$ENDIF}
end;

{ TfrxInt64Property }

function TfrxInt64Property.GetValue: String;
begin
  Result := IntToStr(GetInt64Value);
end;

procedure TfrxInt64Property.SetValue(const Value: String);
begin
  SetOrdValue(StrToInt64(Value));
end;

{ TfrxFloatProperty }

function TfrxFloatProperty.GetValue: String;
begin
  Result := FloatToStr(GetFloatValue);
end;

procedure TfrxFloatProperty.SetValue(const Value: String);
begin
  SetFloatValue(frStrToFloat(Value));
end;


{ TfrxCharProperty }

function TfrxCharProperty.GetValue: String;
var
  Ch: Char;
begin
  Ch := Chr(GetOrdValue);
{$IFDEF DELPHI12}
  if CharInSet(Ch, [#33..#255]) then
{$ELSE}
  if Ch in [#33..#255] then
{$ENDIF}
    Result := Ch else
    FmtStr(Result, '#%d', [Ord(Ch)]);
end;

procedure TfrxCharProperty.SetValue(const Value: String);
var
  i: Integer;
begin
  if Length(Value) = 0 then i := 0 else
    if Length(Value) = 1 then i := Ord(Value[1]) else
      if Value[1] = '#' then i := StrToInt(Copy(Value, 2, 255)) else
        raise Exception.Create(frxResources.Get('prInvProp'));
  SetOrdValue(i);
end;


{ TfrxStringProperty }

function TfrxStringProperty.GetValue: String;
begin
  Result := GetStrValue;
end;

procedure TfrxStringProperty.SetValue(const Value: String);
begin
  SetStrValue(Value);
end;


{ TfrxEnumProperty }

function TfrxEnumProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxEnumProperty.GetValue: String;
var
  i: Integer;
begin
  i := GetOrdValue;
  {$IFDEF FPC}
  Result := GetEnumName(PropInfo.PropType, i);
  {$ELSE}
  Result := GetEnumName(PropInfo.PropType^, i);
  {$ENDIF}
end;

procedure TfrxEnumProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  with GetTypeData(PropInfo.PropType^)^ do
    for i := MinValue to MaxValue do
    {$IFDEF FPC}
      Values.Add(GetEnumName(PropInfo.PropType, i));
    {$ELSE}
      Values.Add(GetEnumName(PropInfo.PropType^, i));
    {$ENDIF}
end;

procedure TfrxEnumProperty.SetValue(const Value: String);
var
  i: Integer;
begin
  {$IFDEF FPC}
  i := GetEnumValue(PropInfo.PropType, Value);
  {$ELSE}
  i := GetEnumValue(PropInfo.PropType^, Value);
  {$ENDIF}
  if i < 0 then
    raise Exception.Create(frxResources.Get('prInvProp'));
  SetOrdValue(i);
end;


{ TfrxSetProperty }

function TfrxSetProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paSubProperties, paReadOnly];
end;

function TfrxSetProperty.GetValue: String;
var
  S: TIntegerSet;
  TypeInfo: PTypeInfo;
  I: Integer;
begin
  Integer(S) := GetOrdValue;
  {$IFDEF FPC}
  TypeInfo := GetTypeData(PropInfo^.PropType)^.CompType;
  {$ELSE}
  TypeInfo := GetTypeData(PropInfo.PropType^).CompType^;
  {$ENDIF}
  Result := '[';
  for i := 0 to 31 do
    if i in S then
    begin
      if Length(Result) <> 1 then
        Result := Result + ',';
      {$IFDEF FPC}
      Result := Result + typinfo.GetEnumName(TypeInfo, i);
      {$ELSE}
      Result := Result + GetEnumName(TypeInfo, i);
      {$ENDIF}
    end;
  Result := Result + ']';
end;


{ TfrxSetElementProperty }

function TfrxSetElementProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxSetElementProperty.GetName: String;
begin
  {$IFDEF FPC}
  Result := GetEnumName(GetTypeData(PropInfo.PropType).CompType, FElement);
  {$ELSE}
  Result := GetEnumName(GetTypeData(PropInfo.PropType^).CompType^, FElement);
  {$ENDIF}
end;

function TfrxSetElementProperty.GetValue: String;
var
  S: TIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if FElement in S then
    Result := 'True' else
    Result := 'False';
end;

procedure TfrxSetElementProperty.GetValues;
begin
  inherited;
  Values.Add('False');
  Values.Add('True');
end;

procedure TfrxSetElementProperty.SetValue(const Value: String);
var
  S: TIntegerSet;
begin
  Integer(S) := GetOrdValue;
  if CompareText(Value, 'True') = 0 then
    Include(S, FElement)
  else if CompareText(Value, 'False') = 0 then
    Exclude(S, FElement)
  else
    raise Exception.Create(frxResources.Get('prInvProp'));
  
  {$IFDEF FPC}
  SetOrdValue(Integer(S));
  {$ELSE}
    SetOrdValue(Integer(S));
  {$ENDIF}
end;


{ TfrxClassProperty }

function TfrxClassProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paSubProperties, paReadOnly];
end;

function TfrxClassProperty.GetValue: String;
begin
  Result := {'';//}'(' + String(PropInfo.PropType^.Name) + ')';
end;


{ TComponentProperty }

function TfrxComponentProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxComponentProperty.GetValue: String;
var
  c: TComponent;
begin
  c := TComponent(GetOrdValue);
  if c <> nil then
    Result := c.Name else
    Result := '';
end;

procedure TfrxComponentProperty.GetValues;
var
  i: Integer;
  c, c1: TfrxComponent;
begin
  inherited;

  if frComponent <> nil then
  begin
    if frComponent is TfrxReportComponent then
      c := frComponent.Page else
      c := frComponent;
    for i := 0 to c.AllObjects.Count - 1 do
    begin
      c1 := c.AllObjects[i];
      if (c1 <> frComponent) and
        c1.InheritsFrom(GetTypeData(PropInfo.PropType^)^.ClassType) then
        Values.Add(c1.Name);
    end;
  end;
end;

procedure TfrxComponentProperty.SetValue(const Value: String);
var
  c: TComponent;
begin
  c := nil;
  if Value <> '' then
  begin
    c := frComponent.Report.FindObject(Value);
    if c = nil then
      raise Exception.Create(frxResources.Get('prInvProp'));
  end;

//  {$IFDEF FPC}
  SetOrdValue(frInteger(c));
//  {$ELSE}
//    SetOrdValue(Integer(c));
//  {$ENDIF}
end;


{ TfrxNameProperty }

function TfrxNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [];
end;


{ TfrxColorProperty }

function TfrxColorProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paOwnerDraw];
end;

function TfrxColorProperty.GetValue: String;
begin
  Result := ColorToString(GetOrdValue);
end;

procedure TfrxColorProperty.SetValue(const Value: String);
var
  c: Integer;
begin
  if IdentToColor(Value, c) then
    SetOrdValue(c) else
    inherited SetValue(Value);
end;

procedure TfrxColorProperty.GetValues;
begin
  inherited;
  GetColorValues(GetStrProc);
end;

function TfrxColorProperty.Edit: Boolean;
var
  ctx: FRX_DPI_AWARENESS_CONTEXT;
begin
  with TColorDialog.Create(Application) do
  begin
    Color := GetOrdValue;
    { awoid common Dialogs bug with HiDPi Per monitor v2 }
    ctx := frxGetThreadDpiAwarenessContext;
    frxSetThreadDpiAwarenessContext(FRX_DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED);
    try
      Result := Execute;
    finally
      frxSetThreadDpiAwarenessContext(ctx);
    end;
    if Result then
      SetOrdValue(Color);
    Free;
  end;
end;

procedure TfrxColorProperty.OnDrawLBItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  c: Integer;
begin
  inherited;
  with TListBox(Control), TListBox(Control).Canvas do
  begin
    IdentToColor(Items[Index], c);
    Brush.Color := c;
    Rectangle(ARect.Left + 2, ARect.Top + 2, ARect.Left + (ARect.Bottom - ARect.Top - 2), ARect.Bottom - 2);
  end;
end;

procedure TfrxColorProperty.OnDrawItem(Canvas: TCanvas; ARect: TRect);
begin
  inherited;
  with Canvas do
  begin
    Brush.Color := GetOrdValue;
    Rectangle(ARect.Left, ARect.Top + 1, ARect.Left + (ARect.Bottom - ARect.Top - 5), ARect.Bottom - 4);
  end;
end;


{ TfrxFontProperty }

function TfrxFontProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paDialog, paSubProperties, paReadOnly];
end;

function TfrxFontProperty.Edit: Boolean;
var
  FontDialog: TFontDialog;
{$IFDEF DELPHI12}
  FontCarSet: Byte;
{$ENDIF}
  ctx: FRX_DPI_AWARENESS_CONTEXT;
begin
  FontDialog := TFontDialog.Create(Application);
  try
    FontDialog.Font := TFont(GetOrdValue);
    FontDialog.Options := FontDialog.Options + [fdForceFontExist];
    {$IFNDEF FPC}
    FontDialog.Device := fdBoth;
    {$ENDIF}
{$IFDEF DELPHI12}
    FontCarSet := FontDialog.Font.Charset;
{$ENDIF}
   { awoid common Dialogs bug with HiDPi Per monitor v2 }
    ctx := frxGetThreadDpiAwarenessContext;
    frxSetThreadDpiAwarenessContext(FRX_DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED);
    try
      Result := FontDialog.Execute;
    finally
      frxSetThreadDpiAwarenessContext(ctx);
    end;
{$IFDEF DELPHI12}
    if FontDialog.Font.Charset = SYMBOL_CHARSET then
      FontDialog.Font.Charset := FontCarSet;
{$ENDIF}
    if Result then
      SetOrdValue(frInteger(FontDialog.Font));
  finally
    FontDialog.Free;
  end;
end;


{ TfrxFontNameProperty }

function TfrxFontNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

procedure TfrxFontNameProperty.GetValues;
begin
  Values.Assign(Screen.Fonts);
end;


{ TfrxFontCharsetProperty }

function TfrxFontCharsetProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxFontCharsetProperty.GetValue: String;
begin
  if not CharsetToIdent(GetOrdValue, Result) then
    FmtStr(Result, '%d', [GetOrdValue]);
end;

procedure TfrxFontCharsetProperty.SetValue(const Value: String);
var
  c: Integer;
begin
  if IdentToCharset(Value, c) then
    SetOrdValue(c) else
    inherited SetValue(Value);
end;

procedure TfrxFontCharsetProperty.GetValues;
begin
  inherited;
  GetCharsetValues(GetStrProc);
end;


{ TfrxModalResultProperty }

const
  ModalResults: array[mrNone..mrYesToAll] of string = (
    'mrNone',
    'mrOk',
    'mrCancel',
    'mrAbort',
    'mrRetry',
    'mrIgnore',
    'mrYes',
    'mrNo',
{$IFDEF DELPHI16}
    'mrClose',
    'mrHelp',
    'mrTryAgain',
    'mrContinue',
{$ENDIF}
    'mrAll',
    'mrNoToAll',
    'mrYesToAll');

function TfrxModalResultProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

function TfrxModalResultProperty.GetValue: String;
begin
  if GetOrdValue in [mrNone..mrYesToAll] then
    Result := ModalResults[GetOrdValue] else
    Result := inherited GetValue;
end;

procedure TfrxModalResultProperty.SetValue(const Value: String);
var
  {$IFDEF FPC}
	  i: frInteger;
  {$ELSE}
	  i: Integer;
  {$ENDIF}
  s: String;
begin
  s := Value;
  if s = '' then
    s := '0';
  for i := Low(ModalResults) to High(ModalResults) do
    if CompareText(ModalResults[i], s) = 0 then
    begin
      SetOrdValue(i);
      Exit;
    end;
  inherited SetValue(s);
end;

procedure TfrxModalResultProperty.GetValues;
var
  {$IFDEF FPC}
	  i: frInteger;
  {$ELSE}
	  i: Integer;
  {$ENDIF}
begin
  inherited;
  for i := mrNone to mrYesToAll do
    Values.Add(ModalResults[i]);
end;


{ TfrxShortCutProperty }

const
  ShortCuts: array[0..108] of TShortCut = (
    scNone,
    Byte('A') or scCtrl,
    Byte('B') or scCtrl,
    Byte('C') or scCtrl,
    Byte('D') or scCtrl,
    Byte('E') or scCtrl,
    Byte('F') or scCtrl,
    Byte('G') or scCtrl,
    Byte('H') or scCtrl,
    Byte('I') or scCtrl,
    Byte('J') or scCtrl,
    Byte('K') or scCtrl,
    Byte('L') or scCtrl,
    Byte('M') or scCtrl,
    Byte('N') or scCtrl,
    Byte('O') or scCtrl,
    Byte('P') or scCtrl,
    Byte('Q') or scCtrl,
    Byte('R') or scCtrl,
    Byte('S') or scCtrl,
    Byte('T') or scCtrl,
    Byte('U') or scCtrl,
    Byte('V') or scCtrl,
    Byte('W') or scCtrl,
    Byte('X') or scCtrl,
    Byte('Y') or scCtrl,
    Byte('Z') or scCtrl,
    Byte('A') or scCtrl or scAlt,
    Byte('B') or scCtrl or scAlt,
    Byte('C') or scCtrl or scAlt,
    Byte('D') or scCtrl or scAlt,
    Byte('E') or scCtrl or scAlt,
    Byte('F') or scCtrl or scAlt,
    Byte('G') or scCtrl or scAlt,
    Byte('H') or scCtrl or scAlt,
    Byte('I') or scCtrl or scAlt,
    Byte('J') or scCtrl or scAlt,
    Byte('K') or scCtrl or scAlt,
    Byte('L') or scCtrl or scAlt,
    Byte('M') or scCtrl or scAlt,
    Byte('N') or scCtrl or scAlt,
    Byte('O') or scCtrl or scAlt,
    Byte('P') or scCtrl or scAlt,
    Byte('Q') or scCtrl or scAlt,
    Byte('R') or scCtrl or scAlt,
    Byte('S') or scCtrl or scAlt,
    Byte('T') or scCtrl or scAlt,
    Byte('U') or scCtrl or scAlt,
    Byte('V') or scCtrl or scAlt,
    Byte('W') or scCtrl or scAlt,
    Byte('X') or scCtrl or scAlt,
    Byte('Y') or scCtrl or scAlt,
    Byte('Z') or scCtrl or scAlt,
    VK_F1,
    VK_F2,
    VK_F3,
    VK_F4,
    VK_F5,
    VK_F6,
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11,
    VK_F12,
    VK_F1 or scCtrl,
    VK_F2 or scCtrl,
    VK_F3 or scCtrl,
    VK_F4 or scCtrl,
    VK_F5 or scCtrl,
    VK_F6 or scCtrl,
    VK_F7 or scCtrl,
    VK_F8 or scCtrl,
    VK_F9 or scCtrl,
    VK_F10 or scCtrl,
    VK_F11 or scCtrl,
    VK_F12 or scCtrl,
    VK_F1 or scShift,
    VK_F2 or scShift,
    VK_F3 or scShift,
    VK_F4 or scShift,
    VK_F5 or scShift,
    VK_F6 or scShift,
    VK_F7 or scShift,
    VK_F8 or scShift,
    VK_F9 or scShift,
    VK_F10 or scShift,
    VK_F11 or scShift,
    VK_F12 or scShift,
    VK_F1 or scShift or scCtrl,
    VK_F2 or scShift or scCtrl,
    VK_F3 or scShift or scCtrl,
    VK_F4 or scShift or scCtrl,
    VK_F5 or scShift or scCtrl,
    VK_F6 or scShift or scCtrl,
    VK_F7 or scShift or scCtrl,
    VK_F8 or scShift or scCtrl,
    VK_F9 or scShift or scCtrl,
    VK_F10 or scShift or scCtrl,
    VK_F11 or scShift or scCtrl,
    VK_F12 or scShift or scCtrl,
    VK_INSERT,
    VK_INSERT or scShift,
    VK_INSERT or scCtrl,
    VK_DELETE,
    VK_DELETE or scShift,
    VK_DELETE or scCtrl,
    VK_BACK or scAlt,
    VK_BACK or scShift or scAlt);

function TfrxShortCutProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

function TfrxShortCutProperty.GetValue: String;
var
  CurValue: TShortCut;
begin
  CurValue := GetOrdValue;
  if CurValue = scNone then
    Result := srNone else
    Result := ShortCutToText(CurValue);
end;

procedure TfrxShortCutProperty.SetValue(const Value: String);
var
  NewValue: TShortCut;
begin
  NewValue := 0;
  if (Value <> '') and (AnsiCompareText(Value, srNone) <> 0) then
    NewValue := TextToShortCut(Value);
  SetOrdValue(NewValue);
end;

procedure TfrxShortCutProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  Values.Add(srNone);
  for i := 1 to High(ShortCuts) do
    Values.Add(ShortCutToText(ShortCuts[i]));
end;


{ TfrxCursorProperty }

function TfrxCursorProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

function TfrxCursorProperty.GetValue: string;
begin
  Result := CursorToString(TCursor(GetOrdValue));
end;

procedure TfrxCursorProperty.GetValues;
begin
  inherited;
  GetCursorValues(GetStrProc);
end;

procedure TfrxCursorProperty.SetValue(const Value: string);
var
  NewValue: Integer;
begin
  if IdentToCursor(Value, NewValue) then
    SetOrdValue(NewValue) else
    inherited;
end;


{ TfrxDateTimeProperty }

function TfrxDateTimeProperty.GetValue: String;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateTimeToStr(DT);
end;

procedure TfrxDateTimeProperty.SetValue(const Value: String);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDateTime(Value);
  SetFloatValue(DT);
end;


{ TfrxDateProperty }

function TfrxDateProperty.GetValue: String;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := DateToStr(DT);
end;

procedure TfrxDateProperty.SetValue(const Value: String);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToDate(Value);
  SetFloatValue(DT);
end;


{ TfrxTimeProperty }

function TfrxTimeProperty.GetValue: String;
var
  DT: TDateTime;
begin
  DT := GetFloatValue;
  if DT = 0.0 then
    Result := ''
  else
    Result := TimeToStr(DT);
end;

procedure TfrxTimeProperty.SetValue(const Value: String);
var
  DT: TDateTime;
begin
  if Value = '' then
    DT := 0.0
  else
    DT := StrToTime(Value);
  SetFloatValue(DT);
end;


{ TfrxObjectCollection }

constructor TfrxObjectCollection.Create;
begin
  inherited Create(TfrxObjectItem);
end;

function TfrxObjectCollection.GetObjectItem(Index: Integer): TfrxObjectItem;
begin
  Result := TfrxObjectItem(inherited Items[Index]);
end;

procedure TfrxObjectCollection.RegisterCategory(const CategoryName: string;
  ButtonBmp: TBitmap; const ButtonHint: string; ImageIndex: Integer);
begin
  RegisterObject1(nil, ButtonBmp, ButtonHint, CategoryName, 0, ImageIndex);
end;

procedure TfrxObjectCollection.RegisterObject(ClassRef: TfrxComponentClass;
  ButtonBmp: TBitmap; const CategoryName: String);
begin
  RegisterObject1(ClassRef, ButtonBmp, '', CategoryName);
end;

procedure TfrxObjectCollection.RegisterObject1(
  ClassRef: TfrxComponentClass; ButtonBmp: TBitmap;
  const ButtonHint: String = ''; const CategoryName: String = '';
  Flags: Integer = 0; ImageIndex: Integer = -1;
  Category: TfrxObjectCategories = []);
var
  i: Integer;
  Item: TfrxObjectItem;
begin
  for i := 0 to Count - 1 do
  begin
    Item := Items[i];
    if (Item.ClassRef <> nil) and (Item.ClassRef = ClassRef) and
      (Item.Flags = Flags) then
      Exit;
  end;

  if ClassRef <> nil then
    Classes.RegisterClass(ClassRef);

  Item := TfrxObjectItem(Add);
  Item.ClassRef := ClassRef;
  Item.ButtonBmp := ButtonBmp;
  Item.ButtonImageIndex := ImageIndex;
  Item.ButtonHint := ButtonHint;
  Item.CategoryName := CategoryName;
  Item.Flags := Flags;
  Item.Category := Category;

  { if category is not set, determine it automatically }
  if (ClassRef <> nil) and (Category = []) then
  begin
    if ClassRef.InheritsFrom(TfrxDataset) or
      ClassRef.InheritsFrom(TfrxCustomDatabase) then
      Item.Category := [ctData]
    else if ClassRef.InheritsFrom(TfrxDialogControl) or
      ClassRef.InheritsFrom(TfrxDialogComponent) then
      Item.Category := [ctDialog]
    else
      Item.Category := [ctReport];
  end;

  {$IFNDEF FPC}
  if ButtonBmp <> nil then
    ButtonBmp.Dormant;
  {$ENDIF}
end;

procedure TfrxObjectCollection.UnRegister(ClassRef: TfrxComponentClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].ClassRef = ClassRef then
      Items[i].Free else
      Inc(i);
  end;
end;

{ TfrxComponentEditorCollection }

constructor TfrxComponentEditorCollection.Create;
begin
  inherited Create(TfrxComponentEditorItem);
end;

function TfrxComponentEditorCollection.GetComponentEditorItem(
  Index: Integer): TfrxComponentEditorItem;
begin
  Result := TfrxComponentEditorItem(inherited Items[Index]);
end;

function TfrxComponentEditorCollection.GetComponentEditor(Component: TfrxComponent;
  Designer: TfrxCustomDesigner; Menu: TMenu): TfrxComponentEditor;
var
  i, j: Integer;
begin
  Result := nil;
  j := -1;
  for i := 0 to Count - 1 do
    if Items[i].ComponentClass = Component.ClassType then
    begin
      j := i;
      break;
    end
    else if Component.InheritsFrom(Items[i].ComponentClass) then
      j := i;

  if j <> -1 then
  begin
    Result := TfrxComponentEditor(Items[j].ComponentEditor.NewInstance);
    Result.Create(Component, Designer, Menu);
  end;
end;

procedure TfrxComponentEditorCollection.Register(ComponentClass: TfrxComponentClass;
  ComponentEditor: TfrxComponentEditorClass);
var
  Item: TfrxComponentEditorItem;
begin
  Item := TfrxComponentEditorItem(Add);
  Item.ComponentClass := ComponentClass;
  Item.ComponentEditor := ComponentEditor;
end;

procedure TfrxComponentEditorCollection.UnRegister(ComponentEditor: TfrxComponentEditorClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].ComponentEditor = ComponentEditor then
      Items[i].Free else
      Inc(i);
  end;
end;


{ TfrxPropertyEditorCollection }

constructor TfrxPropertyEditorCollection.Create;
begin
  inherited Create(TfrxPropertyEditorItem);
  FEventEditorItem := -1;
end;

function TfrxPropertyEditorCollection.GetPropertyEditorItem(
  Index: Integer): TfrxPropertyEditorItem;
begin
  Result := TfrxPropertyEditorItem(inherited Items[Index]);
end;

function TfrxPropertyEditorCollection.GetPropertyEditor(PropertyType: PTypeInfo;
  Component: TPersistent; PropertyName: String): Integer;
var
  i: Integer;
  Item: TfrxPropertyEditorItem;
begin
  if (Pos('tfrx', LowerCase(String(PropertyType.Name))) = 1) and
    (Pos('event', LowerCase(String(PropertyType.Name))) = Length(PropertyType.Name) - 4) then
  begin
    Result := FEventEditorItem;
    Exit;
  end;

  Result := -1;
  for i := Count - 1 downto 0 do
  begin
    Item := Items[i];
    if (Item.ComponentClass = nil) and (Item.PropertyName = '') and
      (Item.PropertyType = PropertyType) then
      Result := i
    else if (Item.ComponentClass = nil) and (Item.PropertyType = PropertyType) and
      (CompareText(Item.PropertyName, PropertyName) = 0) then
    begin
      Result := i;
      break;
    end
    else if (Component.InheritsFrom(Item.ComponentClass)) and
      (CompareText(Item.PropertyName, PropertyName) = 0) then
    begin
      Result := i;
      break;
    end;
  end;
end;

procedure TfrxPropertyEditorCollection.Register(PropertyType: PTypeInfo;
  ComponentClass: TClass; const PropertyName: String;
  EditorClass: TfrxPropertyEditorClass);
var
  Item: TfrxPropertyEditorItem;
begin
  Item := TfrxPropertyEditorItem(Add);
  Item.PropertyType := PropertyType;
  Item.ComponentClass := ComponentClass;
  Item.PropertyName := PropertyName;
  Item.EditorClass := EditorClass;
end;

procedure TfrxPropertyEditorCollection.RegisterEventEditor(
  EditorClass: TfrxPropertyEditorClass);
begin
  Register(nil, nil, '', EditorClass);
  FEventEditorItem := Count - 1;
end;

procedure TfrxPropertyEditorCollection.UnRegister(EditorClass: TfrxPropertyEditorClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].EditorClass = EditorClass then
      Items[i].Free else
      Inc(i);
  end;
end;


{ TfrxExportFilterCollection }

constructor TfrxExportFilterCollection.Create;
begin
  inherited Create(TfrxExportFilterItem);
end;

function TfrxExportFilterCollection.GetExportFilterItem(
  Index: Integer): TfrxExportFilterItem;
begin
  Result := TfrxExportFilterItem(inherited Items[Index]);
end;

procedure TfrxExportFilterCollection.Register(Filter: TfrxCustomExportFilter);
var
  i: Integer;
  Item: TfrxExportFilterItem;
begin
  if Filter = nil then Exit;
  for i := 0 to Count - 1 do
    if Items[i].Filter = Filter then
      Exit;

  Item := TfrxExportFilterItem(Add);
  Item.Filter := Filter;
end;

procedure TfrxExportFilterCollection.UnRegister(Filter: TfrxCustomExportFilter);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].Filter = Filter then
      Items[i].Free else
      Inc(i);
  end;
end;


{ TfrxWizardCollection }

constructor TfrxWizardCollection.Create;
begin
  inherited Create(TfrxWizardItem);
end;

function TfrxWizardCollection.GetWizardItem(Index: Integer): TfrxWizardItem;
begin
  Result := TfrxWizardItem(inherited Items[Index]);
end;

procedure TfrxWizardCollection.Register(ClassRef: TfrxWizardClass;
  ButtonBmp: TBitmap; IsToolbarWizard: Boolean; Bmp32x32: TBitmap);
var
  i: Integer;
  Item: TfrxWizardItem;
begin
  for i := 0 to Count - 1 do
    if Items[i].ClassRef = ClassRef then
      Exit;

  Item := TfrxWizardItem(Add);
  Item.ClassRef := ClassRef;
  Item.ButtonBmp := ButtonBmp;
  if Bmp32x32 <> nil then
    Item.WizardButtonBmp := Bmp32x32;
  Item.ButtonImageIndex := -1;
  Item.ToolBarButtonImageIndex := -1;
  Item.IsToolbarWizard := IsToolbarWizard;

  {$IFNDEF FPC}
  if ButtonBmp <> nil then
    ButtonBmp.Dormant;
  if Bmp32x32 <> nil then
    Bmp32x32.Dormant;
  {$ENDIF}
end;

procedure TfrxWizardCollection.Register1(ClassRef: TfrxWizardClass;
  ImageIndex: Integer);
var
  i: Integer;
  Item: TfrxWizardItem;
begin
  for i := 0 to Count - 1 do
    if Items[i].ClassRef = ClassRef then
      Exit;

  Item := TfrxWizardItem(Add);
  Item.ClassRef := ClassRef;
  Item.ButtonImageIndex := ImageIndex;
end;

procedure TfrxWizardCollection.UnRegister(ClassRef: TfrxWizardClass);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].ClassRef = ClassRef then
      Items[i].Free else
      Inc(i);
  end;
end;


{ globals }

function frxObjects: TfrxObjectCollection;
begin
  if FObjects = nil then
    FObjects := TfrxObjectCollection.Create;
  Result := FObjects;
end;

function frxComponentEditors: TfrxComponentEditorCollection;
begin
  if FComponentEditors = nil then
    FComponentEditors := TfrxComponentEditorCollection.Create;
  Result := FComponentEditors;
end;

function frxPropertyEditors: TfrxPropertyEditorCollection;
begin
  if FPropertyEditors = nil then
    FPropertyEditors := TfrxPropertyEditorCollection.Create;
  Result := FPropertyEditors;
end;

function frxExportFilters: TfrxExportFilterCollection;
begin
  if FExportFilters = nil then
    FExportFilters := TfrxExportFilterCollection.Create;
  Result := FExportFilters;
end;

function frxSaveFilters: TfrxSaveFiltersCollection;
begin
  if FSaveFilters = nil then
    FSaveFilters := TfrxSaveFiltersCollection.Create;
  Result := FSaveFilters;
end;

function frxWizards: TfrxWizardCollection;
begin
  if FWizards = nil then
    FWizards := TfrxWizardCollection.Create;
  Result := FWizards;
end;


{ TfrxSaveFiltersCollection }

constructor TfrxSaveFiltersCollection.Create;
begin
  inherited Create(TfrxSaveFilterItem);
end;

function TfrxSaveFiltersCollection.GetSaveFilterItem(
  Index: Integer): TfrxSaveFilterItem;
begin
  Result := TfrxSaveFilterItem(inherited Items[Index]);
end;

procedure TfrxSaveFiltersCollection.Register(Filter: TfrxCustomIOTransport);
var
  i: Integer;
  Item: TfrxSaveFilterItem;
begin
  if Filter = nil then Exit;
  for i := 0 to Count - 1 do
    if Items[i].SaveFilter = Filter then
      Exit;

  Item := TfrxSaveFilterItem(Add);
  Item.SaveFilter := Filter;
end;

procedure TfrxSaveFiltersCollection.Unregister(Filter: TfrxCustomIOTransport);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if Items[i].SaveFilter = Filter then
      Items[i].Free else
      Inc(i);
  end;
end;

{ TfrxClassNameProperty }

function TfrxClassNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paReadOnly, paValueList, paSortList];
end;

procedure TfrxClassNameProperty.GetValues;
var
  PropIntf: IStringClassNameContainer;
  List: TList;
  i: Integer;
begin
  inherited;
  if Supports(Component, IStringClassNameContainer, PropIntf) then
  begin
    List := PropIntf.GetSupportedClasses;
    if Assigned(List) then
      for i := 0 to List.Count - 1 do
        if Assigned(List[i]) then
          Values.Add(TClass(List[i]).ClassName)
        else if i = 0 then
          Values.Add('')
  end;
end;

procedure TfrxClassNameProperty.SetValue(const Value: String);
begin
  inherited;
  if Assigned(Designer) then
    Designer.UpdateInspector;
end;

initialization
  frxPropertyEditors.Register(TypeInfo(TComponentName), nil, 'Name', TfrxNameProperty);
  frxPropertyEditors.Register(TypeInfo(TColor), nil, '', TfrxColorProperty);
  frxPropertyEditors.Register(TypeInfo(TFont), nil, '', TfrxFontProperty);
  frxPropertyEditors.Register(TypeInfo(String), TFont, 'Name', TfrxFontNameProperty);
  frxPropertyEditors.Register(TypeInfo(Integer), TFont, 'Charset', TfrxFontCharsetProperty);
  frxPropertyEditors.Register(TypeInfo(TModalResult), nil, '', TfrxModalResultProperty);
  frxPropertyEditors.Register(TypeInfo(TShortCut), nil, '', TfrxShortCutProperty);
  frxPropertyEditors.Register(TypeInfo(TCursor), nil, '', TfrxCursorProperty);
  frxPropertyEditors.Register(TypeInfo(TDateTime), nil, '', TfrxDateTimeProperty);
  frxPropertyEditors.Register(TypeInfo(TDate), nil, '', TfrxDateProperty);
  frxPropertyEditors.Register(TypeInfo(TTime), nil, '', TfrxTimeProperty);
  frxPropertyEditors.Register(TypeInfo(TfrxStringClassName), nil, '', TfrxClassNameProperty);

finalization
  if FObjects <> nil then
    FObjects.Free;
  FObjects := nil;
  if FComponentEditors <> nil then
    FComponentEditors.Free;
  FComponentEditors := nil;
  if FPropertyEditors <> nil then
    FPropertyEditors.Free;
  FPropertyEditors := nil;
  if FExportFilters <> nil then
    FExportFilters.Free;
  FExportFilters := nil;
  if FWizards <> nil then
    FWizards.Free;
  FWizards := nil;
  if FSaveFilters <> nil then
    FreeAndNil(FSaveFilters);
end.
