module Key.Decoder exposing (decoder)

import Json.Decode as Decode exposing (Decoder, string)
import Key.Model as Key exposing (Key)


decoder : Decoder Key
decoder =
    let
        keyString : Decoder String
        keyString =
            Decode.field "key" string
    in
    Decode.map Key.fromString keyString
