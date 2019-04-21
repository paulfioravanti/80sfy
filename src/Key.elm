module Key exposing (Key, decoder, pressed, subscriptions)

import Json.Decode as Decode
import Key.Cmd as Cmd
import Key.Decoder as Decoder
import Key.Model as Key exposing (Key)
import Key.Subscriptions as Subscriptions
import Model exposing (Model)


type alias Key =
    Key.Key


decoder : Decode.Decoder Key
decoder =
    Decoder.decoder


pressed : Cmd.Msgs msgs msg -> Model -> Key -> Cmd msg
pressed msgs model key =
    Cmd.pressed msgs model key


subscriptions : (Key -> msg) -> Sub msg
subscriptions keyMsg =
    Subscriptions.subscriptions keyMsg
