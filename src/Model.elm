module Model exposing (Model, init)

import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import VideoPlayer exposing (VideoPlayer)


type alias Model =
    { config : Config
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
        { config = config
        , controlPanel = ControlPanel.init
        , videoPlayer1 = videoPlayer1
        , videoPlayer2 = videoPlayer2
        }
