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
    , playlistLengthFetched
    , resetAudioPlayer
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
    | PlaylistLengthFetched Int
    | ResetAudioPlayer SoundCloudPlaylistUrl
    | ToggleMute


adjustVolume : (Msg -> msg) -> String -> msg
adjustVolume audioPlayerMsg sliderVolume =
    audioPlayerMsg (AdjustVolume sliderVolume)


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


playlistLengthFetched : (Msg -> msg) -> Int -> msg
playlistLengthFetched audioPlayerMsg length =
    audioPlayerMsg (PlaylistLengthFetched length)


resetAudioPlayer : (Msg -> msg) -> SoundCloudPlaylistUrl -> msg
resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    audioPlayerMsg (ResetAudioPlayer soundCloudPlaylistUrl)


toggleMute : (Msg -> msg) -> msg
toggleMute audioPlayerMsg =
    audioPlayerMsg ToggleMute
