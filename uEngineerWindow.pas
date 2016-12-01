unit uEngineerWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, OleCtrls, Chartfx3, TeEngine, Series,
  TeeProcs, Chart, Menus, Excel2000, OleServer, ActiveX, ComObj, ComCtrls;

type
  TfrmEngineeringWindow = class(TForm)
    strGridDisp: TStringGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    btnCreateLog: TButton;
    Button2: TButton;
    Timer1: TTimer;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ctSOOC: TChart;
    Series1: TLineSeries;
    ctSOPW: TChart;
    LineSeries1: TLineSeries;
    ctSOOV: TChart;
    LineSeries2: TLineSeries;
    ctSTSV: TChart;
    LineSeries3: TLineSeries;
    ctSTSC: TChart;
    LineSeries4: TLineSeries;
    ctSTPW: TChart;
    LineSeries5: TLineSeries;
    ctSTST: TChart;
    LineSeries6: TLineSeries;
    ctSTRQ: TChart;
    LineSeries7: TLineSeries;
    ctBTBV: TChart;
    LineSeries8: TLineSeries;
    ctBTBC: TChart;
    LineSeries9: TLineSeries;
    ctBTPW: TChart;
    LineSeries10: TLineSeries;
    ctBTRQ: TChart;
    LineSeries11: TLineSeries;
    ctTSRT: TChart;
    LineSeries13: TLineSeries;
    ctTSRQ: TChart;
    LineSeries14: TLineSeries;
    MainMenu1: TMainMenu;
    mmFile: TMenuItem;
    mmFileClose: TMenuItem;
    O1: TMenuItem;
    V1: TMenuItem;
    L1: TMenuItem;
    R1: TMenuItem;
    U1: TMenuItem;
    N111: TMenuItem;
    N21: TMenuItem;
    N331: TMenuItem;
    N441: TMenuItem;
    N551: TMenuItem;
    N10T1: TMenuItem;
    N2: TMenuItem;
    N15Q1: TMenuItem;
    N3: TMenuItem;
    N20W1: TMenuItem;
    N30H1: TMenuItem;
    N4: TMenuItem;
    S1: TMenuItem;
    N5: TMenuItem;
    mnLogGeneration: TMenuItem;
    N6: TMenuItem;
    GroupBox5: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    lblDate: TLabel;
    lblOpTime: TLabel;
    lblCurrentMode: TLabel;
    Image1: TImage;
    GroupBox6: TGroupBox;
    Timer2: TTimer;
    Panel_8: TPanel;
    Panel_4: TPanel;
    Panel8: TPanel;
    pnl4_00: TPanel;
    pnl4_10: TPanel;
    pnl4_11: TPanel;
    pnl4_01: TPanel;
    pnl4_02: TPanel;
    pnl4_12: TPanel;
    pnl4_13: TPanel;
    pnl4_03: TPanel;
    Panel9: TPanel;
    pnl4_L00: TPanel;
    pnl4_L10: TPanel;
    pnl4_L01: TPanel;
    pnl4_L11: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    pnl8_1: TPanel;
    pnl8_2: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    pnl8_3: TPanel;
    pnl8_4: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    pnl8_L1: TPanel;
    pnl8_L2: TPanel;
    pnl8_5: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    pnl8_6: TPanel;
    pnl8_7: TPanel;
    Panel29: TPanel;
    Panel30: TPanel;
    pnl8_8: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure N111Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure mmFileCloseClick(Sender: TObject);
    procedure N331Click(Sender: TObject);
    procedure N441Click(Sender: TObject);
    procedure N551Click(Sender: TObject);
    procedure N10T1Click(Sender: TObject);
    procedure N15Q1Click(Sender: TObject);
    procedure N20W1Click(Sender: TObject);
    procedure N30H1Click(Sender: TObject);
    procedure L1Click(Sender: TObject);
    procedure btnCreateLogClick(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure mnLogGenerationClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure initializeArray;
    procedure pushValue(var a: array of Single; n: Single);
    procedure drawCharts;
    procedure loadPreferenceValue;
    procedure createLogfile;  // create one instance
    procedure closeLogging;   // create multi data

    function getOperationMode(v: Word): String;
    function getCatridgeID(v: Word): String;

    procedure drawRecyclerLever(iodata1: Integer; iodata2: Byte);

  public
    { Public declarations }
  end;

var
  frmEngineeringWindow: TfrmEngineeringWindow;
  iBatteryPercent, iFuelCellPercent: Single;
  opTime: TDateTime;  // for log file
  opTime2: TDateTime;  // for display
  

  // for chart
//  chartArray: array[1..14] of array[1..30] of Word;
  chartArray: array[1..14] of array[1..30] of Single;

  TSRT: Integer = 1;   // total system residual time
  TSRQ: Integer = 2;   //totla system residual quantity
  SOOV: Integer = 3;   // system output voltage
  SOOC: Integer = 4;   // system output current
  SOPW: Integer = 5;   // system output power
  STSV: Integer = 6;   // stack voltage
  STSC: Integer = 7;   // stack current
  STPW: Integer = 8;   // stack power
  STST: Integer = 9;   // stack temperature
  STRQ: Integer = 10;  // stack residual quantity
  BTBV: Integer = 11;  // battery voltage
  BTBC: Integer = 12;  // battery current
  BTPW: Integer = 13;  // battery power
  BTRQ: Integer = 14;  // battery residual quantity

implementation

uses uBiosInterface, uFuelTray, uConstant, Batclass, clsMain, uLogLocation;

var
  frmLogLocation: TfrmLogLocation;
  sLogLocation: String;
  iLogInterval: Integer;
  iDisplayInterval: Integer;
  strList: TStringList;

{$R *.dfm}

procedure TfrmEngineeringWindow.drawRecyclerLever(iodata1: Integer; iodata2: Byte);

  function get4Desc(level: Integer): String;
  begin
    case level of
    1: result := 'Low - fail';
    2: result := 'Mid - low';
    3: result := 'Mid - high';
    4: result := 'High - fail';
    else
      result := 'NA';
    end;
  end;

  function get8Desc(level: Integer): String;
  begin
    case level of
    1: result := 'Low - fail';
    2: result := 'Low - alert';
    3: result := 'Mid - low';
    4: result := 'Middle';
    5: result := 'Middle';
    6: result := 'Mid - high';
    7: result := 'Mid - alert';
    8: result := 'High - fail';
    else
      result := 'NA';
    end;
  end;


var
  i: Integer;
  bp: Integer;
begin
  Panel_4.Top := 18;
  Panel_4.Left := 9;
  Panel_8.Top := 18;
  Panel_8.Left := 9;

  if (iodata1 = 4) then
  begin

    Panel_4.Visible := true;
    Panel_8.Visible := false;

    if (isBitOn(iodata2, 0)) then
    begin
      pnl4_10.Caption := 'O';
      bp := 1;
    end
    else
      pnl4_10.Caption := 'X';
    if (isBitOn(iodata2, 1)) then
    begin
      pnl4_11.Caption := 'O';
      bp := 2;
    end
    else
      pnl4_11.Caption := 'X';
    if (isBitOn(iodata2, 2)) then
    begin
      pnl4_12.Caption := 'O';
      bp := 3;
    end
    else
      pnl4_12.Caption := 'X';
    if (isBitOn(iodata2, 3)) then
    begin
      pnl4_13.Caption := 'O';
      bp := 4;
    end
    else
      pnl4_13.Caption := 'X';

    pnl4_L01.Caption := IntToStr(bp);
    pnl4_L11.Caption := get4Desc(bp);

  end else if (iodata1 = 8) then
  begin
    Panel_4.Visible := false;
    Panel_8.Visible := true;


    if (isBitOn(iodata2, 0)) then
    begin
      pnl8_1.Caption := 'O';
      bp := 1;
    end
    else
      pnl8_1.Caption := 'X';
    if (isBitOn(iodata2, 1)) then
    begin
      pnl8_2.Caption := 'O';
      bp := 2;
    end
    else
      pnl8_2.Caption := 'X';
    if (isBitOn(iodata2, 2)) then
    begin
      pnl8_3.Caption := 'O';
      bp := 3;
    end
    else
      pnl8_3.Caption := 'X';
    if (isBitOn(iodata2, 3)) then
    begin
      pnl8_4.Caption := 'O';
      bp := 4;
    end
    else
      pnl8_4.Caption := 'X';
    if (isBitOn(iodata2, 4)) then
    begin
      pnl8_5.Caption := 'O';
      bp := 5;
    end
    else
      pnl8_5.Caption := 'X';
    if (isBitOn(iodata2, 5)) then
    begin
      pnl8_6.Caption := 'O';
      bp := 6;
    end
    else
      pnl8_6.Caption := 'X';
    if (isBitOn(iodata2, 6)) then
    begin
      pnl8_7.Caption := 'O';
      bp := 7;
    end
    else
      pnl8_7.Caption := 'X';
    if (isBitOn(iodata2, 7)) then
    begin
      pnl8_8.Caption := 'O';
      bp := 8;
    end
    else
      pnl8_8.Caption := 'X';

    pnl8_L1.Caption := IntToStr(bp);
    pnl8_L2.Caption := get8Desc(bp);
 {
    for i := 0 to 7 do
    begin
      stg8Upper.Cells[i,0] := IntToStr(i+1);
      if (isBitOn(iodata2, i)) then
      begin
        stg8Upper.Cells[i,1] := 'O';
        bp := i+1;
      end
      else
        stg8Upper.Cells[i,1] := 'X'
    end;

    stg8Lower.Cells[0,0] := 'Level';
    stg8Lower.Cells[0,1] := 'Status';
    stg8Lower.Cells[1,0] := IntToStr(bp);
    stg8Lower.Cells[1,1] := get8Desc(bp);
}

  end;

end;

function TfrmEngineeringWindow.getOperationMode(v: Word): String;
begin
  case v of
  $0: result := 'I';
  $1: result := 'B';
  $2: result := 'BO';
  $3: result := 'SBO';
  $4: result := 'SCO';
  $5: result := 'A';
  $6: result := 'AO';
  $7: result := 'AC';
  $8: result := 'ACO';
  else
    result := 'ND';
  end;
end;

function TfrmEngineeringWindow.getCatridgeID(v: Word): String;
var
  s: String;
begin

  case v of
  0:  s := '1 (<low)';
  1:  s := '2 (low-mid)';
  2:  s := '3 (mid-high)';
  3:  s := '4 (>high)';
  else
    s := 'ND';
  end;
  result := s;

(*  if (v >= 0) and (v <= 256) then
  begin
    s := 'CA';
    result := s + Zero_Str(v+1, 3);
  end
  else
    result := 'ND';
*)
end;

procedure TfrmEngineeringWindow.loadPreferenceValue;
var
  sLogInterval, sDisplayInterval: String;
begin
  sLogLocation := getRegValue('LogLocation');
  sLogInterval := getRegValue('LogInterval');
  sDisplayInterval := getRegValue('DisplayInterval');

  if (sLogLocation = '') then
  begin
    sLogLocation := 'C:\';
  end;

 if (strEndsWith(sLogLocation, '\')) then
   sLogLocation := Copy(sLogLocation, 1, Length(sLogLocation)-1);

  if (sLogInterval = '') then
  begin
    iLogInterval := 30;
  end
  else
  begin
    iLogInterval := StrToInt(sLogInterval);
  end;

  if (sDisplayInterval = '') then
  begin
    iDisplayInterval := 30;
  end
  else
  begin
    iDisplayInterval := StrToInt(sDisplayInterval);
  end;

  Timer1.Interval := iDisplayInterval*1000;
  Timer2.Interval := iLogInterval*1000;

end;


procedure TfrmEngineeringWindow.drawCharts;
var
  i: Integer;
begin

  // TSRT
  with ctTSRT.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[TSRT]) do
      Add(chartArray[TSRT, i] , ''     , clTeeColor );
  end;

  // TSRQ
  with ctTSRQ.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[TSRQ]) do
      Add(chartArray[TSRQ, i] , ''     , clTeeColor );
  end;

  // SOOV
  with ctSOOV.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[SOOV]) do
      Add(chartArray[SOOV, i] , ''     , clTeeColor );
  end;


  // SOOC
  with ctSOOC.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[SOOC]) do
      Add(chartArray[SOOC, i] , ''     , clTeeColor );
  end;

  // SOPW
  with ctSOPW.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[SOPW]) do
      Add(chartArray[SOPW, i] , ''     , clTeeColor );
  end;

  // BTBV
  with ctBTBV.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[BTBV]) do
      Add(chartArray[BTBV, i] , ''     , clTeeColor );
  end;

  // BTBC
  with ctBTBC.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[BTBC]) do
      Add(chartArray[BTBC, i] , ''     , clTeeColor );
  end;

  // BTPW
  with ctBTPW.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[BTPW]) do
      Add(chartArray[BTPW, i] , ''     , clTeeColor );
  end;

  // BTRQ
  with ctBTRQ.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[BTRQ]) do
      Add(chartArray[BTRQ, i] , ''     , clTeeColor );
  end;

  // STSV
  with ctSTSV.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[STSV]) do
      Add(chartArray[STSV, i] , ''     , clTeeColor );
  end;

  // STSC
  with ctSTSC.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[STSC]) do
      Add(chartArray[STSC, i] , ''     , clTeeColor );
  end;

  // STPW
  with ctSTPW.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[STPW]) do
      Add(chartArray[STPW, i] , ''     , clTeeColor );
  end;

  // STSC
  with ctSTSC.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[STSC]) do
      Add(chartArray[STSC, i] , ''     , clTeeColor );
  end;

  // STRQ
  with ctSTRQ.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[STRQ]) do
      Add(chartArray[STRQ, i] , ''     , clTeeColor );
  end;

  // STST
  with ctSTST.Series[0] do
  begin
    Clear;
    for i:= 1 to High(chartArray[STST]) do
      Add(chartArray[STST, i] , ''     , clTeeColor );
  end;
  
