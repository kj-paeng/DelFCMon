object frmMainOption: TfrmMainOption
  Left = 395
  Top = 173
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 299
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object btnOK: TBitBtn
    Left = 230
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = btnOKClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 310
    Top = 264
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 377
    Height = 249
    ActivePage = TabSheet2
    TabIndex = 0
    TabOrder = 2
    object TabSheet2: TTabSheet
      Caption = 'Refresh Interval'
      ImageIndex = 1
      object Label3: TLabel
        Left = 15
        Top = 57
        Width = 92
        Height = 16
        Caption = 'Display Interval'
      end
      object Label5: TLabel
        Left = 312
        Top = 63
        Width = 22
        Height = 16
        Caption = 'sec'
      end
      object edtDisplayInterval: TEdit
        Left = 168
        Top = 55
        Width = 137
        Height = 24
        ImeName = 'Microsoft IME 2003'
        TabOrder = 0
        Text = '0'
      end
    end
  end
end
