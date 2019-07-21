module AudioPlayer.Msg exposing
    ( Msg(..)
    , adjustVolume
    , audioPaused
    , audioPlaying
    , nextTrack
    , nextTrackNumberRequested
    , playlistGenerated
    , reInitAudioPlayer
    , setPlaylistLength
    )


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


adjustVolume : (Msg -> msg) -> String -> msg
adjustVolume audioPlayerMsg volume =
    audioPlayerMsg (AdjustVolume volume)


audioPaused : (Msg -> msg) -> msg
audioPaused audioPlayerMsg =
    audioPlayerMsg AudioPaused


audioPlaying : (Msg -> msg) -> msg
audioPlaying audioPlayerMsg =
    audioPlayerMsg AudioPlaying


nextTrack : (Msg -> msg) -> msg
nextTrack audioPlayerMsg =
    audioPlayerMsg NextTrack


nextTrackNumberRequested : (Msg -> msg) -> msg
nextTrackNumberRequested audioPlayerMsg =
    audioPlayerMsg NextTrackNumberRequested


playlistGenerated : List Int -> Msg
playlistGenerated playlist =
    PlaylistGenerated playlist


reInitAudioPlayer : (Msg -> msg) -> String -> msg
reInitAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    audioPlayerMsg (ReInitAudioPlayer soundCloudPlaylistUrl)


setPlaylistLength : (Msg -> msg) -> Int -> msg
setPlaylistLength audioPlayerMsg length =
    audioPlayerMsg (SetPlaylistLength length)
