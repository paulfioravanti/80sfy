module Key exposing (Key, decoder, pressed, subscriptions)

import AudioPlayer
import FullScreen
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


pressed :
    (AudioPlayer.Msg -> msg)
    -> (FullScreen.Msg -> msg)
    -> msg
    -> msg
    -> Model
    -> Key
    -> Cmd msg
pressed audioPlayerMsg fullScreenMsg pauseMsg playMsg model key =
    Cmd.pressed audioPlayerMsg fullScreenMsg pauseMsg playMsg model key


subscriptions : (Key -> msg) -> Sub msg
subscriptions keyMsg =
    Subscriptions.subscriptions keyMsg
