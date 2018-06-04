module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | ToggleMute
    | TogglePlayPause
