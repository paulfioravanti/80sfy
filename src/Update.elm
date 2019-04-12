module Update exposing (update)

import ApplicationState
import AudioPlayer
import Config
import ControlPanel
import FullScreen
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import SecretConfig
import Task
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update
                            Msg.AudioPlayer
                            Msg.VideoPlayer
                            msgForAudioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.Config msgForConfig ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update
                            Msg.AudioPlayer
                            Msg.Config
                            Msg.SecretConfig
                            Msg.VideoPlayer
                            msgForConfig
            in
            ( { model | config = config }, cmd )

        Msg.ControlPanel msgForControlPanel ->
            let
                ( controlPanel, cmd ) =
                    model.controlPanel
                        |> ControlPanel.update msgForControlPanel
            in
            ( { model | controlPanel = controlPanel }
            , Cmd.map Msg.ControlPanel cmd
            )

        Msg.FullScreen fullScreenMsg ->
            let
                cmd =
                    model.browserVendor
                        |> FullScreen.cmd fullScreenMsg
            in
            ( model, cmd )

        Msg.Key code ->
            let
                cmd =
                    code
                        |> Key.pressed
                            Msg.AudioPlayer
                            Msg.FullScreen
                            Msg.Pause
                            Msg.Play
                            model
            in
            ( model, cmd )

        Msg.NoOp ->
            ( model, Cmd.none )

        Msg.Pause ->
            let
                pauseAudio =
                    Msg.AudioPlayer AudioPlayer.pauseAudioMsg
                        |> Task.succeed

                pauseVideo =
                    Msg.VideoPlayer VideoPlayer.pauseVideosMsg
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

        Msg.Play ->
            let
                playAudio =
                    Msg.AudioPlayer AudioPlayer.playAudioMsg
                        |> Task.succeed
                        |> Task.perform identity

                playVideo =
                    Msg.VideoPlayer VideoPlayer.playVideosMsg
                        |> Task.succeed
                        |> Task.perform identity
            in
            ( model, Cmd.batch [ playVideo, playAudio ] )

        Msg.SecretConfig msgForSecretConfig ->
            let
                secretConfig =
                    model.secretConfig
                        |> SecretConfig.update msgForSecretConfig
            in
            ( { model | secretConfig = secretConfig }, Cmd.none )

        Msg.ShowApplicationState ->
            ( model, ApplicationState.show model )

        Msg.VideoPlayer msgForVideoPlayer ->
            let
                -- NOTE: The Config module cannot be imported in
                -- VideoPlayer.Update due to circular dependencies, so the
                -- generateRandomGifMsg is created here and passed to
                -- VideoPlayer.update as a parameter
                generateRandomGifMsg =
                    Msg.Config << Config.generateRandomGifMsg

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
