module Main exposing (main)

import Html
import Model exposing (Model)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import View exposing (view)


main : Program Never Model msg
main =
    Html.program
        { init = Model.init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
