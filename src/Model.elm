module Model exposing (Model, init)

import AudioPlayer exposing (AudioPlayer)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import SecretConfig exposing (SecretConfig)
import VideoPlayer exposing (VideoPlayer)


type alias Model =
    { audioPlayer : AudioPlayer
    , config : Config
    , controlPanel : ControlPanel
    , secretConfig : SecretConfig
    , videoPlayer1 : VideoPlayer
    , videoPlayer2 : VideoPlayer
    }


init : Config -> Model
init ({ gifDisplayIntervalSeconds, soundCloudPlaylistUrl } as config) =
    let
        secretConfig =
            SecretConfig.init soundCloudPlaylistUrl gifDisplayIntervalSeconds

        videoPlayer1zIndex =
            VideoPlayer.zIndex -4

        videoPlayer2zIndex =
            VideoPlayer.zIndex -5
    in
    { audioPlayer = AudioPlayer.init soundCloudPlaylistUrl
    , config = config
    , controlPanel = ControlPanel.init
    , secretConfig = secretConfig
    , videoPlayer1 = VideoPlayer.init (VideoPlayer.id "1") videoPlayer1zIndex
    , videoPlayer2 = VideoPlayer.init (VideoPlayer.id "2") videoPlayer2zIndex
    }
