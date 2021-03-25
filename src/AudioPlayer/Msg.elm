module AudioPlayer.Msg exposing
    ( Msg(..)
    , adjustVolume
    , playlistGenerated
    , playlistLengthFetched
    , resetAudioPlayer
    )

import SoundCloud exposing (SoundCloudPlaylistUrl)


type Msg
    = AdjustVolume String
    | AudioPaused
    | AudioPlaying
    | NextTrack
    | NextTrackNumberRequested
    | PlaylistGenerated (List Int)
    | PlaylistLengthFetched Int
    | ResetAudioPlayer SoundCloudPlaylistUrl
    | ToggleMute


adjustVolume : (Msg -> msg) -> String -> msg
adjustVolume audioPlayerMsg sliderVolume =
    audioPlayerMsg (AdjustVolume sliderVolume)


playlistGenerated : (Msg -> msg) -> List Int -> msg
playlistGenerated audioPlayerMsg playlist =
    audioPlayerMsg (PlaylistGenerated playlist)


playlistLengthFetched : (Msg -> msg) -> Int -> msg
playlistLengthFetched audioPlayerMsg length =
    audioPlayerMsg (PlaylistLengthFetched length)


resetAudioPlayer : (Msg -> msg) -> SoundCloudPlaylistUrl -> msg
resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    audioPlayerMsg (ResetAudioPlayer soundCloudPlaylistUrl)
