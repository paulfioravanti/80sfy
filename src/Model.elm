module Model exposing (Model, init)

import Gif
import Msg exposing (Msg)
import Player exposing (Player, Id(Player1, Player2))


type alias Model =
    { player1 : Player
    , player2 : Player
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { player1 = Player.init Player1
            , player2 = Player.init Player2
            }
    in
        ( model
        , Cmd.batch
            [ Gif.random Player1
            , Gif.random Player2
            ]
        )
