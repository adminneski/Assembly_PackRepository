{ SMComponents library
  Register components and editors

  Copyright (C) 2000-2021, written by Mike Shkolnik, Scalabium Software
  E-Mail:  mshkolnik@scalabium.com
  WEB: http://www.scalabium.com
}
unit SMCReg;

interface

{$I SMVersion.inc}

procedure Register;

implementation
uses Classes,
     EditType, EditTypeDB, AngleLbl, CharMap, ConerBtn, GradPnl,
     MoneyStr, RunText, SendMail, 
     SMPanel, SMScript, SMSensors,
     {$IFDEF SMForDelphi6} DesignIntf, DesignEditors {$ELSE} DsgnIntf {$ENDIF};

type
  { TSMIAboutProperty }
  TSMCAboutProperty = class(TStringProperty)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure Register;
begin
  RegisterComponents('SMComponents', [TAngleLabel,
//                                      TEditTyped,
//                                      TDBEditTyped,
                                      TCharMapCombo,
                                      TConerBtn, TConvexBtn,
                                      TGradientPanel,
                                      TMoneyString,
                                      TRunningText,
                                      TMAPIMail,
                                      TStopLightSensor, TAnalogSensor,
                                      TSMFramePanel,
                                      TSMScriptExecutor]);

//  RegisterPropertyEditor(TypeInfo(TSMCAbout), TSMImportBaseComponent, 'About', TSMCAboutProperty);
end;

function TSMCAboutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paReadOnly];
end;

function TSMCAboutProperty.GetValue: string;
begin
  Result := '3.21';
end;

end.

