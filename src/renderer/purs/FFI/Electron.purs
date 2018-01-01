module FFI.Electron (doAction) where

import Control.Monad.Eff (Eff)
import Prelude (Unit, show, (>>>))
import Types (Action)

foreign import _sendAction :: forall eff. String -> Eff eff Unit

doAction :: forall eff. Action -> Eff eff Unit
doAction =
  show >>> _sendAction
