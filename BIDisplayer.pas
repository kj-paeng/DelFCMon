(*
Battery Image Displayer
*)
unit BIDisplayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList, uBiosInterface, uRoleOverImage;

type
  TBIDisplayer = class(TObject)
(*
    imgPowerStatus: TImage;
    imgBatteryStatus: TImage;
    imgFuelStatus: TImage;
    img_NPC: TImage;
    img_Battery: TImage;
    img_Fuel: TImage;
*)
    lblPowerPercent: TLabel;
    FTempBmp: TBitMap;

    constructor Create;
    destructor Destroy; override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure setPowerImage(var img: TImage; pct: Byte); overload;
    procedure setBatteryImage(var img: TImage; pct: Byte; isFocused: Boolean); overload;
    procedure setBatteryImage(var img: TRollOverImage; pct: Byte; isFocused: Boolean); overload;
//    procedure setFuelImage(var img: TImage; pct: Byte; isFocused: Boolean); overload;
    procedure setFuelImage(var img: TRollOverImage; pct: Byte; isFocused: Boolean); overload;
    procedure setPowerDetailImage(var img: TImage; pct: Byte); overload;
    procedure setPowerDetailImage(var img: TRollOverImage; pct: Byte); overload;
    procedure setBatteryDetailImage(var img: TImage; pct: Byte); overload;
    procedure setBatteryDetailImage(var img: TRollOverImage; pct: Byte); overload;
    procedure setFuelDetailImage(var img: TImage; pct: Byte); overload;
    procedure setFuelDetailImage(var img: TRollOverImage; pct: Byte); overload;
    procedure setProgressImage(var img: TImage; pct: Single); overload;


    // for Popup Detail form
    procedure setBatteryPopupImage(var img: TImage; pct: Byte);
    procedure setFuelcellPopupImage(var img: TImage; pct: Byte);

    // for page1 Tab menu
    procedure setMainTabImage(var img: TImage; main, disable: Byte);

    // for OK Button page 1
    procedure setOKImage(var img: TRollOverImage; isFocosed: Boolean);
    procedure setFlashImage(var img: TImage; idx: Byte; var f: TForm); overload;
    procedure setFlashImage(p: TPoint; idx: Byte; var f: TForm); overload;

    procedure setImage(r: TRect; imgName: String; var f: TForm);

    // for Alert Image
    procedure setBatteryAlertImage(var img: TImage); overload;
    procedure setBatteryAlertImage(var img: TRollOverImage); overload;
    procedure setFuelAlertImage(var img: TImage); overload;
    procedure setFuelAlertImage(var img: TRollOverImage); overload;
    procedure setAlertBackImg(var img: TImage;nls: Byte);
  end;

implementation

uses clsMain;

var
  imgDir: String;
  imgPowerImageFile: String;
  imgBatteryImageFile: String;
  imgFuelImageFile: String;
  imgPowerDetailFile: String;
  imgBatteryDetailFile: String;
  imgFuelDetailFile: String;

  imgBatteryPopupFile: String;
  imgFuelCellPopupFile: String;

  alert1, alert2: Byte;

