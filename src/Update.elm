module Update exposing (update)

import AudioPlayer
import Config
import ControlPanel
import Debug
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayerMsg
            , ConfigMsg
            , ControlPanelMsg
            , KeyMsg
            , SecretConfigMsg
            , ShowApplicationState
            , VideoPlayerMsg
            )
        )
import MsgRouter exposing (MsgRouter)
import SecretConfig
import Task
import VideoPlayer


update : MsgRouter msg -> Msg -> Model -> ( Model, Cmd msg )
update msgRouter msg model =
    case msg of
        AudioPlayerMsg msg ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update msgRouter msg
            in
                ( { model | audioPlayer = audioPlayer }
                , cmd
                )

        ConfigMsg msg ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update msgRouter msg
            in
                ( { model | config = config }
                , cmd
                )

        ControlPanelMsg msg ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgRouter msg
            in
                ( { model | controlPanel = controlPanel }
                , cmd
                )

        KeyMsg code ->
            case code of
                27 ->
                    ( model, VideoPlayer.exitFullScreen )

                38 ->
                    ( model
                    , Task.succeed (toString (model.audioPlayer.volume + 20))
                        |> Task.perform
                            (msgRouter.audioPlayerMsg
                                << AudioPlayer.adjustVolumeMsg
                            )
                    )

                39 ->
                    ( model
                    , Task.succeed ()
                        |> Task.perform
                            (msgRouter.audioPlayerMsg
                                << AudioPlayer.nextTrackMsg
                            )
                    )

                40 ->
                    ( model
                    , Task.succeed (toString (model.audioPlayer.volume - 20))
                        |> Task.perform
                            (msgRouter.audioPlayerMsg
                                << AudioPlayer.adjustVolumeMsg
                            )
                    )

                _ ->
                    ( model, Cmd.none )

        SecretConfigMsg msg ->
            let
                ( secretConfig, cmd ) =
                    model.secretConfig
                        |> SecretConfig.update msgRouter msg
            in
                ( { model | secretConfig = secretConfig }
                , cmd
                )

        ShowApplicationState ->
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
                ( model, Cmd.none )

        VideoPlayerMsg msg ->
            let
                context =
                    { generateRandomGifMsg =
                        msgRouter.configMsg << Config.generateRandomGifMsg
                    }

                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        msgRouter
                        context
                        msg
                        model.videoPlayer1
                        model.videoPlayer2
            in
                ( { model
                    | videoPlayer1 = videoPlayer1
                    , videoPlayer2 = videoPlayer2
                  }
                , cmd
                )
