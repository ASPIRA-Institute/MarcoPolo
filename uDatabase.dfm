object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 286
  Width = 410
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 96
    Top = 16
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=D:\Documents\MarcoPolo\marco_polo.sqlite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object FDQTravelsSections: TFDQuery
    Connection = FDConnection
    Left = 200
    Top = 24
  end
  object FDQTemp: TFDQuery
    Connection = FDConnection
    Left = 168
    Top = 104
  end
  object FDQDocuments: TFDQuery
    Connection = FDConnection
    Left = 288
    Top = 24
  end
  object FDQSections: TFDQuery
    Connection = FDConnection
    Left = 256
    Top = 104
  end
  object FDQImportExport: TFDQuery
    Connection = FDConnection
    Left = 64
    Top = 88
  end
end
