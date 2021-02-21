module Key.Decoder exposing (decoder)

import Json.Decode as Decode exposing (string)
import Key.Model as Key exposing (Key)


decoder : Decode.Decoder Key
decoder =
    let
        keyString =
            Decode.field "key" string
    in
    Decode.map Key.fromString keyString
