object GridFrame: TGridFrame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  TabOrder = 0
  object tvMain: TcxGrid
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    Align = alClient
    TabOrder = 0
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = 'Office2019DarkGray'
    ExplicitTop = -3
    object tvMainDV: TcxGridDBTableView
      OptionsView.GroupByBox = False
      OptionsView.GroupSummaryLayout = gslAlignWithColumns
      OptionsView.Indicator = True
      Styles.StyleSheet = cxGridTableViewStyleSheet1
    end
    object tvMainLevel1: TcxGridLevel
      GridView = tvMainDV
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 304
    Top = 224
    PixelsPerInch = 96
    object siBold: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet
      Styles.GroupSummary = siBold
      BuiltIn = True
    end
  end
end
