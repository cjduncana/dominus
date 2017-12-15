module Main (main) where

import Control.Monad.Eff (Eff)
import FFI.Elm as Elm
import Prelude (Unit)

main :: forall eff. Eff eff Unit
main =
  Elm.startElm
