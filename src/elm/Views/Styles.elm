module Views.Styles
    exposing
        ( Styles
            ( AccentBox
            , AddReport
            , Body
            , CancelButton
            , Card
            , DigitDate
            , Header
            , Month
            , NoStyle
            , ReportDate
            , ReportInput
            , ReportInputWrapper
            , ReportListItemComplete
            , ReportListItemEdit
            , SaveButton
            , SystemButton
            , TableHeader
            )
        , styleSheet
        )

import Style exposing (Property, StyleSheet)
import Style.Border
import Style.Color
import Style.Font
import Views.Colors as Colors
import Views.Fonts as Fonts


type FontStack
    = SansSerif
    | Serif


type Styles
    = NoStyle
    | AccentBox
    | AddReport
    | Body
    | CancelButton
    | Card
    | DigitDate
    | Header
    | Month
    | ReportDate
    | ReportInput
    | ReportInputWrapper
    | ReportListItemComplete
    | ReportListItemEdit
    | SaveButton
    | SystemButton
    | TableHeader


styleSheet : StyleSheet Styles variation
styleSheet =
    Style.styleSheet
        [ Style.style NoStyle []
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
        , Style.style CancelButton
            (Style.Border.all 2
                :: Style.Border.solid
                :: Style.Color.border Colors.mainText
                :: Style.Font.letterSpacing 0.4
                :: Style.Font.size 14
                :: Style.Font.weight 700
                :: textProps
            )
        , Style.style Card
            (Style.Color.background Colors.cardBackground
                :: lightBorder
            )
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
        , Style.style ReportDate (Style.Font.size 40 :: titleProps)
        , Style.style ReportInput
            (Style.Font.letterSpacing 0.4
                :: Style.Font.size 12
                :: textProps
                ++ lightBorder
            )
        , Style.style ReportInputWrapper
            [ Style.Border.top 1
            , Style.Border.solid
            , Style.Color.border Colors.system
            ]
        , Style.style ReportListItemComplete
            (Style.Font.size 16
                :: Style.Font.weight 700
                :: textProps
            )
        , Style.style ReportListItemEdit (Style.Font.size 16 :: textProps)
        , Style.style SaveButton
            [ Style.Border.all 2
            , Style.Border.solid
            , Style.Color.border Colors.accent
            , Style.Color.text Colors.accent
            , Style.Font.letterSpacing 0.4
            , Style.Font.size 14
            , fontStack SansSerif
            , Style.Font.weight 700
            ]
        , Style.style SystemButton
            [ Style.cursor "pointer"
            , Style.Font.lineHeight 0
            ]
        , Style.style TableHeader
            (Style.Border.bottom 1
                :: Style.Border.solid
                :: Style.Color.border Colors.system
                :: Style.Font.center
                :: Style.Font.letterSpacing 0.4
                :: Style.Font.size 14
                :: Style.Font.weight 700
                :: textProps
            )
        ]


fontStack : FontStack -> Property class variation
fontStack stack =
    case stack of
        SansSerif ->
            Style.Font.typeface [ Fonts.roboto, Style.Font.sansSerif ]

        Serif ->
            Style.Font.typeface [ Fonts.domine, Style.Font.serif ]


lightBorder : List (Property class variation)
lightBorder =
    [ Style.Border.all 1
    , Style.Border.solid
    , Style.Color.border Colors.lightBorder
    ]


textProps : List (Property class variation)
textProps =
    [ Style.Color.text Colors.mainText, fontStack SansSerif ]


titleProps : List (Property class variation)
titleProps =
    [ Style.Color.text Colors.mainText, fontStack Serif ]
