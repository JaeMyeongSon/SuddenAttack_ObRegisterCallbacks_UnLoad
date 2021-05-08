object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 145
  ClientWidth = 369
  Color = clBtnFace
  Enabled = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 289
    Height = 113
    Caption = 'UnLoad'
    TabOrder = 0
    OnClick = Button1Click
  end
  object LOGIN_BOX: TGroupBox
    Left = 8
    Top = 8
    Width = 361
    Height = 137
    TabOrder = 1
    object ID_TEXT: TEdit
      Left = 16
      Top = 24
      Width = 249
      Height = 21
      TabOrder = 0
    end
    object PW_TEXT: TEdit
      Left = 16
      Top = 51
      Width = 249
      Height = 21
      PasswordChar = #9679
      TabOrder = 1
    end
    object CODE_TEXT: TEdit
      Left = 16
      Top = 78
      Width = 249
      Height = 21
      TabOrder = 2
    end
    object LOGIN_BUTTON: TButton
      Left = 271
      Top = 22
      Width = 75
      Height = 43
      Caption = 'LOGIN'
      TabOrder = 3
      OnClick = LOGIN_BUTTONClick
    end
    object REGISTER: TButton
      Left = 271
      Top = 71
      Width = 75
      Height = 26
      Caption = 'REGISTER'
      TabOrder = 4
      OnClick = REGISTERClick
    end
    object CODE_DATE: TEdit
      Left = 249
      Top = 78
      Width = 16
      Height = 21
      Enabled = False
      TabOrder = 5
      Visible = False
    end
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 376
    Top = 136
  end
end
