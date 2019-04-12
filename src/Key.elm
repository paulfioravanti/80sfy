module Key exposing (Key, decoder, pressed)

import AudioPlayer
import FullScreen
import Json.Decode as Decode
import Key.Cmd as Cmd
import Key.Decoder as Decoder
import Key.Model as Key
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
