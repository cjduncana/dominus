module Models.Report
    exposing
        ( Report
        , Reports
        , mapReport
        , newReports
        , reportsDecoder
        )

import Array.NonEmpty as NonEmptyArray exposing (NonEmptyArray)
import Date exposing (Date)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra as Decode
import Utils.Persistable as Persistable exposing (Persistable)
import Uuid exposing (Uuid)


type Report
    = NewReport
    | ActiveReport Date
    | CompletedReport Date


type alias Reports =
    NonEmptyArray (Persistable Uuid Report)


newReports : Reports
newReports =
    NewReport
        |> Persistable.New
        |> NonEmptyArray.fromElement


reportsDecoder : Decoder Reports
reportsDecoder =
    Decode.list reportDecoder
        |> Decode.andThen
            (NonEmptyArray.fromList
                >> Maybe.map Decode.succeed
                >> Maybe.withDefault (Decode.fail "No reports found")
            )


reportDecoder : Decoder (Persistable Uuid Report)
reportDecoder =
    Decode.field "completed" Decode.bool
        |> Decode.andThen
            (\completed ->
                Decode.field "date" Decode.date
                    |> Decode.map
                        (if completed then
                            CompletedReport
                         else
                            ActiveReport
                        )
            )
        |> Decode.andThen (Persistable.decoder (Decode.field "id" Uuid.decoder))


mapReport : (Bool -> Maybe Date -> a) -> Maybe Date -> Report -> a
mapReport fn today report =
    case report of
        NewReport ->
            fn False today

        ActiveReport date ->
            fn False <| Just date

        CompletedReport date ->
            fn True <| Just date
