module Utils.Persistable exposing (Persistable(New, Persisted), decoder, value)

import Json.Decode as Decode exposing (Decoder)


type Persistable id value
    = New value
    | Persisted id value


value : Persistable id value -> value
value persistable =
    case persistable of
        New v ->
            v

        Persisted _ v ->
            v


decoder : Decoder id -> value -> Decoder (Persistable id value)
decoder idDecoder =
    flip Persisted
        >> flip Decode.map idDecoder
