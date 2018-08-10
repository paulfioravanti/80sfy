module Model exposing (Model, init)

import AudioPlayer exposing (AudioPlayer)
import Browser exposing (Vendor)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import SecretConfig exposing (SecretConfig)
import VideoPlayer exposing (VideoPlayer)


type alias Model =
    { audioPlayer : AudioPlayer
    , browser : Vendor
    , config : Config
    , controlPanel : ControlPanel
    , secretConfig : SecretConfig
    , videoPlayer1 : VideoPlayer
    , videoPlayer2 : VideoPlayer
    }


init : Config -> Vendor -> Model
init config vendor =
    { audioPlayer = AudioPlayer.init config.soundCloudPlaylistUrl
    , browser = vendor
    , config = config
    , controlPanel = ControlPanel.init
    , secretConfig =
        SecretConfig.init config.soundCloudPlaylistUrl config.gifDisplaySeconds
    , videoPlayer1 = VideoPlayer.init "1" -4
    , videoPlayer2 = VideoPlayer.init "2" -5
    }
