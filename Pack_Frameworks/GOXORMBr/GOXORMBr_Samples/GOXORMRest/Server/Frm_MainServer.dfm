object FrmMainServer: TFrmMainServer
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Server Project'
  ClientHeight = 597
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 518
    Height = 297
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 9
      Width = 47
      Height = 23
      Caption = 'Port:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Shape_ServerStatus: TShape
      Left = 455
      Top = 3
      Width = 43
      Height = 32
      Brush.Color = clRed
      Shape = stCircle
    end
    object Shape_DatabaseStatus: TShape
      Left = 455
      Top = 41
      Width = 42
      Height = 32
      Brush.Color = clRed
      Shape = stCircle
    end
    object Label2: TLabel
      Left = 332
      Top = 6
      Width = 116
      Height = 19
      Caption = 'Server Status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 309
      Top = 47
      Width = 140
      Height = 19
      Caption = 'Database Status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnStart: TButton
      Left = 18
      Top = 41
      Width = 100
      Height = 30
      Caption = 'Start'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 124
      Top = 41
      Width = 100
      Height = 30
      Caption = 'Stop'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnStopClick
    end
    object EdtPort: TEdit
      Left = 71
      Top = 6
      Width = 65
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Text = '8080'
    end
    object Params: TMemo
      Left = 16
      Top = 77
      Width = 481
      Height = 204
      Color = clSilver
      Enabled = False
      TabOrder = 3
    end
  end
  object Log: TMemo
    Left = 0
    Top = 297
    Width = 518
    Height = 300
    Align = alClient
    Color = 33023
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
