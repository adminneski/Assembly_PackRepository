inherited frxHTMLExportDialog: TfrxHTMLExportDialog
  Tag = 8200
  Left = 281
  Top = 199
  ClientHeight = 386
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    Height = 345
    inherited ExportPage: TTabSheet
      inherited OpenCB: TCheckBox
        Top = 300
      end
      inherited GroupQuality: TGroupBox
        Height = 128
        object PicturesL: TLabel
          Tag = 8203
          Left = 12
          Top = 104
          Width = 73
          Height = 13
          AutoSize = False
          Caption = 'Pictures'
        end
        object StylesCB: TCheckBox
          Tag = 8202
          Left = 12
          Top = 20
          Width = 129
          Height = 17
          Caption = 'Styles'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object PicsSameCB: TCheckBox
          Tag = 8204
          Left = 12
          Top = 40
          Width = 129
          Height = 17
          Caption = 'All in one folder'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object FixWidthCB: TCheckBox
          Tag = 8205
          Left = 144
          Top = 20
          Width = 129
          Height = 17
          Caption = 'Fixed width'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object NavigatorCB: TCheckBox
          Tag = 8206
          Left = 12
          Top = 60
          Width = 129
          Height = 17
          Caption = 'Page navigator'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object MultipageCB: TCheckBox
          Tag = 8207
          Left = 144
          Top = 40
          Width = 129
          Height = 17
          Caption = 'Multipage'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = MultipageCBClick
        end
        object BackgrCB: TCheckBox
          Tag = 8209
          Left = 144
          Top = 60
          Width = 129
          Height = 17
          Caption = 'Background'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object PFormatCB: TComboBox
          Left = 88
          Top = 100
          Width = 173
          Height = 21
          ItemHeight = 13
          TabOrder = 6
          Text = 'JPEG'
          Style = csDropDownList
          Items.Strings = (
            'None'
            'PNG'
            'BMP'
            'JPEG')
        end
        object OutlineCB: TCheckBox
          Tag = 8704
          Left = 12
          Top = 80
          Width = 129
          Height = 17
          Caption = 'Outline'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
      end
      inherited GroupBox1: TGroupBox
        Top = 258
      end
    end
  end
  inherited OkB: TButton
    Top = 355
  end
  inherited CancelB: TButton
    Top = 355
  end
end
