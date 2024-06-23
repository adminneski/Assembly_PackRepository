object frxSQLEditorForm: TfrxSQLEditorForm
  Left = 200
  Top = 107
  Width = 620
  Height = 338
  Caption = 'Lines'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 612
    Height = 31
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 23
    EdgeBorders = []
    Flat = True
    TabOrder = 0
    object QBB: TToolButton
      Left = 0
      Top = 0
      ImageIndex = 58
      Visible = False
      OnClick = QBBClick
    end
    object ParamsB: TToolButton
      Left = 23
      Top = 0
      ImageIndex = 71
      OnClick = ParamsBClick
    end
    object ToolButton2: TToolButton
      Left = 46
      Top = 0
      Width = 8
      ImageIndex = 58
      Style = tbsSeparator
    end
    object CancelB: TToolButton
      Left = 54
      Top = 0
      Hint = 'Cancel'
      ImageIndex = 55
      OnClick = CancelBClick
    end
    object OkB: TToolButton
      Left = 77
      Top = 0
      Hint = 'OK'
      ImageIndex = 56
      OnClick = OkBClick
    end
    object ToolButton3: TToolButton
      Left = 100
      Top = 0
      Width = 33
      Caption = 'ToolButton3'
      ImageIndex = 58
      Style = tbsSeparator
    end
    object CBPanel: TPanel
      Left = 133
      Top = 0
      Width = 244
      Height = 23
      BevelOuter = bvNone
      BorderWidth = 1
      ParentBackground = False
      TabOrder = 0
      object LDialect: TLabel
        Left = 1
        Top = 1
        Width = 96
        Height = 21
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SQL Dialect :'
        Layout = tlCenter
      end
      object CBDialect: TComboBox
        Left = 100
        Top = 1
        Width = 139
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = CBDialectChange
      end
    end
    object TBEditDialect: TToolButton
      Left = 377
      Top = 0
      ImageIndex = 68
      OnClick = TBEditDialectClick
    end
    object TBLoadDialect: TToolButton
      Left = 400
      Top = 0
      ImageIndex = 1
      OnClick = TBLoadDialectClick
    end
    object TBSaveDialect: TToolButton
      Left = 423
      Top = 0
      ImageIndex = 2
      OnClick = TBSaveDialectClick
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.ini'
    Filter = 'SQL Syntax presets|*.ini'
    Left = 8
    Top = 48
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.ini'
    Filter = 'SQL Syntax presets|*.ini'
    Left = 56
    Top = 48
  end
end
