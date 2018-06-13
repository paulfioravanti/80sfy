module App exposing (handleKeyPress, showApplicationState)

import AudioPlayer
import Debug
import Model exposing (Model)
import MsgRouter exposing (MsgRouter)
import Task
import VideoPlayer


handleKeyPress : MsgRouter msg -> Model -> Int -> Cmd msg
handleKeyPress msgRouter model keyCode =
    case keyCode of
        27 ->
            VideoPlayer.exitFullScreen

        32 ->
            let
                ( audioMsg, videoMsg ) =
                    if model.audioPlayer.playing then
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
                        |> Task.perform
                            (msgRouter.audioPlayerMsg << audioMsg)
                    , Task.succeed ()
                        |> Task.perform
                            (msgRouter.videoPlayerMsg << videoMsg)
                    ]

        38 ->
            Task.succeed (toString (model.audioPlayer.volume + 20))
                |> Task.perform
                    (msgRouter.audioPlayerMsg
                        << AudioPlayer.adjustVolumeMsg
                    )

        39 ->
            Task.succeed ()
                |> Task.perform
                    (msgRouter.audioPlayerMsg
                        << AudioPlayer.nextTrackMsg
                    )

        40 ->
            Task.succeed (toString (model.audioPlayer.volume - 20))
                |> Task.perform
                    (msgRouter.audioPlayerMsg
                        << AudioPlayer.adjustVolumeMsg
                    )

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
