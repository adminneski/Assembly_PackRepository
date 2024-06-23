object frxStyleEditorForm: TfrxStyleEditorForm
  Left = 363
  Top = 191
  BorderStyle = bsDialog
  Caption = 'Style Editor'
  ClientHeight = 251
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox: TPaintBox
    Left = 164
    Top = 150
    Width = 256
    Height = 78
    OnPaint = PaintBoxPaint
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 429
    Height = 35
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 23
    EdgeBorders = [ebTop, ebBottom]
    Flat = True
    TabOrder = 1
    Wrapable = False
    object AddB: TToolButton
      Left = 0
      Top = 0
      Caption = 'Add'
      ImageIndex = 89
      OnClick = AddBClick
    end
    object DeleteB: TToolButton
      Left = 23
      Top = 0
      Caption = 'Delete'
      ImageIndex = 88
      OnClick = DeleteBClick
    end
    object EditB: TToolButton
      Left = 46
      Top = 0
      Caption = 'Edit'
      ImageIndex = 68
      OnClick = EditBClick
    end
    object StyleBookModeTB: TToolButton
      Left = 69
      Top = 0
      Caption = 'StyleBookModeTB'
      DropdownMenu = StyleModePopup
      ImageIndex = 150
      Style = tbsDropDown
    end
    object AddSheetTB: TToolButton
      Left = 107
      Top = 0
      Caption = 'AddSheetTB'
      ImageIndex = 148
      OnClick = AddSheetTBClick
    end
    object StyleSheetPan: TfrxTBPanel
      Left = 130
      Top = 0
      Width = 93
      Height = 23
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object StyleSheetCB: TfrxComboBox
        Tag = 33
        Left = 0
        Top = 2
        Width = 93
        Height = 19
        ListWidth = 120
        TabOrder = 0
        ItemIndex = -1
        OnChange = StyleSheetCBChange
      end
    end
    object DeleteSheetTB: TToolButton
      Left = 223
      Top = 0
      Caption = 'DeleteSheetTB'
      ImageIndex = 149
      OnClick = DeleteSheetTBClick
    end
    object Sep1: TToolButton
      Left = 246
      Top = 0
      Width = 8
      ImageIndex = 2
      Style = tbsSeparator
    end
    object LoadB: TToolButton
      Left = 254
      Top = 0
      Caption = 'Load'
      ImageIndex = 1
      OnClick = LoadBClick
    end
    object SaveB: TToolButton
      Left = 277
      Top = 0
      Caption = 'Save'
      ImageIndex = 2
      OnClick = SaveBClick
    end
    object Sep2: TToolButton
      Left = 300
      Top = 0
      Width = 8
      ImageIndex = 4
      Style = tbsSeparator
    end
    object CancelB: TToolButton
      Left = 308
      Top = 0
      Caption = 'Cancel'
      ImageIndex = 55
      OnClick = CancelBClick
    end
    object OkB: TToolButton
      Left = 331
      Top = 0
      Caption = 'OK'
      ImageIndex = 56
      OnClick = OkBClick
    end
  end
  object StylesTV: TTreeView
    Tag = 1
    Left = 0
    Top = 31
    Width = 153
    Height = 220
    Align = alLeft
    HideSelection = False
    Indent = 19
    TabOrder = 0
    OnClick = StylesTVClick
    OnEdited = StylesTVEdited
  end
  object ColorB: TButton
    Tag = 2
    Left = 180
    Top = 46
    Width = 75
    Height = 25
    Caption = 'Fill...'
    TabOrder = 2
    OnClick = BClick
  end
  object FontB: TButton
    Tag = 3
    Left = 180
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Font...'
    TabOrder = 3
    OnClick = BClick
  end
  object FrameB: TButton
    Tag = 4
    Left = 180
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Frame...'
    TabOrder = 4
    OnClick = BClick
  end
  object DefCB: TCheckBox
    Left = 272
    Top = 114
    Width = 153
    Height = 17
    Caption = 'Default charset'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = DefCBClick
  end
  object ApplyFillCB: TCheckBox
    Left = 160
    Top = 50
    Width = 17
    Height = 17
    TabOrder = 6
    OnClick = ApplyFillCBClick
  end
  object ApplyFontCB: TCheckBox
    Left = 160
    Top = 82
    Width = 17
    Height = 17
    TabOrder = 7
    OnClick = ApplyFillCBClick
  end
  object ApplyFrameCB: TCheckBox
    Left = 160
    Top = 114
    Width = 17
    Height = 17
    TabOrder = 8
    OnClick = ApplyFillCBClick
  end
  object OpenDialog: TOpenDialog
    Left = 48
    Top = 56
  end
  object SaveDialog: TSaveDialog
    Left = 84
    Top = 56
  end
  object StyleModePopup: TPopupMenu
    Left = 321
    Top = 55
    object StyleBookDesignMI: TMenuItem
      Caption = 'Designer Style book'
      OnClick = StyleBookDesignMIClick
    end
    object StyleBookPreviewMI: TMenuItem
      Tag = 1
      Caption = 'Preview Style book'
      OnClick = StyleBookDesignMIClick
    end
  end
end
