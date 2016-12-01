unit uPM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList, uBiosInterface, BIDisplayer,
  TrayIcon, Menus, jpeg, ActnList, uRoleOverImage;

type
  TfrmPM = class(TForm)
    mainTimer: TTimer;
    FlashTimer: TTimer;
    lblPowerPercent: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    lblMaxWaitTime: TLabel;
    lblCurrentPowerType: TLabel;
    lblBatteryRemain: TLabel;
    Label27: TLabel;
    lblFuelCellRemain: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    lblTotalRemTime: TLabel;
    lblTotalRemMin: TLabel;
    lblACNotice: TLabel;
    lblMaxSaveTime: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Panel9: TPanel;
    TI0: TImage;
    TI1: TImage;
    TI2: TImage;
    TI3: TImage;
    Image2: TImage;
    Image3: TImage;
    pnlOKButton: TPanel;
    lblNPCW: TLabel;
    Label10: TLabel;
    lblNPCV: TLabel;
    Label11: TLabel;
    lblNPCA: TLabel;
    Label12: TLabel;
    lblBatteryW: TLabel;
    Label14: TLabel;
    lblBatteryV: TLabel;
    Label9: TLabel;
    lblBatteryA: TLabel;
    Label8: TLabel;
    lblFuelW: TLabel;
    Label32: TLabel;
    lblFuelV: TLabel;
    Label30: TLabel;
    lblFuelA: TLabel;
    Label29: TLabel;
    img_Battery: TImage;
    img_Fuel: TImage;
    TimerAlerterIcon: TTimer;
    TimerAlerter: TTimer;
    imgFuelStatus: TRollOverImage;
    imgBatteryStatus: TRollOverImage;
    imgOK: TRollOverImage;
    lblColonUp: TLabel;
    lblColonDown: TLabel;
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mainTimerTimer(Sender: TObject);
    procedure FlashTimerTimer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerAlerterTimer(Sender: TObject);
    procedure TimerAlerterIconTimer(Sender: TObject);
    procedure imgFuelStatusClick(Sender: TObject);
    procedure imgBatteryStatusClick(Sender: TObject);
    procedure imgFuelStatusMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgFuelStatusMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgBatteryStatusMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgBatteryStatusMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgOKMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOKMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
//    procedure WndProc(var Message : TMessage); override;
    procedure setSelectedPage;
    procedure init;

  public
    { Public declarations }
    
    isDetailClosed: Boolean;   // prevent exception while opened detail form.
  end;

  TDirection = (tdRight, tdLeft, tdUp, tdDown);
  TDrawer = class(TObject)
    r: TRect;
    backColor: TColor;
    gridColor: TColor;
    lineColor: TColor;
    vMeasure: Integer; // for value
    hMeasure: Integer; // for value
    vlineNo: Integer;  // for just grid line
    hlineNo: Integer;  // for just grid line
    direction: TDirection;
    min: Integer;
    max: Integer;
    list: array[1..100] of Integer;
    oldlist: array[1..100] of Integer;

    constructor Create;
    destructor Destroy; override;

    procedure drawGrid(c: TCanvas);
    procedure drawGraph(c: TCanvas);
    procedure addValue(v: Integer);

  end;

var
  frmPM: TfrmPM;
  imgDisplayer: TBIDisplayer;

// by Kim DongRak (20060515:10:24)
//최대절전모드 방전 예상시간은 기본 전지 남은 잔량(remaining capacity) / 상수(약 40)
//<== 시간 나오고 /24 해서 일로 표시
//대기모드 방전예상시간은 전체 전지 남은 잔량(remaining capacity) / 상수(약 500)
//<== 시간 나옴 / 그대로 표시
// 총 사용가능 시간  NPC(남은 용량 합한 것 (mA/h)  (1-2A - 2page의 시스템 출력 * 1000) > 시간(0.5 면 30분) 
  maxSaveTime: Single;
  maxSaveTimeBattery: Single;
  maxSaveTimeFuelCell: Single;
  maxWaitTime: Single;
  maxWaitTimeBattery: Single;
  maxWaitTimeFuelCell: Single;

  //
  iBatteryPercent, iFuelCellPercent: Single;
  // for ani image
  ani_index: Byte;
  // for identifying selected page (if true, 1 page clicked, other then 2 page clicked)
  b: Boolean;
  // to identify first creation of this form
  isFirst: boolean;


  // SABI variable (For page 2)
  inpcVolt, inpcCurr, iBattVolt, iBattCurr, iFuelVolt, iFuelCurr: Double;
  iNpcDetailPercent, iBatteryDetailPercent, iFuelCellDetailPercent: Double;

  // Alert Type
  alertType: Byte;  // 1 - battery alert, 2 - fuel alert, 3 - system alert, 0 - normal


implementation

uses SABI, clsMain, Batclass, uBatteryDetailForm, uConstant, uFuelTray,
  uBatteryDetailFormEn, uLogLocation, uMainOption, uAlert;

var
  sysDrawer: TDrawer;
  fuelDrawer: TDrawer;
  battDrawer: TDrawer;


{$R *.dfm}


constructor TDrawer.Create;
var
  i: Integer;
begin
  inherited;

  for i := 1 to High(list) do
  begin
    list[i] := 0;
  end;
end;

destructor TDrawer.Destroy;
begin
  inherited;
end;

procedure TDrawer.addValue(v: Integer);
var
  i: Integer;
begin
  for i := 1 to High(list)-1 do
  begin
    list[i] := list[i+1];
  end;
  list[High(list)] := v;

end;

procedure TDrawer.drawGrid;
var
  vdis: Integer;
  hdis: Integer;
  i: Integer;
begin
  c.Pen.Style := psSolid;
  c.Pen.Color := gridcolor;
  c.Pen.Width := 1;
  c.Pen.Mode := pmCopy;

  hdis := (r.Bottom - r.Top) div vlineNo;
  vdis := (r.Right - r.Left) div hlineNo;

  i:=0;
  while true do
  begin
    Inc(i);
    if r.Bottom < r.Top + round(vdis*(i)) then break;
    c.MoveTo(r.Left, r.Top + round(vdis*(i)));
    c.LineTo(r.Right, r.Top + round(vdis*(i)));
  end;

  i := 0;
  while true do
  begin
    Inc(i);
    if r.Right < r.Left + round(hdis*(i)) then break;
    c.MoveTo(r.Left+round(hdis*(i)), r.Top);
    c.LineTo(r.Left+round(hdis*(i)), r.Bottom);
  end;

end;

procedure TDrawer.drawGraph(c: TCanvas);
var
  hdis: Integer;
  i: Integer;
  px, py, nx, ny: Integer;
begin
  clearRect(c, r);
  drawGrid(c);
  // new line create
  c.Pen.Style := psSolid;
  c.Pen.Color := lineColor;
  c.Pen.Width := 1;
  c.Pen.Mode := pmCopy;

  hdis := (r.Bottom - r.Top) div vlineNo;

  for i := High(list) downto 1 do
  begin
    if r.Left+round(hdis*(High(list)-i+1)) > r.Right then break;
    px := r.Left+round(hdis*(High(list)-i));
    py := r.Bottom - round(list[i]*(r.Bottom-r.Top)/(max-min));
    nx := r.Left+round(hdis*(High(list)-i+1));
    ny := r.Bottom - round(list[i-1]*(r.Bottom-r.Top)/(max-min));

    c.MoveTo(px, py);
    c.LineTo(nx, ny);
  end;

end;

