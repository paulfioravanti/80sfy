module AudioPlayer.Task exposing (requestNextTrackNumber)

import AudioPlayer.Msg as Msg exposing (Msg)
import Task


requestNextTrackNumber : (Msg -> msg) -> Cmd msg
requestNextTrackNumber audioPlayerMsg =
    audioPlayerMsg Msg.NextTrackNumberRequested
        |> Task.succeed
        |> Task.perform identity