constructor TBIDisplayer.Create;
begin
  imgDir := getRegValue('imagesDir');
  if (imgDir = '') then imgDir :=  Copy(Application.ExeName, 1, getLastCharPos(Application.ExeName, '\')-1);
  if (strEndsWith(imgDir, '\')) then
    imgDir := Copy(imgDir, 1, Length(imgDir)-1);

  imgPowerImageFile     :='';
  imgBatteryImageFile   :='';
  imgFuelImageFile      :='';
  imgPowerDetailFile    :='';
  imgBatteryDetailFile  :='';
  imgFuelDetailFile     :='';
  imgBatteryPopupFile   :='';
  imgFuelCellPopupFile  :='';

  FTempBmp := TBitMap.Create;
  
end;

procedure TBIDisplayer.setProgressImage(var img: TImage; pct: Single);
var
  curImgFile: String;
  idx: Integer;
begin
  pct := pct/1.25; // (100 /80 )
  idx := getIntegerFromFloat(pct);

  if (idx >80) then idx := 80;
  if (idx < 1) then idx := 1;

  curImgFile := imgDir+'\imgs\2\progress\'+IntToStr(idx)+'.bmp';
{$IFDEF DEBUG}
  WriteLog('setProgressImage', curImgFile);
{$ENDIF}
  img.Picture.LoadFromFile(curImgFile);

end;

destructor TBIDisplayer.Destroy;
begin
  FTempBmp.Free;
  inherited destroy;
end;


procedure TBIDisplayer.setPowerImage(var img: TImage; pct: Byte);
var
  curImgFile: String;
begin
  lblPowerPercent.Caption := IntToStr(pct) + ' %';

  if (pct < 10) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\npc_icon\\0.bmp'
  end else if (pct >=10) and (pct < 30) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\npc_icon\\1.bmp'
  end else if (pct >=30) and (pct <50) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\npc_icon\\2.bmp'
  end else if (pct >=50) and (pct <70) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\npc_icon\\3.bmp'
  end else if (pct >=70) and (pct <85) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\npc_icon\\4.bmp'
  end else if (pct >=85) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\npc_icon\\5.bmp'
  end;

  //
  if (Length(Trim(imgPowerImageFile))=0) then
  begin
    imgPowerImageFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgPowerImageFile <> curImgFile) then
    begin
      imgPowerImageFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;

procedure TBIDisplayer.setBatteryImage(var img: TImage; pct: Byte; isFocused: Boolean);
var
  curImgFile: String;
begin
// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    if (isFocused) then curImgFile := imgDir+'\images\kr\ani\battery1\0-0.bmp'
    else curImgFile := imgDir+'\images\kr\ani\battery1\0.bmp'
  end else if (pct >=10) and (pct < 25) then
  begin
    if (isFocused) then curImgFile := imgDir+'\images\kr\ani\battery1\0-1.bmp'
    else curImgFile := imgDir+'\images\kr\ani\battery1\1.bmp';
  end else if (pct >=25) and (pct <55) then
  begin
    if (isFocused) then curImgFile := imgDir+'\images\kr\ani\battery1\0-2.bmp.bmp'
    else curImgFile := imgDir+'\images\kr\ani\battery1\2.bmp';
  end else if (pct >=55) and (pct <80) then
  begin
    if (isFocused) then curImgFile := imgDir+'\images\kr\ani\battery1\0-3.bmp'
    else curImgFile := imgDir+'\images\kr\ani\battery1\3.bmp'
  end else if (pct >=80) and (pct <95) then
  begin
    if (isFocused) then curImgFile := imgDir+'\images\kr\ani\battery1\0-4.bmp'
    else curImgFile := imgDir+'\images\kr\ani\battery1\4.bmp';
  end else if (pct >=95) and (pct <= 100) then
  begin
    if (isFocused) then curImgFile := imgDir+'\images\kr\ani\battery1\0-5.bmp'
    else curImgFile := imgDir+'\images\kr\ani\battery1\5.bmp';
  end;

  if (Length(Trim(imgBatteryImageFile))=0) then
  begin
    imgBatteryImageFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgBatteryImageFile <> curImgFile) then
    begin
      imgBatteryImageFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;

procedure TBIDisplayer.setBatteryImage(var img: TRollOverImage; pct: Byte; isFocused: Boolean);
var
  curImgFile: String;
  curOverImgFile: String;
begin
// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\battery1\0-0.bmp';
    curImgFile := imgDir+'\images\kr\ani\battery1\0.bmp';
  end else if (pct >=10) and (pct < 25) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\battery1\0-1.bmp';
    curImgFile := imgDir+'\images\kr\ani\battery1\1.bmp';
  end else if (pct >=25) and (pct <55) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\battery1\0-2.bmp.bmp';
    curImgFile := imgDir+'\images\kr\ani\battery1\2.bmp';
  end else if (pct >=55) and (pct <80) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\battery1\0-3.bmp';
    curImgFile := imgDir+'\images\kr\ani\battery1\3.bmp';
  end else if (pct >=80) and (pct <95) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\battery1\0-4.bmp' ;
    curImgFile := imgDir+'\images\kr\ani\battery1\4.bmp';
  end else if (pct >=95) and (pct <= 100) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\battery1\0-5.bmp';
    curImgFile := imgDir+'\images\kr\ani\battery1\5.bmp';
  end;

  if (Length(Trim(imgBatteryImageFile))=0) then
  begin
    imgBatteryImageFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
    img.OverPicture.LoadFromFile(curOverImgFile);
    img.OutPicture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgBatteryImageFile <> curImgFile) then
    begin
      imgBatteryImageFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
      img.OverPicture.LoadFromFile(curOverImgFile);
      img.OutPicture.LoadFromFile(curImgFile);
    end;
  end;
end;

procedure TBIDisplayer.setFuelImage(var img: TRollOverImage; pct: Byte; isFocused: Boolean);
var
  curImgFile: String;
  curOverImgFile: String;

begin

// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\fuel1\0-0.bmp';
    curImgFile := imgDir+'\images\kr\ani\fuel1\0.bmp';
  end else if (pct >=10) and (pct < 25) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\fuel1\0-1.bmp';
    curImgFile := imgDir+'\images\kr\ani\fuel1\1.bmp';
  end else if (pct >=25) and (pct <55) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\fuel1\0-2.bmp';
    curImgFile := imgDir+'\images\kr\ani\fuel1\2.bmp';
  end else if (pct >=55) and (pct <80) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\fuel1\0-3.bmp';
    curImgFile := imgDir+'\images\kr\ani\fuel1\3.bmp';
  end else if (pct >=80) and (pct <95) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\fuel1\0-4.bmp';
    curImgFile := imgDir+'\images\kr\ani\fuel1\4.bmp';
  end else if (pct >=95) and (pct <= 100) then
  begin
    curOverImgFile := imgDir+'\images\kr\ani\fuel1\0-5.bmp';
    curImgFile := imgDir+'\images\kr\ani\fuel1\5.bmp';
  end;

  if (Length(Trim(imgFuelImageFile))=0) then
  begin
    imgFuelImageFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
    img.OverPicture.LoadFromFile(curOverImgFile);
    img.OutPicture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgFuelImageFile <> curImgFile) then
    begin
      imgFuelImageFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
      img.OverPicture.LoadFromFile(curOverImgFile);
      img.OutPicture.LoadFromFile(curImgFile);
    end;
  end;
