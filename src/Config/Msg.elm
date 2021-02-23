module Config.Msg exposing (Msg(..), randomTagGenerated, save, tagsFetched)

import Http exposing (Error)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = TagsFetched (Result Error (List String))
    | RandomTagGenerated VideoPlayerId String
    | Save String String String


randomTagGenerated : (Msg -> msg) -> VideoPlayerId -> String -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


save : (Msg -> msg) -> String -> String -> String -> msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    configMsg (Save soundCloudPlaylistUrl tagsString gifDisplaySecondsString)


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)
