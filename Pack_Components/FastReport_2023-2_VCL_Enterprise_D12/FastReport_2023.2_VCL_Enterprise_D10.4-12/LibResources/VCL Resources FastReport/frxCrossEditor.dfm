object frxCrossEditorForm: TfrxCrossEditorForm
  Left = 190
  Top = 183
  ClientWidth = 702
  ClientHeight = 538
  ActiveControl = OkB
  Caption = 'Cross-tab Editor'
  Color = clBtnFace
  Constraints.MinHeight = 566
  Constraints.MinWidth = 702
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    702
    538)
  PixelsPerInch = 96
  TextHeight = 13
  object DatasetL: TGroupBox
    Left = 4
    Top = 4
    Width = 165
    Height = 205
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Dataset'
    TabOrder = 0
    Visible = False
    DesignSize = (
      165
      205)
    object DatasetCB: TComboBox
      Left = 12
      Top = 20
      Width = 141
      Height = 22
      Style = csOwnerDrawFixed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnClick = DatasetCBClick
      OnDrawItem = DatasetCBDrawItem
    end
    object FieldsLB: TListBox
      Left = 12
      Top = 48
      Width = 141
      Height = 145
      Style = lbOwnerDrawFixed
      Anchors = [akLeft, akTop, akBottom]
      DragMode = dmAutomatic
      ItemHeight = 16
      TabOrder = 1
      OnClick = LBClick
      OnDragDrop = LBDragDrop
      OnDragOver = LBDragOver
      OnDrawItem = FieldsLBDrawItem
    end
  end
  object DimensionsL: TGroupBox
    Left = 4
    Top = 4
    Width = 165
    Height = 205
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Dimensions'
    TabOrder = 1
    Visible = False
    object RowsL: TLabel
      Left = 12
      Top = 20
      Width = 26
      Height = 13
      Caption = 'Rows'
    end
    object ColumnsL: TLabel
      Left = 12
      Top = 48
      Width = 40
      Height = 13
      Caption = 'Columns'
    end
    object CellsL: TLabel
      Left = 12
      Top = 76
      Width = 22
      Height = 13
      Caption = 'Cells'
    end
    object RowsE: TEdit
      Left = 100
      Top = 16
      Width = 33
      Height = 21
      TabOrder = 0
      Text = '0'
      OnChange = DimensionsChange
    end
    object ColumnsE: TEdit
      Tag = 1
      Left = 100
      Top = 44
      Width = 33
      Height = 21
      TabOrder = 1
      Text = '0'
      OnChange = DimensionsChange
    end
    object CellsE: TEdit
      Tag = 2
      Left = 100
      Top = 72
      Width = 33
      Height = 21
      TabOrder = 2
      Text = '1'
      OnChange = DimensionsChange
    end
    object UpDown1: TUpDown
      Left = 133
      Top = 16
      Width = 15
      Height = 21
      Associate = RowsE
      TabOrder = 3
    end
    object UpDown2: TUpDown
      Left = 133
      Top = 44
      Width = 15
      Height = 21
      Associate = ColumnsE
      TabOrder = 4
    end
    object UpDown3: TUpDown
      Left = 133
      Top = 72
      Width = 15
      Height = 21
      Associate = CellsE
      Min = 1
      Position = 1
      TabOrder = 5
    end
  end
  object StructureL: TGroupBox
    Left = 176
    Top = 4
    Width = 521
    Height = 205
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Cross-tab structure'
    TabOrder = 2
    DesignSize = (
      521
      205)
    object Shape1: TShape
      Left = 12
      Top = 104
      Width = 497
      Height = 1
      Anchors = [akLeft, akRight]
      Brush.Color = clBtnFace
      Pen.Style = psDot
    end
    object Shape2: TShape
      Left = 260
      Top = 16
      Width = 1
      Height = 177
      Anchors = [akTop, akBottom]
      Brush.Color = clBtnFace
      Pen.Style = psDot
    end
    object SwapB: TSpeedButton
      Left = 226
      Top = 70
      Width = 27
      Height = 26
      Anchors = []
      Glyph.Data = {
        5A010000424D5A01000000000000760000002800000013000000130000000100
        040000000000E400000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888800000CCCCCCCCCC88888888800000CCCCCCCCCC88888888800000CCFF
        FFFFCC88888888800000CCCCCCCCCC88888888800000CCCCCCCCCC8888888880
        0000888888888888888888800000888888000888888888800000888888008888
        8888888000008888880808888888888000008888888880808888888000008888
        8888880088888880000088888888800088888880000088888888888888888880
        00008888888844444444448000008888888844444444448000008888888844FF
        FFFF44800000888888884444444444800000888888884444444444800000}
      OnClick = SwapBClick
    end
    object RowsLB: TListBox
      Left = 12
      Top = 112
      Width = 241
      Height = 81
      Style = lbOwnerDrawFixed
      DragMode = dmAutomatic
      ExtendedSelect = False
      ItemHeight = 16
      TabOrder = 0
      OnClick = LBClick
      OnDblClick = LBDblClick
      OnDragDrop = LBDragDrop
      OnDragOver = LBDragOver
      OnDrawItem = LBDrawItem
      OnMouseDown = LBMouseDown
    end
    object ColumnsLB: TListBox
      Left = 268
      Top = 16
      Width = 241
      Height = 81
      Style = lbOwnerDrawFixed
      DragMode = dmAutomatic
      ExtendedSelect = False
      ItemHeight = 16
      TabOrder = 1
      OnClick = LBClick
      OnDblClick = LBDblClick
      OnDragDrop = LBDragDrop
      OnDragOver = LBDragOver
      OnDrawItem = LBDrawItem
      OnMouseDown = LBMouseDown
    end
    object CellsLB: TListBox
      Left = 268
      Top = 112
      Width = 241
      Height = 81
      Style = lbOwnerDrawFixed
      DragMode = dmAutomatic
      ExtendedSelect = False
      ItemHeight = 16
      TabOrder = 2
      OnClick = LBClick
      OnDblClick = LBDblClick
      OnDragDrop = LBDragDrop
      OnDragOver = LBDragOver
      OnDrawItem = CellsLBDrawItem
      OnMouseUp = CellsLBMouseUp
    end
  end
  object OptionsL: TGroupBox
    Left = 4
    Top = 216
    Width = 693
    Height = 281
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
    DesignSize = (
      693
      281)
    object RowHeaderCB: TCheckBox
      Left = 440
      Top = 76
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Row header'
      TabOrder = 3
      OnClick = CBClick
    end
    object ColumnHeaderCB: TCheckBox
      Left = 440
      Top = 56
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Column header'
      TabOrder = 2
      OnClick = CBClick
    end
    object RowTotalCB: TCheckBox
      Left = 440
      Top = 116
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Row grand total'
      TabOrder = 5
      OnClick = CBClick
    end
    object ColumnTotalCB: TCheckBox
      Left = 440
      Top = 96
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Column grand total'
      TabOrder = 4
      OnClick = CBClick
    end
    object TitleCB: TCheckBox
      Left = 440
      Top = 16
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Show title'
      TabOrder = 0
      OnClick = CBClick
    end
    object CornerCB: TCheckBox
      Left = 440
      Top = 36
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Show corner'
      TabOrder = 1
      OnClick = CBClick
    end
    object AutoSizeCB: TCheckBox
      Left = 440
      Top = 152
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Auto size'
      TabOrder = 6
      OnClick = CBClick
    end
    object BorderCB: TCheckBox
      Left = 440
      Top = 172
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Border around cells'
      TabOrder = 7
      OnClick = CBClick
    end
    object DownAcrossCB: TCheckBox
      Left = 440
      Top = 192
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Print down then across'
      TabOrder = 8
      OnClick = CBClick
    end
    object PlainCB: TCheckBox
      Left = 440
      Top = 232
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Side-by-side cells'
      TabOrder = 10
      OnClick = CBClick
    end
    object JoinCB: TCheckBox
      Left = 440
      Top = 252
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Join equal cells'
      TabOrder = 11
      OnClick = CBClick
    end
    object Box: TScrollBox
      Left = 12
      Top = 16
      Width = 413
      Height = 253
      Anchors = [akLeft, akTop, akRight]
      BorderStyle = bsNone
      Color = clWindow
      ParentColor = False
      TabOrder = 12
      object PaintBox: TPaintBox
        Left = 16
        Top = 24
        Width = 393
        Height = 225
        OnPaint = PaintBoxPaint
      end
      object ToolBar: TToolBar
        Left = 0
        Top = 0
        Width = 413
        Height = 22
        ButtonHeight = 21
        ButtonWidth = 37
        EdgeBorders = []
        Flat = True
        Indent = 16
        ShowCaptions = True
        TabOrder = 0
        object StyleB: TToolButton
          Left = 16
          Top = 0
          Caption = 'StyleB'
          DropdownMenu = StylePopup
          ImageIndex = 0
        end
      end
    end
    object RepeatCB: TCheckBox
      Left = 440
      Top = 212
      Width = 237
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'RepeatCB'
      TabOrder = 9
      OnClick = CBClick
    end
  end
  object OkB: TButton
    Left = 540
    Top = 504
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object CancelB: TButton
    Left = 620
    Top = 504
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object FuncPopup: TPopupMenu
    Left = 302
    Top = 158
    object Func1MI: TMenuItem
      Caption = 'None'
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = FuncMIClick
    end
    object Func2MI: TMenuItem
      Tag = 1
      Caption = 'Sum'
      GroupIndex = 1
      RadioItem = True
      OnClick = FuncMIClick
    end
    object Func3MI: TMenuItem
      Tag = 2
      Caption = 'Min'
      GroupIndex = 1
      RadioItem = True
      OnClick = FuncMIClick
    end
    object Func4MI: TMenuItem
      Tag = 3
      Caption = 'Max'
      GroupIndex = 1
      RadioItem = True
      OnClick = FuncMIClick
    end
    object Func5MI: TMenuItem
      Tag = 4
      Caption = 'Avg'
      GroupIndex = 1
      RadioItem = True
      OnClick = FuncMIClick
    end
    object Func6MI: TMenuItem
      Tag = 5
      Caption = 'Count'
      GroupIndex = 1
      RadioItem = True
      OnClick = FuncMIClick
    end
  end
  object SortPopup: TPopupMenu
    Left = 334
    Top = 158
    object Sort1MI: TMenuItem
      Caption = 'Asc'
      GroupIndex = 1
      RadioItem = True
      OnClick = SortMIClick
    end
    object Sort2MI: TMenuItem
      Tag = 1
      Caption = 'Desc'
      GroupIndex = 1
      RadioItem = True
      OnClick = SortMIClick
    end
    object Sort3MI: TMenuItem
      Tag = 2
      Caption = 'None'
      GroupIndex = 1
      RadioItem = True
      OnClick = SortMIClick
    end
    object Sort4MI: TMenuItem
      Tag = 3
      Caption = 'Group'
      GroupIndex = 1
      RadioItem = True
      OnClick = SortMIClick
    end
  end
  object StylePopup: TPopupMenu
    Left = 132
    Top = 364
    object Sep1: TMenuItem
      Caption = '-'
    end
    object SaveStyleMI: TMenuItem
      Caption = 'Save style...'
      ImageIndex = 0
      OnClick = SaveStyleMIClick
    end
  end
end
