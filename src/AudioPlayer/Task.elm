module AudioPlayer.Task exposing (reInitAudioPlayer, requestNextTrackNumber)

import AudioPlayer.Msg as Msg exposing (Msg)
import Task


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
