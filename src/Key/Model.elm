module Key.Model exposing (Key, ParentMsgs, fromString, pressed)

import AudioPlayer exposing (AudioPlayer)
import Model exposing (Model)
import Ports
import SecretConfig exposing (SecretConfig)
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
pressed ({ audioPlayerMsg } as parentMsgs) { audioPlayer, secretConfig } key =
    case key of
        Escape ->
            Ports.exitFullscreen

        Space ->
            if AudioPlayer.isPlaying audioPlayer then
                Ports.performPause parentMsgs.portsMsg

            else
                Ports.play

        UpArrow ->
            let
                newVolume : String
                newVolume =
                    adjustVolume audioPlayer secretConfig (+)
            in
            AudioPlayer.performVolumeAdjustment audioPlayerMsg newVolume

        RightArrow ->
            AudioPlayer.performNextTrackSelection audioPlayerMsg

        DownArrow ->
            let
                newVolume : String
                newVolume =
                    adjustVolume audioPlayer secretConfig (-)
            in
            AudioPlayer.performVolumeAdjustment audioPlayerMsg newVolume

        Other ->
            Cmd.none



-- PRIVATE


adjustVolume : AudioPlayer -> SecretConfig -> (Int -> Int -> Int) -> String
adjustVolume { volume } { volumeAdjustmentRate } operator =
    let
        currentVolume : Int
        currentVolume =
            AudioPlayer.rawVolume volume

        adjustmentRate : Int
        adjustmentRate =
            SecretConfig.rawVolumeAdjustmentRate volumeAdjustmentRate

        newVolume : Int
        newVolume =
            operator currentVolume adjustmentRate
    in
    String.fromInt newVolume
