module Config (databaseFilePath) where

import Node.Path (FilePath)
import Node.Path as Path


databaseFilePath :: FilePath -> FilePath
databaseFilePath userDataPath =
  Path.concat [userDataPath, "dominus.db"]
