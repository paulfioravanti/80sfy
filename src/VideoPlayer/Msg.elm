module VideoPlayer.Msg exposing (Msg(..))

import Animation


type Msg
    = AnimateVideoPlayer Animation.Msg
    | ToggleFullScreen
    | TogglePlaying Bool
