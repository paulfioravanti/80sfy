module Config.Msg exposing (Msg(..))

import Http exposing (Error)


type Msg
    = FetchTags (Result Error (List String))
    | GenerateRandomGif String
    | RandomTag String String
    | SaveConfig String String