procedure TfrmPM.setSelectedPage;
begin
  if b then  // 1st page selected
  begin
{$IFDEF EN}
    imgDisplayer.setImage(frmPM.GetClientRect, '\images\en\base\back.bmp', TForm(frmPM));
{$ELSE}
    imgDisplayer.setImage(frmPM.GetClientRect, '\images\kr\base\back.bmp', TForm(frmPM));
{$ENDIF}

//    lblPowerPercent.Visible := true;
//    lblTotalRemTime.Visible := true;
//    lblTotalRemMin.Visible := true;
//    lblACNotice.Visible := true;      // conditional
    lblBatteryRemain.Visible := true;
    Label27.Visible := true;
    lblFuelCellRemain.Visible := true;
    Label33.Visible := true;
    Panel6.Visible := true;
    Panel7.Visible := true;
    Panel8.Visible := true;
    Panel9.Visible := true;

//    Label36.Visible := true;       // 20061030 요청 (by 유재우)
    lblCurrentPowerType.Visible := true;  // conditional
    lblMaxSaveTime.Visible := true;
    lblMaxWaitTime.Visible := true;

    Label3.Visible := true;  // 최대절전모드 방전 예상시간
    Label6.Visible := true;  // 대기모드 유지 예상시간
    Label34.Visible := true; // 각 건전지의 더 자세한 정보를 보시려면
    Label35.Visible := true; // 해당 전지의 아이콘을 클릭 하세요

    Label2.Visible := true;

    imgFuelStatus.Visible := true;
    imgBatteryStatus.Visible := true;

    // 2nd page controls
    lblNPCW.Visible := false;
    Label10.Visible := false;
    lblNPCV.Visible := false;
    Label11.Visible := false;
    lblNPCA.Visible := false;
    Label12.Visible := false;
    lblFuelV.Visible := false;
    Label30.Visible := false;
    lblFuelA.Visible := false;
    Label29.Visible := false;
    lblFuelW.Visible := false;
    Label32.Visible := false;
    lblBatteryV.Visible := false;
    Label9.Visible := false;
    lblBatteryA.Visible := false;
    Label8.Visible := false;
    lblBatteryW.Visible := false;
    Label14.Visible := false;

    img_Fuel.Visible := false;
    img_Battery.Visible := false;


  end
  else  // 2nd page selected
  begin
{$IFDEF EN}
    imgDisplayer.setImage(frmPM.GetClientRect, '\images\en\base\back2.bmp', TForm(frmPM));
{$ELSE}
    imgDisplayer.setImage(frmPM.GetClientRect, '\images\kr\base\back2.bmp', TForm(frmPM));
{$ENDIF}

    // 1st page controls
//    lblPowerPercent.Visible := false;
    lblTotalRemTime.Visible := false;
    lblColonUp.Visible := false;
    lblColonDown.Visible := false;
    lblTotalRemMin.Visible := false;
    lblACNotice.Visible := false;      // conditional
    lblBatteryRemain.Visible := false;
    Label27.Visible := false;
    lblFuelCellRemain.Visible := false;
    Label33.Visible := false;
    Panel6.Visible := false;
    Panel7.Visible := false;
    Panel8.Visible := false;
    Panel9.Visible := false;

//    Label36.Visible := false;  // 20061030 by 유재우
    lblCurrentPowerType.Visible := false;  // conditional
    lblMaxSaveTime.Visible := false;
    lblMaxWaitTime.Visible := false;

    Label3.Visible := false;  // 최대절전모드 방전 예상시간
    Label6.Visible := false;  // 대기모드 유지 예상시간
    Label34.Visible := false; // 각 건전지의 더 자세한 정보를 보시려면
    Label35.Visible := false; // 해당 전지의 아이콘을 클릭 하세요

    Label2.Visible := false;

    imgFuelStatus.Visible := false;
    imgBatteryStatus.Visible := false;

    // 2nd page controls
    lblNPCW.Visible := true;
    Label10.Visible := true;
    lblNPCV.Visible := true;
    Label11.Visible := true;
    lblNPCA.Visible := true;
    Label12.Visible := true;
    lblFuelV.Visible := true;
    Label30.Visible := true;
    lblFuelA.Visible := true;
    Label29.Visible := true;
    lblFuelW.Visible := true;
    Label32.Visible := true;
    lblBatteryV.Visible := true;
    Label9.Visible := true;
    lblBatteryA.Visible := true;
    Label8.Visible := true;
    lblBatteryW.Visible := true;
    Label14.Visible := true;

    img_Fuel.Visible := true;
    img_Battery.Visible := true;


//    sysDrawer.addValue(round(inpcVolt * inpcCurr));
//    fuelDrawer.addValue(round(iFuelVolt * iFuelCurr));
//    battDrawer.addValue(round(ibattVolt * ibattCurr));

    if (round(inpcVolt * inpcCurr) > sysDrawer.max) then
      sysDrawer.addValue(sysDrawer.max)
    else
      sysDrawer.addValue(round(inpcVolt * inpcCurr));

    if (round(iFuelVolt * iFuelCurr) > fuelDrawer.max) then
      fuelDrawer.addValue(fuelDrawer.max)
    else
      fuelDrawer.addValue(round(iFuelVolt * iFuelCurr));

    if (round(ibattVolt * ibattCurr) > battDrawer.max) then
      battDrawer.addValue(battDrawer.max)
    else
      battDrawer.addValue(round(ibattVolt * ibattCurr));

    sysDrawer.drawGrid(self.Canvas);
    fuelDrawer.drawGrid(self.Canvas);
    battDrawer.drawGrid(self.Canvas);
  end;
end;

(*
procedure TfrmPM.WndProc(var Message : TMessage);
begin
  if Message.LParam = Longint(imgBatteryStatus) then
  begin
    if (Message.Msg = CM_MOUSELEAVE) then
    begin
        imgDisplayer.setBatteryImage(imgBatteryStatus, StrToInt(Format('%3.0f', [iBatteryPercent])), true);
    end;
    if (Message.Msg = CM_MOUSEENTER) then
    begin
      imgDisplayer.setBatteryImage(imgBatteryStatus, StrToInt(Format('%3.0f', [iBatteryPercent])), false);
    end;

 end;

  if Message.LParam = Longint(imgFuelStatus) then
  begin
    if (Message.Msg = CM_MOUSELEAVE) then
    begin
      imgDisplayer.setFuelImage(imgFuelStatus, StrToInt(Format('%3.0f', [iFuelCellPercent])), false);
    end;

    if (Message.Msg = CM_MOUSEENTER) then
    begin
      imgDisplayer.setFuelImage(imgFuelStatus, StrToInt(Format('%3.0f', [iFuelCellPercent])), true);
    end;
  end;


   inherited WndProc(Message);
end;
*)

procedure TfrmPM.Image2Click(Sender: TObject);
begin
  frmPM.Canvas.Lock;
  Image2.Picture := TI0.Picture;
  Image3.Picture := TI3.Picture;

  b := true;

  if Image2.Tag = 0 then setSelectedPage;

  Image2.Tag := 1;
  Image3.Tag := 0;

  mainTimerTimer(self);

  flashTimer.Enabled := true;
  flashTimerTimer(self);


  frmPM.Canvas.Unlock;


end;

procedure TfrmPM.Image3Click(Sender: TObject);
var
  // SABI variable
  inpcVolt, inpcCurr, iBattVolt, iBattCurr, iFuelVolt, iFuelCurr: Single;
