unit uMainOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl, ComCtrls;

type
  TfrmMainOption = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    edtDisplayInterval: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainOption: TfrmMainOption;

implementation

uses clsMain;

{$R *.dfm}

procedure TfrmMainOption.FormCreate(Sender: TObject);
var
  sLocation: String;
  sLogInterval: String;
  sDisplayInterval: String;
begin
  sDisplayInterval := getRegValue('DisplayInterval');

  if (sDisplayInterval = '') then
  begin
    edtDisplayInterval.Text := '10';
  end
  else
  begin
    edtDisplayInterval.Text := sDisplayInterval;
  end;


end;

procedure TfrmMainOption.btnOKClick(Sender: TObject);
begin
  updateRegValue('DisplayInterval', edtDisplayInterval.Text);

end;

end.
