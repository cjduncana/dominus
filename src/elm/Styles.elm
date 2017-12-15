module Styles exposing (Styles(NoStyle), styleSheet)

import Style exposing (StyleSheet)


type Styles
    = NoStyle


styleSheet : StyleSheet Styles variations
styleSheet =
    Style.styleSheet
        [ Style.style NoStyle []
        ]