begin

  flashTimer.Enabled := false;

  frmPM.Canvas.Lock;

  inpcVolt := biManager.getBatteryData(NOTEVOLT);
  inpcCurr := biManager.getBatteryData(NOTECURR);
  ibattVolt := biManager.getBatteryData(BATTVOLT);
  ibattCurr := biManager.getBatteryData(BATTCURR);
  iFuelVolt := biManager.getBatteryData(FUELVOLT);
  iFuelCurr := biManager.getBatteryData(FUELCURR);

  if GetACLineStatus then
  begin
    inpcVolt := 0.0;
    inpcCurr := 0.0;
    ibattVolt := 0.0;
    ibattCurr := 0.0;
    iFuelVolt := 0.0;
    iFuelCurr := 0.0;

    sysDrawer.addValue(0);
    fuelDrawer.addValue(0);
    battDrawer.addValue(0);
    
  end;

  // SABI Interface 정보  (Page 2)
  lblNPCV.Caption := Format('%2.1f', [inpcVolt]);//IntToStr(inpcVolt);
  lblNPCA.Caption := Format('%2.1f', [inpcCurr]);//IntToStr(inpcCurr);

  lblBatteryV.Caption := Format('%2.1f', [ibattVolt]);//IntToStr(ibattVolt);
  lblBatteryA.Caption := Format('%2.1f', [ibattCurr]);//IntToStr(ibattCurr);
  lblFuelV.Caption := Format('%2.1f', [iFuelVolt]);//IntToStr(iFuelVolt);
  lblFuelA.Caption := Format('%2.1f', [iFuelCurr]);//IntToStr(iFuelCurr);

  lblNPCW.Caption := Format('%2.1f', [inpcVolt*inpcCurr]);//IntToStr(inpcVolt * inpcCurr);
  lblBatteryW.Caption := Format('%2.1f', [ibattVolt*ibattCurr]);//IntToStr(ibattVolt * ibattCurr);
  lblFuelW.Caption := Format('%2.1f', [iFuelVolt*iFuelCurr]);//IntToStr(iFuelVolt * iFuelCurr);

  Image2.Picture := TI1.Picture;
  Image3.Picture := TI2.Picture;

  b := false;

  if Image3.Tag = 0 then setSelectedPage;

  Image2.Tag := 0;
  Image3.Tag := 1;

  sysDrawer.drawGraph(self.Canvas);
  fuelDrawer.drawGraph(self.Canvas);
  battDrawer.drawGraph(self.Canvas);

  frmPM.Canvas.UnLock;

end;

procedure TfrmPM.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Left := Image2.Left + 1;
  Image2.Top := Image2.Top + 1;

  Image2.Height := Image2.Height - 1;
end;

procedure TfrmPM.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Left := Image2.Left - 1;
  Image2.Top := Image2.Top - 1;
  Image2.Height := Image2.Height + 1;

end;

procedure TfrmPM.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Left := Image3.Left + 1;
  Image3.Top := Image3.Top + 1;

  Image3.Height := Image3.Height - 1;

end;

procedure TfrmPM.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Left := Image3.Left - 1;
  Image3.Top := Image3.Top - 1;

  Image3.Height := Image3.Height + 1;
end;

procedure TfrmPM.CheckBox1Click(Sender: TObject);
begin
  if (CheckBox1.Checked) then
  begin
    updateRegValue('showTrayIcon', '1');
    changeRegValue('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run','SSFuelCell', Application.ExeName);
    frmFuelTray.SSTray.Active := true;
  end
  else
  begin
    updateRegValue('showTrayIcon', '0');
    changeRegValue('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', 'SSFuelCell', '');
    frmFuelTray.SSTray.Active := false;
  end;
end;

procedure TfrmPM.CheckBox2Click(Sender: TObject);
begin
  if (CheckBox2.Checked) then // 각각 Cell 보이기
  begin
    updateRegValue('showEachBattery', '1');
  end else begin
    updateRegValue('showEachBattery', '0');
  end;

end;

procedure TfrmPM.Button1Click(Sender: TObject);
var
  handleDevInfo: HDEVINFO;
  b: Boolean;
  d: Boolean;
  i: Integer;
  data: SP_DEVICE_INTERFACE_DATA;
  detail: SP_DEVICE_INTERFACE_DETAIL_DATA;

  requiredSize: DWORD;
  lastError: DWORD;
begin

  //0x72631e54L, 0x78A4, 0x11d0, 0xbc, 0xf7, 0x00, 0xaa, 0x00, 0xb7, 0xb3, 0x2a
  GUID_DEVICE_BATTERY.D1 := $72631e54;
  GUID_DEVICE_BATTERY.D2 := $78A4;
  GUID_DEVICE_BATTERY.D3 := $11d0;
  GUID_DEVICE_BATTERY.D4[0] := $bc;
  GUID_DEVICE_BATTERY.D4[1] := $f7;
  GUID_DEVICE_BATTERY.D4[2] := $00;
  GUID_DEVICE_BATTERY.D4[3] := $aa;
  GUID_DEVICE_BATTERY.D4[4] := $00;
  GUID_DEVICE_BATTERY.D4[5] := $b7;
  GUID_DEVICE_BATTERY.D4[6] := $b3;
  GUID_DEVICE_BATTERY.D4[7] := $2a;


  handleDevInfo := SetupDiGetClassDevs(
    @GUID_DEVICE_BATTERY,
    nil,
    0,
    DIGCF_PRESENT or DIGCF_DEVICEINTERFACE
  );

  if (handleDevInfo = 0) then
  begin
    // Insert error handling here.

  end;

  data.cbSize := sizeof(SP_DEVICE_INTERFACE_DATA);

  i := 0;

  while true do
  begin
    b := SetupDiEnumDeviceInterfaces (
      handleDevInfo,
      nil,
      @GUID_DEVICE_BATTERY,
      i,
      @data
    );
    
    inc(i);

    if (not b) then break;

(*
  DeviceInfoSet: HDEVINFO;
  DeviceInterfaceData: PSP_DEVICE_INTERFACE_DATA;
  DeviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  DeviceInterfaceDetailDataSize: DWORD;
  RequiredSize: PDWORD;
  DeviceInfoData: PSP_DEVINFO_DATA

*)

    //offsetof( SP_DEVICE_INTERFACE_DETAIL_DATA, DevicePath) + sizeof(TCHAR)
    //detaillength := sizeof(TCHAR);

   d := SetupDiGetDeviceInterfaceDetailW(
      handleDevInfo,
      @data,
      nil,
      0,
      @requiredSize,
      nil
    );
    if (not d) then
    begin
      lastError := GetLastError; //ERROR_INVALID_USER_BUFFER  1784 The supplied user buffer is not valid for the requested operation.
      ShowMessage(IntToStr(lastError));
    end;

    //detail.cbSize := sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);
(*    Do not do this:
detailData.cbSize =Marshal.SizeOf(typeof
(Win32Methods.SP_DEVICE_INTERFACE_DETAIL_DATA));

Marshal.SizeOf returns a size of 8 for the struct which is
not what the setupapi is expecting. The setupapi expects
the original size of the struct. Looking at the header
files in the DDK, I calculated the size to be 5 for the
ANSI version of the function and 6 for the Unicode.

That's what was hanging me up. I forgot I was calling the
Unicode version.

Regards,
Kevin
*)
    detail.cbSize := 6;
    d := SetupDiGetDeviceInterfaceDetailW(
      handleDevInfo,
      @data,
      @detail,
      requiredSize,
      nil,
      nil
    );

    if (not d) then
    begin
      lastError := GetLastError; //ERROR_INVALID_USER_BUFFER  1784 The supplied user buffer is not valid for the requested operation.
      ShowMessage(IntToStr(lastError));
    end else
    begin
      ShowMessage(detail.DevicePath);
    end;
    //devPath := ^detail.DevicePath;
