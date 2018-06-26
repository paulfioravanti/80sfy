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
                    [ Task.succeed ()
                        |> Task.perform (audioPlayerMsg << audioMsg)
                    , Task.succeed ()
                        |> Task.perform (videoPlayerMsg << videoMsg)
                    ]

        UpArrow ->
            let
                newVolume =
                    audioPlayer.volume
                        + config.volumeAdjustmentRate
                        |> toString
            in
                Task.succeed newVolume
                    |> Task.perform
                        (audioPlayerMsg << AudioPlayer.adjustVolumeMsg)

        RightArrow ->
            Task.succeed ()
                |> Task.perform (audioPlayerMsg << AudioPlayer.nextTrackMsg)

        DownArrow ->
            let
                newVolume =
                    audioPlayer.volume
                        - config.volumeAdjustmentRate
                        |> toString
            in
                Task.succeed newVolume
                    |> Task.perform
                        (audioPlayerMsg << AudioPlayer.adjustVolumeMsg)

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
