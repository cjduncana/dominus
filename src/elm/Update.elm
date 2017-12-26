module Update exposing (update)

import Model exposing (Model, Msg)
import Ports


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Model.DateReceived date ->
            ( { model | today = Just date }, Cmd.none )

        Model.PortMsg portMsg ->
            ( model, Ports.cmd portMsg )

        Model.NoOp ->
            ( model, Cmd.none )
