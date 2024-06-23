inherited frmMasterDetailUDS: TfrmMasterDetailUDS
  Left = 272
  Top = 220
  Caption = 'Master-Detail demo'
  ClientHeight = 127
  ClientWidth = 228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 0
    Top = 0
    Width = 228
    Height = 127
    Align = alClient
    Caption = 'Run'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = BitBtn1Click
    ExplicitLeft = 153
    ExplicitWidth = 127
    ExplicitHeight = 75
  end
  object frxReport1: TfrxReport
    Version = '2022.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 38806.595330694400000000
    ReportOptions.LastChange = 38806.595330694400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 4
    Top = 12
    Datasets = <
      item
        DataSet = DetailDS
        DataSetName = 'DetailDS'
      end
      item
        DataSet = MasterDS
        DataSetName = 'MasterDS'
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
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 20.000000000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSet = MasterDS
        DataSetName = 'MasterDS'
        RowCount = 0
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Width = 260.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[MasterDS."name"]')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 20.000000000000000000
        Top = 60.472480000000000000
        Width = 718.110700000000000000
        DataSet = DetailDS
        DataSetName = 'DetailDS'
        RowCount = 0
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 24.000000000000000000
          Width = 236.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[DetailDS."name"]')
          ParentFont = False
        end
      end
    end
  end
  object MasterDS: TfrxUserDataSet
    UserName = 'MasterDS'
    OnCheckEOF = MasterDSCheckEOF
    OnFirst = MasterDSFirst
    OnNext = MasterDSNext
    OnPrior = MasterDSPrior
    Fields.Strings = (
      'name')
    OnGetValue = MasterDSGetValue
    Left = 40
    Top = 12
  end
  object DetailDS: TfrxUserDataSet
    UserName = 'DetailDS'
    OnCheckEOF = DetailDSCheckEOF
    OnFirst = DetailDSFirst
    OnNext = DetailDSNext
    OnPrior = DetailDSPrior
    Fields.Strings = (
      'mas_id'
      'name')
    OnGetValue = DetailDSGetValue
    Left = 76
    Top = 12
  end
end
