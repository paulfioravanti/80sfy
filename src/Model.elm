module Model exposing (Model, init)

import Animation
import Gif
import Msg exposing (Msg)
import RemoteData exposing (RemoteData(..), WebData)


type alias Model =
    { player1GifUrl : WebData String
    , player1Style : Animation.State
    , player2GifUrl : WebData String
    , player2Style : Animation.State
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { player1GifUrl = NotRequested
            , player1Style = Animation.style [ Animation.opacity 1 ]
            , player2Style = Animation.style [ Animation.opacity 0 ]
            , player2GifUrl = NotRequested
            }
    in
        ( { model | player1GifUrl = Requesting }
        , Gif.random
        )
