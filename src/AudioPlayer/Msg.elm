module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | AudioPaused
    | AudioPlaying
    | NextTrack
    | NextTrackNumberRequested
    | PauseAudio
    | PlayAudio
    | PlaylistGenerated (List Int)
    | ReInitAudioPlayer String
    | SetPlaylistLength Int
    | ToggleMute
