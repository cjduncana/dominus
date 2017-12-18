module Styles exposing (Styles(Header, NoStyle), styleSheet)

import Colors
import Fonts
import Style exposing (StyleSheet)
import Style.Color
import Style.Font


type Styles
    = NoStyle
    | Header


styleSheet : StyleSheet Styles variations
styleSheet =
    Style.styleSheet
        [ Style.style NoStyle []
        , Style.style Header
            [ Style.Color.background Colors.mainBackground
            , Style.Color.text Colors.mainText
            , Style.Font.lowercase
            , Style.Font.size 16
            , Style.Font.typeface [ Fonts.roboto, Style.Font.sansSerif ]
            , Style.Font.weight 900
            ]
        ]
