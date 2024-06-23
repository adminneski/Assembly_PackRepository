inherited frmDatabaseMain: TfrmDatabaseMain
  Left = 185
  Top = 107
  Caption = 'DB demo'
  ClientHeight = 456
  ClientWidth = 435
  Position = poScreenCenter
  ExplicitWidth = 451
  ExplicitHeight = 515
  DesignSize = (
    435
    456)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton [0]
    Left = 8
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Run Script'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo [1]
    Left = 8
    Top = 35
    Width = 421
    Height = 413
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'var'
      '  DBForm: TForm;'
      '  Table: TTable;'
      '  DataSource: TDataSource;'
      '  Grid: TDBGrid;'
      'begin'
      '  DBForm := TForm.Create(nil);'
      '  DBForm.SetBounds(100, 100, 400, 400);'
      '  '
      '  Table := TTable.Create(DBForm);'
      '  Table.DatabaseName := '#39'DBDEMOS'#39';'
      '  Table.TableName := '#39'customer.db'#39';'
      '  Table.Open;'
      ''
      '  DataSource := TDataSource.Create(DBForm);'
      '  DataSource.DataSet := Table;'
      ''
      '  Grid := TDBGrid.Create(DBForm);'
      '  Grid.DataSource := DataSource;'
      '  Grid.Parent := DBForm;'
      '  Grid.Align := alClient;'
      ''
      '  DBForm.ShowModal;'
      '  DBForm.Free;'
      'end.')
    ParentFont = False
    TabOrder = 1
  end
  object fsScript1: TfsScript
    SyntaxType = 'PascalScript'
    Left = 112
    Top = 4
  end
  object fsFormsRTTI1: TfsFormsRTTI
    Left = 148
    Top = 4
  end
  object fsBDERTTI1: TfsBDERTTI
    Left = 180
    Top = 4
  end
  object fsDBCtrlsRTTI1: TfsDBCtrlsRTTI
    Left = 212
    Top = 4
  end
  object fsPascal1: TfsPascal
    Left = 248
    Top = 4
  end
end
