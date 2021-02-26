module AudioPlayer.Task exposing
    ( adjustVolume
    , nextTrack
    , playAudio
    , requestNextTrackNumber
    , resetAudioPlayer
    )

import AudioPlayer.Msg as Msg exposing (Msg)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Task


adjustVolume : (Msg -> msg) -> String -> Cmd msg
adjustVolume audioPlayerMsg sliderVolume =
    Msg.adjustVolume audioPlayerMsg sliderVolume
        |> Task.succeed
        |> Task.perform identity


nextTrack : (Msg -> msg) -> Cmd msg
nextTrack audioPlayerMsg =
    Msg.nextTrack audioPlayerMsg
        |> Task.succeed
        |> Task.perform identity


playAudio : (Msg -> msg) -> Cmd msg
playAudio audioPlayerMsg =
    Msg.playAudio audioPlayerMsg
        |> Task.succeed
        |> Task.perform identity


requestNextTrackNumber : (Msg -> msg) -> Cmd msg
requestNextTrackNumber audioPlayerMsg =
    Msg.nextTrackNumberRequested audioPlayerMsg
        |> Task.succeed
        |> Task.perform identity


resetAudioPlayer : (Msg -> msg) -> SoundCloudPlaylistUrl -> Cmd msg
resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    Msg.resetAudioPlayer audioPlayerMsg soundCloudPlaylistUrl
        |> Task.succeed
        |> Task.perform identity
