object frmLogLocation: TfrmLogLocation
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
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'LogFile Location'
      object Label1: TLabel
        Left = 8
        Top = 169
        Width = 99
        Height = 16
        Caption = 'LogFile Location'
      end
      object cboDrive: TDriveComboBox
        Left = 8
        Top = 8
        Width = 353
        Height = 22
        ImeName = 'Microsoft IME 2003'
        TabOrder = 0
        OnChange = cboDriveChange
      end
      object DirList: TDirectoryListBox
        Left = 8
        Top = 32
        Width = 353
        Height = 129
        ImeName = 'Microsoft IME 2003'
        ItemHeight = 16
        TabOrder = 1
        OnChange = DirListChange
      end
      object edtLocation: TEdit
        Left = 8
        Top = 185
        Width = 353
        Height = 24
        Enabled = False
        ImeName = 'Microsoft IME 2003'
        ParentColor = True
        ReadOnly = True
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Logging Interval'
      ImageIndex = 1
      object Label2: TLabel
        Left = 16
        Top = 24
        Width = 139
        Height = 16
        Caption = 'Logfile Creation Interval'
      end
      object Label3: TLabel
        Left = 15
        Top = 55
        Width = 92
        Height = 16
        Caption = 'Display Interval'
      end
      object Label4: TLabel
        Left = 312
        Top = 32
        Width = 22
        Height = 16
        Caption = 'sec'
      end
      object Label5: TLabel
        Left = 312
        Top = 63
        Width = 22
        Height = 16
        Caption = 'sec'
      end
      object edtLogInterval: TEdit
        Left = 168
        Top = 24
        Width = 137
        Height = 24
        ImeName = 'Microsoft IME 2003'
        TabOrder = 0
      end
      object edtDisplayInterval: TEdit
        Left = 168
        Top = 55
        Width = 137
        Height = 24
        ImeName = 'Microsoft IME 2003'
        TabOrder = 1
      end
      object chkStartup: TCheckBox
        Left = 13
        Top = 87
        Width = 235
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Logging at startup of this program'
        TabOrder = 2
        Visible = False
      end
    end
  end
end
