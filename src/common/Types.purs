module Types (Action(..), App, Flag, Good, Report, flag, report) where

import Data.Argonaut.Core (jsonEmptyObject)
import Data.Argonaut.Decode (class DecodeJson, decodeJson, getField)
import Data.Argonaut.Encode (class EncodeJson, (:=), (~>))
import Data.DateTime.Instant (Instant, unInstant)
import Data.Either (Either(..))
import Data.Maybe (Maybe)
import Data.Newtype (unwrap)
import Prelude (bind, ($))


foreign import data App :: Type


data Action
  = CloseWindow
  | MinimizeWindow

instance decodeAction :: DecodeJson Action where
  decodeJson json = do
    obj <- decodeJson json
    actionType <- getField obj "type"
    case actionType of
      "CloseWindow" -> Right CloseWindow
      "MinimizeWindow" -> Right MinimizeWindow
      _ -> Left "Action couldn't be decoded"

instance encodeAction :: EncodeJson Action where
  encodeJson =
    case _ of
      CloseWindow -> "type" := "CloseWindow" ~> jsonEmptyObject
      MinimizeWindow -> "type" := "MinimizeWindow" ~> jsonEmptyObject


data Brand = Brand
  { id :: String
  , name :: String
  }

instance encodeBrand :: EncodeJson Brand where
  encodeJson (Brand { id, name }) =
    "id" := id
      ~> "name" := name
      ~> jsonEmptyObject


data Flag = Flag
  { reports :: Array Report
  , goods :: Array Good
  , now :: Instant
  }

flag :: Array Report -> Array Good -> Instant -> Flag
flag reports goods now =
  Flag { reports: reports, goods: goods, now: now }

instance encodeFlag :: EncodeJson Flag where
  encodeJson (Flag { reports, goods, now }) =
    "reports" := reports
      ~> "goods" := goods
      ~> "now" := (unwrap $ unInstant now)
      ~> jsonEmptyObject


data Good = Good
  { id :: String
  , name :: String
  , brand :: Maybe Brand
  }

instance encodeGood :: EncodeJson Good where
  encodeJson (Good { id, name, brand }) =
    "id" := id
      ~> "name" := name
      ~> "brand" := brand
      ~> jsonEmptyObject


data Report = Report
  { id :: String
  , date :: String
  , completed :: Boolean
  }

report :: String -> String -> Boolean -> Report
report id date completed =
  Report
      { id: id
      , date: date
      , completed: completed
      }

instance encodeReport :: EncodeJson Report where
  encodeJson (Report { id, date, completed }) =
    "id" := id
      ~> "date" := date
      ~> "completed" := completed
      ~> jsonEmptyObject
