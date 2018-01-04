module InitialDatabase (sql) where


sql :: Array String
sql =
  [ createReports
  , createRecords
  , createReportGoods
  , createGoods
  ]


createGoods :: String
createGoods =
  "CREATE TABLE \"goods\" (\"id\" TEXT NOT NULL PRIMARY KEY, \"name\" TEXT NOT NULL, \"brandId\" TEXT);"


createRecords :: String
createRecords =
  "CREATE TABLE \"records\" (\"id\" TEXT NOT NULL PRIMARY KEY, \"reportId\" TEXT NOT NULL, \"index\" INTEGER NOT NULL, \"quantityStored\" INTEGER NOT NULL, \"quantityUsed\" INTEGER NOT NULL);"


createReports :: String
createReports =
  "CREATE TABLE \"reports\" (\"id\" TEXT NOT NULL PRIMARY KEY, \"date\" TEXT NOT NULL, \"completed\" INTEGER NOT NULL);"


createReportGoods :: String
createReportGoods =
  "CREATE TABLE \"report_goods\" (\"id\" TEXT NOT NULL PRIMARY KEY, \"recordId\" TEXT NOT NULL, \"name\" TEXT NOT NULL);"
