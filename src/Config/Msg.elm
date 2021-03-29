module Config.Msg exposing (Msg(..), tagsFetched)

import Http exposing (Error)


type Msg
    = TagsFetched (Result Error (List String))


tagsFetched : (Msg -> msg) -> Result Error (List String) -> msg
tagsFetched configMsg tags =
    configMsg (TagsFetched tags)
