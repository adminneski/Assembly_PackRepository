object frxNewItemForm: TfrxNewItemForm
  Left = 190
  Top = 113
  BorderStyle = bsDialog
  Caption = 'New Items'
  ClientHeight = 334
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pages: TPageControl
    Left = 4
    Top = 4
    Width = 321
    Height = 293
    ActivePage = ItemsTab
    TabOrder = 2
    object ItemsTab: TTabSheet
      Caption = 'Items'
      object ItemsLV: TListView
        Left = 0
        Top = 0
        Width = 313
        Height = 265
        Align = alClient
        Columns = <>
        ReadOnly = True
        TabOrder = 0
        OnDblClick = ItemsLVDblClick
      end
    end
    object TemplateTab: TTabSheet
      Caption = 'From template'
      ImageIndex = 2
      object InheritCB: TCheckBox
        Left = 0
        Top = 240
        Width = 265
        Height = 17
        Caption = 'Inherit the report'
        TabOrder = 0
      end
      object TemplateLV: TListView
        Left = 0
        Top = 0
        Width = 313
        Height = 225
        Columns = <>
        TabOrder = 1
        OnDblClick = ItemsLVDblClick
      end
    end
  end
  object OkB: TButton
    Left = 170
    Top = 304
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelB: TButton
    Left = 250
    Top = 304
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
end
