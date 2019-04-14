module Msg exposing (Msg(..))

import AudioPlayer
import Config
import ControlPanel
import FullScreen
import Key
import SecretConfig
import VideoPlayer


type Msg
    = AudioPlayer AudioPlayer.Msg
    | Config Config.Msg
    | ControlPanel ControlPanel.Msg
    | FullScreen FullScreen.Msg
    | KeyPressed Key.Key
    | NoOp
    | Pause
    | Play
    | SaveConfig String String String
    | SecretConfig SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayer VideoPlayer.Msg
