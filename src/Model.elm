module Model exposing (Model, init)

import AudioPlayer exposing (AudioPlayer)
import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import VideoPlayer exposing (VideoPlayer)


type alias Model =
    { audioPlayer : AudioPlayer
    , config : Config
    , controlPanel : ControlPanel
    , videoPlayer1 : VideoPlayer
    , videoPlayer2 : VideoPlayer
    }


init : Config -> Model
init config =
    let
        videoPlayer1 =
            VideoPlayer.init "1" True -1

        videoPlayer2 =
            VideoPlayer.init "2" False -2
    in
        { audioPlayer = AudioPlayer.init
        , config = config
        , controlPanel = ControlPanel.init
        , videoPlayer1 = videoPlayer1
        , videoPlayer2 = videoPlayer2
        }
