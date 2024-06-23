inherited frmCustomScrollsMain: TfrmCustomScrollsMain
  Left = 192
  Top = 125
  ClientHeight = 431
  ClientWidth = 586
  OnCreate = FormCreate
  ExplicitWidth = 602
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 13
  object frxPreview: TfrxPreview [0]
    Left = 0
    Top = 0
    Width = 569
    Height = 414
    Align = alClient
    OutlineVisible = True
    OutlineWidth = 121
    ThumbnailVisible = False
    FindFmVisible = False
    UseReportHints = True
    OutlineTreeSortType = dtsUnsorted
    HideScrolls = True
    OnScrollMaxChange = frxPreviewOnScrollMaxChange
    OnScrollPosChange = frxPreviewOnScrollPosChange
  end
  object VScroll: TScrollBar [1]
    Left = 569
    Top = 0
    Width = 17
    Height = 414
    Align = alRight
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnScroll = VScrollScroll
    ExplicitLeft = 575
    ExplicitTop = -6
    ExplicitHeight = 390
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 414
    Width = 586
    Height = 17
    HelpContext = 17
    Align = alBottom
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    object HScroll: TScrollBar
      Left = 0
      Top = 0
      Width = 569
      Height = 17
      Align = alClient
      PageSize = 0
      TabOrder = 0
      OnScroll = HScrollScroll
      ExplicitTop = 32
      ExplicitHeight = 9
    end
    object Panel2: TPanel
      Left = 569
      Top = 0
      Width = 17
      Height = 17
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = 575
      ExplicitTop = 6
    end
  end
  object frxReport: TfrxReport
    Version = '2022.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43821.455890636600000000
    ReportOptions.LastChange = 43821.459842037040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 792
    Top = 104
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 136.063080000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        RowCount = 30
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Width = 718.110700000000000000
          Height = 136.063080000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -96
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[time]')
          ParentFont = False
        end
      end
    end
  end
end
