module Config.Msg exposing (Msg(..))

import Http exposing (Error)


type Msg
    = FetchTags (Result Error (List String))
    | GenerateRandomGif String
    | SaveConfig String String
    | RandomTag String String
