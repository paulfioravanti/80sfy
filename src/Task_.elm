module Task_ exposing (pause, pauseMedia, play)

import AudioPlayer
import Task
import VideoPlayer


pause : msg -> Cmd msg
pause pauseMsg =
    pauseMsg
        |> Task.succeed
        |> Task.perform identity


pauseMedia : (AudioPlayer.Msg -> msg) -> (VideoPlayer.Msg -> msg) -> Cmd msg
pauseMedia audioPlayerMsg videoPlayerMsg =
    let
        pauseAudio =
            AudioPlayer.pauseAudioMsg audioPlayerMsg
                |> Task.succeed

        pauseVideo =
            VideoPlayer.pauseVideosMsg videoPlayerMsg
                |> Task.succeed
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
