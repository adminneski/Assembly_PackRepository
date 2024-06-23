object frxHTMLEditorForm: TfrxHTMLEditorForm
  Tag = 3850
  Left = 200
  Top = 107
  Caption = 'HTML'
  ClientHeight = 369
  ClientWidth = 726
  Color = clBtnFace
  Constraints.MinHeight = 408
  Constraints.MinWidth = 408
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 426
    Height = 29
    AutoSize = True
    BorderWidth = 2
    ButtonHeight = 21
    ButtonWidth = 39
    TabOrder = 0
    object LoadB: TToolButton
      Left = 0
      Top = 0
      Caption = 'Load'
      ImageIndex = 1
      OnClick = LoadBClick
    end
    object ToolButton1: TToolButton
      Left = 39
      Top = 0
      Width = 10
      ImageIndex = 3
      Style = tbsSeparator
    end
    object CancelB: TToolButton
      Left = 49
      Top = 0
      Caption = 'Cancel'
      ImageIndex = 55
      OnClick = CancelBClick
    end
    object OkB: TToolButton
      Left = 88
      Top = 0
      Caption = 'OK'
      ImageIndex = 56
      OnClick = OkBClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 29
    Width = 426
    Height = 340
    ActivePage = SourceTabSheet
    Align = alClient
    TabOrder = 1
    object SourceTabSheet: TTabSheet
      Tag = 3860
      Caption = 'Source'
      object SourceToolBar: TToolBar
        Left = 0
        Top = 0
        Width = 418
        Height = 27
        ButtonHeight = 21
        ButtonWidth = 19
        TabOrder = 0
        object ExprB: TToolButton
          Left = 0
          Top = 0
          Hint = 'Insert Expression'
          ImageIndex = 70
          OnClick = ExprBClick
        end
        object AggregateB: TToolButton
          Left = 19
          Top = 0
          ImageIndex = 85
          OnClick = AggregateBClick
        end
        object WordWrapB: TToolButton
          Left = 38
          Top = 0
          Hint = 'Word Wrap'
          AllowAllUp = True
          ImageIndex = 25
          Style = tbsCheck
          OnClick = WordWrapBClick
        end
      end
    end
    object HTMLTabSheet: TTabSheet
      Tag = 3870
      Caption = 'HTML'
      ImageIndex = 1
      object HTMLPaintBox: TPaintBox
        Left = 0
        Top = 27
        Width = 418
        Height = 285
        Align = alClient
        OnPaint = HTMLPaintBoxPaint
      end
      object HTMLToolBar: TToolBar
        Left = 0
        Top = 0
        Width = 418
        Height = 27
        ButtonHeight = 21
        ButtonWidth = 19
        TabOrder = 0
        object WidthToolButton: TToolButton
          Left = 0
          Top = 0
          Hint = 'Use Control Width'
          ImageIndex = 131
          Style = tbsCheck
          OnClick = WidthToolButtonClick
        end
        object ControlSizeToolButton: TToolButton
          Left = 19
          Top = 0
          Hint = 'Show Control Size'
          Caption = 'Use Control Height'
          ImageIndex = 130
          Style = tbsCheck
          OnClick = WidthToolButtonClick
        end
      end
    end
    object DefaultTabSheet: TTabSheet
      Tag = 3880
      Caption = 'Default'
      ImageIndex = 2
      object DefBackgroundLabel: TLabel
        Tag = 3881
        Left = 12
        Top = 12
        Width = 86
        Height = 13
        Caption = 'Background color:'
      end
      object DefFontColorLabel: TLabel
        Tag = 3882
        Left = 12
        Top = 44
        Width = 54
        Height = 13
        Caption = 'Font Color:'
      end
      object DefFontNameLabel: TLabel
        Tag = 3883
        Left = 12
        Top = 76
        Width = 56
        Height = 13
        Caption = 'Font Name:'
      end
      object DefFontSizeLabel: TLabel
        Tag = 3884
        Left = 12
        Top = 108
        Width = 48
        Height = 13
        Caption = 'Font Size:'
      end
      object DefHotSpotColorLabel: TLabel
        Tag = 3885
        Left = 11
        Top = 140
        Width = 74
        Height = 13
        Caption = 'Hot Spot Color:'
      end
      object DefPreFontNameLabel: TLabel
        Tag = 3886
        Left = 12
        Top = 172
        Width = 75
        Height = 13
        Caption = 'Pre Font Name:'
      end
      object MarginWidthLabel: TLabel
        Tag = 3887
        Left = 12
        Top = 204
        Width = 67
        Height = 13
        Caption = 'Margin Width:'
      end
      object MarginHeightLabel: TLabel
        Tag = 3888
        Left = 12
        Top = 236
        Width = 70
        Height = 13
        Caption = 'Margin Height:'
      end
      object DefBackgroundColorBox: TColorBox
        Left = 128
        Top = 9
        Width = 117
        Height = 22
        DefaultColorColor = clWhite
        TabOrder = 0
      end
      object DefFontColorColorBox: TColorBox
        Left = 128
        Top = 41
        Width = 117
        Height = 22
        TabOrder = 1
      end
      object DefFontNameComboBox: TfrxFontComboBox
        Left = 128
        Top = 73
        Width = 144
        Height = 22
        Hint = 'Font Name'
        MRURegKey = '\Software\FastReport\MRUFont'
        DropDownCount = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object DefFontSizeComboBox: TfrxComboBox
        Tag = 3880
        Left = 128
        Top = 105
        Width = 45
        Height = 19
        Hint = 'Font Size'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Items.Strings = (
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11'
          '12'
          '14'
          '16'
          '18'
          '20'
          '22'
          '24'
          '26'
          '28'
          '36'
          '48'
          '72')
        ListWidth = 0
        ParentFont = False
        TabOrder = 3
        ItemIndex = -1
        OnKeyPress = DefFontSizeComboBoxKeyPress
      end
      object DefHotSpotColorColorBox: TColorBox
        Left = 127
        Top = 137
        Width = 117
        Height = 22
        TabOrder = 4
      end
      object DefPreFontNameComboBox: TfrxFontComboBox
        Left = 127
        Top = 169
        Width = 144
        Height = 22
        Hint = 'Font Name'
        MRURegKey = '\Software\FastReport\MRUFont'
        DropDownCount = 12
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object MarginWidthEdit: TEdit
        Left = 128
        Top = 201
        Width = 43
        Height = 21
        TabOrder = 6
        Text = '0'
        OnKeyPress = DefFontSizeComboBoxKeyPress
      end
      object MarginWidthUpDown: TUpDown
        Left = 171
        Top = 201
        Width = 20
        Height = 21
        Associate = MarginWidthEdit
        Max = 10000
        TabOrder = 7
      end
      object MarginHeightEdit: TEdit
        Left = 127
        Top = 233
        Width = 43
        Height = 21
        TabOrder = 8
        Text = '0'
        OnKeyPress = DefFontSizeComboBoxKeyPress
      end
      object MarginHeightUpDown: TUpDown
        Left = 170
        Top = 233
        Width = 20
        Height = 21
        Associate = MarginHeightEdit
        Max = 10000
        TabOrder = 9
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'HTML|*.htm; *.html|Any File|*.*'
    Left = 250
    Top = 2
  end
end
