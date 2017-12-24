module View exposing (view)

import Array.NonEmpty as NonEmptyArray
import Date exposing (Date)
import Element exposing (Element)
import Element.Attributes as Attrs
import Html exposing (Html)
import Model exposing (Model)
import Models.Report exposing (Reports)
import Views.Header exposing (header)
import Views.Reports.List exposing (reportsList)
import Views.Reports.View exposing (reportView)
import Views.Styles as Styles exposing (Styles)


view : Model -> Html msg
view { reports, today } =
    Element.column Styles.NoStyle
        [ Attrs.height Attrs.fill
        , Attrs.width Attrs.fill
        ]
        [ header, body reports today ]
        |> Element.viewport Styles.styleSheet


body : Reports -> Maybe Date -> Element Styles variation msg
body reports today =
    Element.row Styles.Body
        [ Attrs.height Attrs.fill
        , Attrs.padding 4
        ]
        [ reportsList reports today
        , reportView <| NonEmptyArray.getSelected reports
        ]
