module Main exposing (main)

import Html
import Json.Decode exposing (Value)
import Model exposing (Model, Msg)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


main : Program Value Model Msg
main =
    Html.programWithFlags
        { init = Model.init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
