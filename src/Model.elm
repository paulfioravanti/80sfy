module Model exposing (Model, init)

import ControlPanel exposing (ControlPanel)
import Gif
import Msg exposing (Msg)
import Player exposing (Player, PlayerId(Player1, Player2))


type alias Model =
    { controlPanel : ControlPanel
    , controlPanelMouseOver : Bool
    , controlPanelSecondsOpen : Int
    , player1 : Player
    , player2 : Player
    }


init : ( Model, Cmd Msg )
init =
    let
        player1 =
            Player.init Player1 True -1

        player2 =
            Player.init Player2 False -2
    in
        ( { controlPanel = ControlPanel.init
          , controlPanelMouseOver = False
          , controlPanelSecondsOpen = 0
          , player1 = player1
          , player2 = player2
          }
        , Cmd.batch [ Gif.random player1, Gif.random player2 ]
        )
