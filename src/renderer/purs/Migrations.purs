module Migrations (sql) where


sql :: Array String
sql =
  [ createReports
  ]

-- 2018-01-03 13:17
createReports :: String
createReports =
  "CREATE TABLE \"reports\" (\"id\" TEXT NOT NULL PRIMARY KEY, \"date\" TEXT NOT NULL, \"completed\" INTEGER NOT NULL);"
