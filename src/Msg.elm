module Msg exposing (Msg(..))

import AudioPlayer
import Config
import ControlPanel
import Keyboard exposing (KeyCode)
import SecretConfig
import VideoPlayer


type Msg
    = AudioPlayer AudioPlayer.Msg
    | Config Config.Msg
    | ControlPanel ControlPanel.Msg
    | Key KeyCode
    | NoOp
    | Pause
    | Play
    | SecretConfig SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayer VideoPlayer.Msg
