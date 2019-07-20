module Config.Task exposing (generateRandomGif)

import Task


generateRandomGif : (String -> msg) -> String -> Cmd msg
generateRandomGif generateRandomGifMsg videoPlayerId =
    generateRandomGifMsg videoPlayerId
        |> Task.succeed
        |> Task.perform identity
