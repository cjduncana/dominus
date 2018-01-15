module Goods (list) where

import Control.Monad.Aff (Aff)
import Data.Foreign (F, Foreign, ForeignError(..))
import Data.Foreign as Foreign
import Database as Database
import FFI.Sql (SQLJS)
import Node.Buffer (BUFFER)
import Node.FS (FS)
import Node.Path (FilePath)
import Prelude (($))
import Types (Good)


list :: forall eff. FilePath -> Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) (Array Good)
list =
  Database.fromManyResults goodFromResult "SELECT * FROM `goods` ORDER BY `name` DESC;"


goodFromResult :: Array String -> Array Foreign -> F Good
goodFromResult columnName result =
  Foreign.fail $ ForeignError "To Do Implementation"



