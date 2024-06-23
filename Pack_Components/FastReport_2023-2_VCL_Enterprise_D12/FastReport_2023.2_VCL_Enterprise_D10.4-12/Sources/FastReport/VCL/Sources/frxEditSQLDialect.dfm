object frxSQLDialectForm: TfrxSQLDialectForm
  Left = 200
  Top = 107
  Width = 568
  Height = 338
  Caption = 'Lines'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 177
    Top = 0
    Height = 307
  end
  object PnInsp: TPanel
    Left = 180
    Top = 0
    Width = 380
    Height = 307
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
  end
  object PnTree: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 307
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object ToolBar: TToolBar
      Left = 0
      Top = 0
      Width = 177
      Height = 23
      ButtonHeight = 23
      TabOrder = 0
      object TBNewDialect: TToolButton
        Left = 0
        Top = 2
        ImageIndex = 87
        OnClick = TBNewDialectClick
      end
      object TBNewStyle: TToolButton
        Left = 23
        Top = 2
        Caption = 'TBNewStyle'
        ImageIndex = 89
        OnClick = TBNewStyleClick
      end
      object TBDelete: TToolButton
        Left = 46
        Top = 2
        Caption = 'TBDelete'
        ImageIndex = 88
        OnClick = TBDeleteClick
      end
    end
    object TVStyles: TTreeView
      Left = 0
      Top = 23
      Width = 177
      Height = 284
      Align = alClient
      Indent = 19
      TabOrder = 1
      OnChange = TVStylesChange
      OnEdited = TVStylesEdited
    end
  end
end
