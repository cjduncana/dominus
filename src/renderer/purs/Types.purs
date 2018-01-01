module Types (Action, App, Flags, Report, flags, report) where

import Data.Argonaut.Core (jsonEmptyObject)
import Data.Argonaut.Decode (class DecodeJson, decodeJson, getField)
import Data.Argonaut.Encode (class EncodeJson, (:=), (~>))
import Data.DateTime.Instant (Instant, unInstant)
import Data.Either (Either(..))
import Data.Newtype (unwrap)
import Prelude (class Show, bind, ($))


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

instance showAction :: Show Action where
  show CloseWindow = "CloseWindow"
  show MinimizeWindow = "MinimizeWindow"


data Flags = Flags
  { reports :: Array Report
  , now :: Instant
  }

flags :: Array Report -> Instant -> Flags
flags reports now =
  Flags { reports: reports, now: now }

instance encodeFlags :: EncodeJson Flags where
  encodeJson (Flags { reports, now }) =
    "reports" := reports
      ~> "now" := (unwrap $ unInstant now)
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
