module Views.Fonts exposing (domine, roboto)

import Style exposing (Font)
import Style.Font


domine : Font
domine =
    Style.Font.importUrl
        { url = "https://fonts.googleapis.com/css?family=Domine"
        , name = "Domine"
        }


roboto : Font
roboto =
    Style.Font.importUrl
        { url = "https://fonts.googleapis.com/css?family=Roboto:400,700,900"
        , name = "Roboto"
        }
