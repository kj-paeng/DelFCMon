unit Batclass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry;

type

  HDEVINFO = LongWord;
  PCTSTR = PAnsiChar;
  TCHAR = Char;
  

(*
((VOID )(ULONG_PTR)((unsigned long)ul))


  typedef struct _SP_DEVINFO_DATA {
    DWORD cbSize;
    GUID ClassGuid;
    DWORD DevInst;
    ULONG_PTR Reserved;
  } SP_DEVINFO_DATA,  *PSP_DEVINFO_DATA;
*)

  ULONG_PTR = ^ULONG;

  PSP_DEVINFO_DATA = ^SP_DEVINFO_DATA;
  SP_DEVINFO_DATA = record
    cbSize: DWORD;
    ClassGuid: TGUID;
    DevInst: DWORD;
    Reserved: ULONG_PTR;
  end;


(*
  PGUID = ^TGUID;
  TGUID = packed record
    D1: LongWord;
    D2: Word;
    D3: Word;
    D4: array[0..7] of Byte;
  end;
*)


(*

typedef struct _SP_DEVICE_INTERFACE_DATA {
  DWORD cbSize;
  GUID InterfaceClassGuid;
  DWORD Flags;
  ULONG_PTR Reserved;
} SP_DEVICE_INTERFACE_DATA,
*PSP_DEVICE_INTERFACE_DATA;

*)


  PSP_DEVICE_INTERFACE_DATA = ^SP_DEVICE_INTERFACE_DATA;
  SP_DEVICE_INTERFACE_DATA = record
    cbSize: DWORD;
    InterfaceClassGuid: TGUID;
    Flags: DWORD;
    Reserved: ULONG_PTR;
  end;


(*
typedef struct _SP_DEVICE_INTERFACE_DETAIL_DATA {
  DWORD cbSize;
  TCHAR DevicePath[ANYSIZE_ARRAY];
} SP_DEVICE_INTERFACE_DETAIL_DATA,  *PSP_DEVICE_INTERFACE_DETAIL_DATA;
*)
  PSP_DEVICE_INTERFACE_DETAIL_DATA = ^SP_DEVICE_INTERFACE_DETAIL_DATA;
  SP_DEVICE_INTERFACE_DETAIL_DATA = record
    cbSize: DWORD;
    DevicePath: array[0..254] of Char;
  end;



//  DEFINE_GUID(GUID_DEVICE_BATTERY,
//  0x72631e54L, 0x78A4, 0x11d0, 0xbc, 0xf7, 0x00, 0xaa, 0x00, 0xb7, 0xb3, 0x2a);


  const
  DIGCF_ALLCLASSES      = $04; // Return a list of installed devices for all classes. If this flag is set, the ClassGuid parameter is ignored.
  DIGCF_DEVICEINTERFACE = $10; //Return devices that expose interfaces of the interface class that are specified by ClassGuid. If this flag is not set, ClassGuid specifies a setup class.
  DIGCF_PRESENT         = $02; //Return only devices that are present currently.
  DIGCF_PROFILE         = $08;

(*
HDEVINFO SetupDiGetClassDevs(
  const GUID* ClassGuid,
  PCTSTR Enumerator,
  HWND hwndParent,
  DWORD Flags
);
*)

function SetupDiGetClassDevs(
  ClassGuid: PGUID;
  Enumerator: PCTSTR;
  hwndParent: HWND;
  Flags: DWORD): HDEVINFO; stdcall;


(*
BOOL SetupDiEnumDeviceInterfaces(
  HDEVINFO DeviceInfoSet,
  PSP_DEVINFO_DATA DeviceInfoData,
  const GUID* InterfaceClassGuid,
  DWORD MemberIndex,
  PSP_DEVICE_INTERFACE_DATA DeviceInterfaceData
);
*)
function SetupDiEnumDeviceInterfaces(
  DeviceInfoSet: HDEVINFO;
  DeviceInfoData: PSP_DEVINFO_DATA;
  InterfaceClassGuid: PGUID;
  MemberIndex: DWORD;
  DeviceInterfaceData: PSP_DEVICE_INTERFACE_DATA
  ): Boolean; stdcall;


