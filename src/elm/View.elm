module View exposing (view)

import Array.NonEmpty as NonEmptyArray
import Date exposing (Date)
import Element exposing (Element)
import Element.Attributes as Attrs
import Html exposing (Html)
import Model exposing (Model, Msg)
import Models.Report exposing (Reports)
import Utils.Persistable
import Views.Header exposing (header)
import Views.Reports.List exposing (reportsList)
import Views.Reports.View exposing (reportView)
import Views.Styles as Styles exposing (Styles)


view : Model -> Html Msg
view { reports, today } =
    Element.column Styles.NoStyle
        [ Attrs.height Attrs.fill
        , Attrs.width Attrs.fill
        ]
        [ header, body reports today ]
        |> Element.viewport Styles.styleSheet


body : Reports -> Maybe Date -> Element Styles variation Msg
body reports today =
    Element.row Styles.Body
        [ Attrs.height Attrs.fill
        , Attrs.padding 4
        , Attrs.spacing 18
        ]
        [ reportsList reports today
        , NonEmptyArray.getSelected reports
            |> Utils.Persistable.value
            |> Models.Report.mapReport
                (reportView <| NonEmptyArray.selectedIndex reports)
                today
        ]
