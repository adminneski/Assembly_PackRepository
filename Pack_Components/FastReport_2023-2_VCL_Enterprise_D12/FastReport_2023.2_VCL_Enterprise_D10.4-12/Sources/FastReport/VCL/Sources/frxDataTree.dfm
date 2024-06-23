object frxDataTreeForm: TfrxDataTreeForm
  Left = 224
  Top = 111
  Width = 327
  Height = 427
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsSizeToolWin
  Caption = 'Data Fields'
  Color = clBtnFace
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = True
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object FunctionsPn: TPanel
    Left = 38
    Top = 44
    Width = 185
    Height = 265
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object Splitter1: TSplitter
      Left = 0
      Top = 166
      Width = 185
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object HintPanel: TScrollBox
      Left = 0
      Top = 169
      Width = 185
      Height = 96
      HorzScrollBar.Visible = False
      VertScrollBar.Visible = False
      Align = alBottom
      BorderStyle = bsNone
      Color = clWindow
      ParentColor = False
      TabOrder = 0
      object FunctionDescL: TLabel
        Left = 0
        Top = 42
        Width = 185
        Height = 54
        Align = alClient
        AutoSize = False
        Color = clWhite
        ParentColor = False
        ShowAccelChar = False
        WordWrap = True
      end
      object FunctionNameL: TLabel
        Left = 0
        Top = 0
        Width = 185
        Height = 42
        Align = alTop
        AutoSize = False
        Color = clInfoBk
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ShowAccelChar = False
        WordWrap = True
      end
    end
  end
  object NoDataPn: TScrollBox
    Left = 8
    Top = 8
    Width = 101
    Height = 41
    BorderStyle = bsNone
    Color = clWindow
    ParentColor = False
    TabOrder = 2
    Visible = False
    object NoDataL: TLabel
      Left = 0
      Top = 0
      Width = 101
      Height = 41
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'NoDataL'
      Transparent = True
      WordWrap = True
      OnDblClick = DataTreeDblClick
    end
  end
end
