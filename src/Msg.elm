module Msg exposing
    ( Msg(..)
    , audioPlayer
    , browserVendor
    , config
    , controlPanel
    , generateRandomGif
    , keyPressed
    , noOp
    , pause
    , play
    , secretConfig
    , videoPlayer
    )

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


audioPlayer : AudioPlayer.Msg -> Msg
audioPlayer audioPlayerMsg =
    AudioPlayer audioPlayerMsg


browserVendor : BrowserVendor.Msg -> Msg
browserVendor browserVendorMsg =
    BrowserVendor browserVendorMsg


controlPanel : ControlPanel.Msg -> Msg
controlPanel controlPanelMsg =
    ControlPanel controlPanelMsg


config : Config.Msg -> Msg
config configMsg =
    Config configMsg


generateRandomGif : String -> Msg
generateRandomGif tag =
    GenerateRandomGif tag


keyPressed : Key.Key -> Msg
keyPressed key =
    KeyPressed key


noOp : Msg
noOp =
    NoOp


pause : Msg
pause =
    Pause


play : Msg
play =
    Play


secretConfig : SecretConfig.Msg -> Msg
secretConfig secretConfigMsg =
    SecretConfig secretConfigMsg


videoPlayer : VideoPlayer.Msg -> Msg
videoPlayer videoPlayerMsg =
    VideoPlayer videoPlayerMsg
