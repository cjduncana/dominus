module FFI.Ports (start) where

import Control.Monad.Eff (Eff)
import Data.Argonaut.Core (Json)
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Encode (encodeJson)
import Data.Foldable (traverse_)
import Electron (ELECTRON)
import Electron.IpcRenderer as IpcRenderer
import Prelude (Unit, ($), (>>>))
import Types (Action, App)


foreign import _startPorts :: forall eff. (Json -> Eff eff Unit) -> App -> Eff eff Unit


start :: forall eff. App -> Eff (electron :: ELECTRON | eff) Unit
start =
  _startPorts $ decodeJson >>> traverse_ doAction


doAction :: forall eff. Action -> Eff (electron :: ELECTRON | eff) Unit
doAction =
  encodeJson >>> IpcRenderer.send "system-action"
