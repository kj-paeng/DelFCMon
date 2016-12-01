unit uBatteryDetailFormEn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmBatteryDetailEn = class(TForm)
    Image1: TImage;
    detailTimer: TTimer;
    imgBattery: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    imgDetailOK: TImage;
    lblTypeName: TLabel;
    lblMaxSavingTime: TLabel;
    lblWatingTime: TLabel;
    procedure imgDetailOKMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgDetailOKMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgDetailOKClick(Sender: TObject);
    procedure detailTimerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure setIconImage;
  public
    { Public declarations }
    batteryType: Byte;
    percent: Byte;
    maxSaveTime: Single;
    maxWaitTime: Single;
    catridgeID: Single;     
  end;

var
  frmBatteryDetailEn: TfrmBatteryDetailEn;
  maxSaveTime: Single;
  maxSaveTimeBattery: Single;
  maxSaveTimeFuelCell: Single;
  maxWaitTime: Single;
  maxWaitTimeBattery: Single;
  maxWaitTimeFuelCell: Single;
  imgDir: String;


implementation

uses uPM, uConstant, uBiosInterface, Batclass, uFuelTray, clsMain;

{$R uBatteryDetailFormEn.dfm}

procedure TfrmBatteryDetailEn.setIconImage;
begin
  if (percent>100) then percent := 100;
  if (batteryType = BATTERY_DETAIL_TYPE) then
  begin
    imgDisplayer.setBatteryPopupImage(imgBattery, percent);
  end
  else if (batteryType = FUELCELL_DETAIL_TYPE) then
  begin
    imgDisplayer.setFuelcellPopupImage(imgBattery, percent);
  end;

end;

procedure TfrmBatteryDetailEn.imgDetailOKMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgDetailOK.Left := imgDetailOK.Left + 1;
  imgDetailOK.Top := imgDetailOK.Top + 1;
end;

procedure TfrmBatteryDetailEn.imgDetailOKMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgDetailOK.Left := imgDetailOK.Left - 1;
  imgDetailOK.Top := imgDetailOK.Top - 1;

end;

procedure TfrmBatteryDetailEn.imgDetailOKClick(Sender: TObject);
begin
  detailTimer.Enabled := False;
  Close;
end;

procedure TfrmBatteryDetailEn.detailTimerTimer(Sender: TObject);
var
  iBatteryRemainCapa, iFuelCellRemainCapa: Single;

begin
  setIconImage;

  // SABI Interface 정보 (for Page 1)
  iBatteryRemainCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_REM_CAPA);
  iFuelCellRemainCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_REM_CAPA);

  //최대절전모드 방전 예상시간은 기본 전지 남은 잔량(remaining capacity)  / 상수(약 40)
  //<== 시간 나오고 /24 해서 일로 표시
  //대기모드 방전예상시간은 전체 전지 남은 잔량(remaining capacity) / 상수(약 500)
  //<== 시간 나옴 / 그대로 표시
  (*maxSaveTime: Word;
  maxSaveTimeBattery: Word;
  maxSaveTimeFuelCell: Word;
  maxWaitTime: Word;
  maxWaitTimeBattery: Word;
  maxWaitTimeFuelCell: Word;*)
  if (batteryType = BATTERY_DETAIL_TYPE) then
  begin
    maxSaveTimeBattery := iBatteryRemainCapa / 40;
    maxSaveTime := maxSaveTimeBattery /24;
    lblMaxSavingTime.Caption := Format('%3.0f', [maxSaveTime]) + ' Days';

    maxWaitTimeBattery := iBatteryRemainCapa / 500;
    maxWaitTime := maxWaitTimeBattery;

    lblWatingTime.Caption := Format('%3.0f', [maxWaitTime]) + 'Hours';

  end
  else if (batteryType = FUELCELL_DETAIL_TYPE) then
  begin
    maxSaveTimeFuelCell := iFuelCellRemainCapa / 40;
    maxSaveTime := maxSaveTimeFuelCell/24;
    lblMaxSavingTime.Caption := Format('%3.0f', [maxSaveTime]) + ' Days';

    maxWaitTimeFuelCell := iFuelCellRemainCapa / 500;
    maxWaitTime := maxWaitTimeFuelCell;

    lblWatingTime.Caption := Format('%3.0f', [maxWaitTime]) + ' Hours';

  end;


end;

procedure TfrmBatteryDetailEn.FormActivate(Sender: TObject);
begin
  Label2.Caption := 'Current Power Source Type :  ';
  Label3.Caption := 'Residual Time in Sleep Mode : ';
  Label6.Caption := 'Residual Time in Stand-by Mode: ';


  detailTimer.Enabled := True;
  if (batteryType = BATTERY_DETAIL_TYPE) then
    lblTypeName.Caption := 'Li-Ion Battery'
  else if (batteryType = FUELCELL_DETAIL_TYPE) then
    lblTypeName.Caption := 'Fuel Cell';

  setIconImage;

  detailTimerTimer(self);

end;

end.