end;

procedure TfrmEngineeringWindow.pushValue(var a: array of Single; n: Single);
var
  i: Integer;
begin
  for i := 1 to High(a) do
  begin
    a[i-1] := a[i];
  end;
  a[High(a)] := n;
end;

procedure TfrmEngineeringWindow.initializeArray;
var
  i, j: Integer;
begin

  for i := 1 to High(chartArray) do
  begin
    for j := 1 to High(chartArray[i]) do
    begin
      chartArray[i, j] := 0;
    end;
  end;
end;


procedure TfrmEngineeringWindow.FormCreate(Sender: TObject);
begin

  InitializeCriticalSection(CS);

  opTime2 := Now;
     
  lblDate.Caption := '';
  lblOpTime.Caption := '';
  //lblCatID.Caption := '';
  lblCurrentMode.Caption := '';

  strList := TStringList.Create;

  strGridDisp.Cells[0,0]  := '    Current Power Source';
  strGridDisp.Cells[0,1]  := '    Total Residual Time';
  strGridDisp.Cells[0,2]  := '    Residual Quantity [%]';
  strGridDisp.Cells[0,3]  := '    Output Voltage [V]';
  strGridDisp.Cells[0,4]  := '    Output Current [A]';
  strGridDisp.Cells[0,5]  := '    Output Power [W]';
  strGridDisp.Cells[0,6]  := '    Stack Voltage [V]';
  strGridDisp.Cells[0,7]  := '    Stack Current [A]';
  strGridDisp.Cells[0,8]  := '    Stack Power [W]';
  strGridDisp.Cells[0,9]  := '    Stack Temperature [℃]';
  strGridDisp.Cells[0,10] := '    Residual Quantity [%]';
  strGridDisp.Cells[0,11] := '    Battery Voltage [V]';
  strGridDisp.Cells[0,12] := '    Battery Current [A]';
  strGridDisp.Cells[0,13] := '    Battery Power [W]';
  strGridDisp.Cells[0,14] := '    Residual Quantity [%]';

  strGridDisp.ColWidths[0] := 188;
  strGridDisp.ColWidths[1] := 90;

  initializeArray;

  loadPreferenceValue;
  
  Timer1.Enabled := True;
  Timer2.Enabled := False;

  btnCreateLog.Tag := 0;

