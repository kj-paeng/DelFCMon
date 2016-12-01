unit uBiosInterface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList;

type
  TBios = class(TObject)

  private
    { Private declarations }
  public
    { Public declarations }
    function initBios: Integer;
    function getBatteryData(command: BYTE): Single;
    function getDefaultBatteryInfo(slaveAddr: BYTE; command: BYTE): Single;
    procedure getRecyclerData(var iodata2: BYTE);

    
    
  end;

implementation

uses SABI;

procedure TBios.getRecyclerData(var iodata2: BYTE);
var
  inWord: WORD;
  IO: array[0..2] of Byte;
//  ir: Integer;
begin
  inWord := $51;
  IO[1] := $1A;
  IO[2] := $19;

{$IFDEF SABI}
  {ir := }CallBIOSInterface(inWord, IO);
{$ELSE}
  {ir := }DllCallBIOSInterface(inWord, IO);
{$ENDIF}

  iodata2 := IO[1];


end;

function TBios.initBios: Integer;
begin
{$IFDEF SABI}
   result := InitBIOSInterface;
{$ELSE}
   result := DllInitBIOSInterface;
{$ENDIF}
end;

function TBios.getBatteryData(command: BYTE): Single;
var
  inWord: WORD;
  IO: array[0..2] of Byte;
//  ir: Integer;
begin
  inWord := $51;
  IO[1] := $1A;
  IO[2] := command;

{$IFDEF SABI}
  {ir := }CallBIOSInterface(inWord, IO);
{$ELSE}
  {ir := }DllCallBIOSInterface(inWord, IO);
{$ENDIF}

  result := IO[1]/10;

end;

function TBios.getDefaultBatteryInfo(slaveAddr: BYTE; command: BYTE): Single;
var
  inWord: WORD;
  IO: array[0..2] of Byte;
//  ir: Integer;
begin
  inWord := $51;
  IO[1] := slaveAddr;
  IO[2] := command;

{$IFDEF SABI}
  {ir := }CallBIOSInterface(inWord, IO);
{$ELSE}
  {ir := }DllCallBIOSInterface(inWord, IO);
{$ENDIF}

  result := MAKEWORD(IO[1], IO[2]);

end;

end.
