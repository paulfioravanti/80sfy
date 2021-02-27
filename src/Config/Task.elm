module Config.Task exposing (performRandomTagGeneration, performSave)

import Config.Msg as Msg exposing (Msg)
import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (TagsString)
import Task
import VideoPlayer exposing (VideoPlayerId)


performRandomTagGeneration : (VideoPlayerId -> msg) -> VideoPlayerId -> Cmd msg
performRandomTagGeneration generateRandomTagMsg videoPlayerId =
    generateRandomTagMsg videoPlayerId
        |> Task.succeed
        |> Task.perform identity


performSave :
    (Msg -> msg)
    -> SoundCloudPlaylistUrl
    -> TagsString
    -> GifDisplayIntervalSeconds
    -> Cmd msg
performSave configMsg soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds =
    Msg.save configMsg soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds
        |> Task.succeed
        |> Task.perform identity
