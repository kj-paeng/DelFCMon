object Form1: TForm1
  Left = 192
  Top = 114
  Width = 870
  Height = 500
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 52
    Width = 24
    Height = 13
    Caption = 'Input'
  end
  object Label2: TLabel
    Left = 32
    Top = 148
    Width = 32
    Height = 13
    Caption = 'Output'
  end
  object Label3: TLabel
    Left = 32
    Top = 20
    Width = 38
    Height = 13
    Caption = 'Address'
  end
  object Label4: TLabel
    Left = 32
    Top = 176
    Width = 32
    Height = 13
    Caption = 'Output'
  end
  object Label5: TLabel
    Left = 32
    Top = 204
    Width = 32
    Height = 13
    Caption = 'Output'
  end
  object ResultLabel: TLabel
    Left = 424
    Top = 328
    Width = 56
    Height = 13
    Caption = 'ResultLabel'
  end
  object Button1: TButton
    Left = 288
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Call'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 132
    Top = 16
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 132
    Top = 48
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 132
    Top = 144
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 3
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 132
    Top = 172
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 4
    Text = 'Edit3'
  end
  object Edit5: TEdit
    Left = 132
    Top = 200
    Width = 121
    Height = 21
    ImeName = 'Microsoft IME 2003'
    TabOrder = 5
    Text = 'Edit3'
  end
  object Button2: TButton
    Left = 132
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 212
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 296
    Top = 284
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 8
    OnClick = Button4Click
  end
  object FoldersComboBox: TComboBox
    Left = 432
    Top = 280
    Width = 145
    Height = 21
    ImeName = 'Microsoft IME 2003'
    ItemHeight = 13
    TabOrder = 9
    Text = 'FoldersComboBox'
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20')
  end
end
