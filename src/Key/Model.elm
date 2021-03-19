module Key.Model exposing (Key, ParentMsgs, fromString, pressed)

import AudioPlayer
import Config
import Model exposing (Model)
import Ports
import Tasks
import VideoPlayer


type Key
    = DownArrow
    | Escape
    | Other
    | RightArrow
    | Space
    | UpArrow


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , pauseMsg : msg
        , playMsg : msg
        , portsMsg : Ports.Msg -> msg
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


pressed : ParentMsgs msgs msg -> Model -> Key -> Cmd msg
pressed ({ audioPlayerMsg } as msgs) { audioPlayer, config } key =
    case key of
        Escape ->
            Ports.exitFullscreen

        Space ->
            if AudioPlayer.isPlaying audioPlayer then
                Tasks.performPause msgs.portsMsg

            else
                Tasks.performPlay msgs.playMsg

        UpArrow ->
            let
                currentVolume =
                    AudioPlayer.rawVolume audioPlayer.volume

                adjustmentRate =
                    Config.rawVolumeAdjustmentRate config.volumeAdjustmentRate

                newVolume =
                    String.fromInt (currentVolume + adjustmentRate)
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
                    String.fromInt (currentVolume - adjustmentRate)
            in
            AudioPlayer.performVolumeAdjustment audioPlayerMsg newVolume

        _ ->
            Cmd.none
