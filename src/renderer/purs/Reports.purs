module Reports (list) where

import Control.Monad.Aff (Aff)
import Data.Foreign (F, Foreign, ForeignError(..))
import Data.Foreign as Foreign
import Database as Database
import Electron (ELECTRON)
import FFI.Sql (SQLJS)
import Node.Buffer (BUFFER)
import Node.FS (FS)
import Prelude (($))
import Types (Report)


list :: forall eff. Aff (buffer :: BUFFER, electron :: ELECTRON, fs :: FS, sql :: SQLJS | eff) (Array Report)
list =
  Database.fromManyResults reportFromResult "SELECT * FROM `reports` ORDER BY `date` DESC;"


reportFromResult :: Array String -> Array Foreign -> F Report
reportFromResult columnName result =
  Foreign.fail $ ForeignError "To Do Implementation"
