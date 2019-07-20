module VideoPlayer.Cmd exposing (playVideos)

import Task
import VideoPlayer.Msg as Msg exposing (Msg)


playVideos : (Msg -> msg) -> Cmd msg
playVideos videoPlayerMsg =
    videoPlayerMsg Msg.PlayVideos
        |> Task.succeed
        |> Task.perform identity
