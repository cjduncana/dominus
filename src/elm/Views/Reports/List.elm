module Views.Reports.List exposing (reportsList)

import Array.NonEmpty as NonEmptyArray exposing (NonEmptyArray)
import Date exposing (Date)
import Element exposing (Attribute, Element)
import Element.Attributes as Attrs
import Models.Report exposing (Report, Reports)
import Utils.Date as Date
import Utils.Persistable exposing (Persistable)
import Views.Styles as Styles exposing (Styles)
import Views.Vectors as Vectors


reportsList : Reports -> Maybe Date -> Element Styles variation msg
reportsList reports today =
    (addNewReport :: reportsView today reports)
        |> Element.column Styles.NoStyle [ Attrs.spacing 6 ]
        |> Element.el Styles.NoStyle
            [ Attrs.height Attrs.fill
            , Attrs.width Attrs.fill
            ]


addNewReport : Element Styles variation msg
addNewReport =
    Element.row Styles.NoStyle
        [ Attrs.spread
        , Attrs.width Attrs.fill
        , Attrs.paddingTop 11
        , Attrs.paddingLeft 27
        , Attrs.paddingRight 14
        , Attrs.paddingBottom 11
        ]
        [ Element.text "New Report"
        , Element.html Vectors.addButton
        ]
        |> Element.el Styles.AddReport []


reportsView : Maybe Date -> Reports -> List (Element Styles variation msg)
reportsView today =
    NonEmptyArray.indexedMapSelected (reportView today)
        >> NonEmptyArray.toList


reportView :
    Maybe Date
    -> Bool
    -> Int
    -> Persistable a Report
    -> Element Styles variation msg
reportView today isSelected index =
    Utils.Persistable.value
        >> ternary isSelected selectedReport otherReport index today


selectedReport : Int -> Maybe Date -> Report -> Element Styles variation msg
selectedReport _ =
    Models.Report.mapReport
        (\isCompleted maybeDate ->
            Element.column Styles.ReportListItem
                reportListItemAttrs
                [ Element.row Styles.NoStyle
                    [ Attrs.spread ]
                    [ Element.whenJust maybeDate dateView
                    , Element.html Vectors.deleteButton
                    ]
                , Element.when (not isCompleted) actions
                ]
                |> Element.within
                    [ Element.el Styles.AccentBox
                        [ Attrs.height Attrs.fill
                        , Attrs.width <| Attrs.px 9.8
                        ]
                        Element.empty
                    ]
        )


actions : Element Styles variation msg
actions =
    Element.row Styles.NoStyle
        [ Attrs.alignRight, Attrs.spacing 28 ]
        [ Element.text "Edit"
            |> Element.el Styles.ReportListItemEdit []
        , Element.text "Complete"
            |> Element.el Styles.ReportListItemComplete []
        ]


otherReport : Int -> Maybe Date -> Report -> Element Styles variation msg
otherReport _ =
    Models.Report.mapReport
        (\_ maybeDate ->
            Element.row Styles.ReportListItem
                (Attrs.spread :: reportListItemAttrs)
                [ Element.whenJust maybeDate dateView
                , Element.html Vectors.deleteButton
                ]
        )


dateView : Date -> Element Styles variation msg
dateView date =
    Element.column Styles.NoStyle
        []
        [ Date.month date
            |> Date.monthToString
            |> Element.text
            |> Element.el Styles.Month []
        , Date.dateToString date
            |> Element.text
            |> Element.el Styles.DigitDate []
        ]


reportListItemAttrs : List (Attribute variation msg)
reportListItemAttrs =
    [ Attrs.paddingTop 13
    , Attrs.paddingLeft 26
    , Attrs.paddingRight 13
    , Attrs.paddingBottom 13
    , Attrs.width Attrs.fill
    ]


ternary : Bool -> a -> a -> a
ternary decider whenTrue whenFalse =
    if decider then
        whenTrue
    else
        whenFalse
