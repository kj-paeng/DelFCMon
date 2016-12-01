unit uConstant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList;

const
  WM_EXESSFUEL = WM_USER + 2038;

  BATTERY_DETAIL_TYPE = $01;
  FUELCELL_DETAIL_TYPE = $02;

  FUELVOLT = $01; //
  FUELCURR = $08; //
  BATTVOLT = $09; // 
  BATTCURR = $0D; // 
  NOTEVOLT = $012;//
  NOTECURR = $016;//

  STCKTEMP = $018; //
  RECYCLER = $01A; //
  OPERMODE = $00B; // 
  CATRIDID = $01C; //
  CATDENSE = $00C; // 
  CATCAPAC = $00E; //Y
  CATRIDGE_ADDR = $1A;


  
  BATTERY_REM_CAPA = $0F; // 
  BATTERY_FULL_CAPA = $10;  // 
  BATTERY_SLAVE_ADDR = $16;  // 

  FUELCELL_REM_CAPA = $0F; // 
  FUELCELL_FULL_CAPA = $10;  // 
  FUELCELL_SLAVE_ADDR = $1A;  // 

  // distance panel and label in page 1 of user mode 1st page
  DIST = 23;
   

implementation

end.
