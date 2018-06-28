module VideoPlayer.Model exposing (Status(..), VideoPlayer, init)

import Animation exposing (State)
import RemoteData exposing (RemoteData(NotRequested), WebData)


type Status
    = Playing
    | Paused
    | Halted


type alias VideoPlayer =
    { fallbackGifUrl : String
    , gifUrl : WebData String
    , id : String
    , status : Status
    , style : State
    , visible : Bool
    , zIndex : Int
    }


init : String -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    { fallbackGifUrl = "/assets/tv-static.mp4"
    , gifUrl = NotRequested
    , id = id
    , status = Paused
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visible
    , zIndex = zIndex
    }
