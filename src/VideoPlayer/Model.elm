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


init : String -> Int -> VideoPlayer
init id zIndex =
    { fallbackGifUrl = "/assets/tv-static.mp4"
    , gifUrl = NotRequested
    , id = id
    , status = Paused
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = True
    , zIndex = zIndex
    }
