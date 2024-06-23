inherited frmDynamicTable: TfrmDynamicTable
  Left = 179
  Top = 103
  ClientHeight = 138
  ClientWidth = 231
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton [0]
    Left = 0
    Top = 0
    Width = 231
    Height = 138
    Align = alClient
    Caption = 'Print'
    TabOrder = 0
    OnClick = Button1Click
  end
  object frxReport1: TfrxReport
    Tag = 21650
    Version = '2022.2'
    DotMatrixReport = False
    EngineOptions.MaxMemSize = 10000000
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44312.928031423600000000
    ReportOptions.Description.Strings = (
      
        'Demonstrates how to print multiple Table rows with a script. To ' +
        'do this:'
      '- select the Table object;'
      
        '- go to the "Properties" window and click the "Events" tab to vi' +
        'ew a list of available events;'
      '- doubleclick the "ManualBuild" event;'
      
        '- you will see an empty event handler. You need to print rows us' +
        'ing the "TableObject.TableBuilder.PrintRow" method; in each row,' +
        ' you must also print all the columns (using "PrintColumns" metho' +
        'd). See the script'#39's code for more details.'
      
        'When you run a report, the Table will repeat a row and fill it w' +
        'ith data.')
    ReportOptions.LastChange = 44438.750385879600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnObjectManualBuild = frxReport1ObjectManualBuild
    OnReportPrint = 'frxReportAbstractOnReportPrint'
    Left = 20
    Top = 28
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'Country'
      end>
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
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 42.807692310000000000
        Top = 16.000000000000000000
        Width = 718.110700000000000000
        Child = frxReport1.Child1
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 2.500000010000000000
          Top = 1.500000000000000000
          Width = 709.670000000000000000
          Height = 41.307692310000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          FillType = ftGlass
          Fill.Color = clNone
          Fill.Blend = 0.500000000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Customers table')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 220.000000000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 642.520100000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Page#]')
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        FillGap.Top = 0
        FillGap.Left = 0
        FillGap.Bottom = 0
        FillGap.Right = 0
        Frame.Typ = []
        Height = 80.468975560000000000
        Top = 80.000000000000000000
        Width = 718.110700000000000000
        Stretched = True
        ToNRows = 0
        ToNRowsMode = rmCount
        object TableObject3: TfrxTableObject
          AllowVectorExport = True
          Left = 1.845083330000000000
          Top = 1.720470000000000000
          StretchMode = smActualHeight
          object TableColumn2: TfrxTableColumn
            AutoSize = True
            Width = 124.757266666667000000
            MaxWidth = 375.590600000000000000
          end
          object TableColumn1: TfrxTableColumn
            AutoSize = True
            Width = 168.090600000000000000
            MinWidth = 100.000000000000000000
            MaxWidth = 1000.000000000000000000
          end
          object TableColumn3: TfrxTableColumn
            Width = 133.851469565217000000
            MaxWidth = 75.590600000000000000
          end
          object TableColumn4: TfrxTableColumn
            AutoSize = True
            Width = 139.938426086957000000
            MaxWidth = 200.000000000000000000
          end
          object TableColumn5: TfrxTableColumn
            AutoSize = True
            Width = 132.112339130435000000
            MaxWidth = 200.000000000000000000
          end
          object TableRow1: TfrxTableRow
            Height = 32.412142753623200000
            object TableCell21: TfrxTableCell
              AllowVectorExport = True
              Editable = [ferAllowInPreview]
              Restrictions = [rfDontDelete]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = 16694678
              Memo.UTF8W = (
                'Country name')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell1: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              DataSetName = 'Customers'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = 16694678
              Memo.UTF8W = (
                'Capital')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell4: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = 16694678
              Memo.UTF8W = (
                'Continent')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell7: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = 16694678
              Memo.UTF8W = (
                'Area')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell9: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = 16694678
              Memo.UTF8W = (
                'Population')
              ParentFont = False
              VAlign = vaCenter
            end
          end
          object TableRow3: TfrxTableRow
            Height = 27.786538888888900000
            object TableCell23: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              DataField = 'Name'
              DataSet = frxDBDataset1
              DataSetName = 'Country'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = clBtnFace
              Memo.UTF8W = (
                '[Country."Name"]')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell3: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              DataField = 'Capital'
              DataSet = frxDBDataset1
              DataSetName = 'Country'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 6118749
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = clBtnFace
              Memo.UTF8W = (
                '[Country."Capital"]')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell6: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              DataField = 'Continent'
              DataSet = frxDBDataset1
              DataSetName = 'Country'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 6118749
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = clBtnFace
              Memo.UTF8W = (
                '[Country."Continent"]')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell8: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              DataField = 'Area'
              DataSet = frxDBDataset1
              DataSetName = 'Country'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 6118749
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = clBtnFace
              Memo.UTF8W = (
                '[Country."Area"]')
              ParentFont = False
              VAlign = vaCenter
            end
            object TableCell10: TfrxTableCell
              AllowVectorExport = True
              Restrictions = [rfDontDelete]
              DataField = 'Population'
              DataSet = frxDBDataset1
              DataSetName = 'Country'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 6118749
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              Frame.Color = 15000804
              Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
              Fill.BackColor = clBtnFace
              Memo.UTF8W = (
                '[Country."Population"]')
              ParentFont = False
              VAlign = vaCenter
            end
          end
        end
      end
    end
  end
  object frxReportTableObject1: TfrxReportTableObject
    Left = 56
    Top = 32
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=..\..\D' +
      'ata\demo.mdb;Persist Security Info=True'
    TableName = 'Country'
    Left = 96
    Top = 32
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'Country'
    CloseDataSource = False
    DataSet = ADOTable1
    BCDToCurrency = False
    DataSetOptions = []
    Left = 136
    Top = 32
  end
end
