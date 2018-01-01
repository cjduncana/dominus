module FFI.Config (databaseFilePath, schemaFilePath) where

import Node.Path (FilePath)
import Node.Path as Path


foreign import __static :: String


databaseFilePath :: FilePath
databaseFilePath =
  Path.concat [__static, "dominus.db"]


schemaFilePath :: FilePath
schemaFilePath =
  Path.concat [__static, "schema.sql"]
