module Key.Model exposing (Key, Msgs, fromString, pressed)

import AudioPlayer
import BrowserVendor
import Config
import Model exposing (Model)
import Tasks
import VideoPlayer


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
        , videoPlayerMsg : VideoPlayer.Msg -> msg
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
            BrowserVendor.performLeaveFullScreen msgs.browserVendorMsg

        Space ->
            if AudioPlayer.isPlaying audioPlayer then
                Tasks.performPause
                    (AudioPlayer.pauseAudioMsg msgs.audioPlayerMsg)
                    (VideoPlayer.pauseVideosMsg msgs.videoPlayerMsg)

            else
                Tasks.performPlay msgs.playMsg

        UpArrow ->
            let
                currentVolume =
                    AudioPlayer.rawVolume audioPlayer.volume

                adjustmentRate =
                    Config.rawVolumeAdjustmentRate config.volumeAdjustmentRate

                newVolume =
                    currentVolume
                        + adjustmentRate
                        |> String.fromInt
            in
            AudioPlayer.performVolumeAdjustment audioPlayerMsg newVolume

        RightArrow ->
            AudioPlayer.performNextTrackSelection audioPlayerMsg

        DownArrow ->
            let
                currentVolume =
                    AudioPlayer.rawVolume audioPlayer.volume

                adjustmentRate =
                    Config.rawVolumeAdjustmentRate config.volumeAdjustmentRate

                newVolume =
                    currentVolume
                        - adjustmentRate
                        |> String.fromInt
            in
            AudioPlayer.performVolumeAdjustment audioPlayerMsg newVolume

        _ ->
            Cmd.none