//    devicePath := devPath;
//    ShowMessage(devicePath);


  end;

end;

procedure TfrmPM.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  mainTimer.Enabled := false;
  flashTimer.Enabled := false;
  TimerAlerterIcon.Enabled := false;
  TimerAlerter.Enabled := false;

  sysDrawer.Free;
  fuelDrawer.Free;
  battDrawer.Free;

  sysDrawer := nil;
  fuelDrawer := nil;
  battDrawer := nil;

  if (imgDisplayer <> nil) then
  begin
    imgDisplayer.Free;
    imgDisplayer := nil;
  end;
{
  if (frmFuelTray <> nil) then
  begin
    frmFuelTray.Free;
    frmFuelTray := nil;
  end;
}  

end;

procedure TfrmPM.mainTimerTimer(Sender: TObject);
var
  // SABI variable (For page 1)
  iBatteryFullCapa, iBatteryRemainCapa, iFuelCellFullCapa, iFuelCellRemainCapa: Single;
  // Total Cell Info (for Page 1)
  fullRemTime: Extended;
  hour, min: Single;
  batteryLifePercent: Word;
  batteryLifePercent2: Single;
  ihour, imin: Integer;
begin

  inpcVolt := biManager.getBatteryData(NOTEVOLT);
  inpcCurr := biManager.getBatteryData(NOTECURR);
  ibattVolt := biManager.getBatteryData(BATTVOLT);
  ibattCurr := biManager.getBatteryData(BATTCURR);
  iFuelVolt := biManager.getBatteryData(FUELVOLT);
  iFuelCurr := biManager.getBatteryData(FUELCURR);

  // SABI Interface 정보 (for Page 1)
  iBatteryFullCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_FULL_CAPA);
  iBatteryRemainCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_REM_CAPA);
  iFuelCellFullCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_FULL_CAPA);
  iFuelCellRemainCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_REM_CAPA);


      try
        //총사용가능시간=(기본전지잔량+연료전지잔량)/(시스템 출력의 Amphere*1000)
        if (inpcCurr <=0) then inpcCurr := 0.0001;
        fullRemTime := ((iBatteryRemainCapa+iFuelCellRemainCapa)/(inpcCurr*1000))*60*60;
      except
      end;

      if (fullRemTime >= 3600) then
      begin
        min := fullRemTime / 60;
        hour := min / 60;
        ihour := getIntegerFromFloat(hour);
        min := min - ihour*60;
        imin := getIntegerFromFloat(min);

        lblTotalRemTime.Caption := IntToStr(ihour);//Format('%3.0f', [hour]);//IntToStr(hour);//;  //Zero_Str(int, len: integer)
        lblTotalRemMin.Caption := Zero_Str(imin, 2);
      end else if (fullRemTime < 3600) then
      begin
        min := fullRemTime / 60;
        imin := getIntegerFromFloat(min);
        lblTotalRemTime.Caption := '00';
        lblTotalRemMin.Caption := Zero_Str(imin, 2);
      end;




  // prevent dividing by 0
  if iBatteryFullCapa <= 0 then iBatteryFullCapa := 1;
  if iFuelCellFullCapa <= 0 then iFuelCellFullCapa := 1;

  iBatteryPercent := (iBatteryRemainCapa / iBatteryFullCapa) * 100;
  if (iBatteryPercent > 100) then iBatteryPercent := 100;
  iFuelCellPercent := (iFuelCellRemainCapa / iFuelCellFullCapa) * 100;
  if (iFuelCellPercent > 100) then iFuelCellPercent := 100;
  
  if b then
  begin
    // SABI Interface 정보 (for Page 2)
    lblNPCV.Caption := Format('%2.1f', [inpcVolt]);//IntToStr(inpcVolt);
    lblNPCA.Caption := Format('%2.1f', [inpcCurr]);//IntToStr(inpcCurr);
    lblBatteryV.Caption := Format('%2.1f', [ibattVolt]);//IntToStr(ibattVolt);
    lblBatteryA.Caption := Format('%2.1f', [ibattCurr]);//IntToStr(ibattCurr);
    lblFuelV.Caption := Format('%2.1f', [iFuelVolt]);//IntToStr(iFuelVolt);
    lblFuelA.Caption := Format('%2.1f', [iFuelCurr]);//IntToStr(iFuelCurr);

    lblNPCW.Caption := Format('%5.1f', [inpcVolt * inpcCurr]);//IntToStr(inpcVolt * inpcCurr);
    lblBatteryW.Caption := Format('%5.1f', [ibattVolt * ibattCurr]);//IntToStr(ibattVolt * ibattCurr);
    lblFuelW.Caption := Format('%5.1f', [iFuelVolt * iFuelCurr]);//IntToStr(iFuelVolt * iFuelCurr);

    iNpcDetailPercent := inpcVolt * inpcCurr * 100 / 30; // maximum watt is 30w
    if (iNpcDetailPercent > 100) then iNpcDetailPercent := 100.0;

    iBatteryDetailPercent := ibattVolt * ibattCurr * 100 / 30;
    if (iBatteryDetailPercent > 100) then iBatteryDetailPercent := 100.0;

  {$IFDEF DEBUG}
    WriteLog('BatteryProgress', FloatToStr(iBatteryDetailPercent));
  {$ENDIF}

    iFuelCellDetailPercent := iFuelVolt * iFuelCurr * 100 / 30;
    if (iFuelCellDetailPercent > 100) then iFuelCellDetailPercent := 100.0;

  {$IFDEF DEBUG}
    WriteLog('FuelCellProgress', FloatToStr(iFuelCellDetailPercent));
  {$ENDIF}

//    imgDisplayer.setPowerDetailImage(img_NPC, StrToInt(Format('%3.0f', [iNpcDetailPercent])));
//    imgDisplayer.setFuelDetailImage(img_Fuel, StrToInt(Format('%3.0f', [iFuelCellDetailPercent])));
// move to setBatteryImage from setBatteryDetailImage
// move to setFuelImage from setFuelDetailImage
//    imgDisplayer.setBatteryImage(img_Battery, StrToInt(Format('%3.0f', [iBatteryDetailPercent])), false);
//    imgDisplayer.setFuelImage(img_Fuel, StrToInt(Format('%3.0f', [iFuelCellPercent])), false);

    lblBatteryRemain.Caption := Format('%3.0f', [iBatteryPercent]);
    lblFuelCellRemain.Caption := Format('%3.0f', [iFuelCellPercent]);
    imgDisplayer.setBatteryImage(imgBatteryStatus, StrToInt(Format('%3.0f', [iBatteryPercent])), false);

    //최대절전모드 방전 예상시간은 기본 전지 남은 잔량(remaining capacity)  / 상수(약 40)
    //<== 시간 나오고 /24 해서 일로 표시
    //대기모드 방전예상시간은 전체 전지 남은 잔량(remaining capacity) / 상수(약 500)
    //<== 시간 나옴 / 그대로 표시
    (*
    maxSaveTime: Word;
    maxSaveTimeBattery: Word;
    maxSaveTimeFuelCell: Word;
    maxWaitTime: Word;
    maxWaitTimeBattery: Word;
    maxWaitTimeFuelCell: Word;*)
    
    maxSaveTimeBattery := iBatteryRemainCapa / 40;
    maxSaveTimeFuelCell := iFuelCellRemainCapa / 40;
    maxSaveTime := (maxSaveTimeBattery + maxSaveTimeFuelCell)/24;
{$IFDEF EN}
    lblMaxSaveTime.Caption := Format('%3.0f', [maxSaveTime]) + ' Days';
{$ELSE}
    lblMaxSaveTime.Caption := Format('%3.0f', [maxSaveTime]) + ' 일';
{$ENDIF}
    maxWaitTimeBattery := iBatteryRemainCapa / 500;
    maxWaitTimeFuelCell := iFuelCellRemainCapa / 500;
    maxWaitTime := maxWaitTimeBattery + maxWaitTimeFuelCell;

