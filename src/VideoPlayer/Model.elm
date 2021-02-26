module VideoPlayer.Model exposing
    ( VideoPlayer
    , VideoPlayerId
    , id
    , init
    , rawId
    )

import Animation exposing (State)
import RemoteData exposing (WebData)
import VideoPlayer.Status as Status exposing (Status)


type VideoPlayerId
    = VideoPlayerId String


type alias VideoPlayer =
    { fallbackGifUrl : String
    , gifUrl : WebData String
    , id : VideoPlayerId
    , status : Status
    , style : State
    , visible : Bool
    , zIndex : Int
    }


init : VideoPlayerId -> Int -> VideoPlayer
init videoPlayerId zIndex =
    { fallbackGifUrl = "/assets/tv-static.mp4"
    , gifUrl = RemoteData.NotAsked
    , id = videoPlayerId
    , status = Status.paused
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = True
    , zIndex = zIndex
    }


id : String -> VideoPlayerId
id rawIdString =
    VideoPlayerId rawIdString


rawId : VideoPlayerId -> String
rawId (VideoPlayerId rawIdString) =
    rawIdString
