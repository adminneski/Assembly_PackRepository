object frmDLL: TfrmDLL
  Left = 258
  Top = 222
  BorderStyle = bsDialog
  Caption = 'DLL example'
  ClientHeight = 110
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PreviewB: TButton
    Left = 174
    Top = 64
    Width = 81
    Height = 26
    Caption = 'Preview'
    TabOrder = 0
    OnClick = PreviewBClick
  end
  object DesignB: TButton
    Left = 22
    Top = 64
    Width = 81
    Height = 26
    Caption = 'Design'
    TabOrder = 1
    OnClick = DesignBClick
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
    ReportOptions.CreateDate = 38208.098787615740000000
    ReportOptions.LastChange = 44467.189482835650000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 184
    Top = 12
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
    DataSource = CustomerSource
    BCDToCurrency = False
    DataSetOptions = []
    Left = 136
    Top = 12
  end
  object CustomerSource: TDataSource
    DataSet = Customers
    Left = 88
    Top = 12
  end
  object Customers: TADOTable
    Connection = ADOConnection1
    CursorType = ctStatic
    IndexFieldNames = 'Company'
    TableName = 'CUSTOMER'
    Left = 48
    Top = 12
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
  object ADOConnection1: TADOConnection
    ConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='#39'demo.MDB'#39';'
    LoginPrompt = False
    Mode = cmRead
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 12
    Top = 12
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 232
    Top = 12
  end
end
