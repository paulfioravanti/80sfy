module AudioPlayer.Msg exposing
    ( Msg(..)
    , adjustVolume
    , audioPaused
    , audioPlaying
    , nextTrack
    , nextTrackNumberRequested
    , pauseAudio
    , playAudio
    , playlistGenerated
    , reInitAudioPlayer
    , setPlaylistLength
    , toggleMute
    )

import SoundCloud exposing (SoundCloudPlaylistUrl)


type Msg
    = AdjustVolume String
    | AudioPaused
    | AudioPlaying
    | NextTrack
    | NextTrackNumberRequested
    | PauseAudio
    | PlayAudio
    | PlaylistGenerated (List Int)
    | ReInitAudioPlayer SoundCloudPlaylistUrl
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


pauseAudio : (Msg -> msg) -> msg
pauseAudio audioPlayerMsg =
    audioPlayerMsg PauseAudio


playAudio : (Msg -> msg) -> msg
playAudio audioPlayerMsg =
    audioPlayerMsg PlayAudio


playlistGenerated : (Msg -> msg) -> List Int -> msg
playlistGenerated audioPlayerMsg playlist =
    audioPlayerMsg (PlaylistGenerated playlist)


reInitAudioPlayer : (Msg -> msg) -> SoundCloudPlaylistUrl -> msg
reInitAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    audioPlayerMsg (ReInitAudioPlayer soundCloudPlaylistUrl)


setPlaylistLength : (Msg -> msg) -> Int -> msg
setPlaylistLength audioPlayerMsg length =
    audioPlayerMsg (SetPlaylistLength length)


toggleMute : (Msg -> msg) -> msg
toggleMute audioPlayerMsg =
    audioPlayerMsg ToggleMute
