inherited frxDOCXExportDialog: TfrxDOCXExportDialog
  Tag = 9203
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    inherited ExportPage: TTabSheet
      inherited GroupQuality: TGroupBox
        Tag = 10000
        object RadioButton1: TRadioButton
          Tag = 10001
          Left = 12
          Top = 22
          Width = 253
          Height = 21
          Caption = 'Table - tabular layout of the report'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object RadioButton2: TRadioButton
          Tag = 10002
          Left = 12
          Top = 52
          Width = 261
          Height = 21
          Caption = 'Object - layout with floating objects position'
          TabOrder = 2
        end
        object RadioButton3: TRadioButton
          Tag = 10003
          Left = 12
          Top = 82
          Width = 245
          Height = 21
          Caption = 'Text - not implemented'
          Enabled = False
          TabOrder = 0
        end
      end
    end
  end
end
