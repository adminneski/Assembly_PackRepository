inherited frxHTMLDIVExportDialog: TfrxHTMLDIVExportDialog
  Tag = 9305
  Left = 478
  Top = 206
  ActiveControl = OkB
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
          TabOrder = 1
        end
        object UnifiedPicturesCB: TCheckBox
          Tag = 9512
          Left = 12
          Top = 40
          Width = 129
          Height = 17
          Caption = 'Unified Pictures'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object PicturesCB: TCheckBox
          Tag = 8002
          Left = 144
          Top = 20
          Width = 129
          Height = 17
          Caption = 'Pictures'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object MultipageCB: TCheckBox
          Tag = 8207
          Left = 144
          Top = 40
          Width = 129
          Height = 17
          Caption = 'Multipage'
          TabOrder = 3
          OnClick = MultipageCBClick
        end
        object PFormatCB: TComboBox
          Left = 91
          Top = 100
          Width = 168
          Height = 21
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 4
          Text = 'PNG'
          Style = csDropDownList
          Items.Strings = (
            'PNG'
            'EMF'
            'BMP'
            'JPEG')
        end
        object FormattedCB: TCheckBox
          Tag = 9513
          Left = 12
          Top = 60
          Width = 129
          Height = 17
          Caption = 'Formatted'
          TabOrder = 5
        end
        object NavigationCB: TCheckBox
          Tag = 8206
          Left = 144
          Top = 60
          Width = 129
          Height = 17
          Caption = 'Navigator'
          TabOrder = 6
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
