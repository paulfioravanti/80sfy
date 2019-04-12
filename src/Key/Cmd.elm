module Key.Cmd exposing (pressed)

import AudioPlayer
import FullScreen
import Key.Model as Key exposing (Key)
import Model exposing (Model)
import Task


pressed :
    (AudioPlayer.Msg -> msg)
    -> (FullScreen.Msg -> msg)
    -> msg
    -> msg
    -> Model
    -> Key
    -> Cmd msg
pressed audioPlayerMsg fullScreenMsg pauseMsg playMsg { audioPlayer, config } key =
    case key of
        Key.Escape ->
            fullScreenMsg FullScreen.leaveFullScreenMsg
                |> Task.succeed
                |> Task.perform identity

        Key.Space ->
            let
                msg =
                    if AudioPlayer.isPlaying audioPlayer then
                        pauseMsg

                    else
                        playMsg
            in
            Task.succeed msg
                |> Task.perform identity

        Key.UpArrow ->
            let
                newVolume =
                    audioPlayer.volume
                        + config.volumeAdjustmentRate
                        |> String.fromInt
            in
            audioPlayerMsg (AudioPlayer.adjustVolumeMsg newVolume)
                |> Task.succeed
                |> Task.perform identity

        Key.RightArrow ->
            audioPlayerMsg AudioPlayer.nextTrackMsg
                |> Task.succeed
                |> Task.perform identity

        Key.DownArrow ->
            let
                newVolume =
                    audioPlayer.volume
                        - config.volumeAdjustmentRate
                        |> String.fromInt
            in
            audioPlayerMsg (AudioPlayer.adjustVolumeMsg newVolume)
                |> Task.succeed
                |> Task.perform identity

        _ ->
            Cmd.none
