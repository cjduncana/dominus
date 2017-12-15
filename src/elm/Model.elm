module Model exposing (Model, init)


type alias Model =
    ()


initialModel : Model
initialModel =
    ()


init : ( Model, Cmd msg )
init =
    ( initialModel, Cmd.none )
