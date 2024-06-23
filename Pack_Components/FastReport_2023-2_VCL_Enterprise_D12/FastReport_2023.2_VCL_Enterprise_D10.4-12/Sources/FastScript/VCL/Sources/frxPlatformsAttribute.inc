{$IFDEF DELPHI16}
{$IFDEF FMX}
{$IFDEF DELPHI26}
[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidOSX64)]
{$ELSE}
[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
{$ENDIF}
{$ELSE}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
{$ENDIF}

