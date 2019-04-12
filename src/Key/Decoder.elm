module Key.Decoder exposing (decoder)

import Json.Decode as Decode exposing (string)
import Key.Model as Key exposing (Key)


decoder : Decode.Decoder Key
decoder =
    Decode.map Key.fromString (Decode.field "key" string)
