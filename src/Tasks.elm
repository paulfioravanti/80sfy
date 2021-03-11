module Tasks exposing
    ( performPause
    , performPlay
    )

import Ports
import Task


performPause : (Ports.Msg -> msg) -> Cmd msg
performPause portsMsg =
    let
        pauseAudio =
            Task.succeed (Ports.pauseAudioMsg portsMsg)

        pauseVideo =
            Task.succeed (Ports.pauseVideosMsg portsMsg)
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
