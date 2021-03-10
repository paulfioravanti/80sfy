module Msg exposing
    ( Msg(..)
    , audioPaused
    , audioPlayer
    , audioPlaying
    , config
    , controlPanel
    , keyPressed
    , noOp
    , pause
    , play
    , portMsg
    , saveConfig
    , secretConfig
    , showApplicationState
    , videoPlayer
    )

import AudioPlayer
import Config
import ControlPanel
import Gif exposing (GifDisplayIntervalSeconds)
import Key exposing (Key)
import Port
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
    | Port Port.Msg
    | Play
    | SaveConfig SoundCloudPlaylistUrl TagsString GifDisplayIntervalSeconds
    | SecretConfig SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayer VideoPlayer.Msg


audioPaused : Msg
audioPaused =
    AudioPaused


audioPlayer : AudioPlayer.Msg -> Msg
audioPlayer audioPlayerMsg =
    AudioPlayer audioPlayerMsg


audioPlaying : Msg
audioPlaying =
    AudioPlaying


controlPanel : ControlPanel.Msg -> Msg
controlPanel controlPanelMsg =
    ControlPanel controlPanelMsg


config : Config.Msg -> Msg
config configMsg =
    Config configMsg


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


portMsg : Port.Msg -> Msg
portMsg msgForPort =
    Port msgForPort


saveConfig :
    SoundCloudPlaylistUrl
    -> TagsString
    -> GifDisplayIntervalSeconds
    -> Msg
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
