module Msg exposing (Msg(..))

import AudioPlayer
import Config
import ControlPanel
import Keyboard exposing (KeyCode)
import SecretConfig
import VideoPlayer


type Msg
    = AudioPlayerMsg AudioPlayer.Msg
    | ConfigMsg Config.Msg
    | ControlPanelMsg ControlPanel.Msg
    | KeyMsg KeyCode
    | Pause ()
    | Play ()
    | SecretConfigMsg SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayerMsg VideoPlayer.Msg