{$IFDEF EN}
    lblMaxWaitTime.Caption := Format('%3.0f', [maxWaitTime]) + ' Hours';
{$ELSE}
    lblMaxWaitTime.Caption := Format('%3.0f', [maxWaitTime]) + '시간';
{$ENDIF}

    // by ryu jae woo
    if (iFuelCellPercent > 100) then
      iFuelCellPercent := 100.0;
    imgDisplayer.setFuelImage(imgFuelStatus, StrToInt(Format('%3.0f', [iFuelCellPercent])), false);

    // [+ 연료 전지] (lblCurrentPowerType) Visible 여부
    if (iFuelCurr > 0.2) then
    begin
{$IFDEF EN}
      lblCurrentPowerType.Caption := 'Fuel Cell + Li-Ion Battery';
{$ELSE}
      lblCurrentPowerType.Caption := '연료전지 + 보조전지';
{$ENDIF}
      lblCurrentPowerType.Visible := true;
      lblFuelCellRemain.Visible := true;
      Label33.Visible := true;
    //    Label31.Caption := '남은 전지 양   ';
    //  if (iFuelCellPercent > 100) then iFuelCellPercent := 100.0;
    //  imgDisplayer.setFuelImage(imgFuelStatus, StrToInt(Format('%3.0f', [iFuelCellPercent])), false);
    end
    else
    begin

//      iFuelCellRemainCapa := 0; // 0.2 이하면 연료전지 장착되지 않은 것으로 판단함.
{$IFDEF EN}
      lblCurrentPowerType.Caption := 'Li-Ion Battery';
{$ELSE}
      lblCurrentPowerType.Caption := '보조전지';
{$ENDIF}
      lblFuelCellRemain.Visible := false;
      Label33.Visible := false;
      //Label31.Caption := '장착되지 않음   ';
      //imgDisplayer.setFuelImage(imgFuelStatus, StrToInt(Format('%3.0f', [0.0])), false);  // by ryu jae woo
    end;

    // Total Cell Info (for Page 1)
//    fullRemTime := getBatteryRemainTime;
//    if (fullRemTime = $FFFFFFFF) then   // some battery device may return unknown value (ex: Toshiba battery)
    if getACLineStatus then
    begin
      lblACNotice.Visible := true;
      lblTotalRemTime.Visible := false;
      lblColonUp.Visible := false;
      lblColonDown.Visible := false;
      lblTotalRemMin.Visible := false;
    end else
    begin
      lblACNotice.Visible := false;
      lblTotalRemTime.Visible := true;
//      imgColon.Visible := true;
      lblColonUp.Visible := true;
      lblColonDown.Visible := true;
      lblTotalRemMin.Visible := true;
    end;
(*
      try
        //총사용가능시간=(기본전지잔량+연료전지잔량)/(시스템 출력의 Amphere*1000)
        if (inpcCurr <=0) then inpcCurr := 0.0001;
        fullRemTime := ((iBatteryRemainCapa+iFuelCellRemainCapa)/(inpcCurr*1000))*60*60;
      except
      end;

      if (fullRemTime >= 3600) then
      begin
        min := fullRemTime / 60;
        hour := min / 60;
        ihour := getIntegerFromFloat(hour);
        min := min - ihour*60;
        imin := getIntegerFromFloat(min);

        lblTotalRemTime.Caption := IntToStr(ihour);//Format('%3.0f', [hour]);//IntToStr(hour);//;  //Zero_Str(int, len: integer)
        lblTotalRemMin.Caption := Zero_Str(imin, 2);
      end else if (fullRemTime < 3600) then
      begin
        min := fullRemTime / 60;
        imin := getIntegerFromFloat(min);
        lblTotalRemTime.Caption := '00';
        lblTotalRemMin.Caption := Zero_Str(imin, 2);
      end;
*)
{
    iBatteryPercent := (iBatteryRemainCapa / iBatteryFullCapa)* 100;
    if (iBatteryPercent > 100) then iBatteryPercent := 100;
    iFuelCellPercent := (iFuelCellRemainCapa / iFuelCellFullCapa)* 100;
    if (iFuelCellPercent > 100) then iFuelCellPercent := 100;


    batteryLifePercent2 := (iBatteryRemainCapa+iFuelCellRemainCapa)/(iBatteryFullCapa+iFuelCellFullCapa)*100;
    batteryLifePercent := StrToInt(Format('%5.0f', [batteryLifePercent2]));
    if (batteryLifePercent > 100) then batteryLifePercent := 100;
}
  end
  else
  begin

    if getACLineStatus then // AC Line Use
    begin
      // SABI Interface 정보 (for Page 2)
      lblNPCV.Caption := Format('%2.1f', [0.0]);//IntToStr(inpcVolt);
      lblNPCA.Caption := Format('%2.1f', [0.0]);//IntToStr(inpcCurr);
      lblBatteryV.Caption := Format('%2.1f', [0.0]);//IntToStr(ibattVolt);
      lblBatteryA.Caption := Format('%2.1f', [0.0]);//IntToStr(ibattCurr);
      lblFuelV.Caption := Format('%2.1f', [0.0]);//IntToStr(iFuelVolt);
      lblFuelA.Caption := Format('%2.1f', [0.0]);//IntToStr(iFuelCurr);

      lblNPCW.Caption := Format('%5.1f', [0.0]);//IntToStr(inpcVolt * inpcCurr);
      lblBatteryW.Caption := Format('%5.1f', [0.0]);//IntToStr(ibattVolt * ibattCurr);
      lblFuelW.Caption := Format('%5.1f', [0.0]);//IntToStr(iFuelVolt * iFuelCurr);

      iNpcDetailPercent := inpcVolt * inpcCurr * 100 / 30; // maximum watt is 30w
      if (iNpcDetailPercent > 100) then iNpcDetailPercent := 100.0;

      iBatteryDetailPercent := ibattVolt * ibattCurr * 100 / 30;
      if (iBatteryDetailPercent > 100) then iBatteryDetailPercent := 100.0;
//    imgDisplayer.setProgressImage(imgBatteryProgress, iBatteryDetailPercent);

      iFuelCellDetailPercent := iFuelVolt * iFuelCurr * 100 / 30;
      if (iFuelCellDetailPercent > 100) then iFuelCellDetailPercent := 100.0;
//    imgDisplayer.setProgressImage(imgFuelCellProgress, iFuelCellDetailPercent);

