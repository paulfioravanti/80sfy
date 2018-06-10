module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | NextTrack
    | PauseAudio
    | PlayAudio
    | ToggleMute
