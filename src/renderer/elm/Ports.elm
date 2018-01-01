port module Ports exposing (Msg(CloseWindow, MinimizeWindow), cmd)

import Json.Encode as Encode exposing (Value)


type Msg
    = CloseWindow
    | MinimizeWindow


cmd : Msg -> Cmd msg
cmd =
    simpleAction >> outOfElm


simpleAction : Msg -> Value
simpleAction action =
    Encode.object [ ( "type", Encode.string <| toString action ) ]


port outOfElm : Value -> Cmd msg
