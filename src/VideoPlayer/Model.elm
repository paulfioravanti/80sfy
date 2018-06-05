module VideoPlayer.Model exposing (VideoPlayer, init)

import Animation exposing (State)
import RemoteData exposing (RemoteData(NotRequested), WebData)


type alias VideoPlayer =
    { fallbackGifUrl : String
    , gifUrl : WebData String
    , id : String
    , playing : Bool
    , style : State
    , visible : Bool
    , zIndex : Int
    }


init : String -> Bool -> Int -> VideoPlayer
init id visible zIndex =
    { fallbackGifUrl = "https://media3.giphy.com/media/OVlFjmEDhx9rG/giphy.mp4"
    , gifUrl = NotRequested
    , id = id
    , playing = True
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = visible
    , zIndex = zIndex
    }