end;

procedure TfrmEngineeringWindow.Timer1Timer(Sender: TObject);
var
  // SABI variable (For page 2)
  inpcVolt, inpcCurr, iBattVolt, iBattCurr, iFuelVolt, iFuelCurr: Double;
  iNpcDetailPercent, iBatteryDetailPercent, iFuelCellDetailPercent: Double;
  // SABI variable (For page 1)
  iBatteryFullCapa, iBatteryRemainCapa, iFuelCellFullCapa, iFuelCellRemainCapa: Single;
  // Total Cell Info (for Page 1)
  fullRemTime: Extended;
  hour, min: Single;
  batteryLifePercent: Word;
  batteryLifePercent2: Single;

  // SABI variable
  iStackTemp, iCatID, iOpMode: Single ;
  ihour, imin: Integer;

  // RecyclerLever
  iodata2: BYTE;

  iRecyclerCount: Integer;

begin

  lblDate.Caption := DateTimeToStr(getToday);

  // Get Recycler Level Information
  iRecyclerCount := round(biManager.getBatteryData(RECYCLER));//FloatToInteger(biManager.getBatteryData(RECYCLER));
  biManager.getRecyclerData(iodata2);
  drawRecyclerLever(iRecyclerCount, iodata2);

  // SABI Interface 정보 (for Page 2)
  inpcVolt := biManager.getBatteryData(NOTEVOLT);
  strGridDisp.Cells[1, 3] := Format('%2.1f', [inpcVolt]);//IntToStr(inpcVolt);
  inpcCurr := biManager.getBatteryData(NOTECURR);
  strGridDisp.Cells[1, 4] := Format('%2.1f', [inpcCurr]);//IntToStr(inpcCurr);

  ibattVolt := biManager.getBatteryData(BATTVOLT);
  strGridDisp.Cells[1, 11] := Format('%2.1f', [ibattVolt]);//IntToStr(ibattVolt);
  ibattCurr := biManager.getBatteryData(BATTCURR);
  strGridDisp.Cells[1, 12] := Format('%2.1f', [ibattCurr]);//IntToStr(ibattCurr);
  iFuelVolt := biManager.getBatteryData(FUELVOLT);
  strGridDisp.Cells[1, 6] := Format('%2.1f', [iFuelVolt]);//IntToStr(iFuelVolt);
  iFuelCurr := biManager.getBatteryData(FUELCURR);
  strGridDisp.Cells[1, 7] := Format('%2.1f', [iFuelCurr]);//IntToStr(iFuelCurr);

  strGridDisp.Cells[1, 5] := Format('%5.1f', [inpcVolt * inpcCurr]);//IntToStr(inpcVolt * inpcCurr);
  strGridDisp.Cells[1, 13] := Format('%5.1f', [ibattVolt * ibattCurr]);//IntToStr(ibattVolt * ibattCurr);
  strGridDisp.Cells[1, 8] := Format('%5.1f', [iFuelVolt * iFuelCurr]);//IntToStr(iFuelVolt * iFuelCurr);


  iStackTemp := biManager.getBatteryData(STCKTEMP);
  strGridDisp.Cells[1,9] := Format('%3.1f', [iStackTemp]);//


  //iCatID := biManager.getBatteryData(RECYCLER);
  iOpMode := biManager.getBatteryData(OPERMODE);
  //lblCatID.Caption := getCatridgeID(StrToInt(Format('%3.0f', [iCatID])));//
  lblCurrentMode.Caption := getOperationMode(StrToInt(Format('%3.0f', [iOpMode])));//

  lblOpTime.Caption := getTimeDiff2(Now, opTime2);


  iNpcDetailPercent := inpcVolt * inpcCurr * 100 / 30; // maximum watt is 30w
  if (iNpcDetailPercent > 100) then iNpcDetailPercent := 100.0;

  iBatteryDetailPercent := ibattVolt * ibattCurr * 100 / 30;

  iFuelCellDetailPercent := iFuelVolt * iFuelCurr * 100 / 30;
  if (iFuelCellDetailPercent > 100) then iFuelCellDetailPercent := 100.0;

  // SABI Interface 정보 (for Page 1)
  iBatteryFullCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_FULL_CAPA);
  iBatteryRemainCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_REM_CAPA);
  iFuelCellFullCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_FULL_CAPA);
  iFuelCellRemainCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_REM_CAPA);

  // prevent dividing by 0
  if iBatteryFullCapa <= 0 then iBatteryFullCapa := 1;
  if iFuelCellFullCapa <= 0 then iFuelCellFullCapa := 1;


  iBatteryPercent := (iBatteryRemainCapa / iBatteryFullCapa) * 100;
  if (iBatteryPercent > 100) then iBatteryPercent := 100;
  iFuelCellPercent := (iFuelCellRemainCapa / iFuelCellFullCapa) * 100;
  if (iFuelCellPercent > 100) then iFuelCellPercent := 100;

  strGridDisp.Cells[1, 14] := Format('%3.0f', [iBatteryPercent]);
  strGridDisp.Cells[1, 10] := Format('%3.0f', [iFuelCellPercent]);

  //최대절전모드 방전 예상시간은 기본 전지 남은 잔량(remaining capacity)  / 상수(약 40)
  //<== 시간 나오고 /24 해서 일로 표시
  //대기모드 방전예상시간은 전체 전지 남은 잔량(remaining capacity) / 상수(약 500)
  //<== 시간 나옴 / 그대로 표시
  // [+ 연료 전지] (lblCurrentPowerType) Visible 여부
  if (iFuelCurr > 0.2) then
  begin
    strGridDisp.Cells[1, 0] := 'Hybrid';
  end
  else
  begin
    strGridDisp.Cells[1, 0] := 'Batt';
  end;

  // Total Cell Info (for Page 1)
