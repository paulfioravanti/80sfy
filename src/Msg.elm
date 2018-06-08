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
    | FetchRandomGif String (Result Error String)
    | FetchTags (Result Error (List String))
    | InitSecretConfigTags (List String)
    | RandomTag String String
    | SaveConfig String String
    | SecretConfigMsg SecretConfig.Msg.Msg
    | VideoPlayerMsg VideoPlayer.Msg.Msg
