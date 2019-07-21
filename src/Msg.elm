module Msg exposing (Msg(..))

import AudioPlayer
import BrowserVendor
import Config
import ControlPanel
import Key
import SecretConfig
import VideoPlayer


type Msg
    = AudioPlayer AudioPlayer.Msg
    | BrowserVendor BrowserVendor.Msg
    | Config Config.Msg
    | ControlPanel ControlPanel.Msg
    | GenerateRandomGif String
    | KeyPressed Key.Key
    | NoOp
    | Pause
    | Play
    | SaveConfig String String String
    | SecretConfig SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayer VideoPlayer.Msg