//  fullRemTime := ((iBatteryRemainCapa+iFuelCellRemainCapa)/(inpcCurr*1000));

  //총사용가능시간=(기본전지잔량+연료전지잔량)/(시스템 출력의 Amphere*1000)
  if (inpcCurr <=0) then inpcCurr := 0.0001;
  fullRemTime := ((iBatteryRemainCapa+iFuelCellRemainCapa)/(inpcCurr*1000))*60*60;

  pushValue(chartArray[TSRT],  StrToFloat(FormatFloat('0.0', fullRemTime/3600)));
  
  if (fullRemTime >= 3600) then
  begin
    min := fullRemTime / 60;
    hour := min / 60;
    ihour := getIntegerFromFloat(hour);
    min := min - ihour*60;
    imin := getIntegerFromFloat(min);
    if (imin<0) then
    begin
      showmessage('imin='+IntToStr(imin)+';fullRemtime='+intToStr(round(fullRemTime))+';min='+inttostr(round(min)));
    end;
    strGridDisp.Cells[1, 1] := IntToStr(ihour) +':' + Zero_Str(imin, 2);
  end else if (fullRemTime < 3600) then
  begin
    min := fullRemTime / 60;
    imin := getIntegerFromFloat(min);
    strGridDisp.Cells[1, 1] := '00:' + Zero_Str(imin, 2);
  end;


