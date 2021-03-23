module Key.Model exposing (Key, ParentMsgs, fromString, pressed)

import AudioPlayer exposing (AudioPlayer)
import Config exposing (Config)
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
pressed ({ audioPlayerMsg } as parentMsgs) { audioPlayer, config } key =
    case key of
        Escape ->
            Ports.exitFullscreen

        Space ->
            if AudioPlayer.isPlaying audioPlayer then
                Tasks.performPause parentMsgs.portsMsg

            else
                Tasks.performPlay parentMsgs.playMsg

        UpArrow ->
            let
                newVolume =
                    adjustVolume audioPlayer config (+)
            in
            AudioPlayer.performVolumeAdjustment audioPlayerMsg newVolume

        RightArrow ->
            AudioPlayer.performNextTrackSelection audioPlayerMsg

        DownArrow ->
            let
                newVolume =
                    adjustVolume audioPlayer config (-)
            in
            AudioPlayer.performVolumeAdjustment audioPlayerMsg newVolume

        Other ->
            Cmd.none



-- PRIVATE


adjustVolume : AudioPlayer -> Config -> (Int -> Int -> Int) -> String
adjustVolume { volume } { volumeAdjustmentRate } operator =
    let
        currentVolume =
            AudioPlayer.rawVolume volume

        adjustmentRate =
            Config.rawVolumeAdjustmentRate volumeAdjustmentRate

        newVolume =
            operator currentVolume adjustmentRate
    in
    String.fromInt newVolume
