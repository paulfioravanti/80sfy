module VideoPlayer.Msg exposing (Msg(..))

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
