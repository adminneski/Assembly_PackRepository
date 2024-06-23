inherited frmPrintArrayMain: TfrmPrintArrayMain
  Left = 179
  Top = 103
  ClientHeight = 146
  ClientWidth = 242
  ExplicitWidth = 258
  ExplicitHeight = 205
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton [0]
    Left = 8
    Top = 8
    Width = 228
    Height = 130
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Print'
    TabOrder = 0
    OnClick = Button1Click
  end
  object frxReport1: TfrxReport
    Version = '2022.2'
    DotMatrixReport = False
    EngineOptions.MaxMemSize = 10000000
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 38006.786384259300000000
    ReportOptions.LastChange = 38007.008949537000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnGetValue = frxReport1GetValue
    Left = 20
    Top = 28
    Datasets = <
      item
        DataSet = ArrayDS
        DataSetName = 'ArrayDS'
      end>
    Variables = <>
    Style = <>
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
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.000000000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 283.464750000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haCenter
          Memo.Strings = (
            'Array')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 718.000000000000000000
        DataSet = ArrayDS
        DataSetName = 'ArrayDS'
        RowCount = 0
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.Strings = (
            '[element]')
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 185.196970000000000000
        Width = 718.000000000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 642.419312533333000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.Strings = (
            '[Page#]')
        end
      end
    end
  end
  object ArrayDS: TfrxUserDataSet
    UserName = 'ArrayDS'
    Left = 56
    Top = 28
  end
end
