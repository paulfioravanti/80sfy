module Model exposing (Model, init)

import Config exposing (Config)
import ControlPanel exposing (ControlPanel)
import VideoPlayer exposing (VideoPlayer)


type alias Model =
    { config : Config
    , controlPanel : ControlPanel
    , player1 : VideoPlayer
    , player2 : VideoPlayer
    }


init : Config -> Model
init config =
    let
        player1 =
            VideoPlayer.init "1" True -1

        player2 =
            VideoPlayer.init "2" False -2
    in
        { config = config
        , controlPanel = ControlPanel.init
        , player1 = player1
        , player2 = player2
        }
