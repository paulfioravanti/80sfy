module VideoPlayer.Model
    exposing
        ( VideoPlayer
        , VideoPlayerId
        , init
        , setGifUrl
        , setStyle
        , setVisible
        )

import Animation exposing (State)
import RemoteData exposing (RemoteData(NotRequested), WebData)


type alias VideoPlayerId =
    String


type alias VideoPlayer =
    { gifUrl : WebData String
    , id : VideoPlayerId
    , style : State
    , visible : Bool
    , zIndex : Int
    }


init : VideoPlayerId -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    { gifUrl = NotRequested
    , id = id
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visible
    , zIndex = zIndex
    }
