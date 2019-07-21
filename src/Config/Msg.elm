module Config.Msg exposing (Msg(..), save)

import Http exposing (Error)


type Msg
    = InitTags (Result Error (List String))
    | RandomTagGenerated String String
    | Save String String String


save : (Msg -> msg) -> String -> String -> String -> msg
save configMsg soundCloudPlaylistUrl tagsString gifDisplaySecondsString =
    configMsg (Save soundCloudPlaylistUrl tagsString gifDisplaySecondsString)
