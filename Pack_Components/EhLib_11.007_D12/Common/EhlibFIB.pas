{*******************************************************}
{                                                       }
{                  EhLib 10.2                           }
{                  FIBPlus 6.41                         }
{    Register object that sort data in TpFIBDataset     }
{                                                       }
{      Copyright (c) 2005-2022 by Roman V. Babenko      }
{      e-mail: romb@devrace.com                         }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TpFIBDataset automatically after sorting markers      }
{ will be changed.                                      }
{ TFIBDatasetFeaturesEh will sort data locally          }
{ using DoSort procedure of TpFIBDataset                }
{ [+] SortLocal                                         }
{ [+] FilterLocal                                       }
{ [+] SortServer                                        }
{ [+] FilterServer                                      }
{*******************************************************}

unit EhLibFIB;

interface

{$I EhLib.Inc}

implementation

uses
 DBUtilsEh, pFIBDataSet, DB, DBGridEh, ToolCtrlsEh, Classes, SysUtils;

type
  TpFIBDatasetFeaturesEh = class(TDatasetFeaturesEh)
  public
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
  end;


{ TpFIBDatasetFeaturesEh }

function DateValueToIBSQLStringProc(DataSet: TDataSet; Value: Variant): String;
begin
  Result := '''' + FormatDateTime('MM"/"DD"/"YYYY', Value) + '''';
end;

procedure TpFIBDatasetFeaturesEh.ApplyFilter(Sender: TObject;
DataSet: TDataSet; IsReopen: Boolean);
begin
  if (Sender is TDBGridEh)then
  begin
    if (Sender as TDBGridEh).STFilter.Local then
    begin
      TpFIBDataSet(DataSet).Filter :=
        GetExpressionAsFilterString((Sender as TCustomDBGridEh),
        GetOneExpressionAsLocalFilterString, nil, False, True);
      TpFIBDataSet(DataSet).Filtered := True;
    end else
    begin
     ApplyFilterSQLBasedDataSet(( Sender as TCustomDBGridEh ), DataSet,DateValueToIBSQLStringProc,
       IsReopen, 'SelectSQL');
    end;
  end;
end;

procedure TpFIBDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
    FLD  : array of TVarRec ;
    sort : array of boolean;
    I,J  : integer;
    Grid : TCustomDBGridEh;
begin
  if Sender is TCustomDBGridEh then begin
    Grid:=TCustomDBGridEh(Sender);
    J:=Grid.SortMarkedColumns.Count;
    setlength(fld,J);setlength(sort,J);
    for i:=0 to pred(j) do
      begin
       fld[i].VType:=vtAnsiString;
       AnsiString(fld[i].VString):=Grid.SortMarkedColumns[i].fieldname;
       sort[i]:=Grid.SortMarkedColumns[i].Title.SortMarker=smUpEh;
      end;
      TpFibDataset(Dataset).DoSort(fld,sort);
    end;
end;

initialization
  RegisterDatasetFeaturesEh(TpFIBDatasetFeaturesEh, TpFIBDataSet);
end.

