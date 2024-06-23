unit uIndicator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  frxGaugePanel,
  uDemoMain;

type
  TfrmIndicator = class(TfrmDemoMain)
    frxGaugePanel1: TfrxGaugePanel;
    frxGaugePanel2: TfrxGaugePanel;
    frxGaugePanel3: TfrxGaugePanel;
    frxGaugePanel4: TfrxGaugePanel;
    frxIntervalGaugePanel1: TfrxIntervalGaugePanel;
    frxIntervalGaugePanel2: TfrxIntervalGaugePanel;
  protected
    function GetCaption: string; override;
  end;

var
  frmIndicator: TfrmIndicator;

implementation

{$R *.dfm}

{ TfrmIndicator }

function TfrmIndicator.GetCaption: string;
begin
  Result := 'Indicator Demo';
end;

end.
