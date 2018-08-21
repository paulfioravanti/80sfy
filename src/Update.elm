module Update exposing (update)

import AudioPlayer
import Config
import ControlPanel
import FullScreen
import Key
import Model exposing (Model)
import Msg
    exposing
        ( Msg
            ( AudioPlayer
            , Config
            , ControlPanel
            , FullScreen
            , Key
            , NoOp
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
        AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update msgRouter msgForAudioPlayer
            in
                ( { model | audioPlayer = audioPlayer }, cmd )

        Config msgForConfig ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update msgRouter msgForConfig
            in
                ( { model | config = config }, cmd )

        ControlPanel msgForControlPanel ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgRouter msgForControlPanel
            in
                ( { model | controlPanel = controlPanel }, cmd )

        FullScreen fullScreenMsg ->
            let
                cmd =
                    model.browserVendor
                        |> FullScreen.update fullScreenMsg
            in
                ( model, cmd )

        Key code ->
            let
                cmd =
                    code
                        |> Key.pressed msgRouter model
            in
                ( model, cmd )

        NoOp ->
            ( model, Cmd.none )

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

        SecretConfig msgForSecretConfig ->
            let
                ( secretConfig, cmd ) =
                    model.secretConfig
                        |> SecretConfig.update msgForSecretConfig
            in
                ( { model | secretConfig = secretConfig }, cmd )

        ShowApplicationState ->
            let
                _ =
                    Utils.showApplicationState model
            in
                ( model, Cmd.none )

        VideoPlayer msgForVideoPlayer ->
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
                        msgForVideoPlayer
                        model.videoPlayer1
                        model.videoPlayer2
            in
                ( { model
                    | videoPlayer1 = videoPlayer1
                    , videoPlayer2 = videoPlayer2
                  }
                , cmd
                )
