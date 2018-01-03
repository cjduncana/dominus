module FFI.Config (databaseFilePath) where

import Node.Path (FilePath)
import Node.Path as Path


foreign import __static :: String


databaseFilePath :: FilePath
databaseFilePath =
  Path.concat [__static, "dominus.db"]
