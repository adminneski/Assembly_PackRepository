{*******************************************************}
{                                                       }
{         Delphi VCL Extensions (RX)                    }
{                                                       }
{         Copyright (c) 1995, 1996 AO ROSNO             }
{         Copyright (c) 1997, 1998 Master-Bank          }
{                                                       }
{ Revision and component added by JB.                   }
{*******************************************************}

{ Note:
  - in Delphi 5.0 you must add DCLRX5 to the requires page of the
    package you install this components into.
  - in Delphi 4.0 you must add DCLRX4 to the requires page of the
    package you install this components into.
  - in Delphi 3.0 you must add DCLRXCTL to the requires page of the
    package you install this components into.
  - in C++Builder 4.0 you must add DCLRX4 to the requires page of the
    package you install this components into.
  - in C++Builder 3.0 you must add DCLRXCTL to the requires page of the
    package you install this components into. }

unit RxDBReg;

{$I RX.INC}
{$D-,L-,S-}

interface

uses Classes, SysUtils, DB,
  {$IFDEF RX_D6} DesignIntf, DesignEditors {$ELSE} DsgnIntf {$ENDIF}; // Polaris

{ Register data aware custom controls and components }

procedure Register;

implementation

{$R *.dcr}

uses
  TypInfo, RXDBCtrl,  RXDBComb, {rxVCLUtils,}
  {$IFNDEF RX_D3} DBTables, {$ENDIF} {$IFDEF DCS} rxSelDSFrm, {$ENDIF}
  {$IFDEF RX_D3}  {$ENDIF}
  RxResConst, Consts, LibHelp;


{$IFDEF DCS}
{$IFDEF RX_D3}

{ TMemoryDataEditor }

type
  TMemoryDataEditor = class(TMemDataSetEditor)
  protected
    function CopyStructure(Source, Dest: TDataSet): Boolean; override;
  end;

function TMemoryDataEditor.CopyStructure(Source, Dest: TDataSet): Boolean;
begin
  Result := Dest is TRxMemoryData;
  if Result then
    TRxMemoryData(Dest).CopyStructure(Source);
end;

{$ENDIF RX_D3}
{$ENDIF DCS}

{ Designer registration }

procedure Register;
begin

{$IFDEF RX_D4}
  { Database Components are excluded from the STD SKU }
  if GDAL = LongWord(-16) then Exit;
{$ENDIF}

{ Data aware components and controls }
  RegisterComponents('RXLib Lite - DBAware', [
     TDBDateEdit,
    // TRxDBComboEdit,  // Marcado devido esta usando o da paleta GOBT Library
    TRxDBComboBox]);
{$IFDEF RX_D3}
  RegisterNonActiveX([TDBDateEdit,
     TRxDBComboBox,
   // TRxDBComboEdit,  // Marcado devido esta usando o da paleta GOBT Library
    TCustomDBComboBox],
    axrComponentOnly);
{$ENDIF RX_D3}
{$IFDEF RX_D3}

{$IFDEF DCS}
  RegisterComponentEditor(TRxMemoryData, TMemoryDataEditor);
{$ENDIF DCS}
{$ENDIF RX_D3}

end;

end.