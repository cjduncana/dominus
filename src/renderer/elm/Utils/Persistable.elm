module Utils.Persistable exposing (Persistable(New, Persisted), value)


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
