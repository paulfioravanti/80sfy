module SecretConfig.Task exposing (performInitTags)

import SecretConfig.Msg as Msg exposing (Msg)
import Task


performInitTags : (Msg -> msg) -> List String -> Cmd msg
performInitTags secretConfigMsg tags =
    Msg.initTags secretConfigMsg tags
        |> Task.succeed
        |> Task.perform identity
