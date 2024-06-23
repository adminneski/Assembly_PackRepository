inherited frxExportZPLDialog: TfrxExportZPLDialog
  Tag = 9520
  Left = 502
  Top = 320
  Caption = 'frxExportZPLDialog'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited ExportPage: TTabSheet
      inherited GroupQuality: TGroupBox
        object Label1: TLabel
          Tag = 8603
          Left = 13
          Top = 56
          Width = 54
          Height = 13
          Caption = 'Resolution:'
        end
        object PrintAsBitmap: TCheckBox
          Tag = 9521
          Left = 12
          Top = 25
          Width = 97
          Height = 17
          Caption = 'PrintAsBitmap'
          TabOrder = 2
        end
        object BreakLines: TCheckBox
          Tag = 9522
          Left = 136
          Top = 25
          Width = 97
          Height = 17
          Caption = 'BreakLines'
          TabOrder = 0
        end
        object ComboBox1: TComboBox
          Left = 12
          Top = 73
          Width = 145
          Height = 21
          ItemHeight = 13
          ItemIndex = 1
          TabOrder = 1
          Style = csDropDownList
          Text = 'd8_dpmm_203_dpi'
          Items.Strings = (
            'd6_dpmm_152_dpi'
            'd8_dpmm_203_dpi'
            'd12_dpmm_300_dpi'
            'd24_dpmm_600_dpi'
            'test1to1')
        end
      end
    end
  end
end
