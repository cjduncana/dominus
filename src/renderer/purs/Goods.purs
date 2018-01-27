module Goods (list) where

import Control.Monad.Aff (Aff)
import Data.Array as Array
import Data.Foreign (F, Foreign, ForeignError(ForeignError))
import Data.Foreign as Foreign
import Data.Maybe (Maybe(Nothing))
import Data.Maybe as Maybe
import Database as Database
import Electron (ELECTRON)
import FFI.Sql (SQLJS)
import Node.Buffer (BUFFER)
import Node.FS (FS)
import Prelude (pure, ($), (<$>), (<*>), (<>), (>>=))
import Types (Good)
import Types as Types


list :: forall eff. Aff (buffer :: BUFFER, electron :: ELECTRON, fs :: FS, sql :: SQLJS | eff) (Array Good)
list =
  Database.fromManyResults goodFromResult "SELECT * FROM `goods` ORDER BY `name` DESC;"


goodFromResult :: Array String -> Array Foreign -> F Good
goodFromResult columnNames results =
  Types.good
    <$> getStringResult "id"
    <*> getStringResult "name"
    <*> pure Nothing
  where
    getStringResult columnName =
      getResult columnName Foreign.readString columnNames results


getResult :: forall a. String -> (Foreign -> F a) -> Array String -> Array Foreign -> F a
getResult columnName transformer columnNames results =
  Maybe.maybe
    (missingColumnError columnName)
    transformer
    (getForeign columnName columnNames results)


getForeign :: String -> Array String -> Array Foreign -> Maybe Foreign
getForeign columnName columnNames results =
  Array.elemIndex columnName columnNames
    >>= Array.index results


missingColumnError :: forall a. String -> F a
missingColumnError columnName =
  Foreign.fail $ ForeignError $ "Result does not include column named \"" <> columnName <> "\""
