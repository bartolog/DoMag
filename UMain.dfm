object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'DoMag'
  ClientHeight = 426
  ClientWidth = 694
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object ShowDBParams: TButton
    Left = 32
    Top = 32
    Width = 241
    Height = 25
    Caption = 'Mostra parametri di connessione'
    TabOrder = 0
    OnClick = ShowDBParamsClick
  end
  object btnDoDDt: TButton
    Left = 32
    Top = 63
    Width = 241
    Height = 25
    Caption = 'Crea DDT di scarico'
    TabOrder = 1
    OnClick = btnDoDDtClick
  end
end