//    imgDisplayer.setPowerDetailImage(img_NPC, StrToInt(Format('%3.0f', [iNpcDetailPercent])));
// iDetailBatteryPercent > iBatteryPercent로 수정   imgDisplayer.setBatteryDetailImage>imgDisplayer.setBatteryImage
// iDetailFuelCellPercent > iFuelCellPercent로 수정 imgDisplayer.setFuelDetailImage>imgDisplayer.setFuelImage
      imgDisplayer.setBatteryDetailImage(img_Battery, StrToInt(Format('%3.0f', [iBatteryPercent])));
      imgDisplayer.setFuelDetailImage(img_Fuel, StrToInt(Format('%3.0f', [iFuelCellPercent])));


(*
    try
      //총사용가능시간=(기본전지잔량+연료전지잔량)/(시스템 출력의 Amphere*1000)
      if (inpcCurr <=0) then inpcCurr := 0.0001;
        fullRemTime := ((iBatteryRemainCapa+iFuelCellRemainCapa)/(inpcCurr*1000))*60*60;
    except

    end;
*)
      sysDrawer.addValue(0);
      fuelDrawer.addValue(0);
      battDrawer.addValue(0);

      sysDrawer.drawGraph(self.Canvas);
      fuelDrawer.drawGraph(self.Canvas);
      battDrawer.drawGraph(self.Canvas);

    end
    else   //////  do not use AC Line
    begin
      // SABI Interface 정보 (for Page 2)
      lblNPCV.Caption := Format('%2.1f', [inpcVolt]);//IntToStr(inpcVolt);
      lblNPCA.Caption := Format('%2.1f', [inpcCurr]);//IntToStr(inpcCurr);
      lblBatteryV.Caption := Format('%2.1f', [ibattVolt]);//IntToStr(ibattVolt);
      lblBatteryA.Caption := Format('%2.1f', [ibattCurr]);//IntToStr(ibattCurr);
      lblFuelV.Caption := Format('%2.1f', [iFuelVolt]);//IntToStr(iFuelVolt);
      lblFuelA.Caption := Format('%2.1f', [iFuelCurr]);//IntToStr(iFuelCurr);

      lblNPCW.Caption := Format('%5.1f', [inpcVolt * inpcCurr]);//IntToStr(inpcVolt * inpcCurr);
      lblBatteryW.Caption := Format('%5.1f', [ibattVolt * ibattCurr]);//IntToStr(ibattVolt * ibattCurr);
      lblFuelW.Caption := Format('%5.1f', [iFuelVolt * iFuelCurr]);//IntToStr(iFuelVolt * iFuelCurr);

      iNpcDetailPercent := inpcVolt * inpcCurr * 100 / 30; // maximum watt is 30w
      if (iNpcDetailPercent > 100) then iNpcDetailPercent := 100.0;

      iBatteryDetailPercent := ibattVolt * ibattCurr * 100 / 30;
      if (iBatteryDetailPercent > 100) then iBatteryDetailPercent := 100.0;
//    imgDisplayer.setProgressImage(imgBatteryProgress, iBatteryDetailPercent);

      iFuelCellDetailPercent := iFuelVolt * iFuelCurr * 100 / 30;
      if (iFuelCellDetailPercent > 100) then iFuelCellDetailPercent := 100.0;
//    imgDisplayer.setProgressImage(imgFuelCellProgress, iFuelCellDetailPercent);

//    imgDisplayer.setPowerDetailImage(img_NPC, StrToInt(Format('%3.0f', [iNpcDetailPercent])));
// iDetailBatteryPercent > iBatteryPercent로 수정   imgDisplayer.setBatteryDetailImage>imgDisplayer.setBatteryImage
// iDetailFuelCellPercent > iFuelCellPercent로 수정 imgDisplayer.setFuelDetailImage>imgDisplayer.setFuelImage
      imgDisplayer.setBatteryDetailImage(img_Battery, StrToInt(Format('%3.0f', [iBatteryPercent])));
      imgDisplayer.setFuelDetailImage(img_Fuel, StrToInt(Format('%3.0f', [iFuelCellPercent])));


(*
    try
      //총사용가능시간=(기본전지잔량+연료전지잔량)/(시스템 출력의 Amphere*1000)
      if (inpcCurr <=0) then inpcCurr := 0.0001;
        fullRemTime := ((iBatteryRemainCapa+iFuelCellRemainCapa)/(inpcCurr*1000))*60*60;
    except

    end;
*)


      if (round(inpcVolt * inpcCurr) > sysDrawer.max) then
        sysDrawer.addValue(sysDrawer.max)
      else
        sysDrawer.addValue(round(inpcVolt * inpcCurr));

      if (round(iFuelVolt * iFuelCurr) > fuelDrawer.max) then
        fuelDrawer.addValue(fuelDrawer.max)
      else
        fuelDrawer.addValue(round(iFuelVolt * iFuelCurr));

      if (round(ibattVolt * ibattCurr) > battDrawer.max) then
        battDrawer.addValue(battDrawer.max)
      else
        battDrawer.addValue(round(ibattVolt * ibattCurr));

      sysDrawer.drawGraph(self.Canvas);
      fuelDrawer.drawGraph(self.Canvas);
      battDrawer.drawGraph(self.Canvas);
    end;
  end;

  // Alert - when battery volt goes below 6.6 v
  if (ibattVolt <= 6.6) then
  begin
    alertType := 1;
    if (not TimerAlerter.Enabled) then TimerAlerter.Enabled := true;
    if (not TimerAlerterIcon.Enabled) then TimerAlerterIcon.Enabled := true;
  end
  else
  begin
    alertType := 0;
    TimerAlerter.Enabled := false;
    TimerAlerterIcon.Enabled := false;
  end;

  // Alert - When fuel cell remain percentage goes below 10 %
  if (iFuelCellPercent <= 10) then
  begin
    alertType := 2;
    if (not TimerAlerter.Enabled) then TimerAlerter.Enabled := true;
    if (not TimerAlerterIcon.Enabled) then TimerAlerterIcon.Enabled := true;
  end
  else
  begin
    alertType := 0;
    TimerAlerter.Enabled := false;
    TimerAlerterIcon.Enabled := false;
  end;


//  fullRemTime := getBatteryRemainTime;
//  if not (getACLineStatus) then
//  begin
//  end;

  // Alert - When system remain time goes below 10 minutes
  if (fullRemTime <= 600) then
  begin
    alertType := 3;
    if (not TimerAlerter.Enabled) then TimerAlerter.Enabled := true;
    if (not TimerAlerterIcon.Enabled) then TimerAlerterIcon.Enabled := true;
  end
  else
  begin
    alertType := 0;
    TimerAlerter.Enabled := false;
    TimerAlerterIcon.Enabled := false;
  end;
  
end;

procedure TfrmPM.FlashTimerTimer(Sender: TObject);
var
  p: TPoint;
begin
  if (ani_index=13) then
  begin
    ani_index := 1;
    flashTimer.Interval := 2000;
  end
  else
  begin
    inc(ani_index);
    if (ani_index=1) then
      flashTimer.Interval := 2000
    else if (ani_index=7) then
      flashTimer.Interval := 2000
    else
      flashTimer.Interval := 50;
  end;
  p.X := 26;
  p.Y := 172;
  imgDisplayer.setFlashImage(p, ani_index, TForm(frmPM));

end;

procedure TfrmPM.FormPaint(Sender: TObject);
begin
{  if isFirst then
  begin
    isFirst := false;
    init;
  end;}
  setSelectedPage;

end;

