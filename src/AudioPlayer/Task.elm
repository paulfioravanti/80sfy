module AudioPlayer.Task exposing
    ( performAudioPaused
    , performAudioPlayerReset
    , performAudioPlaying
    , performNextTrackNumberRequest
    , performNextTrackSelection
    , performVolumeAdjustment
    )

import AudioPlayer.Msg as Msg exposing (Msg)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Task


performAudioPaused : (Msg -> msg) -> Cmd msg
performAudioPaused audioPlayerMsg =
    Msg.audioPaused audioPlayerMsg
        |> Task.succeed
        |> Task.perform identity


performAudioPlayerReset : (Msg -> msg) -> SoundCloudPlaylistUrl -> Cmd msg
performAudioPlayerReset audioPlayerMsg soundCloudPlaylistUrl =
    Msg.resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl
        |> Task.succeed
        |> Task.perform identity


performAudioPlaying : (Msg -> msg) -> Cmd msg
performAudioPlaying audioPlayerMsg =
    Msg.audioPlaying audioPlayerMsg
        |> Task.succeed
        |> Task.perform identity


performNextTrackNumberRequest : (Msg -> msg) -> Cmd msg
performNextTrackNumberRequest audioPlayerMsg =
    Msg.nextTrackNumberRequested audioPlayerMsg
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
