module Views.Reports.View exposing (reportView)

import Date exposing (Date)
import Element exposing (Element, OnGrid)
import Element.Attributes as Attrs
import Element.Input as Input
import Html
import Model exposing (Msg(NoOp))
import Utils.Date as Date
import Views.Styles as Styles exposing (Styles)


reportView : Int -> Bool -> Maybe Date -> Element Styles variation Msg
reportView index _ maybeDate =
    Element.column Styles.Card
        [ Attrs.paddingTop 32
        , Attrs.paddingLeft 25
        , Attrs.paddingRight 25
        , Attrs.paddingBottom 25
        , Attrs.spacing 40
        ]
        [ header index maybeDate, goodsList ]
        |> Element.el Styles.NoStyle
            [ Attrs.paddingTop 1
            , Attrs.paddingRight 6
            , Attrs.width <| Attrs.fillPortion 2
            ]


header : Int -> Maybe Date -> Element Styles variation msg
header index maybeDate =
    Element.row Styles.NoStyle
        [ Attrs.spread ]
        [ Element.whenJust maybeDate dateView
        , actions index
        ]


dateView : Date -> Element Styles variation msg
dateView date =
    Date.dateToAbbrString date
        |> Element.text
        |> Element.el Styles.ReportDate []


actions : Int -> Element Styles variation msg
actions _ =
    Element.row Styles.NoStyle
        [ Attrs.spacing 26, Attrs.verticalCenter ]
        [ actionButton Styles.SaveButton "Save"
        , actionButton Styles.CancelButton "Cancel"
        ]


actionButton : Styles -> String -> Element Styles variation msg
actionButton style =
    Element.text
        >> Element.el
            Styles.NoStyle
            [ Attrs.center
            , Attrs.verticalCenter
            ]
        >> Element.el style
            [ Attrs.height <| Attrs.px 24
            , Attrs.width <| Attrs.px 94
            ]


goodsList : Element Styles variation Msg
goodsList =
    Element.grid Styles.NoStyle
        []
        { columns =
            Attrs.fillPortion 3
                :: List.repeat 2 (Attrs.fillPortion 2)
                ++ List.repeat 3 Attrs.fill
        , rows = List.repeat 3 Attrs.fill
        , cells = tableHeaders ++ inputRow 0
        }


tableHeaders : List (OnGrid (Element Styles variation msg))
tableHeaders =
    [ "Good", "Brand", "Market", "Qty. Stored", "Qty. Used", "" ]
        |> List.indexedMap
            (\columnPosition title ->
                Element.cell
                    { start = ( columnPosition, 0 )
                    , width = 1
                    , height = 1
                    , content = tableHeader title
                    }
            )


tableHeader : String -> Element Styles variation msg
tableHeader =
    Html.text
        >> List.singleton
        >> Html.span []
        >> Element.html
        >> Element.el Styles.NoStyle [ Attrs.alignLeft, Attrs.alignBottom ]
        >> Element.el Styles.TableHeader [ Attrs.paddingBottom 8 ]


inputRow : Int -> List (OnGrid (Element Styles variation Msg))
inputRow length =
    let
        style =
            if length == 0 then
                Styles.NoStyle
            else
                Styles.ReportInputWrapper

        rowPosition =
            length + 1

        topRightPadding =
            [ Attrs.paddingTop 9, Attrs.paddingRight 5 ]

        emptyCell columnPosition =
            Element.cell
                { start = ( columnPosition, rowPosition )
                , width = 1
                , height = 1
                , content =
                    Element.el style [ Attrs.paddingTop 9 ] Element.empty
                }
    in
    [ Element.cell
        { start = ( 0, rowPosition )
        , width = 2
        , height = 1
        , content =
            Input.text Styles.ReportInput
                []
                { onChange = \_ -> NoOp
                , value = ""
                , label = Input.hiddenLabel "Goods"
                , options = []
                }
                |> Element.el style topRightPadding
        }
    , emptyCell 2
    , Element.cell
        { start = ( 3, rowPosition )
        , width = 1
        , height = 1
        , content =
            Input.text Styles.ReportInput
                []
                { onChange = \_ -> NoOp
                , value = ""
                , label = Input.hiddenLabel "Quantity Stored"
                , options = []
                }
                |> Element.el style (Attrs.paddingLeft 5 :: topRightPadding)
        }
    , Element.cell
        { start = ( 4, rowPosition )
        , width = 1
        , height = 1
        , content =
            Input.text Styles.ReportInput
                []
                { onChange = \_ -> NoOp
                , value = ""
                , label = Input.hiddenLabel "Quantity Used"
                , options = []
                }
                |> Element.el style (Attrs.paddingLeft 5 :: topRightPadding)
        }
    , emptyCell 5
    ]
