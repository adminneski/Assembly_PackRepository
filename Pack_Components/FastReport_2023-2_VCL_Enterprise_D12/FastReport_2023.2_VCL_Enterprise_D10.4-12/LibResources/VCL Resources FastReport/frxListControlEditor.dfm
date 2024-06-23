object frxListControlEditorForm: TfrxListControlEditorForm
  Left = 200
  Top = 107
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Memo'
  ClientHeight = 482
  ClientWidth = 809
  Color = clBtnFace
  Constraints.MinHeight = 352
  Constraints.MinWidth = 520
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  ShowHint = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 809
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
    Width = 809
    Height = 453
    ActivePage = TextTS
    Align = alClient
    Constraints.MinHeight = 252
    TabOrder = 1
    object TextTS: TTabSheet
      Caption = 'Text'
      object ToolBar: TToolBar
        Left = 0
        Top = 0
        Width = 801
        Height = 27
        ButtonHeight = 23
        TabOrder = 0
        object ExprB: TToolButton
          Left = 0
          Top = 0
          Hint = 'Insert Expression'
          ImageIndex = 70
          OnClick = ExprBClick
        end
        object AggregateB: TToolButton
          Left = 23
          Top = 0
          ImageIndex = 85
          OnClick = AggregateBClick
        end
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'HTML|*.htm; *.html|Any File|*.*'
    Left = 250
    Top = 2
  end
end
