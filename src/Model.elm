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
init config =
    let
        secretConfig =
            SecretConfig.init config.soundCloudPlaylistUrl

        videoPlayer1 =
            VideoPlayer.init "1" True -1

        videoPlayer2 =
            VideoPlayer.init "2" False -2
    in
        { audioPlayer = AudioPlayer.init
        , config = config
        , controlPanel = ControlPanel.init
        , secretConfig = secretConfig
        , videoPlayer1 = videoPlayer1
        , videoPlayer2 = videoPlayer2
        }