procedure TfrmPM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  iDisplayInterval: Integer;
begin
  if ((Shift = [ssCtrl] + [ssAlt] + [ssShift]) and (Key = 79))then
  begin
    try
      frmMainOption := TfrmMainOption.Create(nil);
      if frmMainOption.ShowModal = mrOK then
      begin
        iDisplayInterval := StrToInt(getRegValue('DisplayInterval'));
        mainTimer.Interval := iDisplayInterval*1000;
      end;
    finally
      frmLogLocation.Free;
    end;
  end;
end;

procedure TfrmPM.TimerAlerterTimer(Sender: TObject);
begin

  try
    frmAlert := TfrmAlert.Create(nil);
{$IFDEF EN}
        frmAlert.setNLS(1);;
{$ELSE}
        frmAlert.setNLS(0);
{$ENDIF}
    case alertType of
{$IFDEF EN}
    1: {battery alert}
      begin
        frmAlert.setAlertString1('Li-Ion Battery has a short time to be replaced. ');
        frmAlert.setAlertString2('Connect other power source immediately          ');
        frmAlert.setAlertString3('or replace new battery                          ');
        frmAlert.setAlertString4('to prevent data loss.                           ');
      end;
    2: {fuel alert}
      begin
        frmAlert.setAlertString1('Fuel Cell has a short time to be replaced.      ');
        frmAlert.setAlertString2('Connect other power source immediately          ');
        frmAlert.setAlertString3('or replace new cartridge                        ');
        frmAlert.setAlertString4('to prevent data loss.                           ');
      end;
    3: {system alert}
      begin
        frmAlert.setAlertString1('Fucel Cell System has a short time to be replaced. ');
        frmAlert.setAlertString2('Connect other power source immediately,            ');
        frmAlert.setAlertString3('or replace new cartridge and battery               ');
        frmAlert.setAlertString4('to prevent data loss.                             ');
      end;
{$ELSE}
    1: {battery alert}
      begin
        frmAlert.setAlertString1('보조전지의 잔량이 얼마 남지 않았습니다.         ');
        frmAlert.setAlertString3('전원을 연결하거나 새 보조전지로                 ');
      end;
    2: {fuel alert}
      begin
        frmAlert.setAlertString1('연료전지의 연료가 얼마 남지 않았습니다.         ');
        frmAlert.setAlertString3('전원을 연결하거나 새 연료 카트리지로            ');
      end;
    3: {system alert}
      begin
        frmAlert.setAlertString1('시스템의 전체 잔량 시간이 얼마 남지 않았습니다.  ');
        frmAlert.setAlertString3('전원을 연결하거나 새 보조전지 또는 연료 카트리지로   ');
      end;
{$ENDIF}
    else
      exit;
    end;
    frmAlert.ShowModal;
  finally
    if (frmAlert <> nil) then
    begin
      frmAlert := nil;
      frmAlert.Free;
    end;
  end;

end;

procedure TfrmPM.TimerAlerterIconTimer(Sender: TObject);
begin
    case alertType of
    1: {battery alert}
      begin
        imgDisplayer.setBatteryAlertImage(imgBatteryStatus);
      end;
    2: {fuel alert}
      begin
        imgDisplayer.setFuelAlertImage(imgFuelStatus);
      end;
    3: {system alert}
      begin
        //imgDisplayer.setBatteryImage(imgBatteryStatus, StrToInt(Format('%3.0f', [iBatteryPercent])), false);

      end;
    else
      exit;
    end;
  
end;

procedure TfrmPM.imgFuelStatusClick(Sender: TObject);
var
  iCatID: Single;
  iDensity: Single;
  iCapac: Single;
begin            

  iCatID := biManager.getBatteryData(CATRIDID);
//  iDensity := biManager.getBatteryData(CATDENSE);
//  iCapac := biManager.getBatteryData(CATCAPAC);

  iDensity := biManager.getDefaultBatteryInfo(CATRIDGE_ADDR, CATDENSE)/10;
  iCapac := biManager.getDefaultBatteryInfo(CATRIDGE_ADDR, CATCAPAC)/10;


  imgDisplayer.setFuelImage(imgFuelStatus, StrToInt(Format('%3.0f', [iFuelCellPercent])), false);
(*
{$IFDEF EN}
  try
    isDetailClosed := false;
    frmBatteryDetailEn := TfrmBatteryDetailEn.Create(nil);
    frmBatteryDetailEn.batteryType := FUELCELL_DETAIL_TYPE;
    frmBatteryDetailEn.percent := StrToInt(lblFuelCellRemain.Caption);
    frmBatteryDetail.catridgeID := iCatID;
    frmBatteryDetailEn.ShowModal;
  finally
    frmBatteryDetailEn.Free;
    isDetailClosed := true;
  end;
{$ELSE}
*)
  try
    isDetailClosed := false;
    frmBatteryDetail := TfrmBatteryDetail.Create(nil);
    frmBatteryDetail.batteryType := FUELCELL_DETAIL_TYPE;
    frmBatteryDetail.percent := StrToInt(lblFuelCellRemain.Caption);
    frmBatteryDetail.catridgeID := iCatID;
    frmBatteryDetail.iDensity := iDensity;
    frmBatteryDetail.iCapac := iCapac;

    frmBatteryDetail.ShowModal;
  finally
    frmBatteryDetail.Free;
    isDetailClosed := true;
  end;
//{$ENDIF}

end;

procedure TfrmPM.imgBatteryStatusClick(Sender: TObject);
begin
  imgDisplayer.setBatteryImage(imgBatteryStatus, StrToInt(Format('%3.0f', [iBatteryPercent])), false);

{$IFDEF EN}

  try
    isDetailClosed := false;  
    frmBatteryDetailEn := TfrmBatteryDetailEn.Create(nil);
    frmBatteryDetailEn.batteryType := BATTERY_DETAIL_TYPE;
    frmBatteryDetailEn.percent := StrToInt(lblBatteryRemain.Caption);

    frmBatteryDetailEn.ShowModal;
  finally
    frmBatteryDetailEn.Free;
    isDetailClosed := true;
  end;
{$ELSE}
  try
    isDetailClosed := false;  
    frmBatteryDetail := TfrmBatteryDetail.Create(nil);
    frmBatteryDetail.batteryType := BATTERY_DETAIL_TYPE;
    frmBatteryDetail.percent := StrToInt(lblBatteryRemain.Caption);

    frmBatteryDetail.ShowModal;
  finally
    frmBatteryDetail.Free;
    isDetailClosed := true;
  end;

{$ENDIF}


end;

procedure TfrmPM.imgFuelStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgFuelStatus.Left := imgFuelStatus.Left + 1;
  imgFuelStatus.Top := imgFuelStatus.Top + 1;

end;

procedure TfrmPM.imgFuelStatusMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgFuelStatus.Left := imgFuelStatus.Left - 1;
  imgFuelStatus.Top := imgFuelStatus.Top - 1;

end;

procedure TfrmPM.imgBatteryStatusMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgBatteryStatus.Left := imgBatteryStatus.Left + 1;
  imgBatteryStatus.Top := imgBatteryStatus.Top + 1;

end;

procedure TfrmPM.imgBatteryStatusMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imgBatteryStatus.Left := imgBatteryStatus.Left - 1;
  imgBatteryStatus.Top := imgBatteryStatus.Top - 1;

end;

procedure TfrmPM.imgOKMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  imgOK.Left := imgOK.Left + 1;
  imgOK.Top := imgOK.Top + 1;
end;

procedure TfrmPM.imgOKMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  imgOK.Left := imgOK.Left - 1;
  imgOK.Top := imgOK.Top - 1;
end;

