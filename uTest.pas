unit uTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinInet, UrlMon;

const
  WM_EXESSFUEL = WM_USER + 2038;

  BATTERY_DETAIL_TYPE = $01;
  FUELCELL_DETAIL_TYPE = $02;

  // SABI interface constants (for page 2)
  FUELVOLT = $01; // 01h - Static Voltage (Fuel)
  FUELCURR = $08; // 08h - Static Current (Fuel)
  BATTVOLT = $09; // 09h - Battery Voltage
  BATTCURR = $0D; // 0Dh - Battery Current
  NOTEVOLT = $012;// 012h - NPC Voltage
  NOTECURR = $016;// 016h - NPC Current

  // SABI New values
  STCKTEMP = $018; // 018h - Stack Temperature
  RECYCLER = $01A; // 01Ah - Recycler Level count
  OPERMODE = $00B; // 00Bh - Operation Mode
  CATRIDID = $01C; // 01Ch - Catdridge ID
  CATDENSE = $00C; // 00Ch - Catdridge DENSITY
  CATCAPAC = $00E; // 00Eh - Catdridge CAPACITY

  // SABI interface constants (For page 1)
  BATTERY_REM_CAPA = $0F; // 0x0F - Battery remaining capacity
  BATTERY_FULL_CAPA = $10;  // 0x10 - Battery full capacity
  BATTERY_SLAVE_ADDR = $16;  // 16 (DECIMAL?) slave adress[16]_1Byte

  FUELCELL_REM_CAPA = $0F; // 0x0F - Fuelcell remaining capacity
  FUELCELL_FULL_CAPA = $10;  // 0x10 - Fuelcell full capacity
  FUELCELL_SLAVE_ADDR = $1A;  // 16 (DECIMAL?) slave adress[16]_1Byte

  // distance panel and label in page 1 of user mode 1st page
  DIST = 23;
   

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ResultLabel: TLabel;
    FoldersComboBox: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetPathLabel;
  public
    { Public declarations }

    function initBios: Integer;
    function getBatteryData(command: BYTE): Single;
    function getDefaultBatteryInfo(slaveAddr: BYTE; command: BYTE): Single;
    procedure getRecyclerData(var iodata2: BYTE);
    procedure DeleteIECache;
    procedure getFileInIECache;


  end;

var
  Form1: TForm1;
  sParam: String;


const

  EZBOXDLL = 'FuelGaugeDll.dll';


function DllInitBIOSInterface: Integer; cdecl;
function DllCallBIOSInterface(sf: Word; var data: array of BYTE):Integer; cdecl;


implementation

uses clsMain, ShFolder;

{$R *.dfm}

function DllInitBIOSInterface: Integer; cdecl; external EZBOXDLL;
function DllCallBIOSInterface(sf: Word; var data: array of BYTE):Integer; cdecl; external EZBOXDLL;

function GetIeCacheFilenameFromUrl(const Url: string; var Filename:string) : boolean;
var
  info: PInternetCacheEntryInfo;
  size: DWORD;
begin
  result := False;
{  size := 0;
  GetUrlCacheEntryInfo(PAnsiChar(Url), nil, size);
  if size = 0 then exit;
  GetMem(info, size);
  try
    Info^.dwStructSize := SizeOf(TInternetCacheEntryInfo);
    Result := GetUrlCacheEntryInfo(PChar(Url), Info, Size);
    if Result then Filename := Info^.lpszLocalFileName;
  finally
    FreeMem(Info, Size);
  end;
}
end;




procedure TForm1.getRecyclerData(var iodata2: BYTE);
var
  inWord: WORD;
  IO: array[0..2] of BYTE;
//  ir: Integer;
begin
  inWord := $51;
  IO[1] := $1A;
  IO[2] := $19;

  {ir := }DllCallBIOSInterface(inWord, IO);

  iodata2 := IO[1];


end;

function TForm1.initBios: Integer;
begin

   result := DllInitBIOSInterface;

end;

