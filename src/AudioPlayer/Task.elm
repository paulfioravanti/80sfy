module AudioPlayer.Task exposing
    ( performAudioPlayerReset
    , performNextTrackSelection
    , performVolumeAdjustment
    )

import AudioPlayer.Msg as Msg exposing (Msg)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Task


performAudioPlayerReset : (Msg -> msg) -> SoundCloudPlaylistUrl -> Cmd msg
performAudioPlayerReset audioPlayerMsg soundCloudPlaylistUrl =
    Msg.resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl
        |> Task.succeed
        |> Task.perform identity


performNextTrackSelection : (Msg -> msg) -> Cmd msg
performNextTrackSelection audioPlayerMsg =
    Msg.nextTrack audioPlayerMsg
        |> Task.succeed
        |> Task.perform identity


performVolumeAdjustment : (Msg -> msg) -> String -> Cmd msg
performVolumeAdjustment audioPlayerMsg sliderVolume =
    Msg.adjustVolume audioPlayerMsg sliderVolume
        |> Task.succeed
        |> Task.perform identity
