module Msg exposing (Msg(..))

import AudioPlayer
import Animation
import Config.Msg
import ControlPanel.Msg
import Http exposing (Error)
import SecretConfig.Msg
import Time exposing (Time)
import VideoPlayer.Msg


type Msg
    = AudioPlayerMsg AudioPlayer.Msg
    | ConfigMsg Config.Msg.Msg
    | ControlPanelMsg ControlPanel.Msg.Msg
    | CrossFadePlayers Time
    | FetchTags (Result Error (List String))
    | InitSecretConfigTags (List String)
    | RandomTag String String
    | SecretConfigMsg SecretConfig.Msg.Msg
    | VideoPlayerMsg VideoPlayer.Msg.Msg
