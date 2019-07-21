module Key.Model exposing (Key, Msgs, fromString, pressed)

import AudioPlayer
import BrowserVendor
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
        , browserVendorMsg : BrowserVendor.Msg -> msg
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
            BrowserVendor.leaveFullScreen msgs.browserVendorMsg

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
            AudioPlayer.adjustVolumeMsg audioPlayerMsg newVolume
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
            AudioPlayer.adjustVolumeMsg audioPlayerMsg newVolume
                |> Task.succeed
                |> Task.perform identity

        _ ->
            Cmd.none
