module Key.Model exposing (Key, Msgs, fromString, pressed)

import AudioPlayer
import BrowserVendor
import Model exposing (Model)
import Task_


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
            if AudioPlayer.isPlaying audioPlayer then
                Task_.pause msgs.pauseMsg

            else
                Task_.play msgs.playMsg

        UpArrow ->
            let
                newVolume =
                    AudioPlayer.rawVolume audioPlayer.volume
                        + config.volumeAdjustmentRate
                        |> String.fromInt
            in
            AudioPlayer.adjustVolume audioPlayerMsg newVolume

        RightArrow ->
            AudioPlayer.nextTrack audioPlayerMsg

        DownArrow ->
            let
                newVolume =
                    AudioPlayer.rawVolume audioPlayer.volume
                        - config.volumeAdjustmentRate
                        |> String.fromInt
            in
            AudioPlayer.adjustVolume audioPlayerMsg newVolume

        _ ->
            Cmd.none
