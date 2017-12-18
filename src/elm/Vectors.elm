module Vectors exposing (accentBox, close, minimize)

import Colors
import Html exposing (Html)
import TypedSvg as Svg
import TypedSvg.Attributes as Attrs
import TypedSvg.Core exposing (Attribute)
import TypedSvg.Types as Types


accentBox : Html msg
accentBox =
    Svg.svg (Attrs.viewBox 0 0 67 5 :: accentBoxSize)
        [ Svg.rect (accentColor :: accentBoxSize) [] ]


accentBoxSize : List (Attribute msg)
accentBoxSize =
    [ Attrs.height <| Types.Px 5
    , Attrs.width <| Types.Px 67
    ]


accentColor : Attribute msg
accentColor =
    Attrs.fill <| Types.Fill Colors.accent


close : Html msg
close =
    systemIcon
        ("M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z"
            ++ "m121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-"
            ++ "17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4"
            ++ ".7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-"
            ++ "39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 1"
            ++ "7 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z"
        )


minimize : Html msg
minimize =
    systemIcon
        ("M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8z"
            ++ "M124 296c-6.6 0-12-5.4-12-12v-56c0-6.6 5.4-12 12-12h264c6.6 0 1"
            ++ "2 5.4 12 12v56c0 6.6-5.4 12-12 12H124z"
        )


systemIcon : String -> Html msg
systemIcon path =
    Svg.svg (Attrs.viewBox 0 0 512 512 :: systemButtonSize)
        [ Svg.path [ Attrs.d path, systemColor ] [] ]


systemButtonSize : List (Attribute msg)
systemButtonSize =
    [ Attrs.height, Attrs.width ]
        |> List.map ((|>) (Types.Px 25))


systemColor : Attribute msg
systemColor =
    Attrs.fill <| Types.Fill Colors.system
