module ParentMsgs exposing (ParentMsgs, init)

import AudioPlayer
import Config
import ControlPanel
import Gif
import Msg exposing (Msg)
import Ports
import SecretConfig
import SoundCloud
import Tag
import VideoPlayer


type alias ParentMsgs =
    { audioPausedMsg : Msg
    , audioPlayerMsg : AudioPlayer.Msg -> Msg
    , audioPlayingMsg : Msg
    , configMsg : Config.Msg -> Msg
    , controlPanelMsg : ControlPanel.Msg -> Msg
    , noOpMsg : Msg
    , pauseMsg : Msg
    , playMsg : Msg
    , portsMsg : Ports.Msg -> Msg
    , saveConfigMsg :
        SoundCloud.SoundCloudPlaylistUrl
        -> Tag.TagsString
        -> Gif.GifDisplayIntervalSeconds
        -> Msg
    , secretConfigMsg : SecretConfig.Msg -> Msg
    , showApplicationStateMsg : Msg
    , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


init : ParentMsgs
init =
    { audioPausedMsg = Msg.AudioPaused
    , audioPlayerMsg = Msg.AudioPlayer
    , audioPlayingMsg = Msg.AudioPlaying
    , configMsg = Msg.Config
    , controlPanelMsg = Msg.ControlPanel
    , noOpMsg = Msg.NoOp
    , pauseMsg = Msg.Pause
    , playMsg = Msg.Play
    , portsMsg = Msg.Ports
    , saveConfigMsg = Msg.SaveConfig
    , secretConfigMsg = Msg.SecretConfig
    , showApplicationStateMsg = Msg.ShowApplicationState
    , videoPlayerMsg = Msg.VideoPlayer
    }
