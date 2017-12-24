module Views.Reports.View exposing (reportView)

import Element exposing (Element)
import Element.Attributes as Attrs
import Models.Report exposing (Report)
import Utils.Persistable exposing (Persistable)
import Uuid exposing (Uuid)
import Views.Styles as Styles exposing (Styles)


reportView : Persistable Uuid Report -> Element Styles variation msg
reportView _ =
    Element.empty
        |> Element.el Styles.NoStyle
            [ Attrs.height Attrs.fill
            , Attrs.width <| Attrs.fillPortion 2
            ]