{
  if (fullRemTime = $FFFFFFFF) then
  begin
    strGridDisp.Cells[1, 1] := 'Using AC Power';
  end else
  begin
    //총사용가능시간=(기본전지잔량+연료전지잔량)/(시스템 출력의 Amphere*1000)
    fullRemTime := ((iBatteryRemainCapa+iFuelCellRemainCapa)/(inpcCurr*1000))*60*60;

    if (fullRemTime >= 3600) then
    begin
      min := fullRemTime / 60;
      hour := min / 60;
      ihour := getIntegerFromFloat(hour);
      min := min - ihour*60;
      imin := getIntegerFromFloat(min);

      strGridDisp.Cells[1, 1] := IntToStr(ihour) +':' + Zero_Str(imin, 2);
    end else if (fullRemTime < 3600) then
    begin
      min := fullRemTime / 60;
      imin := getIntegerFromFloat(min);
      strGridDisp.Cells[1, 1] := '00:' + Zero_Str(imin, 2);
    end;
  end;
}
  iBatteryPercent := (iBatteryRemainCapa / iBatteryFullCapa)* 100;
  if (iBatteryPercent >100) then iBatteryPercent := 100;
  iFuelCellPercent := (iFuelCellRemainCapa / iFuelCellFullCapa)* 100;
  if (iFuelCellPercent >100) then iFuelCellPercent := 100;


  batteryLifePercent2 := (iBatteryRemainCapa+iFuelCellRemainCapa)/(iBatteryFullCapa+iFuelCellFullCapa)*100;
  batteryLifePercent := StrToInt(Format('%5.0f', [batteryLifePercent2]));
  if (batteryLifePercent > 100) then batteryLifePercent := 100;
  strGridDisp.Cells[1, 2] := intToStr(batteryLifePercent);

  pushValue(chartArray[TSRQ],  batteryLifePercent);
  pushValue(chartArray[SOOV],  StrToFloat(FormatFloat('0.00', inpcVolt)));
  pushValue(chartArray[SOOC],  StrToFloat(FormatFloat('0.00', inpcCurr)));
  pushValue(chartArray[SOPW],  StrToFloat(FormatFloat('0.00', inpcVolt * inpcCurr)));
  pushValue(chartArray[STSV],  StrToFloat(FormatFloat('0.00', iFuelVolt)));
  pushValue(chartArray[STSC],  StrToFloat(FormatFloat('0.00', iFuelCurr)));
  pushValue(chartArray[STPW],  StrToFloat(FormatFloat('0.00', iFuelVolt * iFuelCurr)));
  pushValue(chartArray[STST],  StrToFloat(FormatFloat('0.00', iStackTemp)));
  pushValue(chartArray[STRQ],  StrToFloat(FormatFloat('0.00', iFuelCellPercent)));
  pushValue(chartArray[BTBV],  StrToFloat(FormatFloat('0.00', ibattVolt)));
  pushValue(chartArray[BTBC],  StrToFloat(FormatFloat('0.00', ibattCurr)));
  pushValue(chartArray[BTPW],  StrToFloat(FormatFloat('0.00', ibattVolt*ibattCurr)));
  pushValue(chartArray[BTRQ],  batteryLifePercent);

  drawCharts;
end;

procedure TfrmEngineeringWindow.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmEngineeringWindow.R1Click(Sender: TObject);
begin
  Timer1Timer(self);
end;

procedure TfrmEngineeringWindow.N111Click(Sender: TObject);
begin
  Timer1.Interval := 1000;
end;

procedure TfrmEngineeringWindow.N21Click(Sender: TObject);
begin
  Timer1.Interval := 2000;
end;

procedure TfrmEngineeringWindow.mmFileCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEngineeringWindow.N331Click(Sender: TObject);
begin
  Timer1.Interval := 3000;
end;

procedure TfrmEngineeringWindow.N441Click(Sender: TObject);
begin
  Timer1.Interval := 4000;
end;

procedure TfrmEngineeringWindow.N551Click(Sender: TObject);
begin
  Timer1.Interval := 5000;
end;

procedure TfrmEngineeringWindow.N10T1Click(Sender: TObject);
begin
  Timer1.Interval := 10000;
end;

procedure TfrmEngineeringWindow.N15Q1Click(Sender: TObject);
begin
  Timer1.Interval := 15000;
end;

procedure TfrmEngineeringWindow.N20W1Click(Sender: TObject);
begin
  Timer1.Interval := 20000;
end;

procedure TfrmEngineeringWindow.N30H1Click(Sender: TObject);
begin
  Timer1.Interval := 30000;
end;

procedure TfrmEngineeringWindow.L1Click(Sender: TObject);
begin
  try
    frmLogLocation := TfrmLogLocation.Create(nil);
    if frmLogLocation.ShowModal = mrOK then
    begin
      loadPreferenceValue; 
    end;
  finally
    frmLogLocation.Free;
  end;
end;

