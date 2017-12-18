module Views.Header exposing (header)

import Element exposing (Element)
import Element.Attributes as Attrs
import Styles exposing (Styles)
import Vectors


header : Element Styles variation msg
header =
    Element.text "Dominus"
        |> Element.el Styles.NoStyle
            [ Attrs.center
            , Attrs.verticalCenter
            ]
        |> Element.el Styles.Header
            [ Attrs.height <| Attrs.px 50
            , Attrs.width Attrs.fill
            ]
        |> Element.within [ accentBox, systemControls ]


accentBox : Element Styles variation msg
accentBox =
    Element.html Vectors.accentBox
        |> Element.el Styles.NoStyle
            [ Attrs.center
            , Attrs.alignBottom
            ]


systemControls : Element Styles variation msg
systemControls =
    Element.row Styles.NoStyle
        [ Attrs.padding 12.5
        , Attrs.spacing 15
        ]
        [ minimizeButton, closeButton ]
        |> Element.el Styles.NoStyle
            [ Attrs.alignRight
            , Attrs.verticalCenter
            ]


closeButton : Element Styles variation msg
closeButton =
    Element.html Vectors.close
        |> Element.el Styles.NoStyle
            [ Attrs.center
            , Attrs.verticalCenter
            ]


minimizeButton : Element Styles variation msg
minimizeButton =
    Element.html Vectors.minimize
        |> Element.el Styles.NoStyle
            [ Attrs.center
            , Attrs.verticalCenter
            ]