function TForm1.getBatteryData(command: BYTE): Single;
var
  inWord: WORD;
  IO: array[0..2] of BYTE;
//  ir: Integer;
begin
  inWord := $51;
  IO[1] := $1A;
  IO[2] := command;

  {ir := }DllCallBIOSInterface(inWord, IO);


  result := IO[1]/10;

end;

function TForm1.getDefaultBatteryInfo(slaveAddr: BYTE; command: BYTE): Single;
var
  inWord: WORD;
  IO: array[0..2] of BYTE;
//  ir: Integer;
begin
  inWord := $51;
  IO[1] := slaveAddr;
  IO[2] := command;

  {ir := }DllCallBIOSInterface(inWord, IO);

  result := MAKEWORD(IO[1], IO[2]);

end;

function FloatToInteger(f: Single): Integer;
var
  S: String;
begin
  result := round(f);

(*  try
    S := FloatToStr(f);
    //ShowMessage(IntToStr(Pos('.', S)));
    if (Pos('.', S)= 0) then
      result := StrToInt(S)
    else
      result := StrToInt(Copy(S, 0, Pos('.', S)-1));
  except
    result := 0;
  end;
*)
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  iCatID: Single;
  iDensity: Single;
  iCapac: Single;
begin

  iCatID := getBatteryData(CATRIDID);
  iCapac := getDefaultBatteryInfo($1A, CATCAPAC);
  iDensity := getDefaultBatteryInfo($1A,CATDENSE);


  Edit3.Text := FloatToStr(iDensity);
  Edit4.Text := FloatToStr(iCapac);
  Edit5.Text := IntToStr(FloatToInteger(iCatID));

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   DeleteIECache;
(*   RetrieveUrlCacheEntryFile(
    lpszUrlName: PAnsiChar;
    var lpCacheEntryInfo: TInternetCacheEntryInfo;
    var lpdwCacheEntryInfoBufferSize: DWORD;
    dwReserved: DWORD
   ): BOOL; stdcall;
*)
end;

procedure TForm1.getFileInIECache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
  downResult: HRESULT;
  sfile: String;
begin
   dwEntrySize := 0;
   FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
   GetMem(lpEntryInfo, dwEntrySize);
   if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
   hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize) ;
   if hCacheDir <> 0 then
   begin
     repeat
      sfile := lpEntryInfo^.lpszLocalFileName;

      if (sfile = sParam) then
      begin
        downResult := URLDownloadToFile(nil, PChar(lpEntryInfo^.lpszSourceUrlName), PChar('c:\apm\test.skn'), 0, nil);
        
      end;

      FreeMem(lpEntryInfo, dwEntrySize) ;
      dwEntrySize := 0;
      FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
      GetMem(lpEntryInfo, dwEntrySize) ;

      if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
    until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize) ;
  end;
  FreeMem(lpEntryInfo, dwEntrySize) ;
  FindCloseUrlCache(hCacheDir) ;

end;

procedure TForm1.DeleteIECache;
var
  lpEntryInfo, le2: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
  downResult: HRESULT;
  sfile: String;
begin
   dwEntrySize := 0;
   FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
   GetMem(lpEntryInfo, dwEntrySize);
   if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
   hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize) ;
   if hCacheDir <> 0 then
   begin
     repeat
      sfile := lpEntryInfo^.lpszLocalFileName;
      if (Copy(sfile, Length(sfile)-3, Length(sfile)-1) = '.skn') then
      begin
        GetMem(le2, dwEntrySize);
//        getInternetCacheEntry(sfile, le2);

        showmessage(sfile);
        downResult := URLDownloadToFile(nil, PChar(le2^.lpszSourceUrlName){'http://localhost/Luched-new.exe'}, PChar('c:\test.skn'), 0, nil);
        FreeMem(le2, dwEntrySize);
      end;

       //ExecuteUrl(lpEntryInfo^.lpszSourceUrlName);

       //DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName) ;
       FreeMem(lpEntryInfo, dwEntrySize) ;
       dwEntrySize := 0;
       FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize) ;
       GetMem(lpEntryInfo, dwEntrySize) ;
       if dwEntrySize > 0 then lpEntryInfo^.dwStructSize := dwEntrySize;
     until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize) ;
   end;
   FreeMem(lpEntryInfo, dwEntrySize) ;
   FindCloseUrlCache(hCacheDir) ;