end;


procedure TBIDisplayer.setPowerDetailImage(var img: TImage; pct: Byte);
var
  curImgFile: String;
begin

  if (pct < 5) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\0_0.bmp'
  end else if (pct >=5) and (pct < 15) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\0.bmp'
  end else if (pct >=15) and (pct <30) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\1.bmp'
  end else if (pct >=30) and (pct <50) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\2.bmp'
  end else if (pct >=50) and (pct <70) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\3.bmp'
  end else if (pct >=70) and (pct <= 85) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\4.bmp'
  end else if (pct >=85) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\5.bmp'
  end;

  if (Length(Trim(imgPowerDetailFile))=0) then
  begin
    imgPowerDetailFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgPowerDetailFile <> curImgFile) then
    begin
      imgPowerDetailFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;

procedure TBIDisplayer.setPowerDetailImage(var img: TRollOverImage; pct: Byte);
var
  curImgFile: String;
begin

  if (pct < 5) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\0_0.bmp'
  end else if (pct >=5) and (pct < 15) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\0.bmp'
  end else if (pct >=15) and (pct <30) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\1.bmp'
  end else if (pct >=30) and (pct <50) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\2.bmp'
  end else if (pct >=50) and (pct <70) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\3.bmp'
  end else if (pct >=70) and (pct <= 85) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\4.bmp'
  end else if (pct >=85) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\\imgs\\2\\npc_icon\\5.bmp'
  end;

  if (Length(Trim(imgPowerDetailFile))=0) then
  begin
    imgPowerDetailFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgPowerDetailFile <> curImgFile) then
    begin
      imgPowerDetailFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;


