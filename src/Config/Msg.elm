module Config.Msg exposing (Msg(..), randomTagGenerated, tagsFetched)

import Http exposing (Error)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type Msg
    = TagsFetched (Result Error (List String))
    | RandomTagGenerated VideoPlayerId Tag


randomTagGenerated : (Msg -> msg) -> VideoPlayerId -> Tag -> msg
randomTagGenerated configMsg videoPlayerId tag =
    configMsg (RandomTagGenerated videoPlayerId tag)


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)
