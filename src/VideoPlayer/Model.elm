module VideoPlayer.Model exposing
    ( VideoPlayer
    , VideoPlayerZIndex
    , init
    , rawZIndex
    , zIndex
    )

import Gif exposing (GifUrl)
import RemoteData exposing (WebData)
import VideoPlayer.Animation as Animation exposing (AnimationState)
import VideoPlayer.Status as Status exposing (Status)
import VideoPlayer.VideoPlayerId exposing (VideoPlayerId)


type VideoPlayerZIndex
    = VideoPlayerZIndex Int


type alias VideoPlayer =
    { fallbackGifUrl : GifUrl
    , gifUrl : WebData GifUrl
    , id : VideoPlayerId
    , status : Status
    , style : AnimationState
    , visible : Bool
    , zIndex : VideoPlayerZIndex
    }


init : VideoPlayerId -> VideoPlayerZIndex -> VideoPlayer
init videoPlayerId videoPlayerZIndex =
    { fallbackGifUrl = Gif.url "/assets/tv-static.mp4"
    , gifUrl = RemoteData.NotAsked
    , id = videoPlayerId
    , status = Status.paused
    , style = Animation.visible
    , visible = True
    , zIndex = videoPlayerZIndex
    }


rawZIndex : VideoPlayerZIndex -> Int
rawZIndex (VideoPlayerZIndex rawZIndexInt) =
    rawZIndexInt


zIndex : Int -> VideoPlayerZIndex
zIndex rawZIndexInt =
    VideoPlayerZIndex rawZIndexInt