procedure TBIDisplayer.setBatteryDetailImage(var img: TImage; pct: Byte);
var
  curImgFile: String;
begin
// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\0.bmp'
  end else if (pct >=10) and (pct < 25) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\1.bmp'
  end else if (pct >=25) and (pct <55) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\2.bmp'
  end else if (pct >=55) and (pct <80) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\3.bmp'
  end else if (pct >=80) and (pct <95) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\4.bmp'
  end else if (pct >=95) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\5.bmp'
  end;

  if (Length(Trim(imgBatteryDetailFile))=0) then
  begin
    imgBatteryDetailFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgBatteryDetailFile <> curImgFile) then
    begin
      imgBatteryDetailFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;

procedure TBIDisplayer.setBatteryDetailImage(var img: TRollOverImage; pct: Byte);
var
  curImgFile: String;
begin
// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\0.bmp'
  end else if (pct >=10) and (pct < 25) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\1.bmp'
  end else if (pct >=25) and (pct <55) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\2.bmp'
  end else if (pct >=55) and (pct <80) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\3.bmp'
  end else if (pct >=80) and (pct <95) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\4.bmp'
  end else if (pct >=95) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery2\5.bmp'
  end;

  if (Length(Trim(imgBatteryDetailFile))=0) then
  begin
    imgBatteryDetailFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgBatteryDetailFile <> curImgFile) then
    begin
      imgBatteryDetailFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;


procedure TBIDisplayer.setFuelDetailImage(var img: TImage; pct: Byte);
var
  curImgFile: String;
begin
// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\0.bmp'
  end else if (pct >=10) and (pct < 25) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\1.bmp'
  end else if (pct >=25) and (pct <55) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\2.bmp'
  end else if (pct >=55) and (pct <80) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\3.bmp'
  end else if (pct >=80) and (pct <95) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\4.bmp'
  end else if (pct >=95) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\5.bmp'
  end;

  if (Length(Trim(imgFuelDetailFile))=0) then
  begin
    imgFuelDetailFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgFuelDetailFile <> curImgFile) then
    begin
      imgFuelDetailFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;

procedure TBIDisplayer.setFuelDetailImage(var img: TRollOverImage; pct: Byte);
var
  curImgFile: String;
begin

  if (pct < 10) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\0.bmp'
  end else if (pct >=10) and (pct < 25) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\1.bmp'
  end else if (pct >=25) and (pct <55) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\2.bmp'
  end else if (pct >=55) and (pct <80) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\3.bmp'
  end else if (pct >=80) and (pct <95) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\4.bmp'
  end else if (pct >=95) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel2\5.bmp'
  end;

  if (Length(Trim(imgFuelDetailFile))=0) then
  begin
    imgFuelDetailFile := curImgFile;
    img.Picture.LoadFromFile(curImgFile);
  end else
  begin
    if (imgFuelDetailFile <> curImgFile) then
    begin
      imgFuelDetailFile := curImgFile;
      img.Picture.LoadFromFile(curImgFile);
    end;
  end;
end;

procedure TBIDisplayer.setBatteryPopupImage(var img: TImage; pct: Byte);
var
  curImgFile: String;
begin

// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupbattery\0.bmp'
  end else if (pct >=10) and (pct < 25) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupbattery\1.bmp';
  end else if (pct >=25) and (pct <55) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupbattery\2.bmp';
  end else if (pct >=55) and (pct <80) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupbattery\3.bmp'
  end else if (pct >=80) and (pct <95) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupbattery\4.bmp';
  end else if (pct >=95) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupbattery\5.bmp';
  end;

  img.Picture.LoadFromFile(curImgFile);

end;

procedure TBIDisplayer.setFuelcellPopupImage(var img: TImage; pct: Byte);
var
  curImgFile: String;
