module Update exposing (update)

import App
import AudioPlayer
import Config
import ControlPanel
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayerMsg
            , ConfigMsg
            , ControlPanelMsg
            , KeyMsg
            , Pause
            , Play
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
        AudioPlayerMsg audioPlayerMsg ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update msgRouter audioPlayerMsg
            in
                ( { model | audioPlayer = audioPlayer }
                , cmd
                )

        ConfigMsg configMsg ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update msgRouter configMsg
            in
                ( { model | config = config }
                , cmd
                )

        ControlPanelMsg controlPanelMsg ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgRouter controlPanelMsg
            in
                ( { model | controlPanel = controlPanel }
                , cmd
                )

        KeyMsg code ->
            let
                cmd =
                    code
                        |> App.handleKeyPress msgRouter model
            in
                ( model, cmd )

        Pause () ->
            ( model
            , Cmd.batch
                [ Task.succeed ()
                    |> Task.perform
                        (msgRouter.audioPlayerMsg
                            << AudioPlayer.pauseAudioMsg
                        )
                , Task.succeed ()
                    |> Task.perform
                        (msgRouter.videoPlayerMsg
                            << VideoPlayer.pauseVideosMsg
                        )
                ]
            )

        Play () ->
            ( model
            , Cmd.batch
                [ Task.succeed ()
                    |> Task.perform
                        (msgRouter.audioPlayerMsg
                            << AudioPlayer.playAudioMsg
                        )
                , Task.succeed ()
                    |> Task.perform
                        (msgRouter.videoPlayerMsg
                            << VideoPlayer.playVideosMsg
                        )
                ]
            )

        SecretConfigMsg secretConfigMsg ->
            let
                ( secretConfig, cmd ) =
                    model.secretConfig
                        |> SecretConfig.update secretConfigMsg
            in
                ( { model | secretConfig = secretConfig }
                , cmd
                )

        ShowApplicationState ->
            let
                _ =
                    App.showApplicationState model
            in
                ( model, Cmd.none )

        VideoPlayerMsg videoPlayerMsg ->
            let
                generateRandomGifMsg =
                    msgRouter.configMsg << Config.generateRandomGifMsg

                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        generateRandomGifMsg
                        videoPlayerMsg
                        model.videoPlayer1
                        model.videoPlayer2
            in
                ( { model
                    | videoPlayer1 = videoPlayer1
                    , videoPlayer2 = videoPlayer2
                  }
                , cmd
                )
