module Config (databaseFilePath, schemaFilePath) where

import Node.Path (FilePath)
import Node.Path as Path


databaseFilePath :: FilePath
databaseFilePath =
  Path.concat [".", "dist", "dominus.db"]


schemaFilePath :: FilePath
schemaFilePath =
  Path.concat [".", "dist", "schema.sql"]
