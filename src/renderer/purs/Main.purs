module Main (main) where

import Config as Config
import Control.Monad.Aff (Aff)
import Control.Monad.Aff as Aff
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Console as Console
import Control.Monad.Eff.Now (NOW)
import Control.Monad.Eff.Now as Now
import Data.Either as Either
import Database as Database
import FFI.Elm as Elm
import FFI.Ports as Ports
import FFI.Sql (SQLJS)
import Node.Buffer (BUFFER)
import Node.FS (FS)
import Node.FS.Aff as FS
import Node.Path (FilePath)
import Prelude (Unit, bind, pure, unit, (#), (>>=))
import Reports as Reports
import Types (Report, flags)


main :: forall eff. FilePath -> Eff (buffer :: BUFFER, console :: CONSOLE, fs :: FS, now :: NOW, sql :: SQLJS | eff) Unit
main userDataPath =
  dbInit userDataPath
    >>= (\_ -> Reports.list userDataPath)
    # Aff.runAff_ (Either.either Console.errorShow appInit)


appInit :: forall eff. Array Report -> Eff (now :: NOW | eff) Unit
appInit reports = do
  now <- Now.now
  app <- Elm.start (flags reports now)
  Ports.start app


dbInit :: forall eff. FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) Unit
dbInit userDataPath = do
  databaseExists <- FS.exists databaseFilePath
  if databaseExists then pure unit else do Database.create databaseFilePath
  where
  databaseFilePath = Config.databaseFilePath userDataPath