begin

// 10 25 55 80 95 100
  if (pct < 10) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupfuel\0.bmp'
  end else if (pct >=10) and (pct < 25) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupfuel\1.bmp';
  end else if (pct >=25) and (pct <55) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupfuel\2.bmp';
  end else if (pct >=55) and (pct <80) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupfuel\3.bmp'
  end else if (pct >=80) and (pct <95) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupfuel\4.bmp';
  end else if (pct >=95) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\images\kr\ani\popupfuel\5.bmp';
  end;

  img.Picture.LoadFromFile(curImgFile);


{
  if (pct < 5) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\fuelcell_icon\\0_0.bmp'
  end else if (pct >=5) and (pct < 15) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\fuelcell_icon\\0.bmp'
  end else if (pct >=15) and (pct <30) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\fuelcell_icon\\1.bmp'
  end else if (pct >=30) and (pct <50) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\fuelcell_icon\\2.bmp'
  end else if (pct >=50) and (pct <70) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\fuelcell_icon\\3.bmp'
  end else if (pct >=70) and (pct <= 85) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\fuelcell_icon\\4.bmp'
  end else if (pct >=85) and (pct <= 100) then
  begin
    curImgFile := imgDir+'\\imgs\\1\\fuelcell_icon\\5.bmp'
  end;

  img.Picture.LoadFromFile(curImgFile);
}

end;

procedure TBIDisplayer.setMainTabImage(var img: TImage; main, disable: Byte);
var
  curImgFile: String;
begin
{
  imgDisplayer.setMainTabImage(TI0, 1, 1); // first enabled
  imgDisplayer.setMainTabImage(TI1, 2, 2); // first disabled
  imgDisplayer.setMainTabImage(TI2, 2, 1); // second enabled
  imgDisplayer.setMainTabImage(TI4, 2, 2); // second disabled
}
{$IFDEF EN}
  if main = 1 then
  begin
    if disable = 1 then
      curImgFile := imgDir+'\images\en\button\maintab01.bmp'
    else if disable = 2 then
      curImgFile := imgDir+'\images\en\button\maintab01dis.bmp';
  end
  else if main = 2 then
  begin
    if disable = 1 then
      curImgFile := imgDir+'\images\en\button\maintab02.bmp'
    else if disable = 2 then
      curImgFile := imgDir+'\images\en\button\maintab02dis.bmp';
  end;

{$ELSE}
  if main = 1 then
  begin
    if disable = 1 then
      curImgFile := imgDir+'\images\kr\button\maintab01.bmp'
    else if disable = 2 then
      curImgFile := imgDir+'\images\kr\button\maintab01dis.bmp';
  end
  else if main = 2 then
  begin
    if disable = 1 then
      curImgFile := imgDir+'\images\kr\button\maintap02.bmp'
    else if disable = 2 then
      curImgFile := imgDir+'\images\kr\button\maintap02dis.bmp';
  end;
{$ENDIF}
  img.Picture.LoadFromFile(curImgFile);

end;

procedure TBIDisplayer.setOKImage(var img: TRollOverImage; isFocosed: Boolean);
var
  curImgFile: String;
  curOverImgFile: String;
begin
{$IFDEF EN}
   curOverImgFile := imgDir+'\images\en\button\btn_ok_roll.bmp';
   curImgFile := imgDir+'\images\en\button\btn_ok.bmp';
{$ELSE}
   curOverImgFile := imgDir+'\images\kr\button\btn_ok_roll.bmp';
   curImgFile := imgDir+'\images\kr\button\btn_ok.bmp';
{$ENDIF}
  img.Picture.LoadFromFile(curImgFile);
  img.OutPicture.LoadFromFile(curImgFile);
  img.OverPicture.LoadFromFile(curOverImgFile);


end;

procedure TBIDisplayer.setFlashImage(var img: TImage; idx: Byte; var f: TForm);
var
  curImgFile: String;
