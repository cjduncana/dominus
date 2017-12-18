module View exposing (view)

import Element exposing (Element)
import Element.Attributes as Attrs
import Html exposing (Html)
import Model exposing (Model)
import Styles
import Views.Header exposing (header)


view : Model -> Html msg
view _ =
    Element.column Styles.NoStyle
        [ Attrs.height Attrs.fill
        , Attrs.width Attrs.fill
        ]
        [ header, body ]
        |> Element.viewport Styles.styleSheet


body : Element style variations msg
body =
    Element.empty
