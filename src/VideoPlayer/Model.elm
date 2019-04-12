module VideoPlayer.Model exposing (VideoPlayer, init)

import Animation exposing (State)
import Error
import RemoteData exposing (WebData)
import VideoPlayer.Status as Status exposing (Status)


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
    , gifUrl = RemoteData.NotRequested
    , id = id
    , status = Status.Paused
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = True
    , zIndex = zIndex
    }