begin
{$IFDEF EN}
  curImgFile := imgDir+'\images\en\ani\'+IntToStr(idx)+'.bmp';
{$ELSE}
  curImgFile := imgDir+'\images\kr\ani\'+IntToStr(idx)+'.bmp';
{$ENDIF}
  FTempBmp.LoadFromFile(curImgFile);
  BitBlt(f.Canvas.Handle, img.Left, img.Height, FTempBmp.Width, FTempBmp.Height, FTempBmp.Canvas.Handle, 0,0, SRCCOPY);
end;

procedure TBIDisplayer.setFlashImage(p: TPoint; idx: Byte; var f: TForm);
var
  curImgFile: String;
begin
{$IFDEF EN}
  curImgFile := imgDir+'\images\en\ani\'+IntToStr(idx)+'.bmp';
{$ELSE}
  curImgFile := imgDir+'\images\kr\ani\'+IntToStr(idx)+'.bmp';
{$ENDIF}
  FTempBmp.LoadFromFile(curImgFile);
  BitBlt(f.Canvas.Handle, p.X, p.y, FTempBmp.Width, FTempBmp.Height, FTempBmp.Canvas.Handle, 0,0, SRCCOPY);
end;

procedure TBIDisplayer.setImage(r: TRect; imgName: String; var f: TForm);
var
  curImgFile: String;
begin
  curImgFile := imgDir+imgName;
  FTempBmp.LoadFromFile(curImgFile);
  BitBlt(f.Canvas.Handle, r.Left, r.Top, FTempBmp.Width, FTempBmp.Height, FTempBmp.Canvas.Handle, 0,0, SRCCOPY);

end;

procedure TBIDisplayer.setBatteryAlertImage(var img: TImage);
var
  curImgFile: String;
begin

  if (alert1 = 0) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery1\alert0.bmp';
    alert1 := 1;
  end
  else
  begin
    curImgFile := imgDir+'\images\kr\ani\battery1\alert1.bmp';
    alert1 := 0;
  end;

  img.Picture.LoadFromFile(curImgFile);
end;

procedure TBIDisplayer.setBatteryAlertImage(var img: TRollOverImage);
var
  curImgFile: String;
begin

  if (alert1 = 0) then
  begin
    curImgFile := imgDir+'\images\kr\ani\battery1\alert0.bmp';
    alert1 := 1;
  end
  else
  begin
    curImgFile := imgDir+'\images\kr\ani\battery1\alert1.bmp';
    alert1 := 0;
  end;

  img.Picture.LoadFromFile(curImgFile);
  img.OverPicture.LoadFromFile(curImgFile);
  img.OutPicture.LoadFromFile(curImgFile);
end;


procedure TBIDisplayer.setFuelAlertImage(var img: TImage);
var
  curImgFile: String;
begin

  if (alert1 = 0) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel1\alert0.bmp';
    alert1 := 1;
  end
  else
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel1\alert1.bmp';
    alert1 := 0;
  end;

  img.Picture.LoadFromFile(curImgFile);

end;

procedure TBIDisplayer.setFuelAlertImage(var img: TRollOverImage);
var
  curImgFile: String;
begin

  if (alert1 = 0) then
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel1\alert0.bmp';
    alert1 := 1;
  end
  else
  begin
    curImgFile := imgDir+'\images\kr\ani\fuel1\alert1.bmp';
    alert1 := 0;
  end;

  img.Picture.LoadFromFile(curImgFile);
  img.OverPicture.LoadFromFile(curImgFile);
  img.OutPicture.LoadFromFile(curImgFile);

end;


procedure TBIDisplayer.setAlertBackImg(var img: TImage;nls: Byte);
var
  curImgFile: String;
begin
  if (nls = 0) then
  begin
    curImgFile := imgDir+'\images\kr\alert\pop_alert_back.bmp';
  end
  else if (nls = 1) then
  begin
    curImgFile := imgDir+'\images\en\alert\pop_alert_back.bmp';
  end;

  img.Picture.LoadFromFile(curImgFile);
end;



end.
