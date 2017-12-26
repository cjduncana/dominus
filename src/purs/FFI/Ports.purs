module FFI.Ports (start) where

import Control.Monad.Eff (Eff)
import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (decodeJson)
import Data.Foldable (traverse_)
import FFI.Electron as Electron
import Prelude (Unit, ($), (>>>))
import Types (App)

foreign import _startPorts :: forall eff a. (Json -> Eff eff Unit) -> App -> Eff eff Unit

start :: forall eff. App -> Eff eff Unit
start =
  _startPorts $ decodeJson >>> traverse_ Electron.doAction
