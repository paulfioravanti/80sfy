module Tasks exposing
    ( performPause
    , performPlay
    , performRandomTagGeneration
    )

import Task


performPause : msg -> msg -> Cmd msg
performPause pauseAudioMsg pauseVideosMsg =
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


performPlay : msg -> Cmd msg
performPlay playMsg =
    playMsg
        |> Task.succeed
        |> Task.perform identity


performRandomTagGeneration : msg -> Cmd msg
performRandomTagGeneration generateRandomTagMsg =
    generateRandomTagMsg
        |> Task.succeed
        |> Task.perform identity
