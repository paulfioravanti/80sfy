module Config.Msg exposing (Msg(..), initTags, randomTagGenerated, save)

import Http exposing (Error)


type Msg
    = InitTags (Result Error (List String))
    | RandomTagGenerated String String
    | Save String String String


initTags : (Msg -> msg) -> Result Error (List String) -> msg
initTags configMsg tags =
    configMsg (InitTags tags)


randomTagGenerated : (Msg -> msg) -> String -> String -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


save : (Msg -> msg) -> String -> String -> String -> msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    configMsg (Save soundCloudPlaylistUrl tagsString gifDisplaySecondsString)
