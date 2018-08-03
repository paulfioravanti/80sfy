module Update exposing (update)

import AudioPlayer
import Config
import ControlPanel
import Key
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayer
            , Config
            , ControlPanel
            , Key
            , Pause
            , Play
            , SecretConfig
            , ShowApplicationState
            , VideoPlayer
            )
        )
import MsgRouter exposing (MsgRouter)
import SecretConfig
import Task
import Utils
import VideoPlayer


update : MsgRouter msg -> Msg -> Model -> ( Model, Cmd msg )
update ({ audioPlayerMsg, configMsg, videoPlayerMsg } as msgRouter) msg model =
    case msg of
        AudioPlayer audioPlayerMsg ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update msgRouter audioPlayerMsg
            in
                ( { model | audioPlayer = audioPlayer }, cmd )

        Config configMsg ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update msgRouter configMsg
            in
                ( { model | config = config }, cmd )

        ControlPanel controlPanelMsg ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgRouter controlPanelMsg
            in
                ( { model | controlPanel = controlPanel }, cmd )

        Key code ->
            let
                cmd =
                    code
                        |> Key.pressed msgRouter model
            in
                ( model, cmd )

        Pause ->
            let
                pauseAudio =
                    audioPlayerMsg AudioPlayer.pauseAudioMsg
                        |> Task.succeed

                pauseVideo =
                    videoPlayerMsg VideoPlayer.pauseVideosMsg
                        |> Task.succeed

                -- NOTE: These tasks need to be specifically ordered so that
                -- the player paused overlay is not displayed when the
                -- pause button is pressed on the app player.
                pauseMedia =
                    pauseVideo
                        |> Task.andThen (\_ -> pauseAudio)
                        |> Task.perform identity
            in
                ( model, pauseMedia )

        Play ->
            let
                playAudio =
                    audioPlayerMsg AudioPlayer.playAudioMsg
                        |> Task.succeed
                        |> Task.perform identity

                playVideo =
                    videoPlayerMsg VideoPlayer.playVideosMsg
                        |> Task.succeed
                        |> Task.perform identity
            in
                ( model, Cmd.batch [ playVideo, playAudio ] )

        SecretConfig secretConfigMsg ->
            let
                ( secretConfig, cmd ) =
                    model.secretConfig
                        |> SecretConfig.update secretConfigMsg
            in
                ( { model | secretConfig = secretConfig }, cmd )

        ShowApplicationState ->
            let
                _ =
                    Utils.showApplicationState model
            in
                ( model, Cmd.none )

        VideoPlayer videoPlayerMsg ->
            let
                -- NOTE: The Config module cannot be imported in
                -- VideoPlayer.Update due to circular dependencies, so the
                -- generateRandomGifMsg is created here and passed to
                -- VideoPlayer.update as a parameter
                generateRandomGifMsg =
                    configMsg << Config.generateRandomGifMsg

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
