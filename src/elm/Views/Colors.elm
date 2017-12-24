module Views.Colors
    exposing
        ( accent
        , background
        , cardBackground
        , iconBackground
        , iconMain
        , lightBorder
        , mainText
        , softAccent
        , system
        , systemIcon
        )

import Color exposing (Color)


accent : Color
accent =
    Color.rgb 0 150 136


background : Color
background =
    Color.rgb 247 247 247


softAccent : Color
softAccent =
    Color.rgba 0 150 136 0.2


cardBackground : Color
cardBackground =
    Color.white


iconBackground : Color
iconBackground =
    Color.white


iconMain : Color
iconMain =
    grayishBrown


lightBorder : Color
lightBorder =
    Color.rgb 229 229 229


mainText : Color
mainText =
    grayishBrown


system : Color
system =
    Color.rgb 165 165 165


systemIcon : Color
systemIcon =
    Color.white



-- Base Colors


grayishBrown : Color
grayishBrown =
    Color.rgb 73 73 73
