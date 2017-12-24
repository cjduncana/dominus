module Views.Vectors
    exposing
        ( addButton
        , close
        , deleteButton
        , minimize
        )

import Html exposing (Html)
import TypedSvg as Svg
import TypedSvg.Attributes as Attrs
import TypedSvg.Core exposing (Attribute, Svg)
import TypedSvg.Types as Types
import Views.Colors as Colors


addButton : Html msg
addButton =
    Svg.svg (squareSize 20)
        [ Svg.g []
            [ Svg.circle (iconBackground :: circleSize 10) []
            , Svg.g [ iconMainColor ]
                [ Svg.path [ Attrs.d "M4 9.2h12v2H4z" ] []
                , Svg.path [ Attrs.d "M9 16.2v-12h2v12z" ] []
                ]
            ]
        ]


close : Html msg
close =
    systemIcon -45 <|
        Svg.g [ systemIconColor ]
            [ Svg.path [ Attrs.d "M5 11.5h15V14H5z" ] []
            , Svg.path [ Attrs.d "M11.25 20.25v-15h2.5v15z" ] []
            ]


deleteButton : Html msg
deleteButton =
    Svg.svg (squareSize 26)
        [ Svg.g [ Attrs.transform [ Types.Rotate -45 13.707 11.293 ] ]
            [ Svg.circle (iconBackground :: iconBorder :: circleSize 12) []
            , Svg.g [ iconMainColor ]
                [ Svg.path [ Attrs.d "M4.8 11.04h14.4v2.4H4.8z" ] []
                , Svg.path [ Attrs.d "M10.8 19.44V5.04h2.4v14.4z" ] []
                ]
            ]
        ]


minimize : Html msg
minimize =
    systemIcon 0 <|
        Svg.path [ systemIconColor, Attrs.d "M5 11.25h15v2.5H5z" ] []


systemIcon : Float -> Svg msg -> Html msg
systemIcon rotation innerShape =
    Svg.svg (squareSize 25)
        [ Svg.g [ Attrs.transform [ Types.Rotate rotation 12.5 12.5 ] ]
            [ Svg.circle (systemColor :: circleSize 12.5) []
            , innerShape
            ]
        ]


squareSize : Float -> List (Attribute msg)
squareSize length =
    Attrs.viewBox 0 0 length length
        :: ([ Attrs.height, Attrs.width ]
                |> List.map ((|>) (Types.px length))
           )


circleSize : Float -> List (Attribute msg)
circleSize radius =
    [ Attrs.cx, Attrs.cy, Attrs.r ]
        |> List.map ((|>) (Types.px radius))



-- Color Attributes


systemColor : Attribute msg
systemColor =
    Attrs.fill <| Types.Fill Colors.system


systemIconColor : Attribute msg
systemIconColor =
    Attrs.fill <| Types.Fill Colors.systemIcon


iconBackground : Attribute msg
iconBackground =
    Attrs.fill <| Types.Fill Colors.iconBackground


iconBorder : Attribute msg
iconBorder =
    Attrs.stroke Colors.iconMain


iconMainColor : Attribute msg
iconMainColor =
    Attrs.fill <| Types.Fill Colors.iconMain
