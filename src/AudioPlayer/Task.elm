module AudioPlayer.Task exposing
    ( adjustVolume
    , nextTrack
    , playAudio
    , reInitAudioPlayer
    , requestNextTrackNumber
    )

import AudioPlayer.Msg as Msg exposing (Msg)
import Task


adjustVolume : (Msg -> msg) -> String -> Cmd msg
adjustVolume audioPlayerMsg volume =
    Msg.adjustVolume audioPlayerMsg volume
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


reInitAudioPlayer : (Msg -> msg) -> String -> Cmd msg
reInitAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    Msg.reInitAudioPlayer audioPlayerMsg soundCloudPlaylistUrl
        |> Task.succeed
        |> Task.perform identity


requestNextTrackNumber : (Msg -> msg) -> Cmd msg
requestNextTrackNumber audioPlayerMsg =
    Msg.nextTrackNumberRequested audioPlayerMsg
        |> Task.succeed
        |> Task.perform identity
