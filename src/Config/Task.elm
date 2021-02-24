module Config.Task exposing (generateRandomTag, save)

import Config.Msg as Msg exposing (Msg)
import Task
import VideoPlayer exposing (VideoPlayerId)


generateRandomTag : (VideoPlayerId -> msg) -> VideoPlayerId -> Cmd msg
generateRandomTag generateRandomTagMsg videoPlayerId =
    generateRandomTagMsg videoPlayerId
        |> Task.succeed
        |> Task.perform identity


save : (Msg -> msg) -> String -> String -> String -> Cmd msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    Msg.save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString
        |> Task.succeed
        |> Task.perform identity
