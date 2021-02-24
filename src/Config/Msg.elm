module Config.Msg exposing (Msg(..), randomTagGenerated, save, tagsFetched)

import Http exposing (Error)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = TagsFetched (Result Error (List String))
    | RandomTagGenerated VideoPlayerId Tag
    | Save String String String


randomTagGenerated : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


save : (Msg -> msg) -> String -> String -> String -> msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    configMsg (Save soundCloudPlaylistUrl tagsString gifDisplaySecondsString)


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)
