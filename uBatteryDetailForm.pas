unit uBatteryDetailForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmBatteryDetail = class(TForm)
    Image1: TImage;
    detailTimer: TTimer;
    imgBattery: TImage;
    lblTypeNameTitle: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    imgDetailOK: TImage;
    lblTypeName: TLabel;
    lblMaxSavingTime: TLabel;
    lblWatingTime: TLabel;
    lblFuelCellIDTitle: TLabel;
    lblDensityandCapaTitle: TLabel;
    lblFuelCellID: TLabel;
    lblDensityandCapa: TLabel;
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
    iDensity: Single;
    iCapac: Single;
  end;

var
  frmBatteryDetail: TfrmBatteryDetail;
  maxSaveTime: Single;
  maxSaveTimeBattery: Single;
  maxSaveTimeFuelCell: Single;
  maxWaitTime: Single;
  maxWaitTimeBattery: Single;
  maxWaitTimeFuelCell: Single;
  imgDir: String;


implementation

uses uPM, uConstant, uBiosInterface, Batclass, uFuelTray, clsMain;

{$R *.dfm}

procedure TfrmBatteryDetail.setIconImage;
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

procedure TfrmBatteryDetail.imgDetailOKMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgDetailOK.Left := imgDetailOK.Left + 1;
  imgDetailOK.Top := imgDetailOK.Top + 1;
end;

procedure TfrmBatteryDetail.imgDetailOKMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgDetailOK.Left := imgDetailOK.Left - 1;
  imgDetailOK.Top := imgDetailOK.Top - 1;

end;

procedure TfrmBatteryDetail.imgDetailOKClick(Sender: TObject);
begin
  detailTimer.Enabled := False;
  Close;
end;

procedure TfrmBatteryDetail.detailTimerTimer(Sender: TObject);
var
  iBatteryRemainCapa, iFuelCellRemainCapa: Single;

begin
  setIconImage;

  iBatteryRemainCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_REM_CAPA);
  iFuelCellRemainCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_REM_CAPA);

  if (batteryType = BATTERY_DETAIL_TYPE) then
  begin
    maxSaveTimeBattery := iBatteryRemainCapa / 40;
    maxSaveTime := maxSaveTimeBattery /24;
{$IFDEF EN}
    lblMaxSavingTime.Caption := Format('%3.0f', [maxSaveTime]) + ' Days';
{$ELSE}
    lblMaxSavingTime.Caption := Format('%3.0f', [maxSaveTime]) + ' 일';
{$ENDIF}
    maxWaitTimeBattery := iBatteryRemainCapa / 500;
    maxWaitTime := maxWaitTimeBattery;
{$IFDEF EN}
    lblWatingTime.Caption := Format('%3.0f', [maxWaitTime]) + 'Hours';
{$ELSE}
    lblWatingTime.Caption := Format('%3.0f', [maxWaitTime]) + '시간';
{$ENDIF}

  end
  else if (batteryType = FUELCELL_DETAIL_TYPE) then
  begin
    maxSaveTimeFuelCell := iFuelCellRemainCapa / 40;
    maxSaveTime := maxSaveTimeFuelCell/24;
{$IFDEF EN}
    lblMaxSavingTime.Caption := Format('%3.0f', [maxSaveTime]) + ' Days';
{$ELSE}
    lblMaxSavingTime.Caption := Format('%3.0f', [maxSaveTime]) + ' 일';
{$ENDIF}

    maxWaitTimeFuelCell := iFuelCellRemainCapa / 500;
    maxWaitTime := maxWaitTimeFuelCell;
{$IFDEF EN}
    lblWatingTime.Caption := Format('%3.0f', [maxWaitTime]) + 'Hours';
{$ELSE}
    lblWatingTime.Caption := Format('%3.0f', [maxWaitTime]) + '시간';
{$ENDIF}    
  end;


end;

procedure TfrmBatteryDetail.FormActivate(Sender: TObject);
var
  catId: Integer;
  sDensity: String;

{$IFDEF EN}
  curImgFile: String;
  imgDir: String;
{$ENDIF}

begin
{$IFDEF EN}
  Caption := 'Detail Information';

  lblTypeNameTitle.Caption := 'Current Power Source Type :  ';
  lblFuelCellIDTitle.Caption := 'FuelCell ID :  ';
  lblDensityandCapaTitle.Caption := 'Density / Capacity : ';

  Label3.Caption := 'Residual Time in Sleep Mode : ';
  Label6.Caption := 'Residual Time in Stand-by Mode: ';

  if (imgDir = '') then imgDir :=  Copy(Application.ExeName, 1, getLastCharPos(Application.ExeName, '\')-1);
  if (strEndsWith(imgDir, '\')) then
    imgDir := Copy(imgDir, 1, Length(imgDir)-1);

  curImgFile := imgDir+'\images\en\base\back_detail.bmp';
  Image1.Picture.LoadFromFile(curImgFile);
  ImgDetailOK.Picture.LoadFromFile(imgDir+'\images\en\button\btn_ok.bmp');
  detailTimer.Enabled := True;
  if (batteryType = BATTERY_DETAIL_TYPE) then
  begin
    lblTypeName.Caption := 'Li-Ion Battery';

    lblTypeName.Visible := true;
    lblTypeNameTitle.Visible := true;
    lblTypeName.Top := lblFuelCellID.Top;
    lblTypeNameTitle.Top := lblFuelCellIDTitle.Top;

    lblFuelCellIDTitle.Visible := false;
    lblFuelCellID.Visible := false;
    lblDensityandCapaTitle.Visible := false;
    lblDensityandCapa.Visible := false;
    
  end
  else if (batteryType = FUELCELL_DETAIL_TYPE) then
  begin
    lblTypeName.Caption := 'Fuel Cell';
    lblTypeNameTitle.Visible := false;
    lblTypeName.Visible := false;
    
    catID := FloatToInteger(catridgeID);
    lblFuelCellID.Caption := 'FC43' + IntToStr(catID);

    sDensity := Format('%5.1f', [iDensity / 10])+' mol / ';
    sDensity := sDensity +  Format('%5.0f', [iCapac])+ ' cc';

    lblDensityandCapa.Caption := sDensity;

  end;

{$ELSE}
  detailTimer.Enabled := True;
  if (batteryType = BATTERY_DETAIL_TYPE) then
  begin
    lblTypeName.Caption := '보조전지';

    lblTypeName.Visible := true;
    lblTypeNameTitle.Visible := true;
    lblTypeName.Top := lblFuelCellID.Top;
    lblTypeNameTitle.Top := lblFuelCellIDTitle.Top;

    lblFuelCellIDTitle.Visible := false;
    lblFuelCellID.Visible := false;
    lblDensityandCapaTitle.Visible := false;
    lblDensityandCapa.Visible := false;
    
  end
  else if (batteryType = FUELCELL_DETAIL_TYPE) then
  begin
    lblTypeName.Caption := '연료전지';
    lblTypeNameTitle.Visible := false;
    lblTypeName.Visible := false;

    catID := FloatToInteger(catridgeID);
    lblFuelCellID.Caption := 'FC43' + IntToStr(catID);
    sDensity := Format('%7.1f', [iDensity / 10])+' mol / ';
    sDensity := sDensity + Format('%7.0f', [iCapac])+ ' cc';
    lblDensityandCapa.Caption := sDensity;

  end;

{$ENDIF}

  setIconImage;

  detailTimerTimer(self);

end;

end.
