object Form1: TForm1
  Left = 0
  Top = 0
  ClientHeight = 249
  ClientWidth = 314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 174
    Top = 57
    Width = 117
    Height = 21
    Caption = 'Mestre do bloqueio'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Sitka Banner'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 174
    Top = 7
    Width = 107
    Height = 21
    Caption = 'Mestre do cr'#237'tico'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Sitka Banner'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 163
    Top = 107
    Width = 128
    Height = 21
    Caption = 'Golpe carregado(CS)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Sitka Banner'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 158
    Top = 157
    Width = 154
    Height = 21
    Caption = 'Mestre das sombras(SM)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Sitka Banner'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 16
    Top = 8
    Width = 113
    Height = 21
    Caption = 'Procurar processo:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Sitka Banner'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    StyleName = 'Windows'
  end
  object EditPID: TEdit
    Left = 8
    Top = 184
    Width = 129
    Height = 23
    TabOrder = 0
    Text = 'PID'
  end
  object BtnAttach: TButton
    Left = 8
    Top = 213
    Width = 129
    Height = 25
    Caption = 'Injetar'
    TabOrder = 1
    OnClick = BtnAttachClick
  end
  object EditValue1: TEdit
    Left = 214
    Top = 34
    Width = 34
    Height = 23
    TabOrder = 2
    Text = '13'
    StyleName = 'Windows'
  end
  object BtnApply: TButton
    Left = 163
    Top = 213
    Width = 140
    Height = 25
    Caption = 'Ativar'
    TabOrder = 3
    OnClick = BtnApplyClick
  end
  object EditValue2: TEdit
    Left = 214
    Top = 84
    Width = 34
    Height = 23
    TabOrder = 4
    Text = '12'
  end
  object EditValue3: TEdit
    Left = 213
    Top = 134
    Width = 34
    Height = 23
    TabOrder = 5
    Text = '300'
  end
  object EditValue4: TEdit
    Left = 214
    Top = 184
    Width = 33
    Height = 23
    TabOrder = 6
    Text = '305'
    OnChange = EditValue4Change
  end
  object ProcessListBox: TListBox
    Left = 8
    Top = 67
    Width = 129
    Height = 111
    ItemHeight = 15
    TabOrder = 7
    OnClick = ProcessListBoxDblClick
  end
  object search: TEdit
    Left = 8
    Top = 38
    Width = 129
    Height = 23
    TabOrder = 8
    OnChange = searchChange
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 288
    Top = 8
  end
end
