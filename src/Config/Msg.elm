module Config.Msg exposing (Msg(..))

import Http exposing (Error)


type Msg
    = GenerateRandomGif String
    | InitTags (Result Error (List String))
    | RandomTagGenerated String String
    | Save String String String
