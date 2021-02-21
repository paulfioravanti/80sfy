module Task_ exposing (generateRandomGif, pause, pauseMedia, play)

import Task


generateRandomGif : msg -> Cmd msg
generateRandomGif generateRandomGifMsg =
    generateRandomGifMsg
        |> Task.succeed
        |> Task.perform identity


pause : msg -> Cmd msg
pause pauseMsg =
    pauseMsg
        |> Task.succeed
        |> Task.perform identity


pauseMedia : msg -> msg -> Cmd msg
pauseMedia pauseAudioMsg pauseVideosMsg =
    let
        pauseAudio =
            Task.succeed pauseAudioMsg

        pauseVideo =
            Task.succeed pauseVideosMsg
    in
    -- NOTE: These tasks need to be specifically ordered so that
    -- the player paused overlay is not displayed when the
    -- pause button is pressed on the app player.
    pauseVideo
        |> Task.andThen (\_ -> pauseAudio)
        |> Task.perform identity


play : msg -> Cmd msg
play playMsg =
    playMsg
        |> Task.succeed
        |> Task.perform identity
