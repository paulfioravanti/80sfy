module VideoPlayer.Msg exposing
    ( Msg(..)
    , animateVideoPlayer
    , crossFadePlayers
    , pauseVideos
    , playVideos
    , randomGifUrlFetched
    , videosHalted
    , videosPaused
    , videosPlaying
    )

import Animation
import Http exposing (Error)
import Time exposing (Posix)
import VideoPlayer.Model exposing (VideoPlayerId)


type Msg
    = AnimateVideoPlayer Animation.Msg
    | CrossFadePlayers Posix
    | RandomGifUrlFetched VideoPlayerId (Result Error String)
    | PauseVideos
    | PlayVideos
    | VideosHalted
    | VideosPaused
    | VideosPlaying


animateVideoPlayer : (Msg -> msg) -> Animation.Msg -> msg
animateVideoPlayer videoPlayerMsg animationMsg =
    videoPlayerMsg (AnimateVideoPlayer animationMsg)


crossFadePlayers : (Msg -> msg) -> Posix -> msg
crossFadePlayers videoPlayerMsg time =
    videoPlayerMsg (CrossFadePlayers time)


randomGifUrlFetched :
    (Msg -> msg)
    -> VideoPlayerId
    -> Result Error String
    -> msg
randomGifUrlFetched videoPlayerMsg videoPlayerId gifUrl =
    videoPlayerMsg (RandomGifUrlFetched videoPlayerId gifUrl)


pauseVideos : (Msg -> msg) -> msg
pauseVideos videoPlayerMsg =
    videoPlayerMsg PauseVideos


playVideos : (Msg -> msg) -> msg
playVideos videoPlayerMsg =
    videoPlayerMsg PlayVideos


videosHalted : (Msg -> msg) -> msg
videosHalted videoPlayerMsg =
    videoPlayerMsg VideosHalted


videosPaused : (Msg -> msg) -> msg
videosPaused videoPlayerMsg =
    videoPlayerMsg VideosPaused


videosPlaying : (Msg -> msg) -> msg
videosPlaying videoPlayerMsg =
    videoPlayerMsg VideosPlaying
