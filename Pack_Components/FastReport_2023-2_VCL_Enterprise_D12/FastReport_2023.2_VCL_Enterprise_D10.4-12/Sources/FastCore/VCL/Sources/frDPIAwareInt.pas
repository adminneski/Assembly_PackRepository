{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{ it used to reduce precompiler directives }
{ some interfaces was introduces only in lastest Delphi }
unit frDPIAwareInt;

interface

{$I frVer.inc}

type

  IfrxDPIAwareControl = interface ['{391B5E86-16E3-4935-B2F9-5EFC2A47071B}']
    procedure DoPPIChanged(aNewPPI: Integer);
  end;

implementation

end.
