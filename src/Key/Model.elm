module Key.Model exposing (Key, Msgs, fromString, pressed)

import AudioPlayer
import FullScreen
import Model exposing (Model)
import Task


type Key
    = DownArrow
    | Escape
    | Other
    | RightArrow
    | Space
    | UpArrow


type alias Msgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , fullScreenMsg : FullScreen.Msg -> msg
        , pauseMsg : msg
        , playMsg : msg
    }


fromString : String -> Key
fromString string =
    case string of
        "Escape" ->
            Escape

        " " ->
            Space

        "ArrowUp" ->
            UpArrow

        "ArrowRight" ->
            RightArrow

        "ArrowDown" ->
            DownArrow

        _ ->
            Other


pressed : Msgs msgs msg -> Model -> Key -> Cmd msg
pressed ({ audioPlayerMsg } as msgs) { audioPlayer, config } key =
    case key of
        Escape ->
            msgs.fullScreenMsg FullScreen.leaveFullScreenMsg
                |> Task.succeed
                |> Task.perform identity

        Space ->
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

        UpArrow ->
            let
                newVolume =
                    audioPlayer.volume
                        + config.volumeAdjustmentRate
                        |> String.fromInt
            in
            audioPlayerMsg (AudioPlayer.adjustVolumeMsg newVolume)
                |> Task.succeed
                |> Task.perform identity

        RightArrow ->
            audioPlayerMsg AudioPlayer.nextTrackMsg
                |> Task.succeed
                |> Task.perform identity

        DownArrow ->
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
