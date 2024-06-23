inherited frmInteractiveReport: TfrmInteractiveReport
  Left = 176
  Top = 169
  Caption = 'Interactive report'
  ClientHeight = 139
  ClientWidth = 229
  ExplicitWidth = 245
  ExplicitHeight = 198
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton [0]
    Left = 0
    Top = 0
    Width = 229
    Height = 139
    Align = alClient
    Caption = 'Print!'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MainReport: TfrxReport
    Version = '2022.2'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    EngineOptions.MaxMemSize = 10000000
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator]
    PreviewOptions.OutlineWidth = 180
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 37871.995398692100000000
    ReportOptions.Description.Strings = (
      'Demonstrates how to create simple list report.')
    ReportOptions.LastChange = 38007.008561689800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnClickObject = MainReportClickObject
    Left = 28
    Top = 16
    Datasets = <
      item
        DataSet = CustomersDS
        DataSetName = 'Customers'
      end>
    Variables = <>
    Style = <>
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Columns = 1
      ColumnWidth = 210.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      MirrorMode = []
      PrintOnPreviousPage = True
      object Band1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 28.000000000000000000
        Top = 18.897650000000000000
        Width = 755.905999999999900000
        object Memo1: TfrxMemoView
          Align = baWidth
          AllowVectorExport = True
          Top = 4.000000000000000000
          Width = 755.905999999999900000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clGray
          HAlign = haCenter
          Memo.UTF8W = (
            'Customers')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Band2: TfrxPageHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 32.000000000000000000
        Top = 68.031540000000010000
        Width = 755.905999999999900000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 6.000000000000000000
          Top = 8.000000000000000000
          Width = 194.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Company')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 207.000000000000000000
          Top = 8.000000000000000000
          Width = 163.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Address')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 378.000000000000000000
          Top = 8.000000000000000000
          Width = 127.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Contact')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 512.000000000000000000
          Top = 8.000000000000000000
          Width = 89.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Phone')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 609.000000000000000000
          Top = 8.000000000000000000
          Width = 101.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Fax')
          ParentFont = False
        end
      end
      object Band3: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 28.000000000000000000
        Top = 241.889920000000000000
        Width = 755.905999999999900000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 6.000000000000000000
          Top = 8.000000000000000000
          Width = 704.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page] of [TotalPages]')
          ParentFont = False
        end
      end
      object Band4: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 20.000000000000000000
        Top = 162.519790000000000000
        Width = 755.905999999999900000
        Columns = 1
        ColumnWidth = 200.000000000000000000
        ColumnGap = 20.000000000000000000
        DataSet = CustomersDS
        DataSetName = 'Customers'
        RowCount = 0
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 6.000000000000000000
          Width = 704.000000000000000000
          Height = 20.000000000000000000
          DataSet = CustomersDS
          DataSetName = 'Customers'
          Frame.Typ = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -370606080
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '<Line#> mod 2'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          WordWrap = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 6.000000000000000000
          Width = 194.000000000000000000
          Height = 20.000000000000000000
          Cursor = crHandPoint
          TagStr = '[Customers."Cust No"]'
          DataField = 'Company'
          DataSet = CustomersDS
          DataSetName = 'Customers'
          Frame.Typ = []
          Memo.UTF8W = (
            '[Customers."Company"]')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 207.000000000000000000
          Width = 163.000000000000000000
          Height = 20.000000000000000000
          DataField = 'Addr1'
          DataSet = CustomersDS
          DataSetName = 'Customers'
          Frame.Typ = []
          Memo.UTF8W = (
            '[Customers."Addr1"]')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 378.000000000000000000
          Width = 127.000000000000000000
          Height = 20.000000000000000000
          DataField = 'Contact'
          DataSet = CustomersDS
          DataSetName = 'Customers'
          Frame.Typ = []
          Memo.UTF8W = (
            '[Customers."Contact"]')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 512.000000000000000000
          Width = 89.000000000000000000
          Height = 20.000000000000000000
          DataField = 'Phone'
          DataSet = CustomersDS
          DataSetName = 'Customers'
          Frame.Typ = []
          Memo.UTF8W = (
            '[Customers."Phone"]')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 609.000000000000000000
          Width = 101.000000000000000000
          Height = 20.000000000000000000
          DataField = 'FAX'
          DataSet = CustomersDS
          DataSetName = 'Customers'
          Frame.Typ = []
          Memo.UTF8W = (
            '[Customers."FAX"]')
        end
      end
    end
  end
  object DetailReport: TfrxReport
    Version = '2022.2'
    DotMatrixReport = False
    EngineOptions.MaxMemSize = 10000000
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 37871.995957488400000000
    ReportOptions.Description.Strings = (
      'This report shows how to use multiple groups.')
    ReportOptions.LastChange = 38007.008688888900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 168
    Top = 16
    Datasets = <
      item
        DataSet = DetailQueryDS
        DataSetName = 'Sales'
      end>
    Variables = <
      item
        Name = ' Customer'
        Value = ''
      end
      item
        Name = 'Company'
        Value = 'CustomerData.RepQuery."Company"'
      end
      item
        Name = 'Address'
        Value = 'CustomerData.RepQuery."Addr1"'
      end
      item
        Name = 'Contact'
        Value = 'CustomerData.RepQuery."Contact"'
      end
      item
        Name = 'Phone'
        Value = 'CustomerData.RepQuery."Phone"'
      end
      item
        Name = 'Fax'
        Value = 'CustomerData.RepQuery."FAX"'
      end
      item
        Name = ' Order'
        Value = ''
      end
      item
        Name = 'Order no'
        Value = 'CustomerData.RepQuery."OrderNo"'
      end
      item
        Name = 'Order date'
        Value = 'CustomerData.RepQuery."SaleDate"'
      end
      item
        Name = ' Part'
        Value = ''
      end
      item
        Name = 'Part no'
        Value = 'CustomerData.RepQuery."PartNo"'
      end
      item
        Name = 'Part description'
        Value = 'CustomerData.RepQuery."Description"'
      end
      item
        Name = 'Part price'
        Value = 'CustomerData.RepQuery."ListPrice"'
      end
      item
        Name = 'Part qty'
        Value = 'CustomerData.RepQuery."Qty"'
      end
      item
        Name = 'Part total'
        Value = '[Part price]*[Part qty]'
      end
      item
        Name = ' Description'
        Value = ''
      end
      item
        Name = 'Description'
        Value = 'This report shows how to use multiple groups.'
      end>
    Style = <>
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Columns = 1
      ColumnWidth = 210.000000000000000000
      ColumnPositions.Strings = (
        '0')
      Frame.Typ = []
      MirrorMode = []
      PrintOnPreviousPage = True
      object Band2: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 28.000000000000000000
        Top = 18.897650000000000000
        Width = 755.905999999999900000
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Top = 4.000000000000000000
          Width = 712.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clGray
          HAlign = haCenter
          Memo.UTF8W = (
            'Customers')
          ParentFont = False
          VAlign = vaBottom
        end
      end
      object Band4: TfrxGroupHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 44.000000000000000000
        Top = 105.826840000000000000
        Width = 755.905999999999900000
        Condition = 'Sales."Cust No"'
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Width = 712.000000000000000000
          Height = 44.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Frame.Color = clGray
          Frame.Typ = [ftLeft, ftRight, ftTop]
          Fill.BackColor = clMaroon
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 10.000000000000000000
          Width = 132.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = [ftTop]
          Fill.BackColor = clMaroon
          Memo.UTF8W = (
            'Company')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 10.000000000000000000
          Top = 20.000000000000000000
          Width = 268.000000000000000000
          Height = 24.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Frame.Color = clGray
          Frame.Typ = []
          Fill.BackColor = clMaroon
          Memo.UTF8W = (
            '[Sales."Company"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 302.000000000000000000
          Width = 80.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = [ftTop]
          Fill.BackColor = clMaroon
          Memo.UTF8W = (
            'Phone')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 466.000000000000000000
          Width = 80.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = [ftTop]
          Fill.BackColor = clMaroon
          Memo.UTF8W = (
            'Fax')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 302.000000000000000000
          Top = 20.000000000000000000
          Width = 148.000000000000000000
          Height = 24.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Frame.Color = clGray
          Frame.Typ = []
          Fill.BackColor = clMaroon
          Memo.UTF8W = (
            '[Sales."Phone"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 466.000000000000000000
          Top = 20.000000000000000000
          Width = 148.000000000000000000
          Height = 24.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          Frame.Color = clGray
          Frame.Typ = []
          Fill.BackColor = clMaroon
          Memo.UTF8W = (
            '[Sales."FAX"]')
          ParentFont = False
        end
      end
      object Band5: TfrxGroupHeader
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 40.000000000000000000
        Top = 173.858380000000000000
        Width = 755.905999999999900000
        Condition = 'Sales."Order No"'
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Top = 20.000000000000000000
          Width = 712.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Width = 712.000000000000000000
          Height = 20.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftLeft, ftRight]
          Fill.BackColor = clSilver
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 6.000000000000000000
          Width = 112.000000000000000000
          Height = 20.000000000000000000
          Frame.Color = clGray
          Frame.Typ = []
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Order No [Sales."Order No"]')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 126.000000000000000000
          Width = 116.000000000000000000
          Height = 20.000000000000000000
          Frame.Color = clGray
          Frame.Typ = []
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            'Date [Sales."Sale Date"]')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 46.000000000000000000
          Top = 20.000000000000000000
          Width = 60.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Part')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 114.000000000000000000
          Top = 20.000000000000000000
          Width = 232.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Description')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 354.000000000000000000
          Top = 20.000000000000000000
          Width = 80.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Price')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 442.000000000000000000
          Top = 20.000000000000000000
          Width = 60.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Qty')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 510.000000000000000000
          Top = 20.000000000000000000
          Width = 80.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
      end
      object Band6: TfrxMasterData
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 16.000000000000000000
        Top = 238.110390000000000000
        Width = 755.905999999999900000
        Columns = 1
        ColumnWidth = 200.000000000000000000
        ColumnGap = 20.000000000000000000
        DataSet = DetailQueryDS
        DataSetName = 'Sales'
        RowCount = 0
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Width = 712.000000000000000000
          Height = 16.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 46.000000000000000000
          Width = 60.000000000000000000
          Height = 16.000000000000000000
          DataField = 'Part No'
          DataSet = DetailQueryDS
          DataSetName = 'Sales'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Sales."Part No"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          AllowVectorExport = True
          Left = 114.000000000000000000
          Width = 232.000000000000000000
          Height = 16.000000000000000000
          DataField = 'Description'
          DataSet = DetailQueryDS
          DataSetName = 'Sales'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          Memo.UTF8W = (
            '[Sales."Description"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          AllowVectorExport = True
          Left = 354.000000000000000000
          Width = 80.000000000000000000
          Height = 16.000000000000000000
          DataField = 'List Price'
          DataSet = DetailQueryDS
          DataSetName = 'Sales'
          DisplayFormat.FormatStr = '%2.2m'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Sales."List Price"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          AllowVectorExport = True
          Left = 442.000000000000000000
          Width = 60.000000000000000000
          Height = 16.000000000000000000
          DataField = 'Qty'
          DataSet = DetailQueryDS
          DataSetName = 'Sales'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Sales."Qty"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          AllowVectorExport = True
          Left = 510.000000000000000000
          Width = 80.000000000000000000
          Height = 16.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[<Sales."Qty">*<Sales."List Price">]')
          ParentFont = False
        end
      end
      object Band7: TfrxGroupFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 32.000000000000000000
        Top = 321.260050000000000000
        Width = 755.905999999999900000
        object Memo28: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Width = 712.000000000000000000
          Height = 20.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Frame.Color = clGray
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Fill.BackColor = clSilver
          Memo.UTF8W = (
            
              'Total sales this customer: [Sum(<Sales."Qty">*<Sales."List Price' +
              '">)]')
        end
      end
      object Band8: TfrxGroupFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 24.000000000000000000
        Top = 275.905690000000000000
        Width = 755.905999999999900000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 2.000000000000000000
          Width = 712.000000000000000000
          Height = 24.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftLeft, ftRight]
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 46.000000000000000000
          Width = 544.000000000000000000
          Height = 20.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Color = clGray
          Frame.Typ = [ftTop]
          HAlign = haRight
          Memo.UTF8W = (
            'Total this order: [Sum(<Sales."Qty">*<Sales."List Price">)]')
          ParentFont = False
        end
      end
    end
  end
  object Customers: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    IndexName = 'ByCompany'
    TableName = 'CUSTOMER.DB'
    Left = 28
    Top = 48
    object CustomersCustNo: TFloatField
      FieldName = 'CustNo'
    end
    object CustomersCompany: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object CustomersAddr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object CustomersAddr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object CustomersCity: TStringField
      FieldName = 'City'
      Size = 15
    end
    object CustomersState: TStringField
      FieldName = 'State'
    end
    object CustomersZip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object CustomersCountry: TStringField
      FieldName = 'Country'
    end
    object CustomersPhone: TStringField
      FieldName = 'Phone'
      Size = 15
    end
    object CustomersFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object CustomersTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object CustomersContact: TStringField
      FieldName = 'Contact'
    end
    object CustomersLastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
  end
  object DetailQuery: TQuery
    DatabaseName = 'DBDEMOS'
    SQL.Strings = (
      'select * from customer a, orders b, items c, parts d'
      'where a.custno = b.custno'
      '  and b.orderno = c.orderno'
      '  and c.partno = d.partno'
      '  and a.custno = :custno'
      'order by a.company, orderno')
    Left = 168
    Top = 48
    ParamData = <
      item
        DataType = ftFloat
        Name = 'custno'
        ParamType = ptUnknown
      end>
    object DetailQueryCustNo: TFloatField
      FieldName = 'CustNo'
    end
    object DetailQueryCompany: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object DetailQueryAddr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object DetailQueryAddr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object DetailQueryCity: TStringField
      FieldName = 'City'
      Size = 15
    end
    object DetailQueryState: TStringField
      FieldName = 'State'
    end
    object DetailQueryZip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object DetailQueryCountry: TStringField
      FieldName = 'Country'
    end
    object DetailQueryPhone: TStringField
      FieldName = 'Phone'
      Size = 15
    end
    object DetailQueryFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object DetailQueryTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object DetailQueryContact: TStringField
      FieldName = 'Contact'
    end
    object DetailQueryLastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
    object DetailQueryOrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object DetailQueryCustNo_1: TFloatField
      FieldName = 'CustNo_1'
    end
    object DetailQuerySaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object DetailQueryShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object DetailQueryEmpNo: TIntegerField
      FieldName = 'EmpNo'
    end
    object DetailQueryShipToContact: TStringField
      FieldName = 'ShipToContact'
    end
    object DetailQueryShipToAddr1: TStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object DetailQueryShipToAddr2: TStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object DetailQueryShipToCity: TStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object DetailQueryShipToState: TStringField
      FieldName = 'ShipToState'
    end
    object DetailQueryShipToZip: TStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object DetailQueryShipToCountry: TStringField
      FieldName = 'ShipToCountry'
    end
    object DetailQueryShipToPhone: TStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object DetailQueryShipVIA: TStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object DetailQueryPO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object DetailQueryTerms: TStringField
      FieldName = 'Terms'
      Size = 6
    end
    object DetailQueryPaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object DetailQueryItemsTotal: TCurrencyField
      FieldName = 'ItemsTotal'
    end
    object DetailQueryTaxRate_1: TFloatField
      FieldName = 'TaxRate_1'
    end
    object DetailQueryFreight: TCurrencyField
      FieldName = 'Freight'
    end
    object DetailQueryAmountPaid: TCurrencyField
      FieldName = 'AmountPaid'
    end
    object DetailQueryOrderNo_1: TFloatField
      FieldName = 'OrderNo_1'
    end
    object DetailQueryItemNo: TFloatField
      FieldName = 'ItemNo'
    end
    object DetailQueryPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object DetailQueryQty: TIntegerField
      FieldName = 'Qty'
    end
    object DetailQueryDiscount: TFloatField
      FieldName = 'Discount'
    end
    object DetailQueryPartNo_1: TFloatField
      FieldName = 'PartNo_1'
    end
    object DetailQueryVendorNo: TFloatField
      FieldName = 'VendorNo'
    end
    object DetailQueryDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object DetailQueryOnHand: TFloatField
      FieldName = 'OnHand'
    end
    object DetailQueryOnOrder: TFloatField
      FieldName = 'OnOrder'
    end
    object DetailQueryCost: TCurrencyField
      FieldName = 'Cost'
    end
    object DetailQueryListPrice: TCurrencyField
      FieldName = 'ListPrice'
    end
  end
  object CustomersDS: TfrxDBDataset
    UserName = 'Customers'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CustNo=Cust No'
      'Company=Company'
      'Addr1=Addr1'
      'Addr2=Addr2'
      'City=City'
      'State=State'
      'Zip=Zip'
      'Country=Country'
      'Phone=Phone'
      'FAX=FAX'
      'TaxRate=Tax Rate'
      'Contact=Contact'
      'LastInvoiceDate=Last Invoice Date')
    DataSet = Customers
    BCDToCurrency = False
    DataSetOptions = []
    Left = 28
    Top = 80
  end
  object DetailQueryDS: TfrxDBDataset
    UserName = 'Sales'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CustNo=Cust No'
      'Company=Company'
      'Addr1=Addr1'
      'Addr2=Addr2'
      'City=City'
      'State=State'
      'Zip=Zip'
      'Country=Country'
      'Phone=Phone'
      'FAX=FAX'
      'TaxRate=Tax Rate'
      'Contact=Contact'
      'LastInvoiceDate=Last Invoice Date'
      'OrderNo=Order No'
      'CustNo_1=Cust No 1'
      'SaleDate=Sale Date'
      'ShipDate=Ship Date'
      'EmpNo=Emp No'
      'ShipToContact=Ship To Contact'
      'ShipToAddr1=Ship To Addr1'
      'ShipToAddr2=Ship To Addr2'
      'ShipToCity=Ship To City'
      'ShipToState=Ship To State'
      'ShipToZip=Ship To Zip'
      'ShipToCountry=Ship To Country'
      'ShipToPhone=Ship To Phone'
      'ShipVIA=Ship VIA'
      'PO=PO'
      'Terms=Terms'
      'PaymentMethod=Payment Method'
      'ItemsTotal=Items Total'
      'TaxRate_1=Tax Rate 1'
      'Freight=Freight'
      'AmountPaid=Amount Paid'
      'OrderNo_1=Order No 1'
      'ItemNo=Item No'
      'PartNo=Part No'
      'Qty=Qty'
      'Discount=Discount'
      'PartNo_1=Part No 1'
      'VendorNo=Vendor No'
      'Description=Description'
      'OnHand=On Hand'
      'OnOrder=On Order'
      'Cost=Cost'
      'ListPrice=List Price')
    DataSet = DetailQuery
    BCDToCurrency = False
    DataSetOptions = []
    Left = 168
    Top = 80
  end
end
