{******************************************}
{                                          }
{             FastReport v4.0              }
{              Include file                }
{                                          }
{         Copyright (c) 1998-2006          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

{$I frVer.inc}

{$IFNDEF RAD_ED}{$IFNDEF ACADEMIC_ED}
  {$DEFINE OFF2DBARS}
{$ENDIF}{$ENDIF}
//{$DEFINE TESTALLBARMODE}

{$DEFINE FR6VCL}

// Uncomment the following line if you don't want to include component editors
// into your exe (in case if you don't use designer)
//{$DEFINE NO_EDITORS}

//-------------------------Additional components----------------------------

//---------------- GetMessage Hook----------------------------------
// Hook to GetMessage function for unicode input support (D4-7, BCB4-BCB6)
//{$DEFINE HOOK_WNDPROC_FOR_UNICODE}

//------------------- JPEG images -----------------------------------
// JPEG images. Adds approximately 100Kb to your EXE.
// If you want to show jpeg images in "Picture" object, uncomment
// the following line:
{$IFNDEF FPC} // Free pascal compiler
{$DEFINE JPEG}
{$ENDIF}

//------------------- PNG images -----------------------------------
// PNG images. If you want to show png images in "Picture" object, uncomment
// the following line:
{$IFNDEF FPC} // Free pascal compiler
{$DEFINE PNG}
{$ENDIF}

//------------------- MAP object -----------------------------------
//{$DEFINE FRX_USE_BITMAP_MAP}

{$IFDEF FRX_USE_BITMAP_MAP}
{$DEFINE FRX_DONT_USE_METAFILE_MAP}
{$ENDIF}

//------------------- "Open Picture" dialog -------------------------
// Adds approximately 60Kb to your EXE.
// If you want to use standard "Open picture" dialog in picture editor,
// uncomment the following line:
//{$DEFINE OPENPICTUREDLG}

//------------------- Visual Query builder --------------------------
// To use visual query builder, you should install FastQBuilder component.
// It is included in FR3 Pro and FR3 EE by default.
//{$DEFINE QBUILDER}

{$IFDEF QBUILDER}
  {$UNDEF WITHOUTQBUILDER}
{$ENDIF}
{$IFDEF FPC}
  {$DEFINE WITHOUTQBUILDER}
{$ENDIF}

//------------------- TTabSet control -------------------------------
// In Delphi2005 and BDS2006 you can use TTabSet control instead of TTabControl
// to make a report designer more soft-looked.
{$IFNDEF FPC}
{$DEFINE UseTabset}
{$ENDIF}
//-------------------Use INDY for e-mail export ---------------------
//{$DEFINE USE_INDY}
//----------- Use INDY 9 instead of 10 for save filters -------------
// comment these lines if you have indy 10 on Delphi 7
//{$IFDEF USE_INDY}
{$IFNDEF Delphi9}
{$DEFINE INDY9}
{$DEFINE INDYPARAM_INT}
{$ENDIF}

{$IFDEF Delphi9}
{$DEFINE INDY10_1}
{$DEFINE INDYPARAM_INT}
{$DEFINE INDY10_2005}
{$DEFINE INDYFTP10_2005}
{$ENDIF}

{$IFDEF Delphi10}
{$UNDEF INDYFTP10_2005}
{$ENDIF}

{$IFDEF Delphi12}
{$UNDEF INDY10_2005}
{$ENDIF}

{$IFDEF Delphi12}
{$UNDEF INDYPARAM_INT}
{$ENDIF}

{$IFDEF Delphi16}
{$UNDEF INDY10_1}
{$ENDIF}
//{$ENDIF}

//--------Use custom version of Indy 10 (not from RAD)---------------
//{$DEFINE CUSTOM_INDY}
{$IFDEF CUSTOM_INDY}
{$UNDEF INDY9}
{$UNDEF INDYFTP10_2005}
{$UNDEF INDY10_2005}
{$UNDEF INDYPARAM_INT}
{$UNDEF INDY10_1}
{$ENDIF}

//------------------- Group DB components ---------------------------
// Use it to group all frxDB components.
//{$DEFINE DB_CAT}

//{$DEFINE FR_VER_BASIC}

{$IFDEF FR_COM}
  {$IFDEF FR_LITE}
     {$DEFINE FR_VER_BASIC}
  {$ENDIF}
{$ENDIF}

{$IFNDEF Delphi9}
  {$UNDEF UseTabset}
{$ENDIF}

{$IFDEF Delphi4}
  {$IFDEF FR_VER_BASIC}
    {$DEFINE NO_CRITICAL_SECTION}
  {$ENDIF}
{$ENDIF}

{$IFDEF Delphi12}
{$DEFINE DEL12ORFPC}
{$ELSE}
  {$IFDEF FPC}
  {$DEFINE DEL12ORFPC}
  {$ENDIF}
{$ENDIF}

{$IFDEF Delphi16}
{$DEFINE DEL16ORFPC}
{$ELSE}
  {$IFDEF FPC}
  {$DEFINE DEL16ORFPC}
  {$ENDIF}
{$ENDIF}
