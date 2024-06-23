object DBGridEhCustomizeColumnsDialog: TDBGridEhCustomizeColumnsDialog
  Left = 858
  Top = 244
  Caption = 'Columns setup'
  ClientHeight = 441
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  DesignSize = (
    467
    441)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 22
    Width = 451
    Height = 374
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    object PanelVisibleColumns: TPanel
      Left = 0
      Top = 0
      Width = 193
      Height = 374
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'PanelVisibleColumns'
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 193
        Height = 24
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Visible Columns'
        Layout = tlCenter
      end
      object GridVisibleColumns: TDBGridEh
        Left = 0
        Top = 24
        Width = 193
        Height = 350
        Align = alClient
        AutoFitColWidths = True
        DataSource = DataSource1
        DynProps = <>
        FooterRowCount = 1
        HorzScrollBar.ExtraPanel.VisibleItems = [gsbiRecordsInfoEh]
        IndicatorOptions = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghExtendVertLines]
        ParentShowHint = False
        SearchPanel.Enabled = True
        ShowHint = True
        SumList.Active = True
        TabOrder = 0
        OnCellMouseClick = GridVisibleColumnsCellMouseClick
        OnKeyDown = GridVisibleColumnsKeyDown
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ColumnName'
            Footer.Alignment = taCenter
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = 'Column name'
            ToolTips = True
            Width = 94
          end
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'Width'
            Footers = <>
            ToolTips = True
            Width = 43
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object PanelHiddenColumns: TPanel
      Left = 264
      Top = 0
      Width = 187
      Height = 374
      Align = alRight
      BevelOuter = bvNone
      Caption = 'PanelHiddenColumns'
      TabOrder = 1
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 187
        Height = 24
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Hidden Columns'
        Layout = tlCenter
      end
      object GridHiddenColumns: TDBGridEh
        Left = 0
        Top = 24
        Width = 187
        Height = 350
        Align = alClient
        AutoFitColWidths = True
        DataSource = DataSource2
        DynProps = <>
        IndicatorOptions = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghExtendVertLines]
        ParentShowHint = False
        SearchPanel.Enabled = True
        ShowHint = True
        TabOrder = 0
        OnCellMouseClick = GridHiddenColumnsCellMouseClick
        OnKeyDown = GridHiddenColumnsKeyDown
        Columns = <
          item
            CellButtons = <>
            DynProps = <>
            EditButtons = <>
            FieldName = 'ColumnName'
            Footers = <>
            Title.Caption = 'Column name'
            ToolTips = True
            Width = 128
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object PanelButtons: TPanel
      Left = 193
      Top = 0
      Width = 60
      Height = 374
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
      object bMoveDown: TSpeedButtonEh
        Left = 6
        Top = 158
        Width = 35
        Height = 25
        OnClick = bMoveDownClick
      end
      object bMoveUp: TSpeedButtonEh
        Left = 6
        Top = 127
        Width = 35
        Height = 25
        OnClick = bMoveUpClick
      end
      object bSetWidth: TSpeedButtonEh
        Left = 6
        Top = 80
        Width = 32
        Height = 25
        OnClick = bSetWidthClick
      end
      object bHide: TSpeedButtonEh
        Left = 6
        Top = 208
        Width = 48
        Height = 25
        OnClick = bHideClick
      end
      object bShow: TSpeedButtonEh
        Left = 6
        Top = 239
        Width = 48
        Height = 25
        OnClick = bShowClick
      end
    end
  end
  object bOk: TButton
    Left = 295
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object bCancel: TButton
    Left = 377
    Top = 402
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Filtered = True
    Params = <>
    Left = 16
    Top = 65520
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object ColumnName: TMTStringDataFieldEh
          FieldName = 'ColumnName'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
          Size = 2000
        end
        object RefColumn: TMTRefObjectFieldEh
          FieldName = 'RefColumn'
          DisplayWidth = 20
        end
        object Width: TMTNumericDataFieldEh
          FieldName = 'Width'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
        object Visible: TMTBooleanDataFieldEh
          FieldName = 'Visible'
          DisplayWidth = 20
        end
        object OldIndex: TMTNumericDataFieldEh
          FieldName = 'OldIndex'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            'Col1'
            nil
            nil
            nil
            nil)
          (
            'Col2'
            nil
            nil
            nil
            nil))
      end
    end
  end
  object MemTableEh2: TMemTableEh
    Active = True
    ExternalMemData = MemTableEh1
    Filtered = True
    Params = <>
    Left = 288
    Top = 65520
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 88
    Top = 65520
  end
  object DataSource2: TDataSource
    DataSet = MemTableEh2
    Left = 352
    Top = 65520
  end
end
