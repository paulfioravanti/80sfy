module SecretConfig.Task exposing (initTags)

import SecretConfig.Msg as Msg exposing (Msg)
import Task


initTags : (Msg -> msg) -> List String -> Cmd msg
initTags secretConfigMsg tags =
    Msg.initTags secretConfigMsg tags
        |> Task.succeed
        |> Task.perform identity
