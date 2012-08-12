object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 145
  Width = 464
  object Conn: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 8
    Top = 8
  end
  object Query_Log: TADOQuery
    Connection = Conn
    ParamCheck = False
    Parameters = <>
    Left = 56
    Top = 8
  end
  object Query_Date: TADOQuery
    Connection = Conn
    Parameters = <>
    Left = 120
    Top = 8
  end
end
