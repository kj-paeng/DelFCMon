program pTest;

uses
  Forms,
  Dialogs,
  uTest in 'uTest.pas' {Form1},
  clsMain in '..\..\DelLib\Lib\clsMain.pas',
  ShFolder in '..\..\DelLib\Lib\ShFolder.pas';

{$R *.res}


//  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
//   StdCtrls, WinInet, UrlMon;

var
  s: String;

begin
  Application.Initialize;

  s := ParamStr(1);

  uTest.sParam := s;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
