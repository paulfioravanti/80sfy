module Task_ exposing (pause, play)

import Task


pause : msg -> Cmd msg
pause pauseMsg =
    pauseMsg
        |> Task.succeed
        |> Task.perform identity


play : msg -> Cmd msg
play playMsg =
    playMsg
        |> Task.succeed
        |> Task.perform identity
