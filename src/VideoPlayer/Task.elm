module VideoPlayer.Task exposing (performPauseVideos, performPlayVideos)

import Task
import VideoPlayer.Msg as Msg exposing (Msg)


performPauseVideos : (Msg -> msg) -> Cmd msg
performPauseVideos videoPlayerMsg =
    Msg.pauseVideos videoPlayerMsg
        |> Task.succeed
        |> Task.perform identity


performPlayVideos : (Msg -> msg) -> Cmd msg
performPlayVideos videoPlayerMsg =
    Msg.playVideos videoPlayerMsg
        |> Task.succeed
        |> Task.perform identity