end;

procedure TForm1.Button3Click(Sender: TObject);
var
  downResult: HRESULT;
begin
(*
//  DeleteUrlCacheEntry(PChar(getWindowsTempFolder + FInstallerName));

  try
    try
//      bsc := TBindStatusCallback.Create(JvProgressBar1, Label1);
      downResult := URLDownloadToFile(nil, PChar(FInstallerURL+FInstallerName){'http://localhost/Luched-new.exe'}, PChar(getWindowsTempFolder + FInstallerName), 0, bsc);
    except
      begin
//        msgLabel1.Caption := 'Luched 설치 프로그램 다운로드를 실패했습니다.';
//        msgLabel2.Caption := '알수없는 오류입니다... 잠시후에 다시 시도하십시요.';
      end;
    end;
  finally
    bsc.Free;
  end;

  case downResult of
  S_OK:
    begin
      CreateProcessSimple(PChar(getWindowsTempFolder + FInstallerName));
      msgLabel1.Caption := 'Luched 설치 프로그램 다운로드가 완료되었습니다.';
      msgLabel2.Caption := 'Luched 설치 프로그램을 실행합니다....';

      if self.FormState = [fsCreating] then
        ShowMessage('1')
      else if self.FormState = [fsVisible] then
        ShowMessage('2')
      else if self.FormState = [fsShowing] then
        ShowMessage('3')
      else if self.FormState = [fsModal] then
        ShowMessage('4')
      else if self.FormState = [fsCreatedMDIChild] then
        ShowMessage('5')
      else if self.FormState = [fsActivated] then
        ShowMessage('6')
      else
        ShowMessage('7');

      Timer1.Enabled := true;
    end;
  E_OUTOFMEMORY:
    begin
      msgLabel1.Caption := 'Luched 설치 프로그램 다운로드를 실패했습니다.';
      msgLabel2.Caption := '메모리 오류입니다... 잠시후에 다시 시도하십시요.';

      imgRetry.Visible := true;
      
      //ShowMessage('Download OutofMemory Error');
    end;
  INET_E_DOWNLOAD_FAILURE:
    begin
      msgLabel1.Caption := 'Luched 설치 프로그램 다운로드를 실패했습니다.';
      msgLabel2.Caption := '네트워크 오류 입니다... 잠시후에 다시 시도하십시요.';

      imgRetry.Visible := true;

      //ShowMessage('Download Inet Error');
    end;
  end;
*)
end;

procedure TForm1.FormCreate(Sender: TObject);
begin 
  getFileInIECache;
end;

procedure TForm1.SetPathLabel;
const
  CSIDLs: array[-1..14] of Integer = (0,
    CSIDL_PERSONAL, CSIDL_APPDATA, CSIDL_LOCAL_APPDATA, CSIDL_INTERNET_CACHE,
    CSIDL_COOKIES, CSIDL_HISTORY, CSIDL_COMMON_APPDATA, CSIDL_WINDOWS,
    CSIDL_SYSTEM, CSIDL_PROGRAM_FILES, CSIDL_MYPICTURES,
    CSIDL_PROGRAM_FILES_COMMON, CSIDL_COMMON_DOCUMENTS,
    CSIDL_COMMON_ADMINTOOLS, CSIDL_ADMINTOOLS);
var
  Path: array[0..MAX_PATH] of Char;
begin
  if Succeeded(SHGetFolderPath(Handle, CSIDLs[FoldersComboBox.ItemIndex], 0,
                 SHGFP_TYPE_CURRENT, Path)) and
     (StrLen(Path) <> 0) then
    ResultLabel.Caption := Path
  else
    ResultLabel.Caption := 'Path not available on this system';
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SetPathLabel;
end;

end.
