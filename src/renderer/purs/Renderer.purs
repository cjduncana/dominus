module Renderer (main) where

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
import Electron (ELECTRON)
import FFI.Elm as Elm
import FFI.Ports as Ports
import FFI.Sql (SQLJS)
import Goods as Goods
import Node.Buffer (BUFFER)
import Node.FS (FS)
import Node.FS.Aff as FS
import Prelude (Unit, bind, unless, (#), ($), (<$>), (<*>), (>>=))
import Reports as Reports
import Types (Flag, flag)


main :: forall eff. Eff (buffer :: BUFFER, console :: CONSOLE, electron :: ELECTRON, fs :: FS, now :: NOW, sql :: SQLJS | eff) Unit
main =
  dbInit
    >>= (\_ -> getFlag)
    # Aff.runAff_ (Either.either Console.errorShow appInit)


appInit :: forall eff. Flag -> Eff (electron :: ELECTRON, now :: NOW | eff) Unit
appInit flag =
  Elm.start flag >>= Ports.start


dbInit :: forall eff. Aff (buffer :: BUFFER, electron :: ELECTRON, fs :: FS, sql :: SQLJS | eff) Unit
dbInit = do
  databaseFilePath <- Aff.liftEff' Config.databaseFilePath
  databaseExists <- FS.exists databaseFilePath
  unless databaseExists $ Database.create databaseFilePath


getFlag :: forall eff. Aff (buffer :: BUFFER, electron :: ELECTRON, fs :: FS, now :: NOW, sql :: SQLJS | eff) Flag
getFlag =
  Aff.sequential $ flag
    <$> Aff.parallel Reports.list
    <*> Aff.parallel Goods.list
    <*> Aff.parallel (Aff.liftEff' Now.now)
