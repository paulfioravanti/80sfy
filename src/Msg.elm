module Msg exposing (Msg(..))

import AudioPlayer
import Config
import ControlPanel
import SecretConfig
import VideoPlayer


type Msg
    = AudioPlayerMsg AudioPlayer.Msg
    | ConfigMsg Config.Msg
    | ControlPanelMsg ControlPanel.Msg
    | SecretConfigMsg SecretConfig.Msg
    | VideoPlayerMsg VideoPlayer.Msg
