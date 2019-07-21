module AudioPlayer.Task exposing
    ( adjustVolume
    , nextTrack
    , reInitAudioPlayer
    , requestNextTrackNumber
    )

import AudioPlayer.Msg as Msg exposing (Msg)
import Task


adjustVolume : (Msg -> msg) -> String -> Cmd msg
adjustVolume audioPlayerMsg volume =
    audioPlayerMsg (Msg.AdjustVolume volume)
        |> Task.succeed
        |> Task.perform identity


nextTrack : (Msg -> msg) -> Cmd msg
nextTrack audioPlayerMsg =
    audioPlayerMsg Msg.NextTrack
        |> Task.succeed
        |> Task.perform identity


reInitAudioPlayer : (Msg -> msg) -> String -> Cmd msg
reInitAudioPlayer audioPlayerMsg soundCloudPlaylistUrl =
    audioPlayerMsg (Msg.ReInitAudioPlayer soundCloudPlaylistUrl)
        |> Task.succeed
        |> Task.perform identity


requestNextTrackNumber : (Msg -> msg) -> Cmd msg
requestNextTrackNumber audioPlayerMsg =
    audioPlayerMsg Msg.NextTrackNumberRequested
        |> Task.succeed
        |> Task.perform identity
