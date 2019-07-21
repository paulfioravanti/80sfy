module VideoPlayer.Task exposing (playVideos)

import Task
import VideoPlayer.Msg as Msg exposing (Msg)


playVideos : (Msg -> msg) -> Cmd msg
playVideos videoPlayerMsg =
    Msg.playVideos videoPlayerMsg
        |> Task.succeed
        |> Task.perform identity
