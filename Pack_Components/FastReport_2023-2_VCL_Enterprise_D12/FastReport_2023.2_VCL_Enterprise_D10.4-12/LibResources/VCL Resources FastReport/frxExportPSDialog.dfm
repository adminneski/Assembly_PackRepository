inherited frxExportPSDialog: TfrxExportPSDialog
  Tag = 9530
  Caption = 'frxExportPSDialog'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited ExportPage: TTabSheet
      inherited GroupQuality: TGroupBox
        object Pictures: TCheckBox
          Tag = 8002
          Left = 12
          Top = 47
          Width = 97
          Height = 17
          Caption = 'Pictures'
          TabOrder = 1
        end
        object IncludeImages: TCheckBox
          Tag = 9532
          Left = 136
          Top = 47
          Width = 97
          Height = 17
          Caption = 'Include Images'
          TabOrder = 3
        end
        object HasMultipleFiles: TCheckBox
          Tag = 9531
          Left = 12
          Top = 24
          Width = 205
          Height = 17
          Caption = 'Has Multiple Files'
          TabOrder = 0
        end
       object PicturesL: TLabel
          Tag = 8203
          Left = 12
          Top = 74
          Width = 73
          Height = 13
          AutoSize = False
          Caption = 'Pictures'
        end
        object ComboBox1: TComboBox
          Left = 88
          Top = 70
          Width = 145
          Height = 21
          ItemHeight = 13
          ItemIndex = 1
          TabOrder = 2
          Style = csDropDownList
          Enabled = False
          Text = 'JPEG'
          Items.Strings = (
            'PNG'
            'JPEG')
        end
      end
    end
  end
end
