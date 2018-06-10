module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | NextTrack
    | ToggleMute
    | TogglePlayPause
