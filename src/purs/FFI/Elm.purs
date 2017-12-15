module FFI.Elm (startElm) where

import Control.Monad.Eff (Eff)
import Prelude (Unit)

foreign import startElm :: forall eff. Eff eff Unit
