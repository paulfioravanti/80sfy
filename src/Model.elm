module Model exposing (Model, init)

import ControlPanel exposing (ControlPanel)
import Gif
import Msg exposing (Msg)
import VideoPlayer exposing (VideoPlayer, VideoPlayerId(Player1, Player2))


type alias Model =
    { controlPanel : ControlPanel
    , player1 : VideoPlayer
    , player2 : VideoPlayer
    }


init : ( Model, Cmd Msg )
init =
    let
        player1 =
            VideoPlayer.init Player1 True -1

        player2 =
            VideoPlayer.init Player2 False -2
    in
        ( { controlPanel = ControlPanel.init
          , player1 = player1
          , player2 = player2
          }
        , Cmd.batch [ Gif.random Player1, Gif.random Player2 ]
        )
