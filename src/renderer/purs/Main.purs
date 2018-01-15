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
import Goods as Goods
import Node.Buffer (BUFFER)
import Node.FS (FS)
import Node.FS.Aff as FS
import Node.Path (FilePath)
import Prelude (Unit, bind, pure, unit, (#), (<$>), (<*>), (>>=))
import Reports as Reports
import Types (Flag, flag)


main :: forall eff. FilePath -> Eff (buffer :: BUFFER, console :: CONSOLE, fs :: FS, now :: NOW, sql :: SQLJS | eff) Unit
main userDataPath =
  dbInit userDataPath
    >>= (\_ -> getFlag userDataPath)
    # Aff.runAff_ (Either.either Console.errorShow appInit)


appInit :: forall eff. Flag -> Eff (now :: NOW | eff) Unit
appInit flag =
  Elm.start flag >>= Ports.start


dbInit :: forall eff. FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) Unit
dbInit userDataPath = do
  databaseExists <- FS.exists databaseFilePath
  if databaseExists then pure unit else Database.create databaseFilePath
  where
  databaseFilePath = Config.databaseFilePath userDataPath


getFlag :: forall eff. FilePath -> Aff (buffer :: BUFFER, fs :: FS, now :: NOW, sql :: SQLJS | eff) Flag
getFlag userDataPath =
  flag
    <$> Reports.list userDataPath
    <*> Goods.list userDataPath
    <*> Aff.liftEff' Now.now