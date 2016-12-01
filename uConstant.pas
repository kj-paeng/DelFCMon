unit uConstant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList;

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
  CATRIDGE_ADDR = $1A;


  // SABI interface constants (For page 1)
  BATTERY_REM_CAPA = $0F; // 0x0F - Battery remaining capacity
  BATTERY_FULL_CAPA = $10;  // 0x10 - Battery full capacity
  BATTERY_SLAVE_ADDR = $16;  // 16 (DECIMAL?) slave adress[16]_1Byte

  FUELCELL_REM_CAPA = $0F; // 0x0F - Fuelcell remaining capacity
  FUELCELL_FULL_CAPA = $10;  // 0x10 - Fuelcell full capacity
  FUELCELL_SLAVE_ADDR = $1A;  // 16 (DECIMAL?) slave adress[16]_1Byte

  // distance panel and label in page 1 of user mode 1st page
  DIST = 23;
   

implementation

end.
