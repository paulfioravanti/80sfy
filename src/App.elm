module App exposing (handleKeyPress, showApplicationState)

import AudioPlayer
import Debug
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


handleKeyPress : MsgRouter msg -> Model -> Int -> Cmd msg
handleKeyPress { audioPlayerMsg, videoPlayerMsg } { audioPlayer } keyCode =
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
            Task.succeed (toString (audioPlayer.volume + 20))
                |> Task.perform (audioPlayerMsg << AudioPlayer.adjustVolumeMsg)

        RightArrow ->
            Task.succeed ()
                |> Task.perform (audioPlayerMsg << AudioPlayer.nextTrackMsg)

        DownArrow ->
            Task.succeed (toString (audioPlayer.volume - 20))
                |> Task.perform (audioPlayerMsg << AudioPlayer.adjustVolumeMsg)

        _ ->
            Cmd.none


showApplicationState : Model -> ()
showApplicationState model =
    let
        _ =
            Debug.log "Config" model.secretConfig

        _ =
            Debug.log "Control Panel" model.controlPanel

        _ =
            Debug.log "VideoPlayer 2" model.videoPlayer2

        _ =
            Debug.log "VideoPlayer 1" model.videoPlayer1

        _ =
            Debug.log "Audio Player" model.audioPlayer
    in
        ()


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
