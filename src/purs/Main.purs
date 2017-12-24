module Main (main) where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Now (NOW)
import Control.Monad.Eff.Now as Now
import FFI.Elm as Elm
import Prelude (Unit, bind)
import Types (flags, reports)

main :: forall eff. Eff (now :: NOW | eff) Unit
main = do
  now <- Now.now
  -- TODO: Get records from database
  Elm.startElm (flags reports now)
