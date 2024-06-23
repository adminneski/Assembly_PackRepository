object frmSVGCache: TfrmSVGCache
  Left = 440
  Top = 304
  Caption = 'frmSVGCache'
  ClientHeight = 111
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PreviewTimeLabel: TLabel
    Left = 105
    Top = 17
    Width = 34
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Time: ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object CachedPreviewLabel: TLabel
    Left = 105
    Top = 56
    Width = 34
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Time: ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PreviewButton: TButton
    Left = 7
    Top = 7
    Width = 94
    Height = 35
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Preview'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = PreviewButtonClick
  end
  object CachedPreviewButton: TButton
    Left = 7
    Top = 46
    Width = 94
    Height = 36
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Cached Preview'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = CachedPreviewButtonClick
  end
  object AutoCloseCheckBox: TCheckBox
    Left = 7
    Top = 86
    Width = 129
    Height = 18
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Auto Close Preview'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object frxReport1: TfrxReport
    Version = '2022.2'
    DotMatrixReport = False
    EngineOptions.ConvertNulls = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.OutlineExpand = False
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43026.601309305600000000
    ReportOptions.LastChange = 44482.784827986110000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure ddPickListOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      ''
      'begin'
      ''
      ''
      'end.')
    OnProgressStart = frxReport1ProgressStart
    OnProgressStop = frxReport1ProgressStop
    Left = 264
    Top = 8
    Datasets = <
      item
        DataSet = UserDataSet
        DataSetName = 'UserDataSet'
      end>
    Variables = <
      item
        Name = ' Misc'
        Value = Null
      end
      item
        Name = 'NewPagePerStationOrPack'
        Value = Null
      end
      item
        Name = 'IsMergedView'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      PaperWidth = 210.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MyMasterData: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Frame.BottomLine.Width = 2.000000000000000000
        Height = 226.771721890000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = UserDataSet
        DataSetName = 'UserDataSet'
        RowCount = 0
        object PictureView: TfrxPictureView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Top = 18.897650000000000000
          Width = 332.598427640000000000
          Height = 185.196891890000000000
          Center = True
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object FileNameLabel: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 377.953000000000000000
          Top = 18.897650000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          DataField = 'FileName'
          DataSet = UserDataSet
          DataSetName = 'UserDataSet'
          Frame.Typ = []
          Memo.UTF8W = (
            '[UserDataSet."FileName"]')
        end
      end
    end
  end
  object UserDataSet: TfrxUserDataSet
    RangeEnd = reCount
    UserName = 'UserDataSet'
    Fields.Strings = (
      'FileName')
    OnGetValue = UserDataSetGetValue
    Left = 344
    Top = 8
  end
end
