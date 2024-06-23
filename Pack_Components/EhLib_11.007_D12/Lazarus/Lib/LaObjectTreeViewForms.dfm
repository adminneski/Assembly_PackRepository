object LaObjectTreeViewForm: TLaObjectTreeViewForm
  Left = 0
  Top = 0
  Caption = 'LaObjectTreeViewForm'
  ClientHeight = 627
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 401
    Top = 57
    Width = 10
    Height = 570
    Align = alRight
    ExplicitLeft = 448
    ExplicitTop = 63
    ExplicitHeight = 418
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 5
      Width = 115
      Height = 46
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = Button1Click
    end
    object bTest: TButton
      Left = 136
      Top = 5
      Width = 115
      Height = 46
      Caption = 'Test'
      TabOrder = 1
      OnClick = bTestClick
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 57
    Width = 401
    Height = 570
    Align = alClient
    AutoFitColWidths = True
    DataSource = DataSource1
    DynProps = <>
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'DisplayName'
        Footers = <>
        Width = 273
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Width = 18
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'RefParentID'
        Footers = <>
        Width = 32
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'RowType'
        Footers = <>
        Width = 17
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'RefObj'
        Footers = <>
        Width = 23
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object ObjInsPanel: TPanel
    Left = 411
    Top = 57
    Width = 218
    Height = 570
    Align = alRight
    BevelOuter = bvNone
    Caption = 'ObjInsPanel'
    TabOrder = 2
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    TreeList.Active = True
    TreeList.KeyFieldName = 'ID'
    TreeList.RefParentFieldName = 'RefParentID'
    TreeList.DefaultNodeExpanded = True
    TreeList.FullBuildCheck = False
    Left = 320
    Top = 160
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object ID: TMTNumericDataFieldEh
          FieldName = 'ID'
          NumericDataType = fdtLargeintEh
          AutoIncrement = True
          DisplayWidth = 100
          currency = False
          Precision = 15
        end
        object RefParentID: TMTNumericDataFieldEh
          FieldName = 'RefParentID'
          NumericDataType = fdtLargeintEh
          AutoIncrement = False
          DisplayWidth = 100
          currency = False
          Precision = 15
        end
        object DisplayName: TMTStringDataFieldEh
          FieldName = 'DisplayName'
          StringDataType = fdtWideStringEh
          DisplayWidth = 100
          Size = 1000
        end
        object RowType: TMTStringDataFieldEh
          FieldName = 'RowType'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
        end
        object RefObj: TMTInterfaceDataFieldEh
          FieldName = 'RefObj'
          DisplayWidth = 20
          InterfaceDataType = fdtInterfaceEh
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    OnDataChange = DataSource1DataChange
    Left = 320
    Top = 208
  end
end
