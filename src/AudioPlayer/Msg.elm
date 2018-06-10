module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | NextTrack
    | PauseAudio Bool
    | PlayAudio Bool
    | ToggleMute
