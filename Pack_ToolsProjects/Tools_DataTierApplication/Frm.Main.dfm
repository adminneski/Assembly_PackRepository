object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Neski Solu'#231#245'es - V1.0'
  ClientHeight = 761
  ClientWidth = 484
  Color = 2565927
  Constraints.MaxHeight = 900
  Constraints.MaxWidth = 1280
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object pnCONEXOES_FUNDO: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 761
    Align = alClient
    Color = 5197647
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 11
      Top = 11
      Width = 462
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Tools Data Tier Application'
      Color = 16512
      Font.Charset = ANSI_CHARSET
      Font.Color = clSilver
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object pnSource: TPanel
      Left = 11
      Top = 42
      Width = 462
      Height = 250
      Align = alTop
      BevelOuter = bvNone
      Color = 1907997
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 43
        Top = 41
        Width = 38
        Height = 19
        Caption = 'Host:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 42
        Top = 77
        Width = 38
        Height = 19
        Caption = 'User:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 8
        Top = 114
        Width = 73
        Height = 19
        Caption = 'Password:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblSource_Database: TLabel
        Left = 8
        Top = 148
        Width = 70
        Height = 19
        Caption = 'Database:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label5: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 456
        Height = 23
        Align = alTop
        Alignment = taCenter
        Caption = 'Source'
        Color = 5197647
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        ExplicitWidth = 65
      end
      object edtSource_Host: TComboBox
        Left = 84
        Top = 38
        Width = 365
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtSource_Database: TComboBox
        Left = 84
        Top = 145
        Width = 365
        Height = 27
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnChange = edtSource_DatabaseChange
      end
      object edtSource_User: TEdit
        Left = 84
        Top = 74
        Width = 200
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtSource_Password: TMaskEdit
        Left = 84
        Top = 111
        Width = 200
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 3
        Text = ''
      end
      object btnSourceConnectionTest: TGoButtonAdvanced
        Left = 288
        Top = 111
        Width = 161
        Height = 27
        Cursor = crHandPoint
        Caption = 'Connection Test'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10921638
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000B1300000B1301009A9C1800000203494441545885
          63601805A360B08289DBFEF3CD3CF39F15977CFDAAFF6CBD7BFFEB77EFFFEFD0
          B7FBBF12552DEF3CF29F1768F8BBDE7DFF77A1CBFDFFFF9FB167EFFF929E7DFF
          5F00E5FF23E1537D7BFEDB52C501FDFBFF2B800C055A741F8BE5CB912C7D0074
          C83120FE0855FF0B182221347340CFFEFF29508B3F00D90130F1EE9DFFB98162
          7D60B9BDFF3FF5EEF92F4D1B07ECFB7F056CC9FEFF31D8F401E537411D514375
          07CCDCF49F0B2CB6EFFF575C8913E8F340A89A4D5477C084DDFFE5A0863FC4A5
          AF7BDF7F7368089CA0BA0370450B1C547C100C5CF023B06AEBDFFFA59BFE5C60
          A87EAFC890863B1B53CF01555F0C182A3E9D01E2FF98F8E30F86F24F1319EAFF
          73D0C601459F4418CA3FBEC06E390A9E401B07947D4A27C2F2FF40477E27293A
          887640C5A71EA21C00C61F882FAE897640F9A75E121CA0322C1DD04DB40340D9
          92EA0E28FBE00ACC6A7F884884971942FF3353DF0140603CE19B4DFCF2DFFFE3
          70E0B0453F0F31D4BFE421DA7210E8DDF15F085AECBE0155C1603160E3035A13
          5E4456DBB9EBBF145ABB000503CD584992E57047ECFD7F1D6AC8B4EE3DFF3D81
          F44168084CA58B03801A9D81F8078A817BFF3F06D6FD6228EAF6FF17C1EB80BD
          FF1793E50010E8DBFB5F1BE463A043B6027173FBE1FF82D8D4012D5A8BC3F26F
          3D7BFEBB92ED005240C7FEFF32A0C6293206B52DE962F928180594000048E841
          FD8F8E02AD0000000049454E44AE426082}
        Rounded = False
        TabOrder = 4
        OnClick = btnSourceConnectionTestClick
        Skin = tsOffice2016Black
        Appearance.BorderColor = 4473924
        Appearance.BorderColorHot = 6974058
        Appearance.BorderColorDown = 4473924
        Appearance.BorderColorChecked = 5723991
        Appearance.BorderColorDisabled = 4473924
        Appearance.BorderColorFocused = clGray
        Appearance.Color = 3552822
        Appearance.ColorTo = 3552822
        Appearance.ColorChecked = 5723991
        Appearance.ColorCheckedTo = 5723991
        Appearance.ColorDisabled = 3552822
        Appearance.ColorDisabledTo = clNone
        Appearance.ColorDown = 4473924
        Appearance.ColorDownTo = 4473924
        Appearance.ColorHot = 6974058
        Appearance.ColorHotTo = 6974058
        Appearance.ColorMirror = 3552822
        Appearance.ColorMirrorTo = 3552822
        Appearance.ColorMirrorHot = 6974058
        Appearance.ColorMirrorHotTo = 6974058
        Appearance.ColorMirrorDown = 4473924
        Appearance.ColorMirrorDownTo = 4473924
        Appearance.ColorMirrorChecked = 5723991
        Appearance.ColorMirrorCheckedTo = 5723991
        Appearance.ColorMirrorDisabled = 3552822
        Appearance.ColorMirrorDisabledTo = clNone
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.GradientDisabled = ggVertical
        Appearance.GradientMirrorDisabled = ggVertical
        Appearance.TextColorChecked = 13158600
        Appearance.TextColorDown = 10921638
        Appearance.TextColorHot = 10921638
        Layout = blGlyphLeftAdjusted
      end
      object pnSourceOptions: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 187
        Width = 456
        Height = 60
        Align = alBottom
        BevelOuter = bvNone
        Color = 5197647
        Padding.Left = 30
        Padding.Top = 5
        Padding.Right = 30
        Padding.Bottom = 5
        ParentBackground = False
        TabOrder = 5
        Visible = False
        object btnSource_Extract: TGoButtonAdvanced
          Left = 30
          Top = 5
          Width = 175
          Height = 50
          Cursor = crHandPoint
          Align = alLeft
          Caption = 'Extract Schema Snapshot  [ .dacpac ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10921638
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Rounded = False
          TabOrder = 0
          OnClick = btnSource_ExtractClick
          Skin = tsOffice2016Black
          Appearance.BorderColor = 4473924
          Appearance.BorderColorHot = 6974058
          Appearance.BorderColorDown = 4473924
          Appearance.BorderColorChecked = 5723991
          Appearance.BorderColorDisabled = 4473924
          Appearance.BorderColorFocused = clGray
          Appearance.Color = 3552822
          Appearance.ColorTo = 3552822
          Appearance.ColorChecked = 5723991
          Appearance.ColorCheckedTo = 5723991
          Appearance.ColorDisabled = 3552822
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 4473924
          Appearance.ColorDownTo = 4473924
          Appearance.ColorHot = 6974058
          Appearance.ColorHotTo = 6974058
          Appearance.ColorMirror = 3552822
          Appearance.ColorMirrorTo = 3552822
          Appearance.ColorMirrorHot = 6974058
          Appearance.ColorMirrorHotTo = 6974058
          Appearance.ColorMirrorDown = 4473924
          Appearance.ColorMirrorDownTo = 4473924
          Appearance.ColorMirrorChecked = 5723991
          Appearance.ColorMirrorCheckedTo = 5723991
          Appearance.ColorMirrorDisabled = 3552822
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.GradientDisabled = ggVertical
          Appearance.GradientMirrorDisabled = ggVertical
          Appearance.TextColorChecked = 13158600
          Appearance.TextColorDown = 10921638
          Appearance.TextColorHot = 10921638
        end
        object btnSource_Export: TGoButtonAdvanced
          Left = 251
          Top = 5
          Width = 175
          Height = 50
          Cursor = crHandPoint
          Align = alRight
          Caption = 'Export Data Backup  [ .bacpac ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10921638
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Rounded = False
          TabOrder = 1
          OnClick = btnSource_ExportClick
          Skin = tsOffice2016Black
          Appearance.BorderColor = 4473924
          Appearance.BorderColorHot = 6974058
          Appearance.BorderColorDown = 4473924
          Appearance.BorderColorChecked = 5723991
          Appearance.BorderColorDisabled = 4473924
          Appearance.BorderColorFocused = clGray
          Appearance.Color = 3552822
          Appearance.ColorTo = 3552822
          Appearance.ColorChecked = 5723991
          Appearance.ColorCheckedTo = 5723991
          Appearance.ColorDisabled = 3552822
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 4473924
          Appearance.ColorDownTo = 4473924
          Appearance.ColorHot = 6974058
          Appearance.ColorHotTo = 6974058
          Appearance.ColorMirror = 3552822
          Appearance.ColorMirrorTo = 3552822
          Appearance.ColorMirrorHot = 6974058
          Appearance.ColorMirrorHotTo = 6974058
          Appearance.ColorMirrorDown = 4473924
          Appearance.ColorMirrorDownTo = 4473924
          Appearance.ColorMirrorChecked = 5723991
          Appearance.ColorMirrorCheckedTo = 5723991
          Appearance.ColorMirrorDisabled = 3552822
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.GradientDisabled = ggVertical
          Appearance.GradientMirrorDisabled = ggVertical
          Appearance.TextColorChecked = 13158600
          Appearance.TextColorDown = 10921638
          Appearance.TextColorHot = 10921638
        end
      end
    end
    object pnTarget: TPanel
      Left = 11
      Top = 459
      Width = 462
      Height = 250
      Align = alBottom
      BevelOuter = bvNone
      Color = 1907997
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      object Label6: TLabel
        Left = 40
        Top = 46
        Width = 38
        Height = 19
        Caption = 'Host:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 40
        Top = 81
        Width = 38
        Height = 19
        Caption = 'User:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 7
        Top = 115
        Width = 73
        Height = 19
        Caption = 'Password:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblTarget_Database: TLabel
        Left = 10
        Top = 150
        Width = 70
        Height = 19
        Caption = 'Database:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object edtTarget_Host: TComboBox
        Left = 81
        Top = 43
        Width = 368
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtTarget_Database: TComboBox
        Left = 81
        Top = 147
        Width = 368
        Height = 27
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnChange = edtTarget_DatabaseChange
      end
      object edtTarget_User: TEdit
        Left = 81
        Top = 78
        Width = 200
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtTarget_Password: TMaskEdit
        Left = 81
        Top = 112
        Width = 200
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 3
        Text = ''
      end
      object btnTargetConnectionTest: TGoButtonAdvanced
        Left = 287
        Top = 112
        Width = 161
        Height = 27
        Caption = 'Connection Test'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10921638
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F4000000097048597300000B1300000B1301009A9C1800000203494441545885
          63601805A360B08289DBFEF3CD3CF39F15977CFDAAFF6CBD7BFFEB77EFFFEFD0
          B7FBBF12552DEF3CF29F1768F8BBDE7DFF77A1CBFDFFFF9FB167EFFF929E7DFF
          5F00E5FF23E1537D7BFEDB52C501FDFBFF2B800C055A741F8BE5CB912C7D0074
          C83120FE0855FF0B182221347340CFFEFF29508B3F00D90130F1EE9DFFB98162
          7D60B9BDFF3FF5EEF92F4D1B07ECFB7F056CC9FEFF31D8F401E537411D514375
          07CCDCF49F0B2CB6EFFF575C8913E8F340A89A4D5477C084DDFFE5A0863FC4A5
          AF7BDF7F7368089CA0BA0370450B1C547C100C5CF023B06AEBDFFFA59BFE5C60
          A87EAFC890863B1B53CF01555F0C182A3E9D01E2FF98F8E30F86F24F1319EAFF
          73D0C601459F4418CA3FBEC06E390A9E401B07947D4A27C2F2FF40477E27293A
          887640C5A71EA21C00C61F882FAE897640F9A75E121CA0322C1DD04DB40340D9
          92EA0E28FBE00ACC6A7F884884971942FF3353DF0140603CE19B4DFCF2DFFFE3
          70E0B0453F0F31D4BFE421DA7210E8DDF15F085AECBE0155C1603160E3035A13
          5E4456DBB9EBBF145ABB000503CD584992E57047ECFD7F1D6AC8B4EE3DFF3D81
          F44168084CA58B03801A9D81F8078A817BFF3F06D6FD6228EAF6FF17C1EB80BD
          FF1793E50010E8DBFB5F1BE463A043B6027173FBE1FF82D8D4012D5A8BC3F26F
          3D7BFEBB92ED005240C7FEFF32A0C6293206B52DE962F928180594000048E841
          FD8F8E02AD0000000049454E44AE426082}
        Rounded = False
        TabOrder = 4
        OnClick = btnTargetConnectionTestClick
        Skin = tsOffice2016Black
        Appearance.BorderColor = 4473924
        Appearance.BorderColorHot = 6974058
        Appearance.BorderColorDown = 4473924
        Appearance.BorderColorChecked = 5723991
        Appearance.BorderColorDisabled = 4473924
        Appearance.BorderColorFocused = clGray
        Appearance.Color = 3552822
        Appearance.ColorTo = 3552822
        Appearance.ColorChecked = 5723991
        Appearance.ColorCheckedTo = 5723991
        Appearance.ColorDisabled = 3552822
        Appearance.ColorDisabledTo = clNone
        Appearance.ColorDown = 4473924
        Appearance.ColorDownTo = 4473924
        Appearance.ColorHot = 6974058
        Appearance.ColorHotTo = 6974058
        Appearance.ColorMirror = 3552822
        Appearance.ColorMirrorTo = 3552822
        Appearance.ColorMirrorHot = 6974058
        Appearance.ColorMirrorHotTo = 6974058
        Appearance.ColorMirrorDown = 4473924
        Appearance.ColorMirrorDownTo = 4473924
        Appearance.ColorMirrorChecked = 5723991
        Appearance.ColorMirrorCheckedTo = 5723991
        Appearance.ColorMirrorDisabled = 3552822
        Appearance.ColorMirrorDisabledTo = clNone
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.GradientDisabled = ggVertical
        Appearance.GradientMirrorDisabled = ggVertical
        Appearance.TextColorChecked = 13158600
        Appearance.TextColorDown = 10921638
        Appearance.TextColorHot = 10921638
        Layout = blGlyphLeftAdjusted
      end
      object pnTargetOptions: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 187
        Width = 456
        Height = 60
        Align = alBottom
        BevelOuter = bvNone
        Color = 5197647
        Padding.Left = 30
        Padding.Top = 5
        Padding.Right = 30
        Padding.Bottom = 5
        ParentBackground = False
        TabOrder = 5
        Visible = False
        object btnTarget_Publish: TGoButtonAdvanced
          Left = 30
          Top = 5
          Width = 175
          Height = 50
          Cursor = crHandPoint
          Align = alLeft
          Caption = 'Publish Schema Snapshot  [ .dacpac ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10921638
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Rounded = False
          TabOrder = 0
          OnClick = btnTarget_PublishClick
          Skin = tsOffice2016Black
          Appearance.BorderColor = 4473924
          Appearance.BorderColorHot = 6974058
          Appearance.BorderColorDown = 4473924
          Appearance.BorderColorChecked = 5723991
          Appearance.BorderColorDisabled = 4473924
          Appearance.BorderColorFocused = clGray
          Appearance.Color = 3552822
          Appearance.ColorTo = 3552822
          Appearance.ColorChecked = 5723991
          Appearance.ColorCheckedTo = 5723991
          Appearance.ColorDisabled = 3552822
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 4473924
          Appearance.ColorDownTo = 4473924
          Appearance.ColorHot = 6974058
          Appearance.ColorHotTo = 6974058
          Appearance.ColorMirror = 3552822
          Appearance.ColorMirrorTo = 3552822
          Appearance.ColorMirrorHot = 6974058
          Appearance.ColorMirrorHotTo = 6974058
          Appearance.ColorMirrorDown = 4473924
          Appearance.ColorMirrorDownTo = 4473924
          Appearance.ColorMirrorChecked = 5723991
          Appearance.ColorMirrorCheckedTo = 5723991
          Appearance.ColorMirrorDisabled = 3552822
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.GradientDisabled = ggVertical
          Appearance.GradientMirrorDisabled = ggVertical
          Appearance.TextColorChecked = 13158600
          Appearance.TextColorDown = 10921638
          Appearance.TextColorHot = 10921638
        end
        object btnSource_Import: TGoButtonAdvanced
          Left = 251
          Top = 5
          Width = 175
          Height = 50
          Cursor = crHandPoint
          Align = alRight
          Caption = 'Import Data Backup  [ .bacpac ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10921638
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Rounded = False
          TabOrder = 1
          OnClick = btnSource_ImportClick
          Skin = tsOffice2016Black
          Appearance.BorderColor = 4473924
          Appearance.BorderColorHot = 6974058
          Appearance.BorderColorDown = 4473924
          Appearance.BorderColorChecked = 5723991
          Appearance.BorderColorDisabled = 4473924
          Appearance.BorderColorFocused = clGray
          Appearance.Color = 3552822
          Appearance.ColorTo = 3552822
          Appearance.ColorChecked = 5723991
          Appearance.ColorCheckedTo = 5723991
          Appearance.ColorDisabled = 3552822
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 4473924
          Appearance.ColorDownTo = 4473924
          Appearance.ColorHot = 6974058
          Appearance.ColorHotTo = 6974058
          Appearance.ColorMirror = 3552822
          Appearance.ColorMirrorTo = 3552822
          Appearance.ColorMirrorHot = 6974058
          Appearance.ColorMirrorHotTo = 6974058
          Appearance.ColorMirrorDown = 4473924
          Appearance.ColorMirrorDownTo = 4473924
          Appearance.ColorMirrorChecked = 5723991
          Appearance.ColorMirrorCheckedTo = 5723991
          Appearance.ColorMirrorDisabled = 3552822
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.GradientDisabled = ggVertical
          Appearance.GradientMirrorDisabled = ggVertical
          Appearance.TextColorChecked = 13158600
          Appearance.TextColorDown = 10921638
          Appearance.TextColorHot = 10921638
        end
      end
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 456
        Height = 31
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Target'
        Color = 5197647
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clSilver
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 6
      end
    end
    object pnCompareButton: TPanel
      Left = 11
      Top = 292
      Width = 462
      Height = 167
      Align = alClient
      BevelOuter = bvNone
      Color = 1907997
      Padding.Left = 10
      Padding.Top = 10
      Padding.Right = 10
      Padding.Bottom = 10
      ParentBackground = False
      TabOrder = 3
      object pnXML: TPanel
        Left = 10
        Top = 122
        Width = 442
        Height = 35
        Align = alBottom
        BevelOuter = bvNone
        Color = 2368548
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7961087
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object Image1: TImage
          Left = 0
          Top = 0
          Width = 48
          Height = 35
          Cursor = crHandPoint
          Hint = 'Report Schema Compare'
          Align = alLeft
          AutoSize = True
          Center = True
          ParentShowHint = False
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
            003008060000005702F987000000097048597300000B1300000B1301009A9C18
            0000030A4944415478DAED974D68134114C7BBF9302769622FA2A71EA47A503C
            15ADE84511A5370511AC50D11228E4A309D51EB46910A482B14D0285DC445B4F
            D243C50AA547A50A62A9280A05151145A4440FDAD4245D7F53766189A46DD236
            B3C579F098D99DD979FFDF7CBCDDD5EA36B969B2052800D90214806C010A40B6
            0005205B8002902D4001C816A00056D329994CB6689A768DEA217CEB468BD275
            BD48BC8F5447F2F97C7F341A9DAF1A00F167186C84EA77FC219EDD6800CC89EF
            C38F03335528148E968358162091486C73B95CEF0178572C164F747575FDA881
            78EBE49D23F63010F15028D4573100039C6780BB0C7090019ED552BC45C30445
            23F177550C904AA5AE525C9F9B9BF3C4E3F13FC6BD0EA0BE05028131B39FB152
            1D8B8B8B63ACD25B825EA1CFEB6030F8C8EC333030E075381C7E26E369381C7E
            22FA98F51534DCA0DF65005CD5AC401F426208D12C030629FA11BB9BE09F8C7B
            298A530B0B0B4DDDDDDDBFB824A6FED3ED763776767666AD6399DBC1E853766B
            2CA7614D00B158CCD5D0D0304D7586FB6DCCEC1E6676066F6755EE1B40BA284D
            81994CA63E97CB7D602C9F740043E049828BEDD182F70A618817A956B7002C1D
            780E7F237061DA425C7A6D0160B48DD3B617113B0588F5901B0083783B7E4794
            F44BDA620B99964EA785F857F828224E97ACD092B8A5003C2F5643AC84D3E9CC
            DA0680B6006DE2F07EF6783C4D7EBFFF772900077D10D13DD45F20F48155B454
            009136C930B30818A6BD8D326D15524E9C6D00AC6993D9BF58F76F5AB52F8099
            36A95E20F80829D20D88B87E29D26A850093DC9E2C8D6B7DC1AD3B00811F5378
            4BD2E631824EE04744E0D502948B6B7D764D00048952DCE26B70472412F95A27
            C1D090A1380B407D352B7000FA2966A48719B9596BF14343433E26EF0DD56900
            5A2B06306640BC71C516E965EFDF63EB7CD968E17CAE6CF1F97CCDC4BB4DDCFD
            2488C37C243EAF0AC0F88A14E9B275A5BEEB6D88CF12F712B33F5AAECFAAFF89
            598966061407777B0DB4CF136796ED33BED24FD4FFF1536F675300B24D01C836
            0520DB14806C5300B26DD303FC05F2526F4F0483CC4F0000000049454E44AE42
            6082}
          ShowHint = True
          OnClick = Image1Click
          ExplicitTop = 4
        end
        object Image2: TImage
          Left = 394
          Top = 0
          Width = 48
          Height = 35
          Cursor = crHandPoint
          Hint = 'Report Schema Synchronize'
          Align = alRight
          AutoSize = True
          Center = True
          ParentShowHint = False
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
            003008060000005702F987000000097048597300000B1300000B1301009A9C18
            0000030A4944415478DAED974D68134114C7BBF9302769622FA2A71EA47A503C
            15ADE84511A5370511AC50D11228E4A309D51EB46910A482B14D0285DC445B4F
            D243C50AA547A50A62A9280A05151145A4440FDAD4245D7F53766189A46DD236
            B3C579F098D99DD979FFDF7CBCDDD5EA36B969B2052800D90214806C010A40B6
            0005205B8002902D4001C816A00056D329994CB6689A768DEA217CEB468BD275
            BD48BC8F5447F2F97C7F341A9DAF1A00F167186C84EA77FC219EDD6800CC89EF
            C38F03335528148E968358162091486C73B95CEF0178572C164F747575FDA881
            78EBE49D23F63010F15028D4573100039C6780BB0C7090019ED552BC45C30445
            23F177550C904AA5AE525C9F9B9BF3C4E3F13FC6BD0EA0BE05028131B39FB152
            1D8B8B8B63ACD25B825EA1CFEB6030F8C8EC333030E075381C7E26E369381C7E
            22FA98F51534DCA0DF65005CD5AC401F426208D12C030629FA11BB9BE09F8C7B
            298A530B0B0B4DDDDDDDBFB824A6FED3ED763776767666AD6399DBC1E853766B
            2CA7614D00B158CCD5D0D0304D7586FB6DCCEC1E6676066F6755EE1B40BA284D
            81994CA63E97CB7D602C9F740043E049828BEDD182F70A618817A956B7002C1D
            780E7F237061DA425C7A6D0160B48DD3B617113B0588F5901B0083783B7E4794
            F44BDA620B99964EA785F857F828224E97ACD092B8A5003C2F5643AC84D3E9CC
            DA0680B6006DE2F07EF6783C4D7EBFFF772900077D10D13DD45F20F48155B454
            009136C930B30818A6BD8D326D15524E9C6D00AC6993D9BF58F76F5AB52F8099
            36A95E20F80829D20D88B87E29D26A850093DC9E2C8D6B7DC1AD3B00811F5378
            4BD2E631824EE04744E0D502948B6B7D764D00048952DCE26B70472412F95A27
            C1D090A1380B407D352B7000FA2966A48719B9596BF14343433E26EF0DD56900
            5A2B06306640BC71C516E965EFDF63EB7CD968E17CAE6CF1F97CCDC4BB4DDCFD
            2488C37C243EAF0AC0F88A14E9B275A5BEEB6D88CF12F712B33F5AAECFAAFF89
            598966061407777B0DB4CF136796ED33BED24FD4FFF1536F675300B24D01C836
            0520DB14806C5300B26DD303FC05F2526F4F0483CC4F0000000049454E44AE42
            6082}
          ShowHint = True
          OnClick = Image2Click
          ExplicitTop = 4
        end
        object Image3: TImage
          Left = 198
          Top = 2
          Width = 32
          Height = 32
          Cursor = crHandPoint
          AutoSize = True
          Center = True
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
            00200806000000737A7AF4000000017352474200AECE1CE90000000467414D41
            0000B18F0BFC6105000000097048597300000B1300000B1301009A9C18000004
            3F4944415478DACD977F4C5B5514C7BFAFBF2D0386A53F882519890E1308EA1F
            AC23506861CD62F49F8D251A4234F1C758613F64929941A2268641328AD898E0
            74CA8FE7A2CE7FA64E719B426947A06C09CBB2B88599683222A5A51084154A69
            9FF73DD6A68FC76491B478DA93F7DE7DEFDEF379E79E73EE7D14B658A8FF1380
            926813D13D44A509B21722FA0BD166A2817800F6D827CF7A6AAFFC5933C2DB52
            1196CB119649C14865442560C4624E21A2C050A2073DA3DD19EE4F311120C280
            8A8441ADB0BA022A1482787919A26010928505046FF423F8D7DD4BA4D3F36CC7
            E80806B162DBC8CE939D78A1C2807445621C30B714C28FBF8E62BCC58AF0D2BC
            81348D4601AAA43BF2CE651C6D85984A6C58841906B3F67710FAF3B797C8E5F9
            A8B56A494E3E9DF27203E7CA840AB178FFEB36ACFC718B0F20CB7E9A4E7FD19A
            60EBAB3277B113CBF7EEF001E4594FD299E657910C174C0FF42038F93B1F2025
            5D45EB773E97140F4C8C8FE1FE9C9F0F9091914117E4172405E0E6AD9B989D9D
            AD22A75FC500D46A356D30142505C0ED1E86CFE7E37B40ABD5D12525C6A4005C
            BDEAC2D494870FA0D365D1A565A6A40038071DF0782685002673B9E061861166
            051557ACE2EF538F58C41C03FDEB00641100131F203F3F0F669309CA1425AFDD
            6EFF188B8B8BDCB952F918EA6A6B110804D0F9C9194422918D011C0460720300
            A3B104D64335EBBED5C11A2BE6E7E763D76FBCFE1A2A2ACA71E6D3CFC8E0839B
            0760DD6AB77740A356C3E974E1FB1F2EF25CEDF178786FBA7D7B3A3A3E6CE7BC
            F056FDDB5826ABDFA600C464D9EDE9FE823BD61F6FE00C6E24072AF7A392E837
            E7BFC5850BDFFD07001284652633772191486200B57547303333C31F8178C362
            B1202D3D0D7D3FF52140E241A150E0A38E76C864321C3B568FBFE3A668AD0C3A
            06D6CF82681A4A59809EAE5580DAC3F0AF0160A7A3DD761A7ABD1E878F1C2545
            659A6BB758F670F1F0F3A5CBE8EAEA7E28C043D250471B4B4D310FD0BDDD1CC0
            216B9DC0032C4079B91969A9A9B87CE50AC988A507532782ADED34345A2D8EFF
            CBD4B99C2C804758098DC6D2D58108C097742F0111C34A00A6A7A7378C81A814
            1616E2C489060C8F8CC0666B276B9F308B5C2EA7B012126ABAB8D8189B639BAD
            0D39393BD03FE0809B0C16DDFF31E437367603CF1414901AA0C4B5EBD71124FB
            BD7839D5FC0172737371B2B109E3E377050043432E78A7A6D600683474515171
            ECA13C5284DE7FEF5D48A5C2FD6175F52B68696946767636DE3C58039FD7C7BB
            CF1A6F6D3D85DBB7EFA0B1B149D07F7878085EAF970FA0566B68C3EEDDBC07F5
            4FE861329571791E9B7FA267CF7E8EFDFBF641A57A1CDD3DBD5820BB5D7E9090
            B43C50099D4ECBA52559F978B7598FFA7C7C80AACCCCCC7385BB0C8F3CD79B91
            6BA36E36AE7800BBE47285DB683442241225D4385B415D2E17899B25DEB69CFB
            3051A9547BF5FAEC8441B0C62726EEC1EFF70B3E4C58D9D24FB32D932D07F807
            0B8BD230B5BE0B630000000049454E44AE426082}
          OnClick = Image3Click
        end
      end
      object Panel4: TPanel
        Left = 10
        Top = 10
        Width = 442
        Height = 112
        Align = alClient
        BevelOuter = bvNone
        Padding.Bottom = 10
        TabOrder = 1
        object btnComparer: TGoButtonAdvanced
          Left = 0
          Top = 0
          Width = 198
          Height = 102
          Align = alLeft
          Caption = 'Compare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10921638
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000040000000400806000000AA6971
            DE000000097048597300000B1300000B1301009A9C180000076849444154789C
            ED5A5B6C1455183EBB53F401C420361891A084188D464DD0C8C5074C7CE0A208
            11C4C404F046F485464D800775765B2B263E68442E823E081170F63233DB5298
            5DA5A2400B3131C1A6BB6BD270F5522045E86EA1DCD6FF3FB3859D3333BBB3ED
            DC1EF64FFEECE9CC39FFE59B73FEF3FFA787901AD5A83A6A1227115E9C4742E2
            9A4048DC14084909F83D12084BC7E0B70F7ECF03178A7CBEF8EC98DA4794A1BD
            11C792707C2EE163F779ED4E65E25BEF218DE20A307C173870B6C4399B186486
            C49DA883EAF20DF1F167C03801F8AAFD4E9BF275D0972261F1055228043C725C
            BC1FBEC83E179D369B193F91A6E864779D0FCB2F82E20B650D0B8917810FC0DA
            DF40C2D22AE045C04F133E3A85F0C25D645DEBB89BF2B08DCFF01DF651FBAEC2
            B1AA0C90551E840B7436B842BCF804281D34765A3A0A81EB43EA842070B6E944
            592A301F819E3F4C00BF4C78F931DB749A11283B6CA05C22BCF4A4E3CA87289C
            78AAB8533040C43B1CD7AD06A05B4A6954F68A42D26B6C70745C278B3A69945E
            775CA91985C43774F6384D266B3F41D7A85BC4CBD3416F8B912D8EEBAE10F9BB
            605AF210286712BEBDCE36A5280B6586C510EA2867836D3ACDA88AFD390FDC81
            693080D200417231A4B533E856D72CD4D3AD0F9318646CE333BA0D621FE80B63
            40CE6618DFA9CAB2A6D7470078C3AE0300BBC034F8DDE67E2A2CB5C04C79CE7B
            0086A8599E4042F27278B60382E219079CEE45D9B0EB2CA3BA2AD9E33A002C7D
            DC3211A2F51CB51C8694161317BA9EA51EF8FB1C2D7F43E28D22F7D167F41DF4
            81C44A4DA1C5D554062FDD3B627BEC22D715FACD9E1A0035006A006814E6D241
            CF6A815C26E87D2D90CF7005302491CFD6B9560BE4BBEBA6E733C116D4ED0B00
            6E71B00BC0E007D275330BEDC4B65A0065A1CC7C9A0BA18E529D3E03E016E732
            5C1EC0E880DF4DF974B0018C5F3CD05D37E352964CB9F827A9FFEF2819572890
            0032B6F119BEC33ED817C7C0D8CDB0C43A5196991EDF02E0167B0F407AD434F8
            62DBE02B5D75CBE95C9ABB8E31A03FCBF9A716E83F4A26E4BA83CB01881D00C8
            19DB1D4F73BD283B970D2E435D95EC711D0096F25932110C9E0371600D7CB10D
            F02BD3F59CE67AC0A173C07DD0BE818C6D7C86EFD43E41A9386635CAC8A749AD
            16A8684F13F017AD051255B690887284449367A07D45656C270FD37782F20A91
            A43B46AED02F0034CB05B2B5AD408424386F9123C93C80B195087BA756AFD02F
            00B4B5DD0ECE348233D61DD7319D219F525956C917007CDF7E3738BE7FF88EEB
            80384484766BFF71F6BC1688298F82F3270D1DD9A55C84F5BF9EC452734874EF
            43649B329A32B623CA5CE8F3158C3D6502C2092ABB12795A0BC83F4E30745E50
            CE92EFF67C46DA2D1CC5F37C10642C01408E1B82803ACA9127B5C06F6454FAF7
            89CF4E92B79FD0073445368AEAB92C371FB6D2D3C0A7602B9DAB138A6322C984
            41803C503626D85D0BA04C6C235FEA2253073275B3F2596E1180F92E8CD90232
            0E818CDCDA5F56184473E54BFA450D081D2FC91C4F1A3A4367032C193D089F8C
            18003BB9A7ABBE303A9ED018393E2EEC37731E899561EA90BA24D8993048A2A9
            299600E84F73B3E12BC500E56B4E01F0E6BE068DF3F5D20F5716A6D68E3775AA
            1A0090B6B78D0510FE6666C1D79600187AEE542DD0DB3DA630262E6B00181B8F
            BF53D6A16A01408A2A2B99599083AD718C6500740658AC058A06F615FFEE51E3
            06F6E536F6A783EFBFA47CB08EF93227ADDC3EA91A00DC41A2CA6946D7CBC306
            C036C2FC5D1BF8D65B195635004891E40666166CD6F5711D00B5B0290540BFA5
            19D0B00088A5E6330074EAFA783003CE6A8C8AA71EB4326C580060C6A85D02BD
            BA3EEE03805B5269D66710980C685800A06C2D0097757D02BA4B520EDF116201
            60B23ECCF268B6A7263E0B879E9B01807D86FAEB3244DC0E2B032076B0B3C0D1
            3B4215968026E3CB70570732C1A56600E0BBD2B34B1CABD565610990C6D8E378
            2951070205C2813B42F424C73C089602500A020B00EBBC618ACC06C1886272EF
            90971654BC2A6BF58E109507538F5E9795A716EF082D8019F51E1DFBEDEE7F35
            466DDFD3566A0A9DD2AC630627D4267D166AFC8A281B2B6E8337A9293A192F2A
            9707C106FEBC455BA8EC5406D9B2170BAD6A8EE5316D8724EB558D3FC689D012
            73006ECE0671360011833870CD11009A64ACF7D96AED2DD60CAB20183A4FBF7E
            F26D4BA9B029397847887CD3C696C17F199D015402C1D4792175277CFD7F2C15
            4396C9EA1D21355E5C28DE133A1EC0CBD821B195AE7F8803848F3F4FB6EE9E55
            3CDE2E353061540E9B8160EABC7A26D0AADBFE04E58191016037E1E9ADFE4064
            BD1510CA3A8FE784FAA3B166577CAA8AD463F0837A63932D348161A834E1D145
            7B249CF6EC97579DFF15AACDDB5CF1A96AC2034B3CB8D41B8DC95283A5435135
            DAAFD41D80A8722A1F8A7A4E78746D080275E074712F9F47E2C987691447C636
            2639F41DB3D5953A1FD9F388D7EE5923FCC74854F9D9D89161F141FF7F799630
            26E0E92D5B2C55C78334E0F976CD5B213CBDC53D1B1317CB8E2BFD748CEFB6BA
            9110AE753CC3C3FC1D4F72B0925367C760B1DD098E6FA2E92DFEBBAC4635AA8A
            FE07ACD665CA169853F80000000049454E44AE426082}
          Rounded = False
          Transparent = True
          TabOrder = 0
          Visible = False
          OnClick = btnComparerClick
          Skin = tsOffice2016Black
          Appearance.BorderColor = 4473924
          Appearance.BorderColorHot = 6974058
          Appearance.BorderColorDown = 4473924
          Appearance.BorderColorChecked = 5723991
          Appearance.BorderColorDisabled = 4473924
          Appearance.BorderColorFocused = clGray
          Appearance.Color = 3552822
          Appearance.ColorTo = 3552822
          Appearance.ColorChecked = 5723991
          Appearance.ColorCheckedTo = 5723991
          Appearance.ColorDisabled = 3552822
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 4473924
          Appearance.ColorDownTo = 4473924
          Appearance.ColorHot = 6974058
          Appearance.ColorHotTo = 6974058
          Appearance.ColorMirror = 3552822
          Appearance.ColorMirrorTo = 3552822
          Appearance.ColorMirrorHot = 6974058
          Appearance.ColorMirrorHotTo = 6974058
          Appearance.ColorMirrorDown = 4473924
          Appearance.ColorMirrorDownTo = 4473924
          Appearance.ColorMirrorChecked = 5723991
          Appearance.ColorMirrorCheckedTo = 5723991
          Appearance.ColorMirrorDisabled = 3552822
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.GradientDisabled = ggVertical
          Appearance.GradientMirrorDisabled = ggVertical
          Appearance.TextColorChecked = 13158600
          Appearance.TextColorDown = 10921638
          Appearance.TextColorHot = 10921638
        end
        object btnSynchronize: TGoButtonAdvanced
          Left = 244
          Top = 0
          Width = 198
          Height = 102
          Align = alRight
          Caption = 'Synchronize'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10921638
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          Picture.Data = {
            89504E470D0A1A0A0000000D4948445200000040000000400806000000AA6971
            DE000000097048597300000B1300000B1301009A9C180000028249444154789C
            ED9ACF4AC34010C6A3AB7D03BDE873F8068AA5083D08BE8CA0D59B9E45517C82
            B6528F6D41AF153C2934113DB54554BC145B2F0A31D3C6D88626DDCDFECBAEFB
            C11C84EACEF7ABBB99EC8C6519190DD47B40B99E8D3A7D07B984F1DCB7D186EC
            FCA9E5996F27303F0C1BBDBAB7D6BC6C0F544A6CDE8F5E13ADC9F640255A00DE
            7FC1996C0F540A1B9AF679F8C643BFF3AEF4362005E05E5B73DEB7FEA6CD3628
            5FADB84B07E7EE4CA1222ADA56E1222BDB77A0E543A1E687B15B69C9F61D48B8
            793F64FB0E6400084A0C771DEF50CD4371360807F13F2BD204E0D399DDF24C7F
            054F170F02AF7C881213B14ED8BC0F80FF6199060013CD0F7FCEF3CA072B3111
            EB1C3572FB5D3B33568C759D8CBB59DF76AD520D3F8AB5B655AC929F19B2013C
            DD2F7C539BFF8340BE65B40200C12A31D68A5AE7B8B1BEC7640BA80A00447508
            EA000014F1189C5E07E8020034A1109A7EA8E9040034520AB7B04A61DD0010CB
            00600C405418002902D0160E80E595182D00B8A0140A01CCEF5CAEA70780EA32
            00FE3B00B807A0791D565E700932B80CF1CC97EBECCE16DE3273093473090E7A
            811EA5984CCBF59C55AA7612DFB94588B62DFFD144ABAC728917A74386C15CC2
            29AB5CE2C5E931C3642E41C8364809007973099C00A83397C009803A73099C00
            0837EF8701905600ACFE2EFB750C0032007095FD3BE111D7D9D117C0488D0F4D
            0E6876F0490C4F5201C441D016C0A0B333A1D11986A02E008C80D636B4B8C75A
            DE76C6855638BBC4F0240540140418866097189EE8D7197D1DA604F078B7A822
            00FFCE8DC11638B9C916D825862751EB04D2EF1024947E8F4142E95708116AA4
            146EE9510A7312ED6B6DD290ED3B9001A0FA5C02B5549F4B30525C3F6BF05714
            CCA92C580000000049454E44AE426082}
          Rounded = False
          Transparent = True
          TabOrder = 1
          Visible = False
          OnClick = btnSynchronizeClick
          Skin = tsOffice2016Black
          Appearance.BorderColor = 4473924
          Appearance.BorderColorHot = 6974058
          Appearance.BorderColorDown = 4473924
          Appearance.BorderColorChecked = 5723991
          Appearance.BorderColorDisabled = 4473924
          Appearance.BorderColorFocused = clGray
          Appearance.Color = 3552822
          Appearance.ColorTo = 3552822
          Appearance.ColorChecked = 5723991
          Appearance.ColorCheckedTo = 5723991
          Appearance.ColorDisabled = 3552822
          Appearance.ColorDisabledTo = clNone
          Appearance.ColorDown = 4473924
          Appearance.ColorDownTo = 4473924
          Appearance.ColorHot = 6974058
          Appearance.ColorHotTo = 6974058
          Appearance.ColorMirror = 3552822
          Appearance.ColorMirrorTo = 3552822
          Appearance.ColorMirrorHot = 6974058
          Appearance.ColorMirrorHotTo = 6974058
          Appearance.ColorMirrorDown = 4473924
          Appearance.ColorMirrorDownTo = 4473924
          Appearance.ColorMirrorChecked = 5723991
          Appearance.ColorMirrorCheckedTo = 5723991
          Appearance.ColorMirrorDisabled = 3552822
          Appearance.ColorMirrorDisabledTo = clNone
          Appearance.GradientHot = ggVertical
          Appearance.GradientMirrorHot = ggVertical
          Appearance.GradientDown = ggVertical
          Appearance.GradientMirrorDown = ggVertical
          Appearance.GradientChecked = ggVertical
          Appearance.GradientDisabled = ggVertical
          Appearance.GradientMirrorDisabled = ggVertical
          Appearance.TextColorChecked = 13158600
          Appearance.TextColorDown = 10921638
          Appearance.TextColorHot = 10921638
        end
      end
    end
    object Panel3: TPanel
      Left = 11
      Top = 709
      Width = 462
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 10
      Padding.Top = 10
      Padding.Right = 10
      Padding.Bottom = 10
      ParentBackground = False
      TabOrder = 4
      object Label4: TLabel
        Left = 10
        Top = 10
        Width = 442
        Height = 21
        Cursor = crHandPoint
        Align = alClient
        Caption = 
          'https://docs.microsoft.com/pt-br/sql/tools/sqlpackage?view=sql-s' +
          'erver-ver15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        Layout = tlCenter
        OnClick = Label4Click
        ExplicitWidth = 443
        ExplicitHeight = 16
      end
    end
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'dacpac'
    Filter = 'Data-tier Application package|*.dacpac'
    Left = 25
    Top = 19
  end
  object FDConn_Source: TFDConnection
    Left = 330
    Top = 81
  end
  object FDConn_Target: TFDConnection
    Params.Strings = (
      'Database=master'
      'Password=Neski5500*'
      'Server=DEVELOPERSERVER\DEVELOP'
      'ConnectionDef=MSSQL_Demo')
    LoginPrompt = False
    Left = 333
    Top = 466
  end
  object QSource: TFDQuery
    Connection = FDConn_Source
    Left = 405
    Top = 81
  end
  object QTarget: TFDQuery
    Connection = FDConn_Target
    Left = 404
    Top = 465
  end
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 385
    Top = 16
  end
  object dlgOpen: TSaveDialog
    DefaultExt = 'dacpac'
    Filter = 'Data-tier Application package|*.dacpac'
    Left = 25
    Top = 429
  end
end
