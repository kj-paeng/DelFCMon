unit SABI;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

const

{$IFDEF SABI}
  EZBOXDLL = 'SABI.dll';
  //EZBOXDLL = 'FuelGaugeDll.dll';
{$ELSE}
  EZBOXDLL = 'FuelGaugeDll.dll';
{$ENDIF}

{$IFDEF SABI}
function InitBIOSInterface: Integer; cdecl;
function CallBIOSInterface(sf: Word; var data: array of BYTE):Integer; cdecl;
{$ELSE}
function DllInitBIOSInterface: Integer; cdecl;
function DllCallBIOSInterface(sf: Word; var data: array of BYTE):Integer; cdecl;
{$ENDIF}

implementation

{$IFDEF SABI}
function InitBIOSInterface: Integer; cdecl; external EZBOXDLL;
function CallBIOSInterface(sf: Word; var data: array of BYTE):Integer; cdecl; external EZBOXDLL;
{$ELSE}
function DllInitBIOSInterface: Integer; cdecl; external EZBOXDLL;
function DllCallBIOSInterface(sf: Word; var data: array of BYTE):Integer; cdecl; external EZBOXDLL;
{$ENDIF}


end.

