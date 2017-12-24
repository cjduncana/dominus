module Views.Styles
    exposing
        ( Styles
            ( AccentBox
            , AddReport
            , Body
            , DigitDate
            , Header
            , Month
            , NoLineHeight
            , NoStyle
            , ReportListItem
            , ReportListItemComplete
            , ReportListItemEdit
            )
        , styleSheet
        )

import Style exposing (Property, StyleSheet)
import Style.Border
import Style.Color
import Style.Font
import Views.Colors as Colors
import Views.Fonts as Fonts


type Styles
    = NoStyle
    | NoLineHeight
    | AccentBox
    | AddReport
    | Body
    | DigitDate
    | Header
    | Month
    | ReportListItem
    | ReportListItemComplete
    | ReportListItemEdit


styleSheet : StyleSheet Styles variation
styleSheet =
    Style.styleSheet
        [ Style.style NoStyle []
        , Style.style NoLineHeight [ Style.Font.lineHeight 0 ]
        , Style.style AccentBox [ Style.Color.background Colors.accent ]
        , Style.style AddReport
            (Style.Border.all 1
                :: Style.Border.solid
                :: Style.Color.background Colors.softAccent
                :: Style.Color.border Colors.accent
                :: Style.Font.size 18
                :: Style.Font.weight 700
                :: textProps
            )
        , Style.style Body [ Style.Color.background Colors.background ]
        , Style.style DigitDate
            (Style.Font.letterSpacing 0.5
                :: Style.Font.size 16
                :: textProps
            )
        , Style.style Header
            (Style.Border.bottom 1
                :: Style.Border.solid
                :: Style.Color.background Colors.cardBackground
                :: Style.Color.border Colors.lightBorder
                :: Style.Font.lowercase
                :: Style.Font.size 16
                :: Style.Font.weight 900
                :: textProps
            )
        , Style.style Month (Style.Font.size 30 :: titleProps)
        , Style.style ReportListItem
            [ Style.Border.all 1
            , Style.Border.solid
            , Style.Color.background Colors.cardBackground
            , Style.Color.border Colors.lightBorder
            ]
        , Style.style ReportListItemComplete
            (Style.Font.size 16
                :: Style.Font.weight 700
                :: textProps
            )
        , Style.style ReportListItemEdit (Style.Font.size 16 :: textProps)
        ]


textProps : List (Property class variation)
textProps =
    [ Style.Color.text Colors.mainText
    , Style.Font.typeface [ Fonts.roboto, Style.Font.sansSerif ]
    ]


titleProps : List (Property class variation)
titleProps =
    [ Style.Color.text Colors.mainText
    , Style.Font.typeface [ Fonts.domine, Style.Font.serif ]
    ]
