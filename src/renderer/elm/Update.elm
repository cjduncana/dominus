module Update exposing (update)

import Model exposing (Model, Msg)
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Model.DateReceived today ->
            Model.updateToday today model
                |> Model.doNothing

        Model.PortMsg portMsg ->
            Ports.cmd portMsg
                |> flip Model.doSomething model

        Model.NoOp ->
            Model.doNothing model
