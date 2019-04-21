module Key.Cmd exposing (Msgs, pressed)

import AudioPlayer
import FullScreen
import Key.Model as Key exposing (Key)
import Model exposing (Model)
import Task


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , fullScreenMsg : FullScreen.Msg -> msg
        , pauseMsg : msg
        , playMsg : msg
    }


pressed : Msgs msgs msg -> Model -> Key -> Cmd msg
pressed ({ audioPlayerMsg } as msgs) { audioPlayer, config } key =
    case key of
        Key.Escape ->
            msgs.fullScreenMsg FullScreen.leaveFullScreenMsg
                |> Task.succeed
                |> Task.perform identity

        Key.Space ->
            let
                msg =
                    if AudioPlayer.isPlaying audioPlayer then
                        msgs.pauseMsg

                    else
                        msgs.playMsg
            in
            msg
                |> Task.succeed
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
