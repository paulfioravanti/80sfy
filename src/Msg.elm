module Msg exposing (Msg(..))

import AudioPlayer
import Animation
import Config.Msg
import ControlPanel.Msg
import SecretConfig.Msg
import Time exposing (Time)
import VideoPlayer.Msg


type Msg
    = AudioPlayerMsg AudioPlayer.Msg
    | ConfigMsg Config.Msg.Msg
    | ControlPanelMsg ControlPanel.Msg.Msg
    | CrossFadePlayers Time
    | SecretConfigMsg SecretConfig.Msg.Msg
    | VideoPlayerMsg VideoPlayer.Msg.Msg
