module Reports (list) where

import Control.Monad.Aff (Aff)
import Control.Monad.Aff as Aff
import Control.Monad.Except as Except
import Data.Either as Either
import Data.Foreign (F, Foreign, ForeignError(..))
import Data.Foreign as Foreign
import Data.Functor as Functor
import Data.Traversable as Traversable
import Database as Database
import FFI.Config as Config
import FFI.Sql (QueryResult, SQLJS)
import FFI.Sql as Sql
import Node.Buffer (BUFFER)
import Node.FS (FS)
import Prelude (bind, pure, show, (#), ($), (>>>))
import Types (Report)


list :: forall eff. Aff (buffer :: BUFFER, fs :: FS, sql :: SQLJS | eff) (Array Report)
list = do
  results <- Database.execute Config.databaseFilePath "SELECT * FROM `reports` ORDER BY `date` DESC;"
  Sql.getFirstResult results # reportsFromResult # fromFToAff


reportsFromResult :: QueryResult -> F (Array Report)
reportsFromResult result =
  Functor.map (reportFromResult result.columns) result.values
    # Traversable.sequence


reportFromResult :: Array String -> Array Foreign -> F Report
reportFromResult columnName result =
  Foreign.fail $ ForeignError "To Do Implementation"


fromFToAff :: forall a eff. F a -> Aff eff a
fromFToAff =
  Except.runExcept >>> Either.either (show >>> Aff.error >>> Aff.throwError) pure
