module Msg exposing (Msg(..), Msgs, dictionary)

import AudioPlayer
import ControlPanel
import Gif exposing (GifDisplayIntervalSeconds)
import Key exposing (Key)
import Ports
import SecretConfig
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import Time exposing (Posix)
import VideoPlayer


type Msg
    = AudioPaused
    | AudioPlayer AudioPlayer.Msg
    | AudioPlaying
    | ControlPanel ControlPanel.Msg
    | CrossFadePlayers Posix
    | KeyPressed Key
    | NoOp
    | Pause
    | Ports Ports.Msg
    | Play
    | SaveConfig SoundCloudPlaylistUrl (List Tag) GifDisplayIntervalSeconds
    | SecretConfig SecretConfig.Msg
    | ShowApplicationState
    | VideoPlayer VideoPlayer.Msg


type alias Msgs =
    { audioPausedMsg : Msg
    , audioPlayerMsg : AudioPlayer.Msg -> Msg
    , audioPlayingMsg : Msg
    , controlPanelMsg : ControlPanel.Msg -> Msg
    , crossFadePlayersMsg : Posix -> Msg
    , keyPressedMsg : Key -> Msg
    , noOpMsg : Msg
    , pauseMsg : Msg
    , playMsg : Msg
    , portsMsg : Ports.Msg -> Msg
    , saveConfigMsg :
        SoundCloudPlaylistUrl
        -> List Tag
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
