module AudioPlayer.Msg exposing (Msg(..))


type Msg
    = AdjustVolume String
    | AudioPaused
    | AudioPlaying
    | GeneratePlaylistTrackOrder (List Int)
    | NextTrack
    | NextTrackNumberRequested ()
    | PauseAudio
    | PlayAudio
    | ReInitAudioPlayer String
    | SetPlaylistLength Int
    | ToggleMute
