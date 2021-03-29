module Model exposing (Model, init)

import AudioPlayer exposing (AudioPlayer)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import Flags exposing (Flags)
import VideoPlayer exposing (VideoPlayer, VideoPlayerZIndex)


type alias Model =
    { audioPlayer : AudioPlayer
    , config : Config
    , controlPanel : ControlPanel
    , videoPlayer1 : VideoPlayer
    , videoPlayer2 : VideoPlayer
    }


init : Flags -> Model
init flags =
    let
        config : Config
        config =
            Config.init flags

        videoPlayer1zIndex : VideoPlayerZIndex
        videoPlayer1zIndex =
            VideoPlayer.zIndex -4

        videoPlayer2zIndex : VideoPlayerZIndex
        videoPlayer2zIndex =
            VideoPlayer.zIndex -5
    in
    { audioPlayer = AudioPlayer.init config.soundCloudPlaylistUrl
    , config = config
    , controlPanel = ControlPanel.init
    , videoPlayer1 = VideoPlayer.init (VideoPlayer.id "1") videoPlayer1zIndex
    , videoPlayer2 = VideoPlayer.init (VideoPlayer.id "2") videoPlayer2zIndex
    }
