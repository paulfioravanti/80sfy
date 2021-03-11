module Config.Task exposing (performSave)

import Config.Msg as Msg exposing (Msg)
import Gif exposing (GifDisplayIntervalSeconds)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (TagsString)
import Task


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
