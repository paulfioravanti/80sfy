module Model exposing (Model, init)

import Gif
import Msg exposing (Msg)
import Player exposing (Player, PlayerId(Player1, Player2))


type alias Model =
    { player1 : Player
    , player2 : Player
    }


init : ( Model, Cmd Msg )
init =
    ( { player1 = Player.init Player1 1 True
      , player2 = Player.init Player2 0 False
      }
    , Cmd.batch
        [ Gif.random Player1
        , Gif.random Player2
        ]
    )
