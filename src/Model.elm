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
    { audioPlayer = AudioPlayer.init config.soundCloudPlaylistUrl
    , config = config
    , controlPanel = ControlPanel.init
    , secretConfig =
        SecretConfig.init config.soundCloudPlaylistUrl config.gifDisplaySeconds
    , videoPlayer1 = VideoPlayer.init "1" True -4
    , videoPlayer2 = VideoPlayer.init "2" True -5
    }
