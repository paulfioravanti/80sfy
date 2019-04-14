module Config.Msg exposing (Msg(..))

import Http exposing (Error)


type Msg
    = GenerateRandomGif String
    | InitTags (Result Error (List String))
    | RandomTag String String
    | Save String String String
