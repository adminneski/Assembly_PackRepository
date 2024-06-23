object DlgShowXML: TDlgShowXML
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Report XML'
  ClientHeight = 729
  ClientWidth = 1264
  Color = clBtnFace
  Constraints.MinHeight = 768
  Constraints.MinWidth = 1280
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object EdgeBrowser: TEdgeBrowser
    Left = 0
    Top = 33
    Width = 1264
    Height = 696
    Align = alClient
    TabOrder = 0
    UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
  end
  object pnMSG: TPanel
    Left = 0
    Top = 0
    Width = 1264
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Color = 8421440
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
  end
end
