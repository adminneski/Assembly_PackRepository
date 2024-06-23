object FrmMainClient: TFrmMainClient
  Left = 0
  Top = 0
  Caption = 'Client Project'
  ClientHeight = 662
  ClientWidth = 930
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object Gauge: TGauge
    Left = 0
    Top = 0
    Width = 930
    Height = 25
    Align = alTop
    Progress = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 25
    Width = 930
    Height = 637
    Align = alClient
    Color = 8421440
    ParentBackground = False
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 928
      Height = 176
      Align = alTop
      TabOrder = 0
      object btnSelectALL: TButton
        Left = 664
        Top = 14
        Width = 153
        Height = 25
        Caption = 'Select ALL Dataset'
        TabOrder = 0
        OnClick = btnSelectALLClick
      end
      object Button4: TButton
        Left = 664
        Top = 76
        Width = 153
        Height = 25
        Caption = 'FindFrom'
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button2: TButton
        Left = 7
        Top = 5
        Width = 170
        Height = 25
        Caption = 'Incluir 100 Veiculo Objecto'
        TabOrder = 2
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 7
        Top = 36
        Width = 170
        Height = 25
        Caption = 'Incluir 1000 Veiculo Objecto'
        TabOrder = 3
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 664
        Top = 45
        Width = 153
        Height = 25
        Caption = 'Select ALL ObjectSet'
        TabOrder = 4
        OnClick = Button3Click
      end
    end
    object PageControl1: TPageControl
      AlignWithMargins = True
      Left = 4
      Top = 180
      Width = 922
      Height = 453
      ActivePage = TabSheet_DataSet
      Align = alClient
      TabOrder = 1
      object TabSheet_DataSet: TTabSheet
        Caption = 'TabSheet_DataSet'
        object Panel3: TPanel
          Left = 0
          Top = 209
          Width = 914
          Height = 31
          Align = alTop
          Caption = '2'#186' Nivel'
          Color = clSilver
          ParentBackground = False
          TabOrder = 0
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 914
          Height = 25
          Align = alTop
          Caption = '1'#186' Nivel'
          Color = clSilver
          ParentBackground = False
          TabOrder = 1
        end
        object DBGrid2: TDBGrid
          Left = 0
          Top = 25
          Width = 914
          Height = 184
          Align = alTop
          Color = clWhite
          DataSource = DataSource1
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object DBGrid1: TDBGrid
          Left = 0
          Top = 240
          Width = 914
          Height = 185
          Align = alClient
          Color = clWhite
          DataSource = DataSource2
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
      object TabSheet_ObjectSet: TTabSheet
        Caption = 'TabSheet_ObjectSet'
        ImageIndex = 1
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 914
          Height = 384
          Align = alClient
          Color = clSilver
          Lines.Strings = (
            'Memo1')
          TabOrder = 0
        end
        object pnLength: TPanel
          Left = 0
          Top = 384
          Width = 914
          Height = 41
          Align = alBottom
          TabOrder = 1
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = DtmMainClient.CONTACTS_00
    Left = 752
    Top = 184
  end
  object DataSource2: TDataSource
    DataSet = DtmMainClient.CONTACTS_00_01
    Left = 752
    Top = 496
  end
end