procedure TfrmEngineeringWindow.btnCreateLogClick(Sender: TObject);
begin

  if btnCreateLog.Tag = 0 then
  begin
    btnCreateLog.Tag := 1;
    btnCreateLog.Caption := 'Stop Log File';
    strList.Clear;
    opTime := Now;
    Timer2.Enabled := True;
  end
  else if btnCreateLog.Tag = 1 then
  begin
    btnCreateLog.Tag := 0;
    btnCreateLog.Caption := 'Create Log File';
    Timer2.Enabled := False;
    closeLogging;

  end
{
  xlApp.Connect; //엑셀을 가동한다(InVisible 상태)
  xlBook.connectto(xlApp.workbooks.add(TOleEnum(xlWBATWorksheet), LCID));
  xlSheet.connectto(xlBook.worksheets.item['Sheet1'] as _worksheet );

  //워크시트 이름 변경
  xlSheet.Name := '날죽여라';


  xlApp.DisplayAlerts[LCID] := False;
  xlApp.Visible[LCID] := true;

  Sheet := xlApp.WorkBooks[xlApp.Workbooks.Count].WorkSheets[xlBook.Worksheets.Count];

  Sheet.Cells[1,1] := '엑셀서식';

  xlApp.Range['A1','A1'].borders.lineStyle := 1;
  xlApp.Range['A1','A1'].borders.Color := clNavy;
  xlApp.Range['A1','A1'].Interior.Color := clYellow;
  //폰트변경
  xlApp.Range[Sheet.Cells[1,1],Sheet.Cells[1,1]].font.bold := true;
  xlApp.Range[Sheet.Cells[1,1],Sheet.Cells[1,1]].font.Size := 20;
  xlApp.Range[Sheet.Cells[1,1],Sheet.Cells[1,1]].font.Name := '궁서';

  //우측정렬(가로정렬)
  xlApp.Range[Sheet.Cells[1,1],Sheet.Cells[1,1]].HorizontalAlignment := xlHAlignRight;
  //가운데 정렬(세로정렬)
  xlApp.Range['B1','B1'].VerticalAlignment := xlHAlignCenter;

  //범위로 찍을 경우
  xlApp.Range['B1','C2'].Value := '123456789';

  //숫자형 포맷
  Format := '_-* #,##0.0_-;-* #,##0.0_-;_-* "-"???_-;_-@_-';
  xlApp.Range['B1','B1'].NumberFormatLocal := Format;

  Sheet.Range['B2', 'C2'].Interior.Color := RGB(223, 123, 123);
  xlApp.Range['B4', 'C4'].Interior.Color := clSilver;

  //날짜찍기
  Sheet.Cells[5,1] := '2002/5/6';
  Sheet.Cells[5,2] := '2002/5/6';

  //숫자형
  Sheet.Cells[5,3] := '12345';
  Sheet.Cells[5,4] := '12345';

  //날짜포맷
  Format := 'yyyy-mm-dd';
  xlSheet.Range[Sheet.Cells[5,1], Sheet.Cells[5,1]].NumberFormat := Format;

  Format := 'mmmm d, yyyy';
  xlSheet.Range[Sheet.Cells[5,2], Sheet.Cells[5,2]].NumberFormat := Format;

  Format := '@';
  xlSheet.Range[Sheet.Cells[5,3], Sheet.Cells[5,3]].NumberFormat := Format;

  xlSheet.Range['B11','B11'].VerticalAlignment := xlHAlignCenter;
  xlSheet.Range['B11','B11'].HorizontalAlignment := xlHAlignRight;
  xlSheet.Range['B11','B11'].Value := '셀병합후 가운데(세로) 정렬';
  xlSheet.Range['B11','B13'].MergeCells := true;
  xlSheet.Range['B11','B13'].borders.LineStyle := 2;

  xlSheet.Range['B15','B15'].borders.lineStyle := 0;
  xlSheet.Range['B15','B15'].HorizontalAlignment := xlHAlignRight;
  xlSheet.Range['B15','B15'].Value := '셀병합후 우측(가로) 정렬';
  xlSheet.Range['B15','D15'].MergeCells := true;
  xlSheet.Range['B15','D15'].borders.LineStyle := 1;

  xlSheet.Range['F15','G20'].MergeCells := true;
  xlSheet.Range['F15','F15'].Value := '다중셀병합';
  xlSheet.Range['F15','G20'].MergeCells := true;
  xlSheet.Range['F15','F15'].HorizontalAlignment := xlHAlignCenter;
  xlSheet.Range['F15','F15'].VerticalAlignment   := xlHAlignCenter;
  xlSheet.Range['F15','G20'].borders.Weight := 4;

  //라인스타일
  for i := 0 to 13 do
  begin
    xlSheet.Range['B'+inttostr((2*i)+16),'B'+inttostr((2*i)+16)].borders.lineStyle := i;
    xlSheet.Range['B'+inttostr((2*i)+16),'B'+inttostr((2*i)+16)].Value := 'borders.lineStyle := '+inttostr(i);
  end;

  //border Weight
  for i := 1 to 4 do
  begin
    xlSheet.Range['B'+inttostr((2*i)+42),'B'+inttostr((2*i)+42)].borders.lineStyle := 1;
    xlSheet.Range['B'+inttostr((2*i)+42),'B'+inttostr((2*i)+42)].borders.Weight := 1;
    xlSheet.Range['B'+inttostr((2*i)+42),'B'+inttostr((2*i)+42)].Value := 'borders.Weight := '+inttostr(i);
  end;

  //라인위치
  xlSheet.Range['D18','D18'].borders.Item[1].LineStyle := 1;
  xlSheet.Range['D18','D18'].Value := 'borders.Item[1].LineStyle := 1';
  xlSheet.Range['D20','D20'].borders.Item[2].LineStyle := 1;
  xlSheet.Range['D20','D20'].Value := 'borders.Item[2].LineStyle := 1';
  xlSheet.Range['D22','D22'].borders.Item[3].LineStyle := 1;
  xlSheet.Range['D22','D22'].Value := 'borders.Item[3].LineStyle := 1';
  xlSheet.Range['D24','D24'].borders.Item[4].LineStyle := 1;
  xlSheet.Range['D24','D24'].Value := 'borders.Item[4].LineStyle := 1';

  //패턴변경
  for i := 1 to 18 do
  begin
    xlSheet.Range['D'+inttostr(i+24),'D'+inttostr(i+24)].Interior.Pattern := i;
    xlSheet.Range['E'+inttostr(i+24),'E'+inttostr(i+24)].Value := 'Interior.Pattern := '+inttostr(i);
  end;
}
{ 이미지를 삽입할경우 실제파일을 기록해야 되기 때문에 주석처리 했습니다.
  실제 파일과 경로명 기록하고 주석푸시고 실행해보세요 ^^
  //백그라운드 이미지
  //xlSheet.SetBackgroundPicture('C:\My Documents\My Pictures\couplevssolo(6).jpg');
  //이미지 입력
  Selection := Sheet.Pictures.Insert('C:\My Documents\My Pictures\302492_2.jpg');
  //이미지위치조절
  Selection.ShapeRange.IncrementLeft(243);
  Selection.ShapeRange.IncrementTop(605);
}

