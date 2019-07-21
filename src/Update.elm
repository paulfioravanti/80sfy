module Update exposing (update)

import ApplicationState
import AudioPlayer
import BrowserVendor
import Config
import ControlPanel
import Gif
import Key
import Model exposing (Model)
import Msg exposing (Msg)
import SecretConfig
import Task
import VideoPlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        msgs =
            { audioPlayerMsg = Msg.AudioPlayer
            , browserVendorMsg = Msg.BrowserVendor
            , generateRandomGifMsg = Msg.GenerateRandomGif
            , pauseMsg = Msg.Pause
            , playMsg = Msg.Play
            , secretConfigMsg = Msg.SecretConfig
            , videoPlayerMsg = Msg.VideoPlayer
            }
    in
    case msg of
        Msg.AudioPlayer msgForAudioPlayer ->
            let
                ( audioPlayer, cmd ) =
                    model.audioPlayer
                        |> AudioPlayer.update msgs msgForAudioPlayer
            in
            ( { model | audioPlayer = audioPlayer }, cmd )

        Msg.Config msgForConfig ->
            let
                ( config, cmd ) =
                    model.config
                        |> Config.update msgs msgForConfig
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

        Msg.BrowserVendor browserVendorMsg ->
            let
                cmd =
                    model.browserVendor
                        |> BrowserVendor.cmd browserVendorMsg
            in
            ( model, cmd )

        Msg.GenerateRandomGif videoPlayerId ->
            let
                randomTagGeneratedMsg =
                    Msg.Config << Config.randomTagGeneratedMsg videoPlayerId

                cmd =
                    model.config.tags
                        |> Gif.random randomTagGeneratedMsg
            in
            ( model, cmd )

        Msg.KeyPressed code ->
            let
                cmd =
                    code
                        |> Key.pressed msgs model
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
                    VideoPlayer.pauseVideosMsg Msg.VideoPlayer
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

                playVideos =
                    VideoPlayer.playVideos Msg.VideoPlayer
            in
            ( model, Cmd.batch [ playVideos, playAudio ] )

        Msg.SaveConfig soundCloudPlaylistUrl tagsString gifDisplaySecondsString ->
            let
                saveConfigMsg =
                    Config.saveMsg
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplaySecondsString

                saveConfig =
                    Msg.Config saveConfigMsg
                        |> Task.succeed
                        |> Task.perform identity
            in
            ( model, saveConfig )

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
                ( videoPlayer1, videoPlayer2, cmd ) =
                    VideoPlayer.update
                        Msg.GenerateRandomGif
                        msgForVideoPlayer
                        model
            in
            ( { model
                | videoPlayer1 = videoPlayer1
                , videoPlayer2 = videoPlayer2
              }
            , cmd
            )
