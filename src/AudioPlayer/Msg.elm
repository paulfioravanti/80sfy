module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | AudioPaused
    | AudioPlayerReady
    | AudioPlaying
    | GeneratePlaylistTrackOrder (List Int)
    | NextTrack
    | PauseAudio
    | PlayAudio
    | ToggleMute
