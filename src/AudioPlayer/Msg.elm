module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | AudioPaused
    | AudioPlaying
    | NextTrack
    | PauseAudio
    | PlayAudio
    | ToggleMute