(*
BOOL SetupDiGetDeviceInterfaceDetail(
  HDEVINFO DeviceInfoSet,
  PSP_DEVICE_INTERFACE_DATA DeviceInterfaceData,
  PSP_DEVICE_INTERFACE_DETAIL_DATA DeviceInterfaceDetailData,
  DWORD DeviceInterfaceDetailDataSize,
  PDWORD RequiredSize,
  PSP_DEVINFO_DATA DeviceInfoData
);
*)
function SetupDiGetDeviceInterfaceDetailA(
  DeviceInfoSet: HDEVINFO;
  DeviceInterfaceData: PSP_DEVICE_INTERFACE_DATA;
  DeviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  DeviceInterfaceDetailDataSize: DWORD;
  RequiredSize: PDWORD;
  DeviceInfoData: PSP_DEVINFO_DATA
  ): Boolean; stdcall;
  
function SetupDiGetDeviceInterfaceDetailW(
  DeviceInfoSet: HDEVINFO;
  DeviceInterfaceData: PSP_DEVICE_INTERFACE_DATA;
  DeviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  DeviceInterfaceDetailDataSize: DWORD;
  RequiredSize: PDWORD;
  DeviceInfoData: PSP_DEVINFO_DATA
  ): Boolean; stdcall;


function getBatteryRemainTime: Longword;
function getBatteryLifePercent: Byte;
function getACLineStatus: boolean;


var
  GUID_DEVICE_BATTERY: TGUID;  

implementation

function SetupDiGetClassDevs(
  ClassGuid: PGUID;
  Enumerator: PCTSTR;
  hwndParent: HWND;
  Flags: DWORD)
  : HDEVINFO; stdcall; external 'Setupapi.dll'
  name 'SetupDiGetClassDevsW';
function SetupDiEnumDeviceInterfaces(
  DeviceInfoSet: HDEVINFO;
  DeviceInfoData: PSP_DEVINFO_DATA;
  InterfaceClassGuid: PGUID;
  MemberIndex: DWORD;
  DeviceInterfaceData: PSP_DEVICE_INTERFACE_DATA
  ): Boolean; stdcall; external 'Setupapi.dll'
  name 'SetupDiEnumDeviceInterfaces';
function SetupDiGetDeviceInterfaceDetailA(
  DeviceInfoSet: HDEVINFO;
  DeviceInterfaceData: PSP_DEVICE_INTERFACE_DATA;
  DeviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  DeviceInterfaceDetailDataSize: DWORD;
  RequiredSize: PDWORD;
  DeviceInfoData: PSP_DEVINFO_DATA
  ): Boolean; stdcall;  external 'Setupapi.dll'
   name 'SetupDiGetDeviceInterfaceDetailA';
function SetupDiGetDeviceInterfaceDetailW(
  DeviceInfoSet: HDEVINFO;
  DeviceInterfaceData: PSP_DEVICE_INTERFACE_DATA;
  DeviceInterfaceDetailData: PSP_DEVICE_INTERFACE_DETAIL_DATA;
  DeviceInterfaceDetailDataSize: DWORD;
  RequiredSize: PDWORD;
  DeviceInfoData: PSP_DEVINFO_DATA
  ): Boolean; stdcall;  external 'Setupapi.dll'
   name 'SetupDiGetDeviceInterfaceDetailW';


function getBatteryRemainTime: Longword;
var
  sps: TSystemPowerStatus;
  b: Boolean;
//  fullRemTime: Longword;
//  hour, min: Integer;
begin
  b := GetSystemPowerStatus(sps);

  if (b) then
    result := sps.BatteryLifeTime
  else
    result := 0;
end;

function getACLineStatus: boolean;
var
  sps: TSystemPowerStatus;
  b: Boolean;
begin
  b := GetSystemPowerStatus(sps);

  if (b) then
    result := boolean(sps.ACLineStatus)
  else
    result := false;
end;

function getBatteryLifePercent: Byte;
var
  sps: TSystemPowerStatus;
  b: Boolean;
//  fullRemTime: Longword;
//  hour, min: Integer;
begin
  b := GetSystemPowerStatus(sps);

  if (b) then
    result := sps.BatteryLifePercent
  else
    result := 0;
end;

end.
