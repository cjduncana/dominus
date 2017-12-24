module FFI.Elm (startElm) where

import Control.Monad.Eff (Eff)
import Data.Argonaut.Core (Json)
import Data.Argonaut.Encode (encodeJson)
import Prelude (Unit, (>>>))
import Types (Flags)

foreign import startElmImpl :: forall eff. Json -> Eff eff Unit

startElm :: forall eff. Flags -> Eff eff Unit
startElm =
  encodeJson >>> startElmImpl
