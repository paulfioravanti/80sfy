module Config.Msg exposing (Msg(..), randomTagGenerated, save, tagsFetched)

import Http exposing (Error)


type Msg
    = TagsFetched (Result Error (List String))
    | RandomTagGenerated String String
    | Save String String String


randomTagGenerated : (Msg -> msg) -> String -> String -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


save : (Msg -> msg) -> String -> String -> String -> msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    configMsg (Save soundCloudPlaylistUrl tagsString gifDisplaySecondsString)


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)
