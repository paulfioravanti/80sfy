module Msg exposing (Msg(..), Msgs, dictionary)

import AudioPlayer
import Config
import ControlPanel
import Gif exposing (GifDisplayIntervalSeconds)
import Key exposing (Key)
import Ports
import SecretConfig
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (TagsString)
import Time exposing (Posix)
import VideoPlayer


type Msg
    = AudioPaused
    | AudioPlayer AudioPlayer.Msg
    | AudioPlaying
    | Config Config.Msg
    | ControlPanel ControlPanel.Msg
    | CrossFadePlayers Posix
    | KeyPressed Key
    | NoOp
    | Pause
    | Ports Ports.Msg
    | Play
    | SaveConfig SoundCloudPlaylistUrl TagsString GifDisplayIntervalSeconds
    | SecretConfig SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayer VideoPlayer.Msg


type alias Msgs =
    { audioPausedMsg : Msg
    , audioPlayerMsg : AudioPlayer.Msg -> Msg
    , audioPlayingMsg : Msg
    , configMsg : Config.Msg -> Msg
    , controlPanelMsg : ControlPanel.Msg -> Msg
    , crossFadePlayersMsg : Posix -> Msg
    , keyPressedMsg : Key -> Msg
    , noOpMsg : Msg
    , pauseMsg : Msg
    , playMsg : Msg
    , portsMsg : Ports.Msg -> Msg
    , saveConfigMsg :
        SoundCloudPlaylistUrl
        -> TagsString
        -> GifDisplayIntervalSeconds
        -> Msg
    , secretConfigMsg : SecretConfig.Msg -> Msg
    , showApplicationStateMsg : Msg
    , videoPlayerMsg : VideoPlayer.Msg -> Msg
    }


dictionary : Msgs
dictionary =
    { audioPausedMsg = AudioPaused
    , audioPlayerMsg = AudioPlayer
    , audioPlayingMsg = AudioPlaying
    , configMsg = Config
    , controlPanelMsg = ControlPanel
    , crossFadePlayersMsg = CrossFadePlayers
    , keyPressedMsg = KeyPressed
    , noOpMsg = NoOp
    , pauseMsg = Pause
    , playMsg = Play
    , portsMsg = Ports
    , saveConfigMsg = SaveConfig
    , secretConfigMsg = SecretConfig
    , showApplicationStateMsg = ShowApplicationState
    , videoPlayerMsg = VideoPlayer
    }
