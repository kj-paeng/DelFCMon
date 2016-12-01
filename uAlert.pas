unit uAlert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmAlert = class(TForm)
    imgBack: TImage;
    Image1: TImage;
    lblAlert1: TLabel;
    lblAlert2: TLabel;
    lblAlert3: TLabel;
    lblAlert4: TLabel;
    imgOK: TImage;
    procedure imgOKMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOKMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    alertString1, alertString2, alertString3, alertString4: String;
    nls: Byte; // Ko - 0, En - 1;
    

  public
    { Public declarations }
    procedure setAlertString1(s: String);
    procedure setAlertString2(s: String);
    procedure setAlertString3(s: String);
    procedure setAlertString4(s: String);
    procedure setNLS(b: Byte);
  end;

var
  frmAlert: TfrmAlert;

implementation

uses uPM;

{$R *.dfm}

procedure TfrmAlert.setNLS(b: Byte);
begin
  nls := b;
end;

procedure TfrmAlert.setAlertString1(s: String);
begin
  alertString1 := s;
end;

procedure TfrmAlert.setAlertString2(s: String);
begin
  alertString2 := s;
end;

procedure TfrmAlert.setAlertString3(s: String);
begin
  alertString3 := s;
end;

procedure TfrmAlert.setAlertString4(s: String);
begin
  alertString4 := s;
end;

procedure TfrmAlert.imgOKMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  imgOK.Left := imgOK.Left + 1;
  imgOK.Top := imgOK.Top + 1;

end;

procedure TfrmAlert.imgOKMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  imgOK.Left := imgOK.Left - 1;
  imgOK.Top := imgOK.Top - 1;

end;

procedure TfrmAlert.imgOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAlert.FormShow(Sender: TObject);
begin

  imgDisplayer.setAlertBackImg(imgBack, nls);

  lblAlert1.Caption := alertString1;
  lblAlert3.Caption := alertString3;
{$IFDEF EN}
  lblAlert1.Caption := alertString1;
  lblAlert2.Caption := alertString2;
  lblAlert3.Caption := alertString3;
  lblAlert4.Caption := alertString4;
{$ENDIF}  


end;

end.

