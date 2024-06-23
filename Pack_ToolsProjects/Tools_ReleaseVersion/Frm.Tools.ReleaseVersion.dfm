object FrmToolsReleaseVersion: TFrmToolsReleaseVersion
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Neski Solu'#231#245'es - V1.3'
  ClientHeight = 639
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object pnFundo: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 639
    Align = alClient
    BevelOuter = bvNone
    Color = 4079166
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object pnJSONSettings: TPanel
      Left = 0
      Top = 35
      Width = 554
      Height = 194
      Align = alTop
      Color = 2697513
      Padding.Left = 5
      Padding.Right = 5
      ParentBackground = False
      TabOrder = 0
      object Panel1: TPanel
        Left = 6
        Top = 178
        Width = 542
        Height = 15
        Align = alBottom
        BevelOuter = bvNone
        Color = 2697513
        ParentBackground = False
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 6
        Top = 1
        Width = 542
        Height = 35
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Version Numbers - JSONSetting'
        Color = 2368548
        Font.Charset = ANSI_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
      object RzPageControl_JSONSetting: TRzPageControl
        Left = 6
        Top = 36
        Width = 542
        Height = 142
        Hint = ''
        ActivePage = TabSheet_Version
        Align = alClient
        BackgroundColor = 4079166
        Color = 4079166
        UseColoredTabs = True
        ParentBackgroundColor = False
        ParentColor = False
        TabOrder = 2
        Transparent = True
        FixedDimension = 26
        object TabSheet_Version: TRzTabSheet
          Color = 4079166
          TabVisible = False
          Caption = 'TabSheet_Version'
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 538
            Height = 138
            Align = alClient
            BevelOuter = bvNone
            Color = 4079166
            Padding.Left = 10
            Padding.Top = 10
            Padding.Right = 10
            Padding.Bottom = 10
            ParentBackground = False
            TabOrder = 0
            object Label3: TLabel
              Left = 16
              Top = 52
              Width = 156
              Height = 22
              Caption = 'Version Number:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clSilver
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 12
              Top = 94
              Width = 158
              Height = 22
              Caption = 'Release Number:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clSilver
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label_IntegerVersion: TLabel
              Left = 336
              Top = 60
              Width = 108
              Height = 18
              Caption = 'Integer Version'
              Font.Charset = ANSI_CHARSET
              Font.Color = clOlive
              Font.Height = -15
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label_StringVersion: TLabel
              Left = 336
              Top = 97
              Width = 100
              Height = 18
              Caption = 'String Version'
              Font.Charset = ANSI_CHARSET
              Font.Color = clOlive
              Font.Height = -15
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Bevel1: TBevel
              Left = 321
              Top = 47
              Width = 18
              Height = 86
              Shape = bsLeftLine
            end
            object Panel6: TPanel
              Left = 10
              Top = 10
              Width = 518
              Height = 33
              Align = alTop
              Alignment = taLeftJustify
              BevelOuter = bvNone
              Caption = ' Project Name'
              Color = 2368548
              Font.Charset = ANSI_CHARSET
              Font.Color = clSilver
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentBackground = False
              ParentFont = False
              TabOrder = 0
              object edtProjectName: TEdit
                Left = 117
                Top = 5
                Width = 194
                Height = 23
                Color = 3223857
                Ctl3D = False
                Font.Charset = ANSI_CHARSET
                Font.Color = clSilver
                Font.Height = -15
                Font.Name = 'Arial'
                Font.Style = []
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
              end
            end
            object edtVersionNumber: TSpinEdit
              Left = 177
              Top = 49
              Width = 104
              Height = 32
              Color = 4079166
              EditorEnabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clSilver
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              MaxValue = 0
              MinValue = 0
              ParentFont = False
              TabOrder = 1
              Value = 0
              OnChange = edtVersionNumberChange
            end
            object edtReleaseNumber: TSpinEdit
              Left = 176
              Top = 89
              Width = 105
              Height = 32
              Color = 4079166
              EditorEnabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clSilver
              Font.Height = -19
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              MaxValue = 0
              MinValue = 0
              ParentFont = False
              TabOrder = 2
              Value = 0
              OnChange = edtReleaseNumberChange
            end
            object btnSaveJson_Express: TGoButtonAdvanced
              Left = 285
              Top = 92
              Width = 32
              Height = 32
              Cursor = crHandPoint
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
                89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
                F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
                00097048597300000B1300000B1301009A9C180000031549444154484BB5553D
                6B1441187E37B7B9CBE5CBE0899541C156B4D1460898CA4A5051B014410B4923
                166221E67AB10A361AB50C982616122185D829827F2008C623982FBD5C2E9BDB
                DD993D9F67669DDB1C7A774D9EF0EC3B3BF37ECCFB711B396878A994C7F35FCE
                405C06BD261EB58612CF9D76461306B93E4F46F239C1B20F5B5570AE7CEDEC6A
                36C05B884B749ECFF5C99573278C6157D0239CD7825016BEAE18DB14F711E0A9
                7B034A5634C587C1E860417E560359DFEECCB55A205BF58694468B92ECBFD018
                1F2E40539A1A34B74EF020070BBE14BBD0E8A0342A49682D7CA64CE8D7054810
                DE90CED3AB0CC070A0BF3B0B206D9A6D245A01D25B1B45FC3522253F3676A4B2
                55EFCAD55F756490DA6748643248D20C12D1586B2830F57FDDB89DCC8025B23E
                5A24DA4A648368740342F279BF27F6F7FBA2D841DEDCF8B124FE5BA2BD2896EF
                6B555959EFCECAC6B6C45A23F3D4474AC205D09AA5C1ED9105D73C2EF89E1472
                9D994FC94BB102C64F4AA21580CEB1C90CC258CB1A7E03632383323A5CECC843
                E050B12095CDBA19717B494BC2FD92A75E7EF80831C135157DDC6AC0CFF1B52B
                E82AC0D4B5A13C73EBC274A644B6B9A6C16916DB41D4136BA02D4BCB0749644A
                C426B568260A23DB2B4DEFDA7C10FB7B9061A81259DF8D7AE20632E098B6F930
                29B81EDC9C79EF7A1043E1646948264F8D43318112D4A809134E4B16DCA6C337
                9FBF498432E1BD82AD6360F9F5D4C5699F4A04E6D8655347C38E8E1C96F3A78F
                DB9BA52347E45A9F630785F3F94FCB12298592782B88C200064E3B8CE2064889
                062B482541A8CD77FEC1EC92DC7DB66824DF833096DD8625D7A4B189D55E18C7
                116C43F831D5710162A59F44981C921314294890F2F76E289B2025DF23F487E5
                30E49A7B0810452A803D3E026A877E081760E1E1D545A5F51D04423028830D28
                91D84799ACE4FB9ED9E7B94AD7B401B52E414E401E81DC9F01F1EED1F5E738BC
                0D838006CC80D3C43503DA3D7B63CAECDAEA805A0D1B5DADF97F595C93FF62A9
                7CE3C5F8BD57CB988C497CB2F17F831F2ECC3A26C5CE3C9A6E27D0A1A58361F0
                3C5EBA8A699BB3A7070A913F8CBA750BB2F4FB3F0000000049454E44AE426082}
              Rounded = False
              ShowCaption = False
              TabOrder = 3
              OnClick = btnSaveJson_ExpressClick
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
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 0
      Width = 554
      Height = 35
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Tools Release Version'
      Color = 16512
      Font.Charset = ANSI_CHARSET
      Font.Color = clSilver
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object Panel8: TPanel
      Left = 0
      Top = 229
      Width = 554
      Height = 332
      Align = alTop
      Color = 2697513
      Padding.Left = 5
      Padding.Right = 5
      ParentBackground = False
      TabOrder = 2
      object Panel9: TPanel
        Left = 6
        Top = 314
        Width = 542
        Height = 17
        Align = alBottom
        BevelOuter = bvNone
        Color = 2697513
        ParentBackground = False
        TabOrder = 0
      end
      object Panel10: TPanel
        Left = 6
        Top = 1
        Width = 542
        Height = 35
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = 'Schema Database - DACPAC'
        Color = 2697513
        Font.Charset = ANSI_CHARSET
        Font.Color = clSilver
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
      object Panel13: TPanel
        Left = 6
        Top = 36
        Width = 542
        Height = 278
        Align = alClient
        BevelOuter = bvNone
        Color = 4079166
        Padding.Left = 10
        Padding.Top = 10
        Padding.Right = 10
        Padding.Bottom = 10
        ParentBackground = False
        TabOrder = 2
        object pnSource: TPanel
          Left = 10
          Top = 10
          Width = 522
          Height = 258
          Align = alClient
          BevelOuter = bvNone
          Color = 4079166
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object Label5: TLabel
            Left = 43
            Top = 48
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
          object Label6: TLabel
            Left = 42
            Top = 84
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
          object Label7: TLabel
            Left = 8
            Top = 121
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
            Left = 9
            Top = 155
            Width = 70
            Height = 19
            Caption = 'Database:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clSilver
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 22
            Top = 224
            Width = 55
            Height = 19
            Caption = 'Output:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clSilver
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object edtSource_User: TEdit
            Left = 82
            Top = 81
            Width = 200
            Height = 25
            Color = 4079166
            Font.Charset = ANSI_CHARSET
            Font.Color = clSilver
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object edtSource_Password: TMaskEdit
            Left = 82
            Top = 118
            Width = 200
            Height = 25
            Color = 4079166
            Font.Charset = ANSI_CHARSET
            Font.Color = clSilver
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 1
            Text = ''
          end
          object btnSourceConnectionTest: TGoButtonAdvanced
            Left = 288
            Top = 121
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
            TabOrder = 2
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
          object edtSource_Database: TEdit
            Left = 82
            Top = 154
            Width = 365
            Height = 25
            Color = 4079166
            Font.Charset = ANSI_CHARSET
            Font.Color = clSilver
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object edtSource_Output: TEdit
            Left = 83
            Top = 223
            Width = 365
            Height = 25
            Color = 2368548
            Enabled = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clSilver
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object edtSource_Host: TEdit
            Left = 82
            Top = 47
            Width = 365
            Height = 25
            Color = 4079166
            Font.Charset = ANSI_CHARSET
            Font.Color = clSilver
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object Panel11: TPanel
            Left = 0
            Top = 0
            Width = 522
            Height = 33
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Source'
            Color = 2368548
            Font.Charset = ANSI_CHARSET
            Font.Color = clSilver
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 6
          end
        end
      end
    end
    object pnGenerateVersion: TPanel
      Left = 0
      Top = 561
      Width = 554
      Height = 78
      Align = alClient
      Color = 2368548
      Padding.Left = 100
      Padding.Top = 10
      Padding.Right = 100
      Padding.Bottom = 10
      ParentBackground = False
      TabOrder = 3
      object btnGenerateVersion: TGoButtonAdvanced
        Left = 101
        Top = 11
        Width = 352
        Height = 56
        Cursor = crHandPoint
        Align = alClient
        Caption = 'Generate Version'
        Font.Charset = ANSI_CHARSET
        Font.Color = 4342338
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
          87000000097048597300000B1300000B1301009A9C1800000553494441546881
          ED595D6C145514467DD217450DED2E04C4047FA23E58899248253E28E5E7411E
          083E5363E28340232D69832EFA045276B6589A201A53EBCE6C1734ED2A3F258A
          82DDB58596221648E8B205A346D3A24F9A9848AEE79BDD99BD7BE7CECE9DA965
          4BEC494EB27B67EE39DF39F79C7BCF3D3367CE2CCDD2CCA1D0FED45D214D7F87
          384BFC4F28663093F11B6331FDED057B9277561AA7940AE0BFB341BB7075CCC8
          CC48234CCF7B802FAE88B1A3D2781D940F913CC0978F0FB368EE3A8B5DFDC364
          FCDE4063C555D0C72A8DD7417CCCF3E02DDE43637C4E541A6F09CD8FC597F021
          2282B7987F07736E2A4824A93816D6920F576BBAC17B3FDC96703500CFF855A0
          84D6C3ADC6432ABA0211ED16F752C2EDA398BD5E48BE5FAB356357F8BDCEFBE8
          FF661AFF4B4CD0E7125FB91AF0FCC1AF25BB92296333744136FDFEAD300E9DED
          0B3BE27303815FA47D740F09BC24DF0AF5BFF9FFF0EC8AE409B669708C69E3BF
          BB1AA011BF3E7899ADE83EC1C21E328BAC5F9CBB3379B76F0368790F94C42CBF
          FC1C2FED3CC25ABEBFE60ADA8D9B69CE539D47A532455DC0E20B7C289AA8A189
          372C01F5277F303DFB5AE6127BF440AF2DF8A5C3832C5AC6E35E8CB99061C983
          6CE880AE8DA49333E20630F9F0BE7ECA9ABCBCBB34A65B7393ECD5FE8BAC61E8
          4A60E022379D1D376542363F0EDD5C889D52F4BE516B2FE5DE6E1619FDC91798
          2DA7C7D8CA9E7EF6D80729B6B03D69F2E3F4BB8EC61A4E677DC9826E6028AE44
          7CB9B7F7357DBB35014AFD287BBAEB986719F14C579F2FA7C019DCFC1605038C
          B7AC096B7AD34A4ADE18CEB1C5FB0EA9D541C48B3B0EB1AD433925D9AB7BFBB9
          3032DEF40EA136E3C5620825D8FABE21D67AC5591AF09EE7C12FA0255FFB7986
          358D8CB3DDD94993F17B6D2A633EE38DD831FAB3AB5CE85C7F6C48D891F417BC
          932012B91D252FEFB147DEEF618DC3E352457CD82CD9FF196B39FFA32B286CB7
          78C77A7FD9277DD2F7B6D28A42A7704EF4039BB70144F3627A9568440DEDF7B2
          84E53D5F0E3C6F04BF120D679C89FD24E912CE814CD5EE8FE72981B72999BCA3
          70B4E7934FE22D3EC11036AA89B92695B6E7AD926C14D06583270CC0E20F7C81
          4840BD2568B54411B64AEBF9B6117988C9B871E4AA3D0F5BACF87C554F9A5F81
          FA40E04D0334639B2568DD914187A245B4C75BCFDFCD4E2A1B8077AD7990213E
          5F7778804FDCA6E006D0E4E930605776C29EF740FBC1B206546946E3140CB809
          21F4E17485904212D7F1499C0A9AC4CEC372CA497C7FB42B24B64864DB286A9B
          926D54A1ACC63BF3036CA3D8DA953D4F9306540F32D43625075919231C0759FC
          B8F43DE941A6E969A583ACBA4DAFF35D4A74144B097817218238476283512E63
          8CF7FC831D9FB2C8058F52827403836D0895399E06A0E964177329B5620E8519
          6F8417033CBCAC942FBD697E15B67BAF00574EAFF4514EA3305BC6259F1B236C
          CA795EE492725AD39BBD57608A171A2425CA036C8F3827C04FD06FEC36B2842D
          C78E0B4D34F1ACA701E62A785C295FF9F6826F305E4643E67F72A5CCAF42E9A5
          7EE337E7CD0BB8F3523F30B54B7D8E2EF55F144F5DEB520F99D0C9859EBF4B7D
          7E154ADB2A6E5CD379D46C91F805DF7CEE9A79B6A8E8F0DD5601A1B185A6925C
          A0D0D88AE53B72685A956D6CD133BC8377D51B5BC668A0C616086D3D3ACAF792
          07260AC27E21453BF32D477D93ACB558DBEDDE5AAC4D7CE97486A6FF0959666B
          91644347C1EB13F42C06470602EF20C66E1387D0982525F1C0CD5D9A2BED524B
          744D2BDD12ED752FBAA53F7080F84F4C1B649F98FAB84F4C9A71B9D2781D844F
          A8AAB510256BA4D2781D844FA7622B460A9ECAE219F999150460A866F11552FC
          D08D31787EC6829FA5FF2BFD0B77EA4298CE7814BF0000000049454E44AE4260
          82}
        Rounded = False
        TabOrder = 0
        Visible = False
        OnClick = btnGenerateVersionClick
        Skin = tsOffice2016Gray
        Appearance.BorderColor = 4473924
        Appearance.BorderColorHot = 15917525
        Appearance.BorderColorCheckedHot = 14925219
        Appearance.BorderColorDown = 14925219
        Appearance.BorderColorChecked = 15914434
        Appearance.BorderColorDisabled = 4473924
        Appearance.BorderColorFocused = clGray
        Appearance.Color = 11711154
        Appearance.ColorTo = clNone
        Appearance.ColorChecked = 15914434
        Appearance.ColorCheckedTo = clNone
        Appearance.ColorDisabled = 11711154
        Appearance.ColorDisabledTo = clNone
        Appearance.ColorDown = 14925219
        Appearance.ColorDownTo = clNone
        Appearance.ColorHot = 15917525
        Appearance.ColorHotTo = clNone
        Appearance.ColorMirror = 11711154
        Appearance.ColorMirrorTo = clNone
        Appearance.ColorMirrorHot = 15917525
        Appearance.ColorMirrorHotTo = clNone
        Appearance.ColorMirrorDown = 14925219
        Appearance.ColorMirrorDownTo = clNone
        Appearance.ColorMirrorChecked = 15914434
        Appearance.ColorMirrorCheckedTo = clNone
        Appearance.ColorMirrorDisabled = 11711154
        Appearance.ColorMirrorDisabledTo = clNone
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.GradientDisabled = ggVertical
        Appearance.GradientMirrorDisabled = ggVertical
        Appearance.TextColorChecked = 4342338
        Appearance.TextColorDown = 4342338
        Appearance.TextColorHot = 4342338
      end
    end
  end
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 489
    Top = 376
  end
  object FDConn_Source: TFDConnection
    Left = 490
    Top = 313
  end
  object dlgSave: TSaveDialog
    Left = 462
    Top = 44
  end
end
