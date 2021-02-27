module Tasks exposing
    ( performPause
    , performPauseMedia
    , performPlay
    , performRandomGifGeneration
    )

import Task


performPause : msg -> Cmd msg
performPause pauseMsg =
    pauseMsg
        |> Task.succeed
        |> Task.perform identity


performPauseMedia : msg -> msg -> Cmd msg
performPauseMedia pauseAudioMsg pauseVideosMsg =
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


performRandomGifGeneration : msg -> Cmd msg
performRandomGifGeneration generateRandomGifMsg =
    generateRandomGifMsg
        |> Task.succeed
        |> Task.perform identity
