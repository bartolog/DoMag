object dbProductionContainer: TdbProductionContainer
  Height = 480
  Width = 640
  object UniConnection1: TUniConnection
    ProviderName = 'mySQL'
    Database = 'falegnameria_fusti'
    Username = 'bartolo'
    Server = 'server2018'
    Connected = True
    LoginPrompt = False
    Left = 192
    Top = 104
    EncryptedPassword = '9DFF9EFF8DFF8BFF90FF93FF90FF'
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    SQL.Strings = (
      'SELECT'
      '  sdl.Data,'
      '  m.Nome AS macchina,'
      '  sdl1.Materiale,'
      '  sdl1.Dim_X_Pannello,'
      '  sdl1.Dim_Y_Pannello,'
      '  sdl1.Dim_Z_Pannello,'
      '  SUM(rsl.Qta) AS TQta,'
      '  sum('
      
        '  (sdl1.Dim_X_Pannello * 0.001 * sdl1.Dim_Y_Pannello * 0.001 * r' +
        'sl.Qta)) AS TMQ'
      'FROM schede_di_lavorazione sdl'
      '  INNER JOIN righe_scheda_lavorazione rsl'
      '    ON sdl.IdScheda = rsl.IdScheda'
      '  INNER JOIN schemi_di_lavorazione sdl1'
      '    ON rsl.idSchema = sdl1.idSchema'
      
        '  -- INNER JOIN dettagio_schema ds ON sdl1.idSchema = ds.idSchem' +
        'a'
      '  INNER JOIN macchine m'
      '    ON sdl.idMacchina = m.idMacchina'
      'WHERE sdl1.Modelli LIKE &MacroProg'
      'AND sdl.idMacchina = :idMacchina'
      'AND sdl.Stato = '#39'chiusa'#39
      'GROUP BY sdl.Data,'
      '         macchina,'
      '         sdl1.Materiale,'
      '         sdl1.Dim_X_Pannello,'
      '         sdl1.Dim_Y_Pannello,'
      '         sdl1.Dim_Z_Pannello'
      ';'
      ''
      '')
    Active = True
    Left = 192
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'idMacchina'
        Value = 6
      end>
    MacroData = <
      item
        Name = 'MacroProg'
        Value = #39'39/2025%'#39
      end>
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 304
    Top = 104
  end
  object UniDataSource1: TUniDataSource
    DataSet = UniQuery1
    Left = 304
    Top = 192
  end
  object UniSQLMonitor1: TUniSQLMonitor
    Left = 336
    Top = 312
  end
  object vqTotals: TVirtualQuery
    MasterSource = UniDataSource1
    SourceDataSets = <
      item
        TableName = 'TotaliGiornalieri'
        DataSet = UniQuery1
      end>
    SQL.Strings = (
      
        'select concat('#39'mp_'#39',substring(materiale,1,4),Dim_Z_Pannello ) as' +
        ' codice ,'
      
        'concat('#39'Pannello '#39', materiale ,'#39' '#39', Dim_x_Pannello,'#39' X '#39', Dim_Y_' +
        'Pannello,'#39' X '#39',Dim_Z_Pannello) as Descrizione ,sum(TMQ) as Total' +
        'eQta from Totaligiornalieri'
      
        'group by  materiale,Dim_x_Pannello, Dim_Y_Pannello,Dim_Z_Pannell' +
        'o;')
    Left = 224
    Top = 320
  end
end
