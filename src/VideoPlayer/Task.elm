module VideoPlayer.Task exposing (performPlayVideos)

import Task
import VideoPlayer.Msg as Msg exposing (Msg)


performPlayVideos : (Msg -> msg) -> Cmd msg
performPlayVideos videoPlayerMsg =
    Msg.playVideos videoPlayerMsg
        |> Task.succeed
        |> Task.perform identity
