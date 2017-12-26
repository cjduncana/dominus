module Types (Action, App, Flags, Report, flags, reports) where

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

reports :: Array Report
reports =
  [ Report
      { id: "56b50d53-11b1-4d63-9e6d-ff2037a0cb14"
      , date: "2011-10-05T14:48:00.000Z"
      , completed: false
      }
  , Report
      { id: "1ab63729-d7c7-4b66-b18d-ced03da9c373"
      , date: "2017-12-22T01:06:21-05:00"
      , completed: true
      }
  , Report
      { id: "2cc2eade-5825-459c-a7f7-8417a7855fbe"
      , date: "1970-06-25T00:20:27-05:00"
      , completed: false
      }
  , Report
      { id: "a131448d-d2fe-485a-b1bd-fda419ea87a3"
      , date: "1974-10-19T00:24:39-05:00"
      , completed: true
      }
  ]

instance encodeReport :: EncodeJson Report where
  encodeJson (Report { id, date, completed }) =
    "id" := id
      ~> "date" := date
      ~> "completed" := completed
      ~> jsonEmptyObject
