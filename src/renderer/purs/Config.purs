module Config (databaseFilePath) where

import Control.Monad.Eff (Eff)
import Data.Array ((:))
import Electron (ELECTRON)
import Electron.App (Path(UserData))
import Electron.Remote.App as App
import Node.Path (FilePath)
import Node.Path as Path
import Prelude ((<#>), (<<<))


databaseFilePath :: forall eff. Eff (electron :: ELECTRON | eff) FilePath
databaseFilePath =
  App.getPath UserData <#> (Path.concat <<< (_ : ["dominus.db"]))
