module Model
    exposing
        ( Model
        , Msg(DateReceived, NoOp, PortMsg)
        , closeWindow
        , init
        , minimizeWindow
        )

import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Decode.Extra as Decode
import Models.Good exposing (Goods)
import Models.Report exposing (Reports)
import Ports
import Task


type alias Model =
    { reports : Reports
    , goods : Goods
    , today : Maybe Date
    }


initialModel : Model
initialModel =
    { reports = Models.Report.newReports
    , goods = []
    , today = Nothing
    }


init : Value -> ( Model, Cmd Msg )
init =
    Decode.decodeValue modelDecoder
        >> Result.withDefault initialModel
        >> initCmd


initCmd : Model -> ( Model, Cmd Msg )
initCmd model =
    model.today
        |> Maybe.map (\_ -> Cmd.none)
        |> Maybe.withDefault (Task.perform DateReceived Date.now)
        |> (,) model


type Msg
    = DateReceived Date
    | PortMsg Ports.Msg
    | NoOp


closeWindow : Msg
closeWindow =
    PortMsg Ports.CloseWindow


minimizeWindow : Msg
minimizeWindow =
    PortMsg Ports.MinimizeWindow


reportsDecoder : Decoder Reports
reportsDecoder =
    Decode.field "reports" Models.Report.reportsDecoder
        |> Decode.maybe
        |> Decode.map (Maybe.withDefault Models.Report.newReports)


goodsDecoder : Decoder Goods
goodsDecoder =
    Decode.list Models.Good.goodDecoder
        |> Decode.field "goods"


todayDecoder : Decoder Date
todayDecoder =
    Decode.field "now" Decode.float
        |> Decode.map Date.fromTime


modelDecoder : Decoder Model
modelDecoder =
    Decode.succeed Model
        |> Decode.andMap reportsDecoder
        |> Decode.andMap goodsDecoder
        |> Decode.andMap (Decode.maybe todayDecoder)
