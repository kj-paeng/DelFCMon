unit uFuelTray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TrayIcon, Menus, uConstant, ExtCtrls, uBiosInterface;

type
  TfrmFuelTray = class(TForm)
    SSTray: TTrayIcon;
    PopupMenu1: TPopupMenu;
    pmOpen: TMenuItem;
    N1: TMenuItem;
    pmClose: TMenuItem;
    Timer1: TTimer;
    procedure pmOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pmCloseClick(Sender: TObject);
    procedure SSTrayDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure WMEXESSFuel(var TWMessage); message WM_EXESSFUEL;
  public
    { Public declarations }
  end;

var
  frmFuelTray: TfrmFuelTray;
  biManager: TBios;

implementation

uses uPM, clsMain;

{$R *.dfm}

procedure TfrmFuelTray.WMEXESSFuel(var TWMessage); 
begin
  pmOpenClick(nil);  
end;

procedure TfrmFuelTray.pmOpenClick(Sender: TObject);
var
  handle: integer;
begin
  try
(*    if (frmPM = nil) then
    begin
      frmPM.Free;
      frmPM := nil;
    end;
*)
    handle := FindWindow(PChar('TfrmPM'), nil);
    if (handle=0) then
    begin
      Application.CreateForm(TfrmPM, frmPM);
    end
    else
    begin
//      Application.CreateForm(TfrmPM, frmPM);
      BringWindowToTop(handle);
    end;

//    frmPM := TfrmPM.Create(self);
//    frmPM.ShowModal;
  finally
//    frmPM.Free;
  end;
end;

procedure TfrmFuelTray.FormCreate(Sender: TObject);
var
  initResult: Byte;
  appDir: String;
begin

  Self.Left := -1000;
  Self.Top := -1000;

{$IFDEF EN}
  pmOpen.Caption := 'Open FuelCell Manager';
  pmClose.Caption := 'Close';

{$ELSE}
  pmOpen.Caption := '���������ý��� ����';
  pmClose.Caption := '�ݱ�';

{$ENDIF}

(*
  appDir := Copy(Application.ExeName, 1, getLastCharPos(Application.ExeName, '\'));
CreateProcessSimple(appDir + 'RichEditor.exe');
  Close;
  biManager := TBios.Create;
  initResult := biManager.initBios;
  if (initResult <> 0) then
  begin
    MessageDlg('BiosInit value is not zero['+IntToStr(initResult)+'].', mtInformation, [mbOK], 0);

    appDir := Copy(Application.ExeName, 1, getLastCharPos(Application.ExeName, '\'));
    CreateProcessSimple(appDir + 'StartMem.exe');

  end;
*)

  SSTray.Active := True;
  Timer1.Interval := StrToInt(getRegValue('DisplayInterval'))*1000;
  Timer1Timer(Self);
{$IFDEF DEBUG}
  OpenLogFile;
{$ENDIF}

  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW );
  ShowWindow(Application.Handle, SW_SHOW);

end;

procedure TfrmFuelTray.pmCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFuelTray.SSTrayDblClick(Sender: TObject);
begin
  pmOpenClick(self);
end;

procedure TfrmFuelTray.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  handle: Integer;
begin
  if (frmPM <> nil) then
    if not frmPM.isDetailClosed then
    begin
      {$IFDEF EN}
        MessageDlg('Please, exit after closing Battery Detail Window.', mtWarning, [mbOk], 0);
        CanClose := false;
        Exit;
      {$ELSE}
        MessageDlg('���� ������ ȭ���� �ݾ��ֽ� �� �����Ͻʽÿ�', mtWarning, [mbOk], 0);
        CanClose := false;
        Exit;
      {$ENDIF}
    end;

  if (biManager <> nil) then
  begin
    biManager.Free;
    biManager := nil;
  end;


  handle := FindWindow(PChar('TfrmPM'), nil);
  if (handle<>0) then
  begin
    frmPM.Free;
    frmPM := nil;
  end;

  SSTray.Active := False;

{$IFDEF DEBUG}
  CloseLogFile;            
{$ENDIF}

end;

procedure TfrmFuelTray.Timer1Timer(Sender: TObject);
var
  iFuelCurr: Double;
  // SABI variable (For page 1)
  iBatteryFullCapa, iBatteryRemainCapa, iFuelCellFullCapa, iFuelCellRemainCapa: Single;
  batteryLifePercent: Word;
  batteryLifePercent2: Single;

begin
  iFuelCurr := biManager.getBatteryData(FUELCURR);
  // SABI Interface ���� (for Page 1)
  iBatteryFullCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_FULL_CAPA);
  iBatteryRemainCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_REM_CAPA);
  iFuelCellFullCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_FULL_CAPA);
  iFuelCellRemainCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_REM_CAPA);

  if (iFuelCurr <= 0.2) then iFuelCellRemainCapa := 0; // 0.2 ���ϸ� �������� �������� ���� ������ �Ǵ���.

  batteryLifePercent2 := (iBatteryRemainCapa+iFuelCellRemainCapa)/(iBatteryFullCapa+iFuelCellFullCapa)*100;
  batteryLifePercent := StrToInt(Format('%5.0f', [batteryLifePercent2]));
  if (batteryLifePercent > 100) then batteryLifePercent := 100;

{$IFDEF EN}
  SSTray.ToolTip := 'Samsung Fuelcell Monitor ('+ IntToStr(batteryLifePercent) + '% remain)';
{$ELSE}
  SSTray.ToolTip := '�Ｚ �������� ����� ('+ IntToStr(batteryLifePercent) + '% ����)';
{$ENDIF}
end;

end.