procedure TfrmPM.imgOKClick(Sender: TObject);
begin
{$IFDEF DEBUG}
  WriteLog('OKClick', '>>>1');
{$ENDIF}
  //Close;
  if (CheckBox1.Checked) then
  begin
{$IFDEF DEBUG}
    WriteLog('OKClick', '>>>2');
{$ENDIF}
    self.Visible := false;
    mainTimer.Enabled := false;
    flashTimer.Enabled := false;
    self.Close;
{$IFDEF DEBUG}
    WriteLog('OKClick', '>>>3');
{$ENDIF}
  end
  else
  begin
{$IFDEF DEBUG}
    WriteLog('OKClick', '>>>4');
{$ENDIF}

    self.Visible := false;
    mainTimer.Enabled := false;
    flashTimer.Enabled := false;
    Close;
{$IFDEF DEBUG}
    WriteLog('OKClick', '>>>5');
{$ENDIF}

    if (frmPM <> nil) then frmPM := nil;
{$IFDEF DEBUG}
    WriteLog('OKClick', '>>>6');
{$ENDIF}
    Application.Terminate;
  end;
end;

procedure TfrmPM.FormCreate(Sender: TObject);
begin
  isDetailClosed := true;

  self.DoubleBuffered := true;
  isFirst := true;
  
  mainTimer.Enabled := true;
  flashTimer.Enabled := true;

  sysDrawer := TDrawer.Create;
  fuelDrawer := TDrawer.Create;
  battDrawer := TDrawer.Create;

  sysDrawer.r.Left := 25;
  sysDrawer.r.Top := 249;
  sysDrawer.r.Bottom := 315;
  sysDrawer.r.Right := 182;

  sysDrawer.gridColor := TColor($00408000);
  sysDrawer.lineColor := clLime;
  sysDrawer.vMeasure := 1000;
  sysDrawer.hMeasure := 30;
  sysDrawer.vlineNo := 10;
  sysDrawer.hlineNo := 20;
  sysDrawer.direction := tdRight;
{$IFDEF SABI}
  sysDrawer.min := 0;
  sysDrawer.max := 55;
{$ELSE}
  sysDrawer.min := 0;
  sysDrawer.max := 642;
{$ENDIF}

  fuelDrawer.r.Left := 460;
  fuelDrawer.r.Top := 113;
  fuelDrawer.r.Bottom := 166;
  fuelDrawer.r.Right := 587;

  fuelDrawer.gridColor := TColor($00408000);
  fuelDrawer.lineColor := clLime;
  fuelDrawer.vMeasure := 1000;
  fuelDrawer.hMeasure := 30;
  fuelDrawer.vlineNo := 10;
  fuelDrawer.hlineNo := 20;
  fuelDrawer.direction := tdRight;
{$IFDEF SABI}
  fuelDrawer.min := 0;
  fuelDrawer.max := 55;
{$ELSE}
  fuelDrawer.min := 0;
  fuelDrawer.max := 642;
{$ENDIF}

  battDrawer.r.Left := 460;
  battDrawer.r.Top := 260;
  battDrawer.r.Bottom := 312;
  battDrawer.r.Right := 587;

  battDrawer.gridColor := TColor($00408000);
  battDrawer.lineColor := clLime;
  battDrawer.vMeasure := 1000;
  battDrawer.hMeasure := 30;
  battDrawer.vlineNo := 10;
  battDrawer.hlineNo := 20;
  battDrawer.direction := tdRight;
{$IFDEF SABI}
  battDrawer.min := 0;
  battDrawer.max := 55;
{$ELSE}
  battDrawer.min := 0;
  battDrawer.max := 642;
{$ENDIF}

  b := true;

  init;

end;

procedure TfrmPM.init;
begin

  ShowWindow(frmPM.Handle, SW_HIDE);

  frmPM.Color := clWhite;

{------------ from FormCreate Event ----------------}

  Image2.Tag := 1;
  Image3.Tag := 0;

  if (getRegValue('showTrayIcon')='1') then
  begin
    CheckBox1.Checked := true;
  end else if (getRegValue('showTrayIcon')='0') then
  begin
    CheckBox1.Checked := false;
  end;

  if (getRegValue('showEachBattery')='1') then
  begin
    CheckBox2.Checked := true;
  end else if (getRegValue('showEachBattery')='0') then
  begin
    CheckBox2.Checked := false;
  end;

  imgDisplayer:= TBIDisplayer.Create;

  imgDisplayer.lblPowerPercent := lblPowerPercent;

  mainTimerTimer(self);

  // 2nd page controls
  lblNPCW.Visible := false;
  Label10.Visible := false;
  lblNPCV.Visible := false;
  Label11.Visible := false;
  lblNPCA.Visible := false;
  Label12.Visible := false;
  lblFuelV.Visible := false;
  Label30.Visible := false;
  lblFuelA.Visible := false;
  Label29.Visible := false;
  lblFuelW.Visible := false;
  Label32.Visible := false;
  lblBatteryV.Visible := false;
  Label9.Visible := false;
  lblBatteryA.Visible := false;
  Label8.Visible := false;
  lblBatteryW.Visible := false;
  Label14.Visible := false;

{$IFDEF EN}
  Application.Title := 'Fuel Cell System';
  frmPM.Caption := 'Fuel Cell System';

  CheckBox1.Caption := 'Keep the icon displayed on the tray';
  CheckBox2.Caption := 'Display cell information';

  Panel6.Left := Panel6.Left - DIST;
  Panel7.Left := Panel7.Left - DIST;
  Panel8.Left := Panel8.Left - DIST;
  Label2.Left := Label2.Left - DIST;
  Label3.Left := Label3.Left - DIST;
  Label6.Left := Label6.Left - DIST;

  Label2.Caption := 'Current Power Source Type';
  Panel7.Top := Panel7.Top + 1;
  Panel8.Top := Panel8.Top + 1;
  Label3.Caption := 'Residual Time in Sleep Mode';
  lblMaxSaveTime.Caption := '00 Days';
  Label6.Caption := 'Residual Time in Stand-by Mode';
  Label34.Caption := 'Click the cell icon for more information';
  Label35.Caption := '';
  imgDisplayer.setMainTabImage(Image2, 1, 1); // first enabled
  imgDisplayer.setMainTabImage(Image3, 2, 2); // second disabled

  imgDisplayer.setMainTabImage(TI0, 1, 1); // first enabled
  imgDisplayer.setMainTabImage(TI1, 1, 2); // first disabled
  imgDisplayer.setMainTabImage(TI2, 2, 1); // second enabled
  imgDisplayer.setMainTabImage(TI3, 2, 2); // second disabled

  imgDisplayer.setOKImage(imgOK, false);

//  Label36.Caption := 'Li-Ion Battery';  // 20061030 by 유재우
//  Label36.Width := Label36.Width + 8;  // 20061030 by 유재우
  lblCurrentPowerType.Caption := 'FuelCell + Li-IonBattery';
  lblCurrentPowerType.Top := lblCurrentPowerType.Top+1;
  lblACNotice.Caption := 'AC Power';

{$ELSE}
  lblCurrentPowerType.Caption := '연료전지 + 보조전지';
{$ENDIF}

  imgDisplayer.setOKImage(imgOK, true);

/////////////////////// Alert Window
  TimerAlerter.Enabled := false;
  TimerAlerterIcon.Enabled := false;
  TimerAlerter.Interval := 30000;
  TimerAlerterIcon.Interval := 1000;




end;

procedure TfrmPM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
