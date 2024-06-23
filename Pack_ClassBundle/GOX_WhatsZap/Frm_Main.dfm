object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Align = alClient
  BorderIcons = [biSystemMenu]
  Caption = 'FrmMain'
  ClientHeight = 692
  ClientWidth = 1315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object MResponse: TMemo
    Left = 681
    Top = 0
    Width = 634
    Height = 692
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
    WantTabs = True
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 681
    Height = 692
    ActivePage = TabSheet_Instance
    Align = alLeft
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object TabSheet_Instance: TTabSheet
      Caption = 'Instance'
      object GroupBox1: TGroupBox
        Left = 13
        Top = 3
        Width = 308
        Height = 606
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold, fsItalic]
        Padding.Left = 10
        Padding.Top = 10
        Padding.Right = 10
        ParentFont = False
        TabOrder = 0
        object Button2: TButton
          Left = 12
          Top = 283
          Width = 284
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'GET - /status'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 0
          OnClick = Button2Click
        end
        object Button4: TButton
          Left = 12
          Top = 365
          Width = 284
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'GET - /restart'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 1
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 12
          Top = 324
          Width = 284
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'GET - /qr-code/image'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 2
          OnClick = Button5Click
        end
        object Panel2: TPanel
          Left = 12
          Top = 33
          Width = 284
          Height = 250
          Align = alTop
          BevelKind = bkTile
          BevelOuter = bvNone
          TabOrder = 3
          object Image1: TImage
            Left = 0
            Top = 41
            Width = 280
            Height = 205
            Align = alClient
            AutoSize = True
            Center = True
            Proportional = True
            ExplicitLeft = 72
            ExplicitTop = -26
            ExplicitWidth = 196
            ExplicitHeight = 236
          end
          object Button1: TButton
            Left = 0
            Top = 0
            Width = 280
            Height = 41
            Cursor = crHandPoint
            Align = alTop
            Caption = 'Show QRCode'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            Style = bsCommandLink
            TabOrder = 0
            OnClick = Button1Click
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Message'
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 23
        Top = 32
        Width = 330
        Height = 478
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold, fsItalic]
        Padding.Left = 10
        Padding.Top = 10
        Padding.Right = 10
        ParentFont = False
        TabOrder = 0
        object Button7: TButton
          Left = 12
          Top = 33
          Width = 306
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'POST - /send-text'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 0
          OnClick = Button7Click
        end
        object Button8: TButton
          Left = 12
          Top = 74
          Width = 306
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'POST - /send-contact'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 1
          OnClick = Button8Click
        end
        object Button9: TButton
          Left = 12
          Top = 115
          Width = 306
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'POST - /send-image'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 2
          OnClick = Button9Click
        end
        object Button6: TButton
          Left = 12
          Top = 156
          Width = 306
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'POST - /send-audio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 3
          OnClick = Button6Click
        end
        object Button10: TButton
          Left = 12
          Top = 197
          Width = 306
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'POST - /send-video'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 4
          OnClick = Button10Click
        end
        object Button3: TButton
          Left = 12
          Top = 238
          Width = 306
          Height = 41
          Cursor = crHandPoint
          Align = alTop
          Caption = 'POST - /send-link'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Style = bsCommandLink
          TabOrder = 5
          OnClick = Button3Click
        end
      end
    end
  end
end
