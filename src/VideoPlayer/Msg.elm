module VideoPlayer.Msg exposing
    ( Msg(..)
    , animateVideoPlayer
    , crossFadePlayers
    , haltVideos
    , playVideos
    , videosHalted
    , videosPaused
    , videosPlaying
    )

import Animation
import Http exposing (Error)
import Time exposing (Posix)


type Msg
    = AnimateVideoPlayer Animation.Msg
    | CrossFadePlayers Posix
    | FetchRandomGif String (Result Error String)
    | HaltVideos
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


haltVideos : (Msg -> msg) -> msg
haltVideos videoPlayerMsg =
    videoPlayerMsg HaltVideos


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
