module View exposing (view)

import Element exposing (Element)
import Html exposing (Html)
import Model exposing (Model)
import Styles


view : Model -> Html msg
view model =
    Element.viewport Styles.styleSheet body


body : Element style variations msg
body =
    Element.empty
