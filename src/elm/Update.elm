module Update exposing (update)

import Model exposing (Model, Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Model.DateReceived date ->
            ( { model | today = Just date }, Cmd.none )

        Model.NoOp ->
            ( model, Cmd.none )
