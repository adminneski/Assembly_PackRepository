{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{               Embedded Language Resources             }
{                                                       }
{     Copyright (c) 2017-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit EhLibEmbeddedLangConsts;

{$I EhLib.Inc}

interface

implementation

{$IFDEF EH_LIB_12} 
  {$R ..\..\LangResources\Res\EhLibLangConsts.ARA.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.BGR.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.CHS.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.CSY.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.DEU.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.ENU.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.ESP.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.FAR.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.FRA.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.JPN.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.KOR.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.PLK.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.PTB.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.RUS.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.SKY.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.TRK.dfm}
  {$R ..\..\LangResources\Res\EhLibLangConsts.UKR.dfm}
{$ELSE}
  {$R EhLibLangConsts.ENU.dfm}
  {$R EhLibLangConsts.FRA.dfm}
  {$R EhLibLangConsts.RUS.dfm}
  {$R EhLibLangConsts.UKR.dfm}
{$ENDIF}

end.
