program SSFuelCellMonitor;

uses
  Forms, Dialogs, SysUtils,
  uPM in 'uPM.pas' {frmPM},
  uEngineerWindow in 'uEngineerWindow.pas' {frmEngineeringWindow},
  SABI in 'SABI.pas',
  uFuelTray in 'uFuelTray.pas' {frmFuelTray},
  clsMain in '..\..\DelLib\Lib\clsMain.pas',
  Batclass in 'Batclass.pas',
  uBiosInterface in 'uBiosInterface.pas',
  BIDisplayer in 'BIDisplayer.pas',
  uDetailBar in 'uDetailBar.pas',
  uConstant in 'uConstant.pas',
  uMainOption in 'uMainOption.pas' {frmMainOption},
  uLogLocation in 'uLogLocation.pas' {frmLogLocation},
  uBatteryDetailForm in 'uBatteryDetailForm.pas' {frmBatteryDetail},
  uBatteryDetailFormEn in 'uBatteryDetailFormEn.pas' {frmBatteryDetailEn},
  uAlert in 'uAlert.pas' {frmAlert};

{$R *.res}
var
  appDir: String;
  initResult: Byte;
begin

  // Check Bios Init;
//  ShowMessage('aa');
//  appDir := Copy(Application.ExeName, 1, getLastCharPos(Application.ExeName, '\'));
//  CreateProcessSimple(appDir + 'RichEditor.exe');
//  MessageDlg('BiosInit value is not zero['+IntToStr(initResult)+'].  Please, try again.', mtInformation, [mbOK], 0);

  biManager := TBios.Create;
  initResult := biManager.initBios;

  if (initResult <> 0) then
  begin
    MessageDlg('BiosInit value is not zero['+IntToStr(initResult)+'].  Please, try again.', mtInformation, [mbOK], 0);

    appDir := Copy(Application.ExeName, 1, getLastCharPos(Application.ExeName, '\'));
    CreateProcessSimple(appDir + 'StartMem.exe');
    Exit;  
  end;


{ SABI or TEST DLL }
{$IFDEF SABI}

{$ELSE}

{$ENDIF}

{ DEBUG or RELEASE }
{$IFDEF DEBUG}

{$ELSE}

{$ENDIF}

{ ENGLISH or KOREAN }
{$IFDEF ENG}

{$ELSE}

{$ENDIF}

  Application.Initialize;

{ USER or ENGINEER }
{$IFDEF USERMODE}
  Application.CreateForm(TfrmFuelTray, frmFuelTray);
{$ELSE}
  Application.CreateForm(TfrmEngineeringWindow, frmEngineeringWindow);
{$ENDIF}

  Application.Run;
end.
