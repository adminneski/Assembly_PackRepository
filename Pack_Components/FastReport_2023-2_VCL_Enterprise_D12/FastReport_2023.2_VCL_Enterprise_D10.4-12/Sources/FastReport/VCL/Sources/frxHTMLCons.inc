{
Version   11.9
Copyright (c) 1995-2008 by L. David Baldwin
Copyright (c) 2008-2018 by Bernd Gabriel

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Note that the source modules HTMLGIF1.PAS, DITHERUNIT.PAS
are covered by separate copyright notices located in those modules.
}

//{$IFDEF CONDITIONALEXPRESSIONS}
//
//
//  // Must be at the top...
//  {$IF CompilerVersion >= 24.0}
//    {$LEGACYIFEND ON}
//  {$IFEND}
//{$ENDIF}
{$ifdef FPC}

{ Identify FreePascal/Lazarus Compiler Version }

  {$define LCL}
  {$mode delphi}
  {$H+}

  {$define FPC_TODO}

  {$define HasStrictDelimiter}

  {$define ver100_plus}
  {$define ver120_plus}

  {$define TSearchRecHasNoTimestamp}
{$else}

{ Identify Delphi Compiler Version:

  #   Compiler          Version Compiler Defined Symbol
  D26 Delphi 10.3 Rio     33    VER330
  D25 Delphi 10.2 Tokyo   32    VER320
  D24 Delphi 10.1 Berlin  31    VER310
  D23 Delphi 10   Seattle 30    VER300
  D22 Delphi XE8          29    VER290
  D21 Delphi XE7          28    VER280
  D20 Delphi XE6          27    VER270
  D19 Delphi XE5          26    VER260
  D18 Delphi XE4          25    VER250
  D17 Delphi XE3          24    VER240
  D16 Delphi XE2          23    VER230
  D15 Delphi XE           22    VER220
  D14 Delphi 2010         21    VER210
  D12 Delphi 2009         20    VER200
  D11 Delphi 2007         18.5  VER185
  D10 Delphi 2006         18    VER180
  D9  Delphi 2005         17    VER170
  D8  Delphi 8            16    VER160
  D7  Delphi 7            15    VER150
  D6  Delphi 6            14    VER140
      C++Builder 5              VER130 BCB
  D5  Delphi 5                  VER130
      C++Builder 4              VER125
  D4  Delphi 4                  VER120
      C++Builder 3              VER110
  D3  Delphi 3                  VER100
      C++Builder 1              VER93
  D2  Delphi 2                  VER90
  D1  Delphi 1                  VER80

  Since Delphi 6 the version number can be found in the system constant System.CompilerVersion

  NOTICE: HtmlViewer no longer supports versions before Delphi 6
  BG, 20.11.2010: HtmlViewer sources use neither ver100_plus nor ver120_plus any more.
  We keep the defines alive for custom code which might still use them.

  A complete list of version numbers can be found at:

  http://docwiki.embarcadero.com/RADStudio/XE8/de/Compiler-Versionen
}

  {$define VCL}
  {$define Windows}
  {$ifdef CONDITIONALEXPRESSIONS} {Delphi 6 and up}
    {$define ver100_plus}
    {$define ver120_plus}
    {$ifdef ver140}
    {$else}
      {$define Delphi7_Plus}
      {$define Compiler15_Plus}
      {$ifdef ver150}
      {$else}
        {$define Compiler16_Plus}
        {$ifdef ver160}
        {$else}
          {$define Compiler17_Plus}
          {$ifdef ver170}
          {$else}
            {$define Compiler18_Plus}
            {$ifdef ver180}
            {$else}
              {$define Compiler19_Plus}
              {$ifdef ver185}
              {$else}
                {$define Compiler20_Plus}
                {$ifdef ver200}
                {$else}
                  {$define Compiler21_Plus}
                  {$ifdef ver210}
                  {$else}
                    {$define Compiler22_Plus}
                    {$ifdef ver220}
                    {$else}
                      {$define Compiler23_Plus}
                      {$ifdef ver230}
                      {$else}
                        {$define Compiler24_Plus}
                        {$ifdef ver240}
                        {$else}
                          {$define Compiler25_Plus}
                          {$ifdef ver250}
                          {$else}
                            {$define Compiler26_Plus}
                            {$ifdef ver260}
                            {$else}
                              {$define Compiler27_Plus}
                             {$ifdef ver270}
                             {$else}
                               {$define Compiler28_Plus}
                               {$ifdef ver280}
                               {$else}
                                 {$define Compiler29_Plus}
                                 {$ifdef ver290}
                                 {$else}
                                   {$define Compiler30_Plus}
                                   {$ifdef ver300}
                                   {$else}
                                     {$define Compiler31_Plus}
                                     {$ifdef ver310}
                                     {$else}
                                       {$define Compiler32_Plus}
                                       {$ifdef ver320}
                                       {$else}
                                         {$define Compiler33_Plus}
                                         {$ifdef ver330}
                                         {$else}
                                         {$endif}
                                       {$endif}
                                     {$endif}
                                   {$endif}
                                 {$endif}
                               {$endif}
                             {$endif}
                            {$endif}
                          {$endif}
                        {$endif}
                        {$LEGACYIFEND ON}
                      {$endif}
                    {$endif}
                  {$endif}
                {$endif}
              {$endif}
            {$endif}
          {$endif}
        {$endif}
      {$endif}
    {$endif}
  {$else}
    {$message 'Sorry, but Delphi versions before 6 are not supported.'}
  {$endif}

  { Compiler Features }

  {$ifdef Compiler20_Plus}
    {$ifdef DEBUG}
    {$else}
      {$define UseInline}
    {$endif}
  {$endif}

  {$ifdef Compiler18_Plus}
    {$define HasStrictDelimiter}
  {$endif}

  {$ifdef Compiler22_Plus}
  {$else}
    {$define TSearchRecHasNoTimestamp}
  {$endif}

  { Set Delphi Compiler Switches }

  {$ifdef ver150}  {Delphi 7}
  {$warn Unsafe_Type off}
  {$warn Unsafe_Code off}
  {$warn Unsafe_Cast off}
  {$endif}

  {$A+,B-,F-,G+,I+,P+,T-,V+,X+,R-}

  {$ifdef Win32}
    {$J+}  {typed constants are modifiable}
    {$H+}  {LongStrings On}
  {$endif}
  {$ifdef Win64}
    {$J+}  {typed constants are modifiable}
    {$H+}  {LongStrings On}
  {$endif}

  {$ifndef DebugIt}
    {$W-}  {Stack frames off}
    {$Q-}  {overflow checking off}
    {$S-}  {stack checking off}
    {$C-}  {Assertions off}
    {$ifdef Win32}
      {$O+}  {optimization on}
    {$endif}
  {$else}
    {$W+}  {Stack frames on}
    {$Q+}  {overflow checking on}
    {$S+}  {stack checking on}
    {$C+}  {Assertions on}
    {$ifdef Win32}
      {$O-}  {optimization off}
    {$endif}
  {$endif}

  {$warn Symbol_Platform Off}

  {$IFDEF UNICODE}
  // {$HIGHCHARUNICODE ON}  {make all #nn char constants Wide for better portability}
  {$ENDIF}

{$endif}

{ Define Aspects Of HtmlViewer }

{$ifdef MSWindows}
  {.$define BorderSinglePixelException} {Drawing 4 sided polygon the borders
  with single pixel thickness, the drawing can be done by lines by defining this
  constant. On print preview results are better without the single pixel exception,
  but it does not work correctly on certain printers, so the default behaviour
  can be overrules this way.}
{$else}
  {$define NoFlatScrollbars}
  {$define MultiMediaMissing}
{$endif}

{$ifdef Compiler23_Plus}
   {$define UseVCLStyles}
{$endif}

{$ifdef Compiler24_Plus}
  {$define HasSystemUITypes}
{$endif}


