module VideoPlayer.Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Time exposing (Time)


type Msg
    = AnimateVideoPlayer Animation.Msg
    | CrossFadePlayers Time
    | FetchRandomGif String (Result Error String)
    | HaltVideos
    | PauseVideos
    | PerformFullScreenToggle
    | PlayVideos
    | VideosHalted
    | VideosPaused
    | VideosPlaying