{  //수식입력
  Format := '#,##0.00_ ;-#,##0.00;_-* "-"???_-;_-@_-';
  xlApp.Range['F3','H8'].NumberFormatLocal := Format;

  xlSheet.Range['F3', 'H8'].Formula := '=RAND()*10';
  xlSheet.Range['F9', 'F9'].Formula := '=SUM(F3:F8)';
  xlSheet.Range['G9', 'G9'].Formula := '=SUM(G3:G8)';
  xlSheet.Range['H9', 'H9'].Formula := '=SUM(H3:H8)';
  xlSheet.Range['I9', 'I9'].Formula := '=SUM(F9:H9)';


  xlSheet.Range['F2', 'F2'].Value := '1학년';
  xlSheet.Range['G2', 'G2'].Value := '2학년';
  xlSheet.Range['H2', 'H2'].Value := '3학년';

  xlSheet.Range['E3', 'E3'].Value := '1번';
  xlSheet.Range['E4', 'E4'].Value := '2번';
  xlSheet.Range['E5', 'E5'].Value := '3번';
  xlSheet.Range['E6', 'E6'].Value := '4번';
  xlSheet.Range['E7', 'E7'].Value := '5번';
  xlSheet.Range['E8', 'E8'].Value := '6번';
  xlSheet.Range['E3', 'E8'].HorizontalAlignment := xlHAlignRight;
}

{
  //차트용 오브젝트 생성
  ChObj := (xlSheet.ChartObjects(EmptyParam, lcid) as ChartObjects).Add(600, 10, 400, 250);
  ExcelChart1.ConnectTo(ChObj.Chart as _Chart);
  //데이터 범위(데이터뿐만아니라 가로축 세로축에 찍힐 주석값까지 포함해야함)
  Rnge := xlSheet.Range['E2','H8']; // the data range, including titles
  //차트타입
  ChType := TOleEnum(xl3DColumn);
  ExcelChart1.ChartWizard(Rnge, ChType, EmptyParam, xlColumns, 1, 1, True,
                          xlSheet.Range['A1', 'A1'].Text, // The chart title
                          '번호', '점수', EmptyParam, lcid);
  Ax := ExcelChart1.Axes(xlValue, xlPrimary, lcid) as Axis;
  Ax.AxisTitle.Font.FontStyle := '굴림체';
  //자동으로 컬럼의 폭을 맞춘다.
  xlSheet.Columns.AutoFit;
}
end;

procedure TfrmEngineeringWindow.C1Click(Sender: TObject);
begin
  btnCreateLogClick(self);
end;

procedure TfrmEngineeringWindow.S1Click(Sender: TObject);
begin
  Timer1.Interval := iDisplayInterval * 1000;
end;

procedure TfrmEngineeringWindow.Timer2Timer(Sender: TObject);
var
  Present:TDateTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;

  iBatteryFullCapa, iBatteryRemainCapa, iFuelCellFullCapa, iFuelCellRemainCapa: Single;
  // Total Cell Info (for Page 1)
  fullRemTime: Extended;
  batteryLifePercent: Word;
  batteryLifePercent2: Single;
//  diff: Double;

begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Min, Sec, MSec);
  
  iBatteryFullCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_FULL_CAPA);
  iBatteryRemainCapa := biManager.getDefaultBatteryInfo(BATTERY_SLAVE_ADDR, BATTERY_REM_CAPA);
  iFuelCellFullCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_FULL_CAPA);
  iFuelCellRemainCapa := biManager.getDefaultBatteryInfo(FUELCELL_SLAVE_ADDR, FUELCELL_REM_CAPA);

  if (iBatteryFullCapa <= 0) then iBatteryFullCapa := 1;
  if (iFuelCellFullCapa <= 0) then iFuelCellFullCapa := 1;


  iBatteryPercent := (iBatteryRemainCapa / iBatteryFullCapa) * 100;
  if (iBatteryPercent > 100) then iBatteryPercent := 100;
  iFuelCellPercent := (iFuelCellRemainCapa / iFuelCellFullCapa) * 100;
  if (iFuelCellPercent > 100) then iFuelCellPercent := 100;


  strList.Add(
    IntToStr(Year)+ ':' + IntToStr(Month) + ':' + IntToStr(Day) + ';'
    +Zero_str(Hour, 2)+':'+Zero_str(Min, 2)+':'+Zero_str(Sec, 2)+':'+Zero_str(MSec, 3){IntToStr(Year)+'.'+Zero_str(Month, 2)+'.'+Zero_str(Day, 2)}+';'  // Time
    +getTimeDiff2(Present, opTime)+';'                                           // Op Time
    +FloatToStr(biManager.getBatteryData(STCKTEMP))+';'             // Stack Temp
    +FloatToStr(biManager.getBatteryData(FUELVOLT))+';'             // Stack Volt
    +FloatToStr(biManager.getBatteryData(FUELCURR))+';'             // Stack Curr
    +FloatToStr(biManager.getBatteryData(BATTVOLT))+';'             // Battery Volt
    +FloatToStr(biManager.getBatteryData(BATTCURR))+';'             // Battery Curr
    +FloatToStr(biManager.getBatteryData(NOTEVOLT))+';'             // Output Volt
    +FloatToStr(biManager.getBatteryData(NOTECURR))+';'             // Output Curr
    +FloatToStr(iFuelCellRemainCapa)+';'                            // Fuel Quantity
    +FloatToStr(iBatteryPercent)+';'                                // Battery Quantity
    +getOperationMode(StrToInt(Format('%3.0f', [biManager.getBatteryData(OPERMODE)])))+';' // Op Mode
//    + getCatridgeID(StrToInt(Format('%3.0f', [biManager.getBatteryData(CATRIDID)])))+';'    // Cat ID
    +Format('%3.0f', [biManager.getBatteryData(CATRIDID)])+';' // Cat ID
    );


end;

procedure TfrmEngineeringWindow.mnLogGenerationClick(Sender: TObject);
begin
  mnLogGeneration.Checked := not mnLogGeneration.Checked;

  if (mnLogGeneration.Checked) then
  begin
    mnLogGeneration.Caption := 'Stop Logging(&G)';
    strList.Clear;
    opTime := Now;    
    Timer2.Enabled := True;
  end
  else
  begin
    mnLogGeneration.Caption := 'Start Logging(&G)';
    Timer2.Enabled := False;
    closeLogging;
  end;
