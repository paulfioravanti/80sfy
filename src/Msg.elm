module Msg exposing
    ( Msg(..)
    , config
    , controlPanel
    , keyPressed
    )

import AudioPlayer
import Config
import ControlPanel
import Gif exposing (GifDisplayIntervalSeconds)
import Key exposing (Key)
import Ports
import SecretConfig
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (TagsString)
import VideoPlayer


type Msg
    = AudioPaused
    | AudioPlayer AudioPlayer.Msg
    | AudioPlaying
    | Config Config.Msg
    | ControlPanel ControlPanel.Msg
    | KeyPressed Key
    | NoOp
    | Pause
    | Ports Ports.Msg
    | Play
    | SaveConfig SoundCloudPlaylistUrl TagsString GifDisplayIntervalSeconds
    | SecretConfig SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayer VideoPlayer.Msg


controlPanel : ControlPanel.Msg -> Msg
controlPanel controlPanelMsg =
    ControlPanel controlPanelMsg


config : Config.Msg -> Msg
config configMsg =
    Config configMsg


keyPressed : Key -> Msg
keyPressed key =
    KeyPressed key
