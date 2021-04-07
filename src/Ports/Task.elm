module Ports.Task exposing (performPause)

import Ports.Msg as Msg exposing (Msg)
import Task exposing (Task)


performPause : (Msg -> msg) -> Cmd msg
performPause portsMsg =
    let
        pauseAudio : Task x msg
        pauseAudio =
            Task.succeed (portsMsg Msg.PauseAudio)

        pauseVideos : Task x msg
        pauseVideos =
            Task.succeed (portsMsg Msg.PauseVideos)
    in
    -- NOTE: These tasks need to be specifically ordered so that
    -- the player paused overlay is not displayed when the
    -- pause button is pressed on the app player.
    pauseVideos
        |> Task.andThen (\_ -> pauseAudio)
        |> Task.perform identity
