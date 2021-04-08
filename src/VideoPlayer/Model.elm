module VideoPlayer.Model exposing
    ( VideoPlayer
    , VideoPlayerZIndex
    , crossFade
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
    { fallbackGifUrl = Gif.url "assets/tv-static.mp4"
    , gifUrl = RemoteData.NotAsked
    , id = videoPlayerId
    , status = Status.playing
    , style = Animation.visible
    , visible = True
    , zIndex = videoPlayerZIndex
    }


crossFade :
    VideoPlayer
    -> VideoPlayer
    -> ( VideoPlayer, VideoPlayer, VideoPlayerId )
crossFade videoPlayer1 videoPlayer2 =
    let
        ( newVideoPlayer1Visibility, nowHiddenVideoPlayerId, opacity ) =
            if videoPlayer1.visible then
                ( False, videoPlayer1.id, 0 )

            else
                ( True, videoPlayer2.id, 1 )

        animateToNewOpacity : AnimationState
        animateToNewOpacity =
            Animation.toOpacity opacity videoPlayer1.style
    in
    ( { videoPlayer1
        | style = animateToNewOpacity
        , visible = newVideoPlayer1Visibility
      }
    , videoPlayer2
    , nowHiddenVideoPlayerId
    )


rawZIndex : VideoPlayerZIndex -> Int
rawZIndex (VideoPlayerZIndex rawZIndexInt) =
    rawZIndexInt


zIndex : Int -> VideoPlayerZIndex
zIndex rawZIndexInt =
    VideoPlayerZIndex rawZIndexInt
