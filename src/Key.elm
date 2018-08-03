module Key exposing (pressed)

import AudioPlayer
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import Task
import VideoPlayer


type Key
    = DownArrow
    | Escape
    | RightArrow
    | Space
    | Unknown
    | UpArrow


pressed : MsgRouter msg -> Model -> Int -> Cmd msg
pressed { audioPlayerMsg, videoPlayerMsg } { audioPlayer, config } keyCode =
    case toKey keyCode of
        Escape ->
            VideoPlayer.exitFullScreen

        Space ->
            let
                ( audioMsg, videoMsg ) =
                    if audioPlayer.playing then
                        ( AudioPlayer.pauseAudioMsg
                        , VideoPlayer.pauseVideosMsg
                        )
                    else
                        ( AudioPlayer.playAudioMsg
                        , VideoPlayer.playVideosMsg
                        )
            in
                Cmd.batch
                    [ Task.succeed (audioPlayerMsg audioMsg)
                        |> Task.perform identity
                    , Task.succeed (videoPlayerMsg videoMsg)
                        |> Task.perform identity
                    ]

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
