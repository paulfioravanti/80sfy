module Model exposing (Model, init)

import AudioPlayer exposing (AudioPlayer)
import Browser exposing (Browser)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import SecretConfig exposing (SecretConfig)
import VideoPlayer exposing (VideoPlayer)


type alias Model =
    { audioPlayer : AudioPlayer
    , browser : Browser
    , config : Config
    , controlPanel : ControlPanel
    , secretConfig : SecretConfig
    , videoPlayer1 : VideoPlayer
    , videoPlayer2 : VideoPlayer
    }


init : Config -> Browser -> Model
init config browser =
    { audioPlayer = AudioPlayer.init config.soundCloudPlaylistUrl
    , browser = browser
    , config = config
    , controlPanel = ControlPanel.init
    , secretConfig =
        SecretConfig.init config.soundCloudPlaylistUrl config.gifDisplaySeconds
    , videoPlayer1 = VideoPlayer.init "1" -4
    , videoPlayer2 = VideoPlayer.init "2" -5
    }
