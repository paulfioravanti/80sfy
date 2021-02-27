module Config.Task exposing (performRandomTagGeneration, performSave)

import Config.Msg as Msg exposing (Msg)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Task
import VideoPlayer exposing (VideoPlayerId)


performRandomTagGeneration : (VideoPlayerId -> msg) -> VideoPlayerId -> Cmd msg
performRandomTagGeneration generateRandomTagMsg videoPlayerId =
    generateRandomTagMsg videoPlayerId
        |> Task.succeed
        |> Task.perform identity


performSave : (Msg -> msg) -> SoundCloudPlaylistUrl -> String -> String -> Cmd msg
performSave configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    Msg.save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString
        |> Task.succeed
        |> Task.perform identity
