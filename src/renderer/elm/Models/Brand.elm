module Models.Brand exposing (Brand, brandDecoder)

import Json.Decode as Decode exposing (Decoder)
import Utils.Persistable as Persistable exposing (Persistable)
import Uuid exposing (Uuid)


type Brand
    = Brand String


brandDecoder : Decoder (Persistable Uuid Brand)
brandDecoder =
    Decode.field "name" Decode.string
        |> Decode.map Brand
        |> Decode.andThen (Persistable.decoder (Decode.field "id" Uuid.decoder))
