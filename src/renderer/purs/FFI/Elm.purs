module FFI.Elm (start) where

import Control.Monad.Eff (Eff)
import Data.Argonaut.Core (Json)
import Data.Argonaut.Encode (encodeJson)
import Prelude ((>>>))
import Types (App, Flag)

foreign import _startElmImpl :: forall eff. Json -> Eff eff App

start :: forall eff. Flag -> Eff eff App
start =
  encodeJson >>> _startElmImpl
