module VideoPlayer.Model exposing
    ( VideoPlayer
    , VideoPlayerId
    , VideoPlayerZIndex
    , id
    , init
    , rawId
    , rawZIndex
    , zIndex
    )

import Animation exposing (State)
import Gif exposing (GifUrl)
import RemoteData exposing (WebData)
import VideoPlayer.Status as Status exposing (Status)


type VideoPlayerId
    = VideoPlayerId String


type VideoPlayerZIndex
    = VideoPlayerZIndex Int


type alias VideoPlayer =
    { fallbackGifUrl : GifUrl
    , gifUrl : WebData GifUrl
    , id : VideoPlayerId
    , status : Status
    , style : State
    , visible : Bool
    , zIndex : VideoPlayerZIndex
    }


init : VideoPlayerId -> VideoPlayerZIndex -> VideoPlayer
init videoPlayerId videoPlayerZIndex =
    { fallbackGifUrl = Gif.url "/assets/tv-static.mp4"
    , gifUrl = RemoteData.NotAsked
    , id = videoPlayerId
    , status = Status.paused
    , style = Animation.style [ Animation.opacity 1 ]
    , visible = True
    , zIndex = videoPlayerZIndex
    }


id : String -> VideoPlayerId
id rawIdString =
    VideoPlayerId rawIdString


rawId : VideoPlayerId -> String
rawId (VideoPlayerId rawIdString) =
    rawIdString


rawZIndex : VideoPlayerZIndex -> Int
rawZIndex (VideoPlayerZIndex rawZIndexInt) =
    rawZIndexInt


zIndex : Int -> VideoPlayerZIndex
zIndex rawZIndexInt =
    VideoPlayerZIndex rawZIndexInt
