module Msg exposing
    ( Msg(..)
    , audioPlayer
    , browserVendor
    , config
    , controlPanel
    , generateRandomTag
    , keyPressed
    , noOp
    , pause
    , play
    , saveConfig
    , secretConfig
    , showApplicationState
    , videoPlayer
    )

import AudioPlayer
import BrowserVendor
import Config
import ControlPanel
import Gif exposing (GifDisplayIntervalSeconds)
import Key exposing (Key)
import SecretConfig
import SoundCloud exposing (SoundCloudPlaylistUrl)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = AudioPlayer AudioPlayer.Msg
    | BrowserVendor BrowserVendor.Msg
    | Config Config.Msg
    | ControlPanel ControlPanel.Msg
    | GenerateRandomTag VideoPlayerId
    | KeyPressed Key
    | NoOp
    | Pause
    | Play
    | SaveConfig SoundCloudPlaylistUrl String GifDisplayIntervalSeconds
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


generateRandomTag : VideoPlayerId -> Msg
generateRandomTag videoPlayerId =
    GenerateRandomTag videoPlayerId


keyPressed : Key -> Msg
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


saveConfig : SoundCloudPlaylistUrl -> String -> GifDisplayIntervalSeconds -> Msg
saveConfig soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds =
    SaveConfig soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds


secretConfig : SecretConfig.Msg -> Msg
secretConfig secretConfigMsg =
    SecretConfig secretConfigMsg


showApplicationState : Msg
showApplicationState =
    ShowApplicationState


videoPlayer : VideoPlayer.Msg -> Msg
videoPlayer videoPlayerMsg =
    VideoPlayer videoPlayerMsg
