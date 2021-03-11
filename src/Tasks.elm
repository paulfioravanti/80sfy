module Tasks exposing
    ( performPause
    , performPlay
    )

import Port
import Task


performPause : (Port.Msg -> msg) -> Cmd msg
performPause portMsg =
    let
        pauseAudio =
            Task.succeed (Port.pauseAudioParentMsg portMsg)

        pauseVideo =
            Task.succeed (Port.pauseVideosMsg portMsg)
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
