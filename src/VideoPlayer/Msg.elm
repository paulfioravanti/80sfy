module VideoPlayer.Msg exposing (Msg(..))

import Animation
import Http exposing (Error)
import Time exposing (Time)


type Msg
    = AnimateVideoPlayer Animation.Msg
    | CrossFadePlayers Time
    | ExitFullScreen
    | FetchRandomGif String (Result Error String)
    | HaltVideos
    | PauseVideos
    | PerformFullScreenToggle
    | PlayVideos
    | RequestFullScreen
    | VideosHalted
    | VideosPaused
    | VideosPlaying
