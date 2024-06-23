inherited frmBenchmarkMain: TfrmBenchmarkMain
  Left = 776
  Top = 192
  Caption = 'Benchmark'
  ClientHeight = 441
  ClientWidth = 731
  Font.Name = 'MS Sans Serif'
  ExplicitWidth = 747
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 731
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 16
      Width = 91
      Height = 13
      Caption = #1055#1086#1083#1077#1081' '#1080#1079#1084#1077#1088#1077#1085#1080#1081
    end
    object Label2: TLabel
      Left = 201
      Top = 16
      Width = 67
      Height = 13
      Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1077#1081
    end
    object Label3: TLabel
      Left = 201
      Top = 44
      Width = 95
      Height = 13
      Caption = #1048#1089#1093#1086#1076#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081
    end
    object Label4: TLabel
      Left = 4
      Top = 44
      Width = 113
      Height = 13
      Caption = #1059#1085#1080#1082#1072#1083#1100#1085#1099#1093' '#1079#1085#1072#1095#1077#1085#1080#1081
    end
    object Status: TLabel
      Left = 188
      Top = 107
      Width = 3
      Height = 13
    end
    object d_cnt: TSpinEdit
      Left = 120
      Top = 8
      Width = 71
      Height = 22
      MaxValue = 10
      MinValue = 1
      TabOrder = 0
      Value = 4
    end
    object m_cnt: TSpinEdit
      Left = 304
      Top = 8
      Width = 68
      Height = 22
      MaxValue = 10
      MinValue = 0
      TabOrder = 1
      Value = 4
    end
    object r_cnt: TSpinEdit
      Left = 304
      Top = 40
      Width = 68
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 100000
    end
    object dm_cnt: TSpinEdit
      Left = 120
      Top = 40
      Width = 73
      Height = 22
      MaxValue = 10000000
      MinValue = 1
      TabOrder = 3
      Value = 500
    end
    object Button1: TButton
      Left = 400
      Top = 8
      Width = 185
      Height = 25
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1090#1077#1089#1090#1086#1074#1099#1081' '#1085#1072#1073#1086#1088' '#1076#1072#1085#1085#1099#1093
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 400
      Top = 71
      Width = 185
      Height = 25
      Action = actBuildCross
      TabOrder = 6
    end
    object Progress: TProgressBar
      Left = 4
      Top = 106
      Width = 178
      Height = 17
      TabOrder = 7
      Visible = False
    end
    object Button3: TButton
      Left = 400
      Top = 40
      Width = 185
      Height = 25
      Action = actLoadDS
      TabOrder = 5
    end
  end
  object fcxSliceGridToolbar1: TfcxSliceGridToolbar [1]
    Left = 0
    Top = 129
    Width = 731
    Height = 22
    AutoSize = True
    Caption = 'fcxSliceGridToolbar1'
    TabOrder = 1
    Version = '2.0.0'
    SliceGrid = fcxSliceGrid1
  end
  object fcxSliceGrid1: TfcxSliceGrid [2]
    Left = 0
    Top = 151
    Width = 731
    Height = 290
    Version = '2.0.0'
    Align = alClient
    Slice = fcxSlice1
    Styles.CaptionArea.TextColor = clBlack
    Styles.CaptionArea.FillColor = 15466495
    Styles.CaptionArea.GradientColor = clWhite
    Styles.CaptionArea.Font.Charset = DEFAULT_CHARSET
    Styles.CaptionArea.Font.Color = clWindowText
    Styles.CaptionArea.Font.Height = -11
    Styles.CaptionArea.Font.Name = 'MS Sans Serif'
    Styles.CaptionArea.Font.Style = []
    Styles.CaptionArea.GradientDirection = tgdHorizontal
    Styles.HeaderArea.TextColor = clBlack
    Styles.HeaderArea.FillColor = clBtnFace
    Styles.HeaderArea.Font.Charset = DEFAULT_CHARSET
    Styles.HeaderArea.Font.Color = clWindowText
    Styles.HeaderArea.Font.Height = -11
    Styles.HeaderArea.Font.Name = 'MS Sans Serif'
    Styles.HeaderArea.Font.Style = []
    Styles.HeaderCells.TextColor = clBlack
    Styles.HeaderCells.FillColor = clBtnFace
    Styles.HeaderCells.Font.Charset = DEFAULT_CHARSET
    Styles.HeaderCells.Font.Color = clWindowText
    Styles.HeaderCells.Font.Height = -11
    Styles.HeaderCells.Font.Name = 'MS Sans Serif'
    Styles.HeaderCells.Font.Style = []
    Styles.HeaderCellsSelected.TextColor = clBtnText
    Styles.HeaderCellsSelected.FillColor = clBtnShadow
    Styles.HeaderCellsSelected.Font.Charset = DEFAULT_CHARSET
    Styles.HeaderCellsSelected.Font.Color = clWindowText
    Styles.HeaderCellsSelected.Font.Height = -11
    Styles.HeaderCellsSelected.Font.Name = 'MS Sans Serif'
    Styles.HeaderCellsSelected.Font.Style = []
    Styles.DataArea.TextColor = clGray
    Styles.DataArea.FillColor = clWhite
    Styles.DataArea.Font.Charset = DEFAULT_CHARSET
    Styles.DataArea.Font.Color = clWindowText
    Styles.DataArea.Font.Height = -11
    Styles.DataArea.Font.Name = 'MS Sans Serif'
    Styles.DataArea.Font.Style = []
    Styles.DataCells.TextColor = clBlack
    Styles.DataCells.FillColor = clWhite
    Styles.DataCells.Font.Charset = DEFAULT_CHARSET
    Styles.DataCells.Font.Color = clWindowText
    Styles.DataCells.Font.Height = -11
    Styles.DataCells.Font.Name = 'MS Sans Serif'
    Styles.DataCells.Font.Style = []
    Styles.DataCellsSelected.TextColor = clHighlightText
    Styles.DataCellsSelected.FillColor = clHighlight
    Styles.DataCellsSelected.Font.Charset = DEFAULT_CHARSET
    Styles.DataCellsSelected.Font.Color = clWindowText
    Styles.DataCellsSelected.Font.Height = -11
    Styles.DataCellsSelected.Font.Name = 'MS Sans Serif'
    Styles.DataCellsSelected.Font.Style = []
    Styles.StatusArea.TextColor = clBlack
    Styles.StatusArea.FillColor = clBtnFace
    Styles.StatusArea.Font.Charset = DEFAULT_CHARSET
    Styles.StatusArea.Font.Color = clWindowText
    Styles.StatusArea.Font.Height = -11
    Styles.StatusArea.Font.Name = 'MS Sans Serif'
    Styles.StatusArea.Font.Style = []
    Styles.ActiveDimension.TextColor = clCaptionText
    Styles.ActiveDimension.FillColor = clActiveCaption
    Styles.ActiveDimension.GradientColor = clGradientActiveCaption
    Styles.ActiveDimension.Font.Charset = DEFAULT_CHARSET
    Styles.ActiveDimension.Font.Color = clWindowText
    Styles.ActiveDimension.Font.Height = -11
    Styles.ActiveDimension.Font.Name = 'MS Sans Serif'
    Styles.ActiveDimension.Font.Style = []
    Styles.ActiveDimension.GradientDirection = tgdHorizontal
    Styles.InactiveDimension.TextColor = clInactiveCaptionText
    Styles.InactiveDimension.FillColor = clInactiveCaption
    Styles.InactiveDimension.GradientColor = clGradientInactiveCaption
    Styles.InactiveDimension.Font.Charset = DEFAULT_CHARSET
    Styles.InactiveDimension.Font.Color = clWindowText
    Styles.InactiveDimension.Font.Height = -11
    Styles.InactiveDimension.Font.Name = 'MS Sans Serif'
    Styles.InactiveDimension.Font.Style = []
    Styles.InactiveDimension.GradientDirection = tgdHorizontal
    Styles.Measure.TextColor = clCaptionText
    Styles.Measure.FillColor = clGreen
    Styles.Measure.GradientColor = clMoneyGreen
    Styles.Measure.Font.Charset = DEFAULT_CHARSET
    Styles.Measure.Font.Color = clWindowText
    Styles.Measure.Font.Height = -11
    Styles.Measure.Font.Name = 'MS Sans Serif'
    Styles.Measure.Font.Style = []
    Styles.Measure.GradientDirection = tgdHorizontal
    Styles.DataCellsTotals.TextColor = clBlack
    Styles.DataCellsTotals.FillColor = 15466495
    Styles.DataCellsTotals.GradientColor = clWhite
    Styles.DataCellsTotals.Font.Charset = DEFAULT_CHARSET
    Styles.DataCellsTotals.Font.Color = clWindowText
    Styles.DataCellsTotals.Font.Height = -11
    Styles.DataCellsTotals.Font.Name = 'MS Sans Serif'
    Styles.DataCellsTotals.Font.Style = []
    Styles.FieldsItem.TextColor = clCaptionText
    Styles.FieldsItem.FillColor = clMoneyGreen
    Styles.FieldsItem.Font.Charset = DEFAULT_CHARSET
    Styles.FieldsItem.Font.Color = clWindowText
    Styles.FieldsItem.Font.Height = -11
    Styles.FieldsItem.Font.Name = 'MS Sans Serif'
    Styles.FieldsItem.Font.Style = []
    TabOrder = 2
    XDimsZone.Visible = True
    YDimsZone.Visible = True
    PageDimsZone.Visible = True
    StatusZone.FloatFormat.DecSeparator = ','
    StatusZone.FloatFormat.FormatStr = '#0.##'
    StatusZone.FloatFormat.Kind = fkNumeric
    StatusZone.IntegerFormat.DecSeparator = ','
    StatusZone.IntegerFormat.FormatStr = '#0.##'
    StatusZone.IntegerFormat.Kind = fkNumeric
    FieldsZone.Visible = True
  end
  inherited alMain: TActionList
    object actLoadDS: TAction
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1082#1091#1073
      OnExecute = actLoadDSExecute
      OnUpdate = actLoadDSUpdate
    end
    object actBuildCross: TAction
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1082#1088#1086#1089#1089'-'#1090#1072#1073#1083#1080#1094#1091
      OnExecute = actBuildCrossExecute
      OnUpdate = actBuildCrossUpdate
    end
  end
  object fcxCube1: TfcxCube
    Version = '2.0.0'
    DataSource = fcxDataSource1
    CubeSource = fccs_DataSource
    Formats.BooleanFormat.DecSeparator = ','
    Formats.BooleanFormat.FormatStr = 'False,True'
    Formats.BooleanFormat.Kind = fkBoolean
    Formats.DateFormat.DecSeparator = ','
    Formats.DateFormat.FormatStr = 'dd.MM.yyyy'
    Formats.DateFormat.Kind = fkDateTime
    Formats.TimeFormat.DecSeparator = ','
    Formats.TimeFormat.FormatStr = 'h:mm'
    Formats.TimeFormat.Kind = fkDateTime
    Formats.DateTimeFormat.DecSeparator = ','
    Formats.DateTimeFormat.FormatStr = 'h:mm dd.MM.yyyy'
    Formats.DateTimeFormat.Kind = fkDateTime
    Formats.FloatFormat.DecSeparator = ','
    Formats.FloatFormat.FormatStr = '%2.2n'
    Formats.FloatFormat.Kind = fkNumeric
    Formats.CurrencyFormat.DecSeparator = ','
    Formats.CurrencyFormat.FormatStr = '%2.2m'
    Formats.CurrencyFormat.Kind = fkNumeric
    Formats.IntegerFormat.DecSeparator = ','
    Formats.IntegerFormat.FormatStr = '%g'
    Formats.IntegerFormat.Kind = fkNumeric
    Formats.TextFormat.DecSeparator = ','
    Formats.PercentFormat.DecSeparator = ','
    Formats.PercentFormat.FormatStr = '%2.2n'
    Formats.PercentFormat.Kind = fkNumeric
    Formats.DatePathFormat.MonthDisplayFormat = mdf_Long
    Formats.DatePathFormat.WeekDayDisplayFormat = wddf_Long
    Formats.DatePathFormat.QuarterDisplayFormat = qdf_System
    Formats.DatePathFormat.WeekNumberDisplayFormat = wndf_System
    Left = 168
    Top = 184
  end
  object fcxSlice1: TfcxSlice
    Version = '2.0.0'
    Cube = fcxCube1
    FieldsOrder = fcfloByDataSet
    Left = 200
    Top = 184
  end
  object fcxDataSource1: TfcxDataSource
    Version = '2.0.0'
    DataSet = fcxDBDataSet1
    Fields = <>
    Left = 136
    Top = 184
  end
  object fcxDBDataSet1: TfcxDBDataSet
    Version = '2.0.0'
    DataSet = cdsBench
    Left = 104
    Top = 184
  end
  object cdsBench: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 128
  end
end
