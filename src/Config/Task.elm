module Config.Task exposing (generateRandomGif, save)

import Config.Msg as Msg exposing (Msg)
import Task
import VideoPlayer exposing (VideoPlayerId)


generateRandomGif : (VideoPlayerId -> msg) -> VideoPlayerId -> Cmd msg
generateRandomGif generateRandomGifMsg videoPlayerId =
    generateRandomGifMsg videoPlayerId
        |> Task.succeed
        |> Task.perform identity


save : (Msg -> msg) -> String -> String -> String -> Cmd msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    Msg.save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString
        |> Task.succeed
        |> Task.perform identity
