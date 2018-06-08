module VideoPlayer.Msg exposing (Msg(..))

import Animation
import Http exposing (Error)


type Msg
    = AnimateVideoPlayer Animation.Msg
    | FetchRandomGif String (Result Error String)
    | ToggleFullScreen
    | TogglePlaying Bool
