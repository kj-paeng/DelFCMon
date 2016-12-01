unit uLogLocation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ComCtrls;

type
  TfrmLogLocation = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cboDrive: TDriveComboBox;
    DirList: TDirectoryListBox;
    Label1: TLabel;
    edtLocation: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtLogInterval: TEdit;
    edtDisplayInterval: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    chkStartup: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure cboDriveChange(Sender: TObject);
    procedure DirListChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogLocation: TfrmLogLocation;

implementation

uses clsMain;

{$R *.dfm}

procedure TfrmLogLocation.FormCreate(Sender: TObject);
var
  sLocation: String;
  sLogInterval: String;
  sDisplayInterval: String;
begin
  sLocation := getRegValue('LogLocation');
  sLogInterval := getRegValue('LogInterval');
  sDisplayInterval := getRegValue('DisplayInterval');

  if (sLocation = '') then
  begin
    edtLocation.Text := 'C:\';
    cboDrive.Drive := 'C';
    dirList.Directory := 'C:\';
  end
  else
  begin
    if (strEndsWith(sLocation, '\')) then
      sLocation := Copy(sLocation, 1, Length(sLocation)-1);
      
    edtLocation.Text := sLocation;
    cboDrive.Drive := sLocation[1];
    dirList.Directory := sLocation;
  end;




  if (sLogInterval = '') then
  begin
    edtLogInterval.Text := '30';
  end
  else
  begin
    edtLogInterval.Text := sLogInterval;
  end;

  if (sDisplayInterval = '') then
  begin
    edtDisplayInterval.Text := '30';
  end
  else
  begin
    edtDisplayInterval.Text := sDisplayInterval;
  end;


end;

procedure TfrmLogLocation.cboDriveChange(Sender: TObject);
begin
  edtLocation.Text := dirList.Directory;
end;

procedure TfrmLogLocation.DirListChange(Sender: TObject);
begin
  edtLocation.Text := dirList.Directory;
end;

procedure TfrmLogLocation.btnOKClick(Sender: TObject);
begin
  updateRegValue('LogLocation', edtLocation.Text);
  updateRegValue('LogInterval', edtLogInterval.Text);
  updateRegValue('DisplayInterval', edtDisplayInterval.Text); 

end;

end.
