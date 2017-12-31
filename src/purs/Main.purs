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
import Prelude (Unit, bind, not, pure, unit)
import Types (flags, reports)

main :: forall eff. Eff (buffer :: BUFFER, console :: CONSOLE, fs :: FS, now :: NOW, sql :: SQLJS | eff) Unit
main =
  Aff.runAff_ (Either.either Console.errorShow (\_ -> appInit)) dbInit

appInit :: forall eff. Eff (now :: NOW | eff) Unit
appInit = do
  now <- Now.now
  -- TODO: Get records from database
  app <- Elm.start (flags reports now)
  Ports.start app

dbInit :: forall eff. Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) Unit
dbInit = do
  databaseExists <- FS.exists Config.databaseFilePath
  if databaseExists then pure unit else do
    schemaExists <- FS.exists Config.schemaFilePath
    if not schemaExists then
      Database.empty Config.databaseFilePath
      else
      Database.create Config.databaseFilePath Config.schemaFilePath
