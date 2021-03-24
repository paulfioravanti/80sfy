module VideoPlayer.Msg exposing
    ( Msg(..)
    , animateVideoPlayer
    , randomGifUrlFetched
    , videosHalted
    , videosPaused
    , videosPlaying
    )

import Animation
import Http exposing (Error)
import VideoPlayer.VideoPlayerId exposing (VideoPlayerId)


type Msg
    = AnimateVideoPlayer Animation.Msg
    | RandomGifUrlFetched VideoPlayerId (Result Error String)
    | VideosHalted
    | VideosPaused
    | VideosPlaying


animateVideoPlayer : (Msg -> msg) -> Animation.Msg -> msg
animateVideoPlayer videoPlayerMsg animationMsg =
    videoPlayerMsg (AnimateVideoPlayer animationMsg)


randomGifUrlFetched :
    (Msg -> msg)
    -> VideoPlayerId
    -> Result Error String
    -> msg
randomGifUrlFetched videoPlayerMsg videoPlayerId gifUrl =
    videoPlayerMsg (RandomGifUrlFetched videoPlayerId gifUrl)


videosHalted : (Msg -> msg) -> msg
videosHalted videoPlayerMsg =
    videoPlayerMsg VideosHalted


videosPaused : (Msg -> msg) -> msg
videosPaused videoPlayerMsg =
    videoPlayerMsg VideosPaused


videosPlaying : (Msg -> msg) -> msg
videosPlaying videoPlayerMsg =
    videoPlayerMsg VideosPlaying
