module Models.Good exposing (Goods, goodDecoder)

import Json.Decode as Decode exposing (Decoder)
import Models.Brand exposing (Brand)
import Utils.Persistable as Persistable exposing (Persistable)
import Uuid exposing (Uuid)


type Good
    = Good String (Maybe (Persistable Uuid Brand))


type alias Goods =
    List (Persistable Uuid Good)


goodDecoder : Decoder (Persistable Uuid Good)
goodDecoder =
    Decode.maybe Models.Brand.brandDecoder
        |> Decode.field "brand"
        |> Decode.map2 Good (Decode.field "name" Decode.string)
        |> Decode.andThen (Persistable.decoder (Decode.field "id" Uuid.decoder))
