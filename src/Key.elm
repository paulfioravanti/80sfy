module Key exposing (pressed)

import AudioPlayer
import Browser
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import Task


type Key
    = DownArrow
    | Escape
    | RightArrow
    | Space
    | Unknown
    | UpArrow


pressed : MsgRouter msg -> Model -> Int -> Cmd msg
pressed msgRouter { audioPlayer, config } keyCode =
    let
        { audioPlayerMsg, browserMsg, pauseMsg, playMsg } =
            msgRouter
    in
        case toKey keyCode of
            Escape ->
                browserMsg Browser.leaveFullScreenMsg
                    |> Task.succeed
                    |> Task.perform identity

            Space ->
                let
                    msg =
                        if AudioPlayer.isPlaying audioPlayer then
                            pauseMsg
                        else
                            playMsg
                in
                    Task.succeed msg
                        |> Task.perform identity

            UpArrow ->
                let
                    newVolume =
                        audioPlayer.volume
                            + config.volumeAdjustmentRate
                            |> toString
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
                            |> toString
                in
                    audioPlayerMsg (AudioPlayer.adjustVolumeMsg newVolume)
                        |> Task.succeed
                        |> Task.perform identity

            _ ->
                Cmd.none


toKey : Int -> Key
toKey keyCode =
    case keyCode of
        27 ->
            Escape

        32 ->
            Space

        38 ->
            UpArrow

        39 ->
            RightArrow

        40 ->
            DownArrow

        _ ->
            Unknown
