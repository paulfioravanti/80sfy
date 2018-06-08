module Msg exposing (Msg(..))

import AudioPlayer
import Config.Msg
import ControlPanel.Msg
import SecretConfig.Msg
import VideoPlayer.Msg


type Msg
    = AudioPlayerMsg AudioPlayer.Msg
    | ConfigMsg Config.Msg.Msg
    | ControlPanelMsg ControlPanel.Msg.Msg
    | SecretConfigMsg SecretConfig.Msg.Msg
    | VideoPlayerMsg VideoPlayer.Msg.Msg