end;



procedure TfrmEngineeringWindow.closeLogging;
var
  i: Integer;
  s: String;

  xls: Variant;
  sheet: Variant;
  Present:TDateTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;

  sFileName: String;

begin

  // excel Automation
  try
     xls := CreateOleObject('excel.Application');
  except
     MessageDlg('Failed connet to excel...!', mtError, [mbOk], 0);
     Abort;
  end;

  try
     xls.Visible := False;
     xls.DisplayAlerts := False;
     xls.Workbooks.Open(ExtractFileDir(Application.ExeName)+'\Template2.xls');
  except on E: Exception do
     begin
        MessageDlg(E.Message, mtError, [mbOk], 0);
        xls.Quit;
        xls := UnAssigned;
        Finalize(xls);
        Exit;
     end;
  end;

  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Min, Sec, MSec);

  sheet := xls.Workbooks[1].WorkSheets[1];
  sheet.Cells[3, 11] := '실험일자 : '+IntToStr(Year)+'.'+Zero_str(Month, 2)+'.'+Zero_str(Day, 2);

  for i := 0 to strList.Count - 1 do
  begin
    s := strList.Strings[i];

    sheet.Cells[i+5,1] := GetFieldValue(s, 0, ';');    // Date
    sheet.Cells[i+5,2] := GetFieldValue(s, 1, ';');    // Time
    sheet.Cells[i+5,3] := GetFieldValue(s, 2, ';');    // OP Time
    sheet.Cells[i+5,4] := GetFieldValue(s, 3, ';');    // Stack Temp
    sheet.Cells[i+5,5] := GetFieldValue(s, 4, ';');    // Stack Volt
    sheet.Cells[i+5,6] := GetFieldValue(s, 5, ';');    // Stack Curr
    sheet.Cells[i+5,7] := GetFieldValue(s, 6, ';');    // Battery Volt
    sheet.Cells[i+5,8] := GetFieldValue(s, 7, ';');    // Battery Curr
    sheet.Cells[i+5,9] := GetFieldValue(s, 8, ';');    // Output Volt
    sheet.Cells[i+5,10] := GetFieldValue(s, 9, ';');   // Output Curr
    sheet.Cells[i+5,11] := GetFieldValue(s, 10, ';');  // Fuel Quantity
    sheet.Cells[i+5,12] := GetFieldValue(s, 11, ';');  // Battery Quantity
    sheet.Cells[i+5,13] := GetFieldValue(s, 12, ';');  // Op Mode
    sheet.Cells[i+5,14] := GetFieldValue(s, 13, ';');  // Cat ID

  end;

  sheet.Range['A5','N'+IntToStr(i+4)].borders.LineStyle := 1;

  sheet.Columns.AutoFit;

  sFileName := getFileNameFromDateTime(sLogLocation+'\'+'sdi_', '.xls');
  xls.Workbooks[1].SaveAs(sFileName);

  xls.Quit;
  xls := UnAssigned;
  Finalize(xls);
  ShowMessage('Finished making log file : ' + sFileName);

end;

procedure TfrmEngineeringWindow.createLogfile;
var
  xls: Variant;
  sheet: Variant;

  i: Integer;
  s: String;

  Present:TDateTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;

  sFileName: String;


begin

  // excel Automation
  try
     xls := CreateOleObject('excel.Application');
  except
     MessageDlg('Failed connet to excel...!', mtError, [mbOk], 0);
     Abort;
  end;

  try
     xls.Visible := False;
     xls.DisplayAlerts := False;
     xls.Workbooks.Open(ExtractFileDir(Application.ExeName)+'\Template1.xls');
  except on E: Exception do
     begin
        MessageDlg(E.Message, mtError, [mbOk], 0);
        xls.Quit;
        xls := UnAssigned;
        Finalize(xls);
        Exit;
     end;
  end; 

  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  DecodeTime(Present, Hour, Min, Sec, MSec);

  sheet := xls.Workbooks[1].WorkSheets[1];
  sheet.Cells[5,1] := IntToStr(Year)+'.'+Zero_str(Month, 2)+'.'+Zero_str(Day, 2);  //V > Order
  sheet.Cells[5,2] := Zero_str(Hour, 2)+':'+Zero_str(Min, 2)+':'+Zero_str(Sec, 2)+':'+Zero_str(MSec, 3);
  sheet.Cells[5,3] := ''; //구동시간
  sheet.Cells[5,4] := ''; // Stack 온도
  sheet.Cells[5,5] := biManager.getBatteryData(FUELVOLT);
  sheet.Cells[5,6] := biManager.getBatteryData(FUELCURR);
  sheet.Cells[5,7] := biManager.getBatteryData(BATTVOLT);
  sheet.Cells[5,8] := biManager.getBatteryData(BATTCURR);
  sheet.Cells[5,9] := biManager.getBatteryData(NOTEVOLT);
  sheet.Cells[5,10] := biManager.getBatteryData(NOTECURR);
  sheet.Cells[5,11] := '';  // 연료잔량
  sheet.Cells[5,12] := '';  // 구동모드
  sheet.Cells[3, 10] := '실험일자 : '+IntToStr(Year)+'.'+Zero_str(Month, 2)+'.'+Zero_str(Day, 2);

  sheet.Columns.AutoFit;

  sFileName := getFileNameFromDateTime(sLogLocation+'\'+'sdi_', '.xls');
  xls.Workbooks[1].SaveAs(sFileName);

  xls.Quit;
  xls := UnAssigned;
  Finalize(xls);

end;

procedure TfrmEngineeringWindow.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  DeleteCriticalSection(CS);

  strList.Free;
  strList := nil;
  
  Timer1.Enabled := false;
  Timer2.Enabled := false;

end;

end.
